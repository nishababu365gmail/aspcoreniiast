using System;
using System.Collections.Generic;
using System.Text;

namespace NIIASTModels
{
    public class FeesPayment
    {
        public int FeesPaymentId { get; set; }
        public int StudentId { get; set; }
        public int CourseId { get; set; }        
        public Decimal Fees { get; set; }
        public Decimal FeesPaid { get; set; }
       public Decimal FeesDueAmount { get; set; }        
        public DateTime FeesPaidDate { get; set; }
    // public DateTime FeesDueDate { get; set; }
  }
}
