using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NIIAST.Pages.FeesPayment
{
    public class NeethuModel : PageModel
    {
        [BindProperty]
        public NModel mdl { get; set; }
        public void OnGet()
        {
        }
    }
}
