using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using NIIASTModels;

using CaseDiary.Service;
using CaseDiary.Pages.Shared;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace NIIAST
{
    public class StudentsSearchPageModel : PageModel
       {
        [BindProperty(SupportsGet = true)]
        public string Course { get; set; }
        [BindProperty]
        public StudentResult ObjStudentResult { get; set; }
        [BindProperty(SupportsGet = true)]
        public StudentSearch ObjStudentSearch { get; set; }
        public List<SelectListItem> CourseList { get; set; }
        public BL ObjBl { get; set; }
        public List<StudentResult> ObjStudentResultlst { get; set; }        
        #region pagination
        [BindProperty(SupportsGet = true)]
        public int CurrentPage { get; set; }
        public int Count { get; set; }
        public int PageSize { get; set; } = 2;
        public int TotalPages => (int)Math.Ceiling(decimal.Divide(Count, PageSize));
        #endregion
        public StudentsSearchPageModel(ICaseDiaryRepository repository)
        {
            
            ObjBl = new BL(repository);
        }
        public void OnGet()
        {
            if (CurrentPage == 0)
            {
                pageinitialization();                
            }
            else
            {
                ObjStudentSearch.StuCourse = Convert.ToInt32(Course);
                ObjStudentResult = new StudentResult();
                if (ObjStudentSearch.StuRegistrationDate == DateTime.MinValue)
                {
                    ObjStudentSearch.StuRegistrationDate = null;
                }
            }
                     
            ObjStudentResultlst = ObjBl.GetPaginatedStudentsResult(ObjStudentSearch, ObjStudentResult, "niiast", "sp_GetAllOrSingleStudent1", CurrentPage,PageSize);
            Count = ObjBl.GetCount(ObjStudentSearch, ObjStudentResult, "niiast", "sp_GetAllOrSingleStudent1");
           // Count = ObjStudentResultlst.Count();
            CourseList = new List<SelectListItem>();
            CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
        }

        public void OnPostGetStudents()
        {
            if (ObjStudentSearch.StuRegistrationDate == DateTime.MinValue)
            {
                ObjStudentSearch.StuRegistrationDate = null;
            }
             // ObjStudentResultlst= ObjBl.getmainitemdetails(ObjStudentSearch,ObjStudentResult,"niiast", "sp_GetAllOrSingleStudent1");
            ObjStudentResultlst = ObjBl.GetPaginatedStudentsResult(ObjStudentSearch, ObjStudentResult, "niiast", "sp_GetAllOrSingleStudent1",CurrentPage, PageSize);
            Count = ObjBl.GetCount(ObjStudentSearch, ObjStudentResult, "niiast", "sp_GetAllOrSingleStudent1");
            pageinitializationafterpost();
        }
        void pageinitializationafterpost()
        {
            ObjStudentSearch.StuRegistrationDate = DateTime.MinValue;
            CourseList = new List<SelectListItem>();
            CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
        }
        void pageinitialization()
        {
            
            ObjStudentResult = new StudentResult();
            ObjStudentSearch = new StudentSearch();
            ObjStudentSearch.StuRegistrationDate = DateTime.MinValue;
            CourseList = new List<SelectListItem>();
            CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
            ObjStudentResultlst = new List<StudentResult>();
        }
    }
}