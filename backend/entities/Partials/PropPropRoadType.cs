using System.ComponentModel.DataAnnotations.Schema;

namespace Pims.Dal.Entities
{
    /// <summary>
    /// PimsPropPropRoadType class, provides an entity for the datamodel to manage property road types.
    /// </summary>
    public partial class PimsPropPropRoadType : IdentityBaseAppEntity<long>, IBaseAppEntity
    {
        #region Properties
        [NotMapped]
        public override long Id { get => this.PropPropRoadTypeId; set => this.PropPropRoadTypeId = value; }
        #endregion

    }
}
