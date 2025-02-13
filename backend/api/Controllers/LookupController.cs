using System.Collections.Generic;
using System.Linq;
using MapsterMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Pims.Dal;
using Swashbuckle.AspNetCore.Annotations;
using Model = Pims.Api.Models.Lookup;

namespace Pims.Api.Controllers
{
    /// <summary>
    /// LookupController class, provides endpoints for code lookups.
    /// </summary>
    [Authorize]
    [ApiController]
    [ApiVersion("1.0")]
    [Route("v{version:apiVersion}/lookup")]
    [Route("lookup")]
    public class LookupController : ControllerBase
    {
        #region Variables
        private readonly IPimsRepository _pimsService;
        private readonly IMapper _mapper;
        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new instance of a LookupController class.
        /// </summary>
        /// <param name="pimsService"></param>
        /// <param name="mapper"></param>
        public LookupController(IPimsRepository pimsService, IMapper mapper)
        {
            _pimsService = pimsService;
            _mapper = mapper;
        }
        #endregion

        #region Endpoints

        /// <summary>
        /// Get all of the role code values.
        /// </summary>
        /// <returns></returns>
        [HttpGet("roles")]
        [Produces("application/json")]
        [ProducesResponseType(typeof(IEnumerable<Model.RoleModel>), 200)]
        [SwaggerOperation(Tags = new[] { "lookup" })]
        public IActionResult GetRoles()
        {
            var roleCodes = _mapper.Map<Model.RoleModel[]>(_pimsService.Lookup.GetRoles());
            return new JsonResult(roleCodes.ToArray());
        }

        /// <summary>
        /// Get all of the property classification code values.
        /// </summary>
        /// <returns></returns>
        [HttpGet("property/classifications")]
        [Produces("application/json")]
        [ProducesResponseType(typeof(IEnumerable<Model.LookupModel>), 200)]
        [SwaggerOperation(Tags = new[] { "lookup" })]
        public IActionResult GetPropertyClassificationTypes()
        {
            var classifications = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyClassificationTypes());
            return new JsonResult(classifications.ToArray());
        }

        /// <summary>
        /// Get all of the code values.
        /// </summary>
        /// <returns></returns>
        [HttpGet("all")]
        [Produces("application/json")]
        [ProducesResponseType(typeof(IEnumerable<Model.LookupModel>), 200)]
        [SwaggerOperation(Tags = new[] { "lookup" })]
        public IActionResult GetAll()
        {
            var areaUnitTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyAreaUnitTypes());
            var classificationTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyClassificationTypes());
            var contactMethodTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetContactMethodTypes());
            var countries = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetCountries());
            var districts = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetDistricts());
            var insuranceTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetInsuranceTypes());
            var leaseCategoryTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseCategoryTypes());
            var leaseInitiatorTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseInitiatorTypes());
            var leasePaymentFrequencyTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeasePmtFreqTypes());
            var leasePaymentMethodTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeasePaymentMethodTypes());
            var leasePaymentReceivableTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPaymentReceivableTypes());
            var leasePaymentStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeasePaymentStatusTypes());
            var leaseProgramTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseProgramTypes());
            var leasePurposeTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeasePurposeTypes());
            var leaseResponsibilityTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseResponsibilityTypes());
            var leaseStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseStatusTypes());
            var leaseTermStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseTermStatusTypes());
            var leaseTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetLeaseTypes());
            var organizationTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetOrganizationTypes());
            var propertyImprovementTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyImprovementTypes());
            var propertyTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyTypes());
            var provinces = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetProvinces());
            var regions = _mapper.Map<Model.LookupModel<short>[]>(_pimsService.Lookup.GetRegions());
            var roleCodes = _mapper.Map<Model.RoleModel[]>(_pimsService.Lookup.GetRoles());
            var securityDepositTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetSecurityDepositTypes());
            var tenureTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyTenureTypes());
            var researchStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetResearchFileStatusTypes());
            var requestSourceTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GeRequestSourceTypes());
            var researchPurposeTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetResearchPurposeTypes());
            var propertyResearchPurposeTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyResearchPurposeTypes());
            var propertyAnomalyTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyAnomalyTypes());
            var propertyRoadTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyRoadTypes());
            var propertyAdjacentLandTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyAdjacentLandTypes());
            var volumeUnitTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyVolumeUnitTypes());
            var propertyVolumetricTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPropertyVolumetricTypes());
            var pphStatusType = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetPPHStatusType());
            var documentStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetDocumentStatusTypes());
            var acquisitionFileStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetAcquisitionFileStatusTypes());
            var acquisitionPhysFileStatusTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetAcquisitionPhysFileStatusTypes());
            var acquisitionTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetAcquisitionTypes());
            var activityTemplateTypes = _mapper.Map<Model.LookupModel[]>(_pimsService.Lookup.GetActivityTemplateTypes());

            var codes = new List<object>();
            codes.AddRange(areaUnitTypes);
            codes.AddRange(classificationTypes);
            codes.AddRange(contactMethodTypes);
            codes.AddRange(countries);
            codes.AddRange(districts);
            codes.AddRange(insuranceTypes);
            codes.AddRange(leaseCategoryTypes);
            codes.AddRange(leaseInitiatorTypes);
            codes.AddRange(leasePaymentFrequencyTypes);
            codes.AddRange(leasePaymentMethodTypes);
            codes.AddRange(leasePaymentReceivableTypes);
            codes.AddRange(leasePaymentStatusTypes);
            codes.AddRange(leaseProgramTypes);
            codes.AddRange(leasePurposeTypes);
            codes.AddRange(leaseResponsibilityTypes);
            codes.AddRange(leaseStatusTypes);
            codes.AddRange(leaseTermStatusTypes);
            codes.AddRange(leaseTypes);
            codes.AddRange(organizationTypes);
            codes.AddRange(propertyImprovementTypes);
            codes.AddRange(propertyTypes);
            codes.AddRange(provinces);
            codes.AddRange(regions);
            codes.AddRange(roleCodes);
            codes.AddRange(securityDepositTypes);
            codes.AddRange(tenureTypes);
            codes.AddRange(researchStatusTypes);
            codes.AddRange(requestSourceTypes);
            codes.AddRange(researchPurposeTypes);
            codes.AddRange(propertyResearchPurposeTypes);
            codes.AddRange(propertyAnomalyTypes);
            codes.AddRange(propertyRoadTypes);
            codes.AddRange(propertyAdjacentLandTypes);
            codes.AddRange(volumeUnitTypes);
            codes.AddRange(propertyVolumetricTypes);
            codes.AddRange(pphStatusType);
            codes.AddRange(documentStatusTypes);
            codes.AddRange(acquisitionFileStatusTypes);
            codes.AddRange(acquisitionPhysFileStatusTypes);
            codes.AddRange(acquisitionTypes);
            codes.AddRange(activityTemplateTypes);

            return new JsonResult(codes);
        }
        #endregion
    }
}
