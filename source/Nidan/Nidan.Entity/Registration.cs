namespace Nidan.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Registration")]
    public partial class Registration
    {
        public int RegistrationId { get; set; }

        public int? StudentCode { get; set; }

        public int EnquiryId { get; set; }

        public int CourseId { get; set; }

        public int CourseInstallmentId { get; set; }

        public int CandidateFeeId { get; set; }

        public string Remarks { get; set; }

        public DateTime? FollowupDate { get; set; }

        public int CentreId { get; set; }

        public int OrganisationId { get; set; }

        public virtual CandidateFee CandidateFee { get; set; }

        public virtual Registration Registration1 { get; set; }

        public virtual Registration Registration2 { get; set; }

        public virtual Enquiry Enquiry { get; set; }

        public virtual Course Course { get; set; }

        public virtual CourseInstallment CourseInstallment { get; set; }

        public virtual Centre Centre { get; set; }

        public virtual Organisation Organisation { get; set; }
    }
}
