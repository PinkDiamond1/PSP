﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace Pims.Dal.Entities
{
    [Table("PIMS_PROPERTY_RESEARCH_FILE")]
    [Index(nameof(PropertyId), Name = "PRSCRC_PROPERTY_ID_IDX")]
    [Index(nameof(ResearchFileId), Name = "PRSCRC_RESEARCH_FILE_ID_IDX")]
    [Index(nameof(ResearchFileId), nameof(PropertyId), Name = "PRSCRC_RSRCH_FILE_PROP_TUC", IsUnique = true)]
    public partial class PimsPropertyResearchFile
    {
        public PimsPropertyResearchFile()
        {
            PimsActInstPropRsrchFiles = new HashSet<PimsActInstPropRsrchFile>();
            PimsPrfPropResearchPurposeTypes = new HashSet<PimsPrfPropResearchPurposeType>();
        }

        [Key]
        [Column("PROPERTY_RESEARCH_FILE_ID")]
        public long PropertyResearchFileId { get; set; }
        [Column("PROPERTY_ID")]
        public long PropertyId { get; set; }
        [Column("RESEARCH_FILE_ID")]
        public long ResearchFileId { get; set; }
        [Column("PROPERTY_NAME")]
        [StringLength(500)]
        public string PropertyName { get; set; }
        [Column("DISPLAY_ORDER")]
        public int? DisplayOrder { get; set; }
        [Column("IS_DISABLED")]
        public bool? IsDisabled { get; set; }
        [Column("IS_LEGAL_OPINION_REQUIRED")]
        public bool? IsLegalOpinionRequired { get; set; }
        [Column("IS_LEGAL_OPINION_OBTAINED")]
        public bool? IsLegalOpinionObtained { get; set; }
        [Column("DOCUMENT_REFERENCE")]
        [StringLength(2000)]
        public string DocumentReference { get; set; }
        [Column("RESEARCH_SUMMARY")]
        public string ResearchSummary { get; set; }
        [Column("CONCURRENCY_CONTROL_NUMBER")]
        public long ConcurrencyControlNumber { get; set; }
        [Column("APP_CREATE_TIMESTAMP", TypeName = "datetime")]
        public DateTime AppCreateTimestamp { get; set; }
        [Required]
        [Column("APP_CREATE_USERID")]
        [StringLength(30)]
        public string AppCreateUserid { get; set; }
        [Column("APP_CREATE_USER_GUID")]
        public Guid? AppCreateUserGuid { get; set; }
        [Required]
        [Column("APP_CREATE_USER_DIRECTORY")]
        [StringLength(30)]
        public string AppCreateUserDirectory { get; set; }
        [Column("APP_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
        public DateTime AppLastUpdateTimestamp { get; set; }
        [Required]
        [Column("APP_LAST_UPDATE_USERID")]
        [StringLength(30)]
        public string AppLastUpdateUserid { get; set; }
        [Column("APP_LAST_UPDATE_USER_GUID")]
        public Guid? AppLastUpdateUserGuid { get; set; }
        [Required]
        [Column("APP_LAST_UPDATE_USER_DIRECTORY")]
        [StringLength(30)]
        public string AppLastUpdateUserDirectory { get; set; }
        [Column("DB_CREATE_TIMESTAMP", TypeName = "datetime")]
        public DateTime DbCreateTimestamp { get; set; }
        [Required]
        [Column("DB_CREATE_USERID")]
        [StringLength(30)]
        public string DbCreateUserid { get; set; }
        [Column("DB_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
        public DateTime DbLastUpdateTimestamp { get; set; }
        [Required]
        [Column("DB_LAST_UPDATE_USERID")]
        [StringLength(30)]
        public string DbLastUpdateUserid { get; set; }

        [ForeignKey(nameof(PropertyId))]
        [InverseProperty(nameof(PimsProperty.PimsPropertyResearchFiles))]
        public virtual PimsProperty Property { get; set; }
        [ForeignKey(nameof(ResearchFileId))]
        [InverseProperty(nameof(PimsResearchFile.PimsPropertyResearchFiles))]
        public virtual PimsResearchFile ResearchFile { get; set; }
        [InverseProperty(nameof(PimsActInstPropRsrchFile.PropertyResearchFile))]
        public virtual ICollection<PimsActInstPropRsrchFile> PimsActInstPropRsrchFiles { get; set; }
        [InverseProperty(nameof(PimsPrfPropResearchPurposeType.PropertyResearchFile))]
        public virtual ICollection<PimsPrfPropResearchPurposeType> PimsPrfPropResearchPurposeTypes { get; set; }
    }
}
