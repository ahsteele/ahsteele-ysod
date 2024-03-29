﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<StackExchange.DataExplorer.Models.User>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
  User - <%= Model.Login %> Edit - Stack Exchange Data Explorer
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <table width="720px" id="user-edit-table">
    <tbody>
      <tr>
        <td style="vertical-align: top; text-align: center; padding: 20px; width: 128px;
          vertical-align: top; text-align: center; padding: 20px; width: 128px;">
          <h3>
            <%= Model.Gravatar(128) %>
            <a href="http://gravatar.com">Change Picture</a>
          </h3>
        </td>
        <td style="vertical-align: top;">
          <h2>
            Registered User</h2>
          <form action="/users/update/<%= Model.Id %>" method="post">
          <%= Html.ValidationSummary(true) %>
          <table style="width: 600px;">
            <tbody>
              <tr>
                <td>
                  <%= Html.LabelFor(model => model.Login) %>
                </td>
                <td>
                  <%= Html.TextBoxFor(model => model.Login, new { style = "width: 260px" })%>
                  <%= Html.ValidationMessageFor(model => model.Login) %>
                </td>
              </tr>
              <tr>
                <td>
                  <%= Html.LabelFor(model => model.Email) %>
                </td>
                <td>
                  <%= Html.TextBoxFor(model => model.Email, new { style = "width: 260px" })%>
                  <%= Html.ValidationMessageFor(model => model.Email) %>
                </td>
              </tr>
              <tr>
                <td>
                  <%= Html.LabelFor(model => model.Website) %>
                </td>
                <td>
                  <%= Html.TextBoxFor(model => model.Website, new { style = "width: 260px" })%>
                  <%= Html.ValidationMessageFor(model => model.Website) %>
                </td>
              </tr>
              <tr>
                <td>
                  <%= Html.LabelFor(model => model.Location) %>
                </td>
                <td>
                  <%= Html.TextBoxFor(model => model.Location, new {style = "width: 260px"})%>
                  <%= Html.ValidationMessageFor(model => model.Location) %>
                </td>
              </tr>
              <tr>
                <td>
                  <label>
                    Birthday</label>
                </td>
                <td>
                  <%= Html.TextBoxFor(model => model.DOB, String.Format("{0:g}", Model.DOB)) %>
                  <%= Html.ValidationMessageFor(model => model.DOB) %>
                  <span style="color: rgb(136, 136, 136);">YYYY/MM/DD</span>
                </td>
              </tr>
              <tr>
                <td style="vertical-align: top;">
                  <label>
                    About Me</label>
                </td>
                <td>
                  <%= Html.TextAreaFor(model => model.AboutMe, new {rows = 12, cols = 56})%>
                  <%= Html.ValidationMessageFor(model => model.AboutMe) %>
                </td>
              </tr>
              <tr>
                <td>
                </td>
                <td class="form-submit">
                  <input type="submit" value="Save Profile" />
                  <input type="button" onclick="location.href='/users/<%=Model.Id %>'" value="Cancel" name="cancel" id="cancel"/>
                </td>
              </tr>
            </tbody>
          </table>
          </form>
        </td>
      </tr>
    </tbody>
  </table>
</asp:Content>
