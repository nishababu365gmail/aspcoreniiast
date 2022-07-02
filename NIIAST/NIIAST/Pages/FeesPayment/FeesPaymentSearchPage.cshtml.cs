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
    public class FeesPaymentSearchPageModel : PageModel
    {
        public BL ObjBl { get; set; }
        public List<SelectListItem> CourseList { get; set; }
        public List<SelectListItem> StudentList { get; set; }        
        public FeesPaymentDetailSearch DetailSearch { get; set; }
        public FeesPaymentDetailResult DetailResult { get; set; }
        [BindProperty]
        public FeesPaymentMasterSearch MasterSearch { get; set; }
        public FeesPaymentMasterResult MasterResult { get; set; }
        public List<FeesPaymentDetailResult> DetailResultlst { get; set; }
        public List<FeesPaymentMasterResult> MasterResultlst { get; set; }
        public FeesPaymentSearchPageModel(ICaseDiaryRepository repository)
        {
            ObjBl = new BL(repository);
        }
        public void OnGet(){
            pageinitialization();           
        }
        void pageinitialization()
        {
            MasterSearch = new FeesPaymentMasterSearch();
            MasterResult = new FeesPaymentMasterResult();
            DetailResultlst = new List<FeesPaymentDetailResult>();
            MasterResultlst = new List<FeesPaymentMasterResult>();            
            CourseList = new List<SelectListItem>();
            CourseList = ObjBl.GetDropdownlistValsFromDatabase("", "m_course", 0);
            StudentList = new List<SelectListItem>();
            StudentList = ObjBl.GetDropdownlistValsFromDatabase("", "m_student", 0);
            
        }
        public void OnPostGetFeesPaymentDetails()
        {
            DetailSearch = new FeesPaymentDetailSearch();
            DetailResult = new FeesPaymentDetailResult();
            MasterResult = new FeesPaymentMasterResult();
            MasterResultlst = new List<FeesPaymentMasterResult>();
            DetailResultlst = new List<FeesPaymentDetailResult>();
            MasterResultlst = ObjBl.getmainitemdetails(MasterSearch, MasterResult, "niiast", "sp_GetAllOrSingleFeesPaymentMaster");             
            DetailResultlst = ObjBl.getmainitemdetails(DetailSearch, DetailResult, "niiast", "sp_GetAllOrSingleFeesPaymentDetails");
        }
    }
   
    
    
}