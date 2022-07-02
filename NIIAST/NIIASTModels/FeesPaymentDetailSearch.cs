using System;
using System.Collections.Generic;
using System.Text;

namespace NIIASTModels
{
    public class FeesPaymentDetailSearch
    {

        public int? MasterFeesPaymentId { get; set; }
        public int? FeesPaymentId { get; set; }

        public int ?StudentId { get; set; }
        public int ?CourseId { get; set; }
        
    }
}
