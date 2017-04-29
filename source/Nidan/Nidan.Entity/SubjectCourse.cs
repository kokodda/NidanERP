namespace Nidan.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SubjectCourse")]
    public partial class SubjectCourse
    {
        public int SubjectCourseId { get; set; }

        public int SubjectId { get; set; }

        public int CourseId { get; set; }

        public int OrganisationId { get; set; }

        public virtual Subject Subject { get; set; }

        public virtual Course Course { get; set; }

        public virtual Organisation Organisation { get; set; }
    }
}