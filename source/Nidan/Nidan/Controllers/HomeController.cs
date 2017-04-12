﻿using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using Nidan.Business.Interfaces;
using Nidan.Extensions;
using Nidan.Models;


namespace Nidan.Controllers
{
    [Authorize]
    public class HomeController : BaseController
    {
        public HomeController(INidanBusinessService nidanBusinessService) : base(nidanBusinessService)
        {
        }

        private readonly DateTime _today = new DateTime(DateTime.UtcNow.Year, DateTime.UtcNow.Month, DateTime.UtcNow.Day, 0, 0, 0);
        public ActionResult Index()

        {
            var organisationId = UserOrganisationId;
            var personnelId = UserPersonnelId;
            var centreId = UserCentreId;
            bool isSuperAdmin = User.IsInAnyRoles("SuperAdmin");

            var permissions = NidanBusinessService.RetrievePersonnelPermissions(User.IsInRole("Admin"), organisationId, personnelId);

            var enquiryCount = NidanBusinessService.RetrieveFollowUps(UserOrganisationId,
               e => (isSuperAdmin || e.CentreId == UserCentreId) && e.FollowUpDateTime == _today && e.FollowUpType.ToLower() == "enquiry").Items.Count();

            var totalEnquiryCount =
                NidanBusinessService.RetrieveEnquiries(UserOrganisationId, e => (isSuperAdmin || e.CentreId == UserCentreId) && e.Close != "Yes" && e.Registered == false).Count();

            var counsellingCount = NidanBusinessService.RetrieveFollowUps(UserOrganisationId,
               e => (isSuperAdmin || e.CentreId == UserCentreId) && e.FollowUpDateTime == _today && e.FollowUpType.ToLower() == "counselling").Items.Count();

            var totalMobilizationCount =
                NidanBusinessService.RetrieveMobilizations(UserOrganisationId, e => (isSuperAdmin || e.CentreId == UserCentreId) && e.Close != "Yes")
                    .Items.Count();


            if (User.IsInRole("User") && !permissions.IsManager)
                return RedirectToAction("Profile", "Personnel", new { id = personnelId });

            var viewModel = new HomeViewModel
            {
                Permissions = permissions,
                EnquiryCount = enquiryCount,
                CounsellingCount = counsellingCount,
                TotalEnquiryCount = totalEnquiryCount,
                TotalMobilizationCount = totalMobilizationCount
                //Divisions = initialDivisions,
                //SelectedDivisionIds = permissions.IsAdmin ? null : initialDivisions.Select(c => c.DivisionId).ToList()
            };

            return View(viewModel);
        }

        [AllowAnonymous]
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View(new BaseViewModel());
        }

        [AllowAnonymous]
        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View(new BaseViewModel());
        }
    }
}