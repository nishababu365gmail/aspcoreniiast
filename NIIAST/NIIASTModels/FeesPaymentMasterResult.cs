using System;
using System.Collections.Generic;
using System.Text;

namespace NIIASTModels
{
    public class FeesPaymentMasterResult
    {
        public int FeesPaymentMasterId { get; set; }
        public int StudentId { get; set; }
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public string StuFirstName { get; set; }
        public decimal FeesPaid { get; set; }

        public decimal FeesDueAmount { get; set; }

         

    }
}
