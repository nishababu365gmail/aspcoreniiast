using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CaseDiary.Pages.Shared;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using NIIASTModels;
using CaseDiary.Service;

namespace NIIAST
{
    public class IndexModel : PageModel
    {
        public FeesPaymentDetailSearch DetailSearch { get; set; }
        public FeesPaymentDetailResult DetailResult { get; set; }        
        public FeesPaymentMasterSearch MasterSearch { get; set; }
        public FeesPaymentMasterResult MasterResult { get; set; }
        public List<FeesPaymentDetailResult> DetailResultlst { get; set; }
        [BindProperty]
        public List<FeesPaymentMasterResult> MasterResultlst { get; set; }
        [BindProperty]
           public decimal TotalFeesPaid { get; set; }
        [BindProperty]
        public decimal TotalFeesDueAmount { get; set; }

        [BindProperty]
        public decimal TotalFeesRemaining{ get; set; }
        public IndexModel(ICaseDiaryRepository repository)
        {
            ObjBl = new BL(repository);
        }
        public StudentResult ObjStudentResult { get; set; }        
        public StudentSearch ObjStudentSearch { get; set; }
        public List<SelectListItem> CourseList { get; set; }
        public BL ObjBl { get; set; }
        [BindProperty]
        public List<StudentResult> ObjStudentResultlst { get; set; }
        void pageinitialization()
        {

            ObjStudentResult = new StudentResult();
            ObjStudentSearch = new StudentSearch();
            ObjStudentSearch.StuRegistrationDate = DateTime.MinValue;
            CourseList = new List<SelectListItem>();
            CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
            ObjStudentResultlst = new List<StudentResult>();            
            MasterResult = new FeesPaymentMasterResult();
            MasterResultlst = new List<FeesPaymentMasterResult>();            
            MasterSearch = new FeesPaymentMasterSearch();
            MasterResultlst = ObjBl.getmainitemdetails(MasterSearch, MasterResult, "niiast", "sp_GetAllOrSingleFeesPaymentMaster");
           
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
             TotalFeesPaid=   m.Sum(x => x.FeesPaid);
            TotalFeesDueAmount=    m.Sum(x => x.FeesDueAmount);
            TotalFeesRemaining = TotalFeesDueAmount - TotalFeesPaid;
           // return 0.0M;
        }
        public void OnGet()
        {
            //GetAllCoursesOfSingleStudent("student_course",12);
            pageinitialization();
            if(ObjStudentSearch.StuRegistrationDate == DateTime.MinValue)
            {
                ObjStudentSearch.StuRegistrationDate = null;
            }
            ObjStudentResultlst = ObjBl.getmainitemdetails(ObjStudentSearch, ObjStudentResult, "niiast", "sp_GetAllOrSingleStudent1");
        }
        public  string GetAllCoursesOfSingleStudent(string relationname,int Id)
        {
            string ConcatenatedCourseValues = "";
            Dictionary<int, string> CourseDict = new Dictionary<int, string>();
            CourseDict = ObjBl.GetCardValsFromDatabase(relationname, Id);
            if (CourseDict.Count > 0)
            {
              ConcatenatedCourseValues=   string.Join(",", CourseDict.Values.ToList());
               
            }
            return ConcatenatedCourseValues;
        }
    }
}