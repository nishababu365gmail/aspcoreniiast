using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NIIASTModels
{
    public class StudentSearch

{       public string StuFirstName { get; set; }          
        public int ? StuCourse { get; set; }      
        [Phone]
        public string  StuPhoneNo { get; set; }        
        public DateTime ?StuRegistrationDate { get; set; }
        public int? StudentId { get; set; }

    }
}
