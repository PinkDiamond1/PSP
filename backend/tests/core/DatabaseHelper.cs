using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Security.Claims;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Options;
using Moq;
using Pims.Core.Helpers;
using Pims.Dal;
using Pims.Dal.Security;

namespace Pims.Core.Test
{
    /// <summary>
    /// DatabaseHelper static class, provides helper functions for the TestHelper when interacting with a Database.
    /// </summary>
    [ExcludeFromCodeCoverage]
    public static class DatabaseHelper
    {
        #region Methods
        /// <summary>
        /// Creates an instance of a PimsContext and initializes it with the specified 'permission'.
        /// Uses an InMemoryDatabase instead of relational.
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="permission"></param>
        /// <param name="ensureDeleted"></param>
        /// <returns></returns>
        public static PimsContext CreatePimsContext(this TestHelper helper, Permissions permission, bool ensureDeleted = false)
        {
            return helper.CreatePimsContext(StringHelper.Generate(10), permission, ensureDeleted);
        }

        /// <summary>
        /// Creates an instance of a PimsContext and initializes it with the specified 'user'.
        /// Uses an InMemoryDatabase instead of relational.
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="user"></param>
        /// <param name="ensureDeleted"></param>
        /// <returns></returns>
        public static PimsContext CreatePimsContext(this TestHelper helper, ClaimsPrincipal user, bool ensureDeleted = false)
        {
            return helper.CreatePimsContext(StringHelper.Generate(10), user, ensureDeleted);
        }

        /// <summary>
        /// Creates an instance of a PimsContext and initializes it with the specified 'permission'.
        /// Uses an InMemoryDatabase instead of relational.
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="dbName"></param>
        /// <param name="permission"></param>
        /// <param name="ensureDeleted"></param>
        /// <returns></returns>
        public static PimsContext CreatePimsContext(this TestHelper helper, string dbName, Permissions permission, bool ensureDeleted = false)
        {
            var user = PrincipalHelper.CreateForPermission(permission);
            return helper.CreatePimsContext(dbName, user, ensureDeleted);
        }

        /// <summary>
        /// Creates an instance of a PimsContext and initializes it with the specified 'user'.
        /// Uses an InMemoryDatabase instead of relational.
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="dbName"></param>
        /// <param name="user"></param>
        /// <param name="ensureDeleted"></param>
        /// <returns></returns>
        public static PimsContext CreatePimsContext(this TestHelper helper, string dbName, ClaimsPrincipal user, bool ensureDeleted = false)
        {
            // Generate a randome database name.
            if (string.IsNullOrWhiteSpace(dbName))
            {
                dbName = StringHelper.Generate(10);
            }

            helper.AddSingleton(user);
            var options = new DbContextOptionsBuilder<PimsContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .EnableSensitiveDataLogging()
                .ConfigureWarnings(m => m.Ignore(InMemoryEventId.TransactionIgnoredWarning))
                .Options;

            var contextAccessor = new Mock<IHttpContextAccessor>();
            var httpContext = helper.CreateHttpContext(user);
            contextAccessor.Setup(m => m.HttpContext).Returns(httpContext);

            var serializerOptions = new Mock<IOptions<JsonSerializerOptions>>();
            helper.AddSingleton(serializerOptions);

            var context = new PimsContext(options, contextAccessor.Object, serializerOptions.Object);

            if (ensureDeleted)
            {
                context.Database.EnsureDeleted();
            }

            helper.AddSingleton(context);

            return context;
        }

        /// <summary>
        /// Initialize the PimsContext with the specified data in 'entities'.
        /// Initializes the database with default data to support other tables.
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        public static PimsContext InitializeDatabase(this TestHelper helper, ClaimsPrincipal user)
        {
            return helper.InitializeDatabase(StringHelper.Generate(15), user);
        }

        /// <summary>
        /// Initialize the PimsContext with the specified data in 'entities'.
        /// Initializes the database with default data to support other tables.
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="dbName"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        public static PimsContext InitializeDatabase(this TestHelper helper, string dbName, ClaimsPrincipal user)
        {
            var context = helper.CreatePimsContext(dbName, user, true);
            return context.SeedDatabase();
        }

