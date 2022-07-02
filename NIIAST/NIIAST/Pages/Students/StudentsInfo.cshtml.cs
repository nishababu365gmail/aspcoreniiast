using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using NIIASTModels;
using CaseDiary.Service;
using CaseDiary.Pages.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Hosting;
using System.IO;

namespace NIIAST
{
    public class StudentsInfoModel : PageModel
    {
        [BindProperty]
        public Students StudentInfo { get; set; }
        [BindProperty]
        public int[] StuCourse { get; set; }
        [BindProperty]
        public int[] StuDegrees { get; set; }
        [BindProperty]
        public int StudentId { get; set; }
        [BindProperty]
        public IFormFile Photo { get; set; }
        public BL ObjBl { get; set; }
        public List<SelectListItem> DegreeList { get; set; }
        public List<SelectListItem> CourseList { get; set; }
        List<Students> StudentInfolst { get; set; }
        private readonly IWebHostEnvironment webHostEnvironment;

        public StudentsInfoModel(ICaseDiaryRepository repository,
            IWebHostEnvironment webHostEnvironment)
        {
            ObjBl = new BL(repository);
            this.webHostEnvironment = webHostEnvironment;
        }

        public void OnGet(int StudentId)
        {
            if (StudentId == 0)
            {
                pageInitilization();
            }
            else
            {
                DegreeList = new List<SelectListItem>();
                CourseList = new List<SelectListItem>();
                DegreeList = ObjBl.GetDropdownlistValsFromDatabase("", "m_degree", 0);
                CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
                Int32[] intobject = new int[1];
                intobject[0] = StudentId;
                StudentInfolst = new List<Students>();
                StudentSearch Search = new StudentSearch();
                Students Result = new Students();
                Search.StudentId = StudentId;
                  StudentInfolst = ObjBl.getmainitemdetails(Search, Result, "niiast", "sp_GetAllOrSingleStudent1", intobject[0]);
               
                string localStuCourse = "";
                string localStuDegree = "";
                if (StudentInfolst.Count > 0)
                {
                    StudentInfo = StudentInfolst[0];
                    localStuCourse = StudentInfo.StuCourse;
                    localStuDegree = StudentInfo.StuDegree;
                    if (!String.IsNullOrEmpty(localStuCourse) )
                    { 
                        StuCourse = localStuCourse.Split(',').Select(n => int.Parse(n.Trim())).ToArray();
                    }
                    if (!String.IsNullOrEmpty(localStuDegree))
                    {
                        StuDegrees = localStuDegree.Split(',').Select(n => int.Parse(n.Trim())).ToArray();
                    }
                    
                }
            }
        }

     private void   pageInitilization()


        {
            StudentInfo = new Students();
            StudentInfo.StuRegistrationDate = DateTime.Now.Date;            
            DegreeList = new List<SelectListItem>();
            CourseList=new List<SelectListItem>();
            DegreeList = ObjBl.GetDropdownlistValsFromDatabase("", "m_degree", 0);
            CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);

        }

        public void OnPost()
        {
            if (Photo != null)
            {
                // If a new photo is uploaded, the existing photo must be
                // deleted. So check if there is an existing photo and delete
                if (StudentInfo.StuPhotoPath != null)
                {
                    string filePath = Path.Combine(webHostEnvironment.WebRootPath,
                        "images", StudentInfo.StuPhotoPath);
                    System.IO.File.Delete(filePath);
                }
                // Save the new photo in wwwroot/images folder and update
                // PhotoPath property of the employee object
                StudentInfo.StuPhotoPath = ProcessUploadedFile();
            }
            else
            {
                if (StudentInfo.StuPhotoPath != null)
                {

                }
            }
            string degrees=string.Join(',', StuDegrees);
            string course = string.Join(',', StuCourse);
            StudentInfo.StuCourse = course;
            StudentInfo.StuDegree = degrees;
            StudentInfo.StudentId = StudentId;
            ObjBl.InsertItems(StudentInfo, "niiast", "sp_savestudent");
            pageInitilization();
        }
        private string ProcessUploadedFile()
        {
            string uniqueFileName = null;

            if (Photo != null)
            {
                string uploadsFolder = Path.Combine(webHostEnvironment.WebRootPath, "images");
                uniqueFileName = Guid.NewGuid().ToString() + "_" + Photo.FileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    Photo.CopyTo(fileStream);
                }
            }

            return uniqueFileName;
        }
    }
}