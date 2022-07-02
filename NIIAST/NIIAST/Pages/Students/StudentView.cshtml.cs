using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using CaseDiary.Pages.Shared;
using CaseDiary.Service;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using NIIASTModels;

namespace NIIAST
{
    public class StudentViewModel : PageModel
    {
        [BindProperty]
        public Students StudentInfo { get; set; }               
        [BindProperty]
        public int StudentId { get; set; }
        [BindProperty]
        public Microsoft.AspNetCore.Http.IFormFile Photo { get; set; }

        [BindProperty]
        public string Course { get; set; }
        [BindProperty]
        public string Degree { get; set; }
        public FeesPaymentMasterResult MasterResult { get; private set; }
        public List<FeesPaymentMasterResult> MasterResultlst { get; private set; }
        [BindProperty]
        public decimal TotalFeesPaid { get; set; }
        [BindProperty]
        public decimal TotalFeesDueAmount { get; set; }

        [BindProperty]
        public decimal TotalFeesRemaining { get; set; }
        public BL ObjBl { get; set; }      
        List<Students> StudentInfolst { get; set; }
        public FeesPaymentMasterSearch MasterSearch { get; private set; }

        private readonly IWebHostEnvironment webHostEnvironment;
         public StudentViewModel(ICaseDiaryRepository repository,
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
                
                Int32[] intobject = new int[1];
                intobject[0] = StudentId;
                StudentInfolst = new List<Students>();
                StudentSearch Search = new StudentSearch();
                Students Result = new Students();
                Search.StudentId = StudentId;
                StudentInfolst = ObjBl.getmainitemdetails(Search, Result, "niiast", "sp_GetAllOrSingleStudent1", intobject[0]);
               
                if (StudentInfolst.Count > 0)
                {
                    StudentInfo = StudentInfolst[0];
                    Course=   GetAllCoursesOfSingleStudent("student_course",StudentId);
                    Degree = GetAllCoursesOfSingleStudent("student_degree", StudentId);
                    MasterResult = new FeesPaymentMasterResult();
                    MasterResultlst = new List<FeesPaymentMasterResult>();
                    MasterSearch = new FeesPaymentMasterSearch();
                    MasterResultlst = ObjBl.getmainitemdetails(MasterSearch, MasterResult, "niiast", "sp_GetAllOrSingleFeesPaymentMaster");
                    GetCardDeckFeesPaid(StudentId);
                }
            }
        }

        private void pageInitilization()
        {
            StudentInfo = new Students();
            StudentInfo.StuRegistrationDate = DateTime.Now.Date;          
         }
        public void GetCardDeckFeesPaid(int StudentId)
        {
            var m = from s in MasterResultlst
                    where s.StudentId == StudentId
                    select new FeesPaymentMasterResult
                    {
                        FeesPaid = s.FeesPaid,
                        FeesDueAmount = s.FeesDueAmount
                    };
            TotalFeesPaid = m.Sum(x => x.FeesPaid);
            TotalFeesDueAmount = m.Sum(x => x.FeesDueAmount);
            TotalFeesRemaining = TotalFeesDueAmount - TotalFeesPaid;
            // return 0.0M;
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
        public string GetAllCoursesOfSingleStudent(string relationname, int StudentId)
        {
            string ConcatenatedCourseValues = "";
            Dictionary<int, string> CourseDict = new Dictionary<int, string>();
            CourseDict = ObjBl.GetCardValsFromDatabase(relationname, StudentId);
            if (CourseDict.Count > 0)
            {
                ConcatenatedCourseValues = string.Join(",", CourseDict.Values.ToList());

            }
            return ConcatenatedCourseValues;
        }
    }
}