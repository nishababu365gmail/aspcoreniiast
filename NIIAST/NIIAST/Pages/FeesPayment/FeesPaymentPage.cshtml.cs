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
    public class FeesPaymentPageModel : PageModel
    {
        [BindProperty(SupportsGet = true)]
        public FeesPayment ObjFeesPayment { get; set; }
        public List<SelectListItem> Studentlist { get; set; }

        public List<SelectListItem> Courselist { get; set; }
        public List<FeesPayment> FeesPaymentlst { get; set; }
        public BL ObjBl { get; set; }
        [BindProperty]
        public decimal FeesTobePaid { get; set; }
        [BindProperty]
        public string CourseName { get; set; }
        [BindProperty]
        public string  StudentName { get; set; }
        public FeesPaymentDetailSearch DetailSearch { get; private set; }
        public FeesPaymentDetailResult DetailResult { get; private set; }
        public FeesPaymentMasterResult MasterResult { get; private set; }
        public List<FeesPaymentMasterResult> MasterResultlst { get; private set; }
        public List<FeesPaymentDetailResult> DetailResultlst { get; private set; }
        public FeesPaymentMasterSearch MasterSearch { get; private set; }

        public FeesPaymentPageModel(ICaseDiaryRepository repository)
        {
            ObjBl = new BL(repository);
        }
        public JsonResult OnGetStudentCourse(int StudentId)
        {
            Courselist = ObjBl.GetDropdownlistValsFromDatabase("student_course", StudentId);

            return new JsonResult(Courselist);
            //return new JsonResult(objbl.GetDropdownlistValsFromDatabase("MainCourtId", "m_subcourt", CourtId));
        }
        public void OnGet(int FeesPaymentId)
        {
            pageinitialization();
            if (FeesPaymentId > 0)
            {
                decimal LocalFeesPaid = 0.00M;
                DetailSearch = new FeesPaymentDetailSearch();
                MasterSearch = new FeesPaymentMasterSearch();
                DetailResult = new FeesPaymentDetailResult();
                MasterResult = new FeesPaymentMasterResult();
                MasterResultlst = new List<FeesPaymentMasterResult>();
                DetailResultlst = new List<FeesPaymentDetailResult>();
                DetailSearch.FeesPaymentId = FeesPaymentId;
                Courselist = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
                DetailResultlst = ObjBl.getmainitemdetails(DetailSearch, DetailResult, "niiast", "sp_GetAllOrSingleFeesPaymentDetails");
                if (DetailResultlst.Count > 0)
                {
                    MasterSearch.FeesPaymentMasterId = DetailResultlst[0].MasterFeesPaymentId;
                }
                MasterResultlst = ObjBl.getmainitemdetails(MasterSearch, MasterResult, "niiast", "sp_GetAllOrSingleFeesPaymentMaster");
                if (MasterResultlst.Count > 0)
                {
                    ObjFeesPayment.FeesDueAmount = MasterResultlst[0].FeesDueAmount;
                    LocalFeesPaid= MasterResultlst[0].FeesPaid;
                }
                if (DetailResultlst.Count > 0)
                {
                    ObjFeesPayment.StudentId = DetailResultlst[0].StudentId;
                    ObjFeesPayment.CourseId = DetailResultlst[0].CourseId;
                    ObjFeesPayment.Fees = DetailResultlst[0].Fees;
                    ObjFeesPayment.FeesPaidDate = DetailResultlst[0].FeesPaidDate;                    
                    ObjFeesPayment.FeesPaymentId = DetailResultlst[0].FeesPaymentId;
                    FeesTobePaid = ObjFeesPayment.FeesDueAmount - LocalFeesPaid;
                    CourseName = DetailResultlst[0].CourseName;
                    StudentName = DetailResultlst[0].StuFirstName;
                }
                    
                
            }
        }

        void pageinitialization()
        {
            ObjFeesPayment = new FeesPayment();
            ObjFeesPayment.FeesPaidDate = DateTime.Now.Date;
            Studentlist = new List<SelectListItem>();
            Studentlist = ObjBl.GetDropdownlistValsFromDatabase("", "m_student", 0);
        }

        public void OnPost()
        {
            ObjBl.InsertItems(ObjFeesPayment, "niiast", "sp_save_masterfeespayment");
            pageinitialization();
        }


        public JsonResult OnGetStudentFeesPayment(int CourseId, int StudentId)
        {
            ObjFeesPayment = new FeesPayment();
            FeesPaymentMasterSearch objsearch = new FeesPaymentMasterSearch();
            objsearch.StudentId = StudentId;
            objsearch.CourseId = CourseId;
            FeesPaymentlst = ObjBl.getmainitemdetails(objsearch, ObjFeesPayment, "niiast", "sp_GetFeesStudentCourseWise", 0);
            if (FeesPaymentlst.Count > 0) { 
            ObjFeesPayment = FeesPaymentlst[0];            }
            
            FeesTobePaid = ObjFeesPayment.FeesDueAmount - ObjFeesPayment.FeesPaid;
            return new JsonResult(ObjFeesPayment);
        }
    }
}