﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using StackExchange.DataExplorer.Helpers;
using StackExchange.DataExplorer.ViewModel;
using StackExchange.DataExplorer.Models;

namespace StackExchange.DataExplorer.Controllers {

    public class UserController : StackOverflowController {

        [Route("users")]
        public ActionResult Index(int? page) {

            var currentPage = page ?? 1;

            SetHeader("Users");
            SelectMenuItem("Users");

            ViewData["PageNumbers"] = new PageNumber("/users?page=-1", (Current.DB.Users.Count() / 35) + 1, currentPage - 1, "pager fr");  

            var data = Current.DB.Users.OrderBy(u => u.Login).ToPagedList(page ?? 1, 35);
            return View(data);
        }


        [ValidateInput(false)]
        [HttpPost]
        [Route("users/update/{id}", RoutePriority.High)]
        public ActionResult Update(int id, User updatedUser) {

            var user = Current.DB.Users.First(u => u.Id == id);

            if (user.Id == updatedUser.Id && (updatedUser.Id == CurrentUser.Id || CurrentUser.IsAdmin)) {
                user.Login = HtmlUtilities.Safe(updatedUser.Login);
                user.AboutMe = updatedUser.AboutMe;
                user.DOB = updatedUser.DOB;
                user.Email = HtmlUtilities.Safe(updatedUser.Email);
                user.Website = HtmlUtilities.Safe(updatedUser.Website);
                user.Location = HtmlUtilities.Safe(updatedUser.Location);
                Current.DB.SubmitChanges();
                return Redirect("/users/" + user.Id.ToString());
            } else {
                return Redirect("/");
            }
        }

        [HttpGet]
        [Route("users/edit/{id}", RoutePriority.High)]
        public ActionResult Edit(int id) {

            var user = Current.DB.Users.First(u => u.Id == id);

            if (user.Id == CurrentUser.Id || CurrentUser.IsAdmin) {

                SetHeader(user.Login + " - Edit");
                return View(user);
            } else {
                return Redirect("/");
            }
        }

        [Route("users/{id}")]
        [Route("users/{id}/{ignore}")]
        public ActionResult Show(int id, object ignore, string order_by) {
            var user = Current.DB.Users.FirstOrDefault(row => row.Id == id);
            if (user == null) {
                return PageNotFound();
            }

            var db = Current.DB;

            SetHeader(user.Login);

            order_by = order_by ?? "saved";

            ViewData["UserQueryHeaders"] = new SubHeader()
            {
              Items = new List<SubHeaderViewData>() {
                    new SubHeaderViewData()
                    {
                        Description = "saved",
                        Title = "Saved Queries",
                        Href = "/users/" + user.Id.ToString() + "?order_by=saved",
                        Selected = (order_by == "saved")
                    },
                    new SubHeaderViewData()
                    {
                        Description = "favorite",
                        Title = "Favorite Queries",
                        Href = "/users/" + user.Id.ToString() + "?order_by=favorite",
                        Selected = (order_by == "favorite")
                    },
                    new SubHeaderViewData()
                    {
                        Description = "recent",
                        Title = "Recent Queries",
                        Href = "/users/" + user.Id.ToString() + "?order_by=recent",
                        Selected = (order_by == "recent")
                    }
                }
            };


            IQueryable<QueryExecutionViewData> queries;

            if (order_by == "recent") {
                queries = from e in db.QueryExecutions
                          join q in db.Queries on e.QueryId equals q.Id
                          join s in db.Sites on e.SiteId equals s.Id
                          where e.UserId == id
                          orderby e.LastRun descending
                          select new QueryExecutionViewData
                          {
                              LastRun = e.LastRun,
                              SiteName = s.Name.ToLower(),
                              SQL = q.QueryBody,
                              Id = q.Id,
                              Name = q.Name,
                              Description = q.Description, 
                              UrlPrefix = "q"
                          };
            } else {

                if (order_by == "favorite") {
                    
                    queries = from v in db.Votes
                              join e in db.SavedQueries on v.SavedQueryId equals e.Id
                              join q in db.Queries on e.QueryId equals q.Id
                              join s in db.Sites on e.SiteId equals s.Id
                              where v.UserId == id && v.VoteTypeId == (int)VoteType.Favorite
                              orderby e.LastEditDate descending
                              select new QueryExecutionViewData
                              {
                                  LastRun = e.LastEditDate ?? DateTime.Now,
                                  SiteName = s.Name.ToLower(),
                                  SQL = q.QueryBody,
                                  Id = e.Id,
                                  Name = e.Title,
                                  Description = e.Description
                              };

                } else {

                    queries = from e in db.SavedQueries
                              join q in db.Queries on e.QueryId equals q.Id
                              join s in db.Sites on e.SiteId equals s.Id
                              where e.UserId == id && !(e.IsDeleted ?? false)
                              orderby e.LastEditDate descending
                              select new QueryExecutionViewData
                              {
                                  LastRun = e.LastEditDate ?? DateTime.Now,
                                  SiteName = s.Name.ToLower(),
                                  SQL = q.QueryBody,
                                  Id = e.Id,
                                  Name = e.Title,
                                  Description = e.Description
                              };
                }
            }

            var queriesArray = queries.Take(50).ToArray();

            ViewData["Queries"] = queriesArray;
            if (queriesArray.Length == 0) {
                if (order_by == "recent") {
                    if (user.Id == CurrentUser.Id) {
                        ViewData["EmptyMessage"] = "You have never ran any queries";
                    } else {
                        ViewData["EmptyMessage"] = "No queries ran recently";
                    }
                } else if (order_by == "favorite") {
                    if (user.Id == CurrentUser.Id) {
                        ViewData["EmptyMessage"] = "You have no favorite queries, click the star icon on a query to favorite it";
                    } else {
                        ViewData["EmptyMessage"] = "No favorites";
                    }
                } 
                else 
                {
                    if (user.Id == CurrentUser.Id) {
                        ViewData["EmptyMessage"] = "You have no saved queries, you can save any query after you run it";
                    } else {
                        ViewData["EmptyMessage"] = "No saved queries";
                    }
                }
            } 
            return View(user);
        }

    }
}
