using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CaseDiary.Service;
using Microsoft.AspNetCore.Mvc.Rendering;
//using CaseDiary.Models;
using NIIASTModels;
namespace CaseDiary.Pages.Shared
{
    public class BL
    {
        private ICaseDiaryRepository CaseDiaryRepository { get; set; }
        public List<SelectListItem> Options { get; set; }
        public List<SelectListItem> statelist { get; set; }
        public BL(ICaseDiaryRepository repository)
        {
            CaseDiaryRepository = repository;            
            
        }
        public void InsertItems(Students mystudent, string dbname, string spname)
        {
            CaseDiaryRepository.InsertItems<Students>(ref mystudent, dbname, spname);
        }
        public void InsertItems(FeesPayment payment, string dbname, string spname)
        {
            CaseDiaryRepository.InsertItems<FeesPayment>(ref payment, dbname, spname);
        }
        public List<SelectListItem> GetDropdownlistValsFromDatabase(string argmaincolumnname, string argtablename, int? argmaincolumnvalue)
        {
            SelectList locallist;
            Dictionary<int, string> catdict = new Dictionary<int, string>();
            catdict = CaseDiaryRepository.GetDropdownlistValsFromDatabase(argmaincolumnname, argtablename, argmaincolumnvalue);            
            statelist = GetDropDownSelectListItemFromDatabase(catdict);
            return statelist;
        }

        public List<SelectListItem> GetDropdownlistValsFromDatabase(string relationname, int argmaincolumnvalue)
        {
            SelectList locallist;
            Dictionary<int, string> catdict = new Dictionary<int, string>();
            catdict = CaseDiaryRepository.GetDropdownlistValsFromDatabase(relationname, argmaincolumnvalue);
            statelist = GetDropDownSelectListItemFromDatabase(catdict);
            return statelist;
        }
        //this following function is not used
        private SelectList GetDropDownSelectListFromDatabase(Dictionary<int, string> dict)
        {
            SelectList locallist;

            Options = new List<SelectListItem>();
            foreach (KeyValuePair<int, string> item in dict)
            {
                Options.Add(new SelectListItem() { Text = item.Value, Value = item.Key.ToString(), Selected = false });

            }

            locallist = new SelectList(Options, "Value", "Text");
            return locallist;
        }
        private List<SelectListItem> GetDropDownSelectListItemFromDatabase(Dictionary<int, string> dict)
        {
            

            Options = new List<SelectListItem>();
            foreach (KeyValuePair<int, string> item in dict)
            {
                Options.Add(new SelectListItem() { Text = item.Value, Value = item.Key.ToString(), Selected = false });

            }

           
            return Options;
        }
       
        public List<StudentResult> getmainitemdetails(StudentSearch obj, StudentResult objreturntype, string dbname, string spname, params object[] optionalargs)
        {
            List<StudentResult> listparty = CaseDiaryRepository.getmainitemdetails<StudentSearch, StudentResult>(ref obj, ref objreturntype, dbname, spname, optionalargs);
            return listparty;
        }
        public Dictionary<int,string> GetCardValsFromDatabase(string relationname, int Id)
        {
            Dictionary<int, string> listvalues = new Dictionary<int, string>();
            listvalues = CaseDiaryRepository.GetCardValsFromDatabase(relationname, Id);
            return listvalues;
        }
        public List<Students> getmainitemdetails(StudentSearch obj, Students objreturntype, string dbname, string spname, params object[] optionalargs)
        {
            List<Students> listparty = CaseDiaryRepository.getmainitemdetails<StudentSearch, Students>(ref obj, ref objreturntype, dbname, spname, optionalargs);
            return listparty;
        }
        public List<StudentResult> GetPaginatedStudentsResult(StudentSearch obj, StudentResult objreturntype, string dbname, string spname, int currentPage, int pageSize = 2, params object[] optionalargs)
        {
            var data = getmainitemdetails(obj, objreturntype, dbname, spname);
            return data.OrderBy(d => d.StudentId).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();
        }

        public int GetCount(StudentSearch obj, StudentResult objreturntype, string dbname, string spname)
        {
            var data = getmainitemdetails(obj, objreturntype, dbname, spname);
            return data.Count;
        }
        public List<FeesPayment> getmainitemdetails(FeesPaymentMasterSearch obj, FeesPayment objreturntype, string dbname, string spname, params object[] optionalargs)
        {
            List<FeesPayment> listparty = CaseDiaryRepository.getmainitemdetails<FeesPaymentMasterSearch, FeesPayment>(ref obj, ref objreturntype, dbname, spname, optionalargs);
            return listparty;
        }

        public List<FeesPaymentDetailResult> getmainitemdetails(FeesPaymentDetailSearch obj, FeesPaymentDetailResult objreturntype, string dbname, string spname, params object[] optionalargs)
        {
            List<FeesPaymentDetailResult> listparty = CaseDiaryRepository.getmainitemdetails<FeesPaymentDetailSearch, FeesPaymentDetailResult>(ref obj, ref objreturntype, dbname, spname, optionalargs);
            return listparty;
        }

        public List<FeesPaymentMasterResult> getmainitemdetails(FeesPaymentMasterSearch obj, FeesPaymentMasterResult objreturntype, string dbname, string spname, params object[] optionalargs)
        {
            List<FeesPaymentMasterResult> listparty = CaseDiaryRepository.getmainitemdetails<FeesPaymentMasterSearch, FeesPaymentMasterResult>(ref obj, ref objreturntype, dbname, spname, optionalargs);
            return listparty;
        }

    }
}
