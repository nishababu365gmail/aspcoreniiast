using System;
using System.Collections.Generic;
using System.Text;

namespace NIIASTModels
{
    public class FeesPaymentDetailResult
    {
        public int MasterFeesPaymentId { get; set; }
        public int FeesPaymentId { get; set; }        
        public int StudentId { get; set; }
        public int CourseId { get; set; }
        public string StuFirstName { get; set; }
        public string CourseName { get; set; }
        public decimal Fees { get; set; }

        //public decimal FeesPaid { get; set; }
        //public decimal FeesDueAmount { get; set; }            
        public DateTime FeesPaidDate { get; set; }


       
    }
}
