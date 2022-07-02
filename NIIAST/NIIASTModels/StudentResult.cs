using System;
using System.Collections.Generic;
using System.Text;

namespace NIIASTModels
{
    public class StudentResult

    {
        
        public string StuFirstName { get; set; }      
     
        public int StudentId { get; set; }
        public string StuAdharNo { get; set; }
        
        public string StuPhoneNo { get; set; }
        
        public string StuEmailId { get; set; }
        public string StuPhotoPath { get; set; }
        public DateTime StuRegistrationDate { get; set; }
        public Boolean IsPlacementRequired { get; set; }
        public Boolean IsWorking { get; set; }
    }
}
