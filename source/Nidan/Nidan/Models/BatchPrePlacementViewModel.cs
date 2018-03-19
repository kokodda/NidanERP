﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nidan.Entity;

namespace Nidan.Models
{
    public class BatchPrePlacementViewModel : BaseViewModel
    {
        public BatchPrePlacement BatchPrePlacement { get; set; }
        public SelectList Batches { get; set; }
        public SelectList Centres { get; set; }
    }
}