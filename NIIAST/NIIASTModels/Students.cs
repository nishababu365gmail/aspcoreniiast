using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NIIASTModels
{
   public  class Students
{
        [Required]
        public string StuFirstName { get; set; }
        [Required]
        public string StuLastName { get; set; }
       [Required]
        public string StuCourse { get; set; }
        public string StuDegree { get; set; }
        public int StudentId { get; set; }
        public string StuAdharNo { get; set; }
        [Phone]
        public string StuPhoneNo { get; set; }
        [DataType(DataType.EmailAddress)]
        [EmailAddress]
        public string StuEmailId { get; set; }
        public string StuNotes { get; set; }        
        public DateTime StuRegistrationDate { get; set; }
        public Boolean IsPlacementRequired { get; set; }
        public Boolean IsWorking { get; set; }
        public string  StuPhotoPath { get; set; }











    }
}