        /// <summary>
        /// Initializes the database with default data to support other tables.
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static PimsContext SeedDatabase(this PimsContext context)
        {
            var countries = EntityHelper.CreateDefaultCountries();
            var regions = EntityHelper.CreateDefaultRegions();
            var organizationTypes = EntityHelper.CreateDefaultOrganizationTypes();
            var organizationIdentifierTypes = EntityHelper.CreateDefaultOrganizationIdentifierTypes();
            context.AddRange(countries);
            context.AddRange(regions);
            context.AddRange(organizationTypes);
            context.AddRange(organizationIdentifierTypes);
            context.AddRange(EntityHelper.CreateDefaultRoles());
            context.AddRange(EntityHelper.CreateDefaultPropertyTypes());
            context.AddRange(EntityHelper.CreateDefaultPropertyClassificationTypes());
            context.AddRange(EntityHelper.CreateDefaultPropertyTenureTypes());
            context.AddRange(EntityHelper.CreateDefaultPropertyStatusTypes());
            context.AddRange(EntityHelper.CreateDefaultPropertyAreaUnitTypes());
            context.AddRange(EntityHelper.CreateDefaultDataSourceTypes());
            context.AddRange(EntityHelper.CreateDefaultContactMethodTypes());
            context.AddRange(EntityHelper.CreateDefaultAcquisitionFileStatusTypes());
            context.AddRange(EntityHelper.CreateDefaultAcquisitionTypes());
            context.AddRange(EntityHelper.CreateDefaultProvinces(countries.First()));
            context.AddRange(EntityHelper.CreateDefaultDistricts(regions.First()));
            context.AddRange(EntityHelper.CreateDefaultOrganizations(organizationTypes.First(), organizationIdentifierTypes.First()));
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Saves current changes to data context.
        /// This will only work if the service provider has been built.
        /// </summary>
        /// <param name="helper"></param>
        /// <returns></returns>
        public static PimsContext SaveChanges(this TestHelper helper)
        {
            var context = helper.GetService<PimsContext>();
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Add to the PimsContext 'context' with the specified data in 'entities'.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="helper"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        public static PimsContext AddAndSaveChanges<T>(this TestHelper helper, params T[] entity)
            where T : class
        {
            var context = helper.GetService<PimsContext>();
            context.Set<T>().AddRange(entity);
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Add to the PimsContext 'context' with the specified data in 'entities'.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="context"></param>
        /// <param name="entities"></param>
        /// <returns></returns>
        public static PimsContext AddAndSaveRange<T>(this TestHelper helper, IEnumerable<T> entities)
            where T : class
        {
            var context = helper.GetService<PimsContext>();
            context.Set<T>().AddRange(entities);
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Save the changes that are in memory context to the datasource.
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static PimsContext SaveChanges(this PimsContext context)
        {
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Add to the PimsContext 'context' with the specified data in 'entities'.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="context"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        public static PimsContext UpdateAndSaveChanges<T>(this PimsContext context, params T[] entity)
            where T : class
        {
            context.Set<T>().UpdateRange(entity);
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Add to the PimsContext 'context' with the specified data in 'entities'.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="context"></param>
        /// <param name="entities"></param>
        /// <returns></returns>
        public static PimsContext UpdateAndSaveRange<T>(this PimsContext context, IEnumerable<T> entities)
            where T : class
        {
            context.Set<T>().UpdateRange(entities);
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Add to the PimsContext 'context' with the specified data in 'entities'.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="context"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        public static PimsContext AddAndSaveChanges<T>(this PimsContext context, params T[] entity)
            where T : class
        {
            context.Set<T>().AddRange(entity);
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Add to the PimsContext 'context' with the specified data in 'entities'.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="context"></param>
        /// <param name="entities"></param>
        /// <returns></returns>
        public static PimsContext AddAndSaveRange<T>(this PimsContext context, IEnumerable<T> entities)
            where T : class
        {
            context.Set<T>().AddRange(entities);
            context.SaveChanges();
            return context;
        }

        /// <summary>
        /// Ensure the database has been deleted.
        /// </summary>
        /// <param name="context"></param>
        public static void EnsureDeleted(this PimsContext context)
        {
            context.Database.EnsureDeleted();
        }

        /// <summary>
        /// Ensure the database has been deleted.
        /// </summary>
        /// <param name="helper"></param>
        public static void EnsureDeleted(this TestHelper helper)
        {
            var context = helper.GetService<PimsContext>();
            context.EnsureDeleted();
        }
        #endregion
    }
}
