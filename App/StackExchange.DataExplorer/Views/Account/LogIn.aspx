﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" %>
<%@ Import Namespace="StackExchange.DataExplorer" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
  Log In or Register - Stack Exchange Data Explorer
</asp:Content>


<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="page-description">
    <div class="form-error">
    </div>
    <form id="openid_form" action="/user/authenticate" method="post">       
            
            <div id="openid_choice"> 
	            <p>Click your <a href="http://openid.net/what/">OpenID</a> account provider</p> 
	            <div id="openid_btns"></div> 
            </div> 
			
            <div id="openid_input_area"> 
            </div> 
	        
	        <div> 
	            <noscript> 
                <p>OpenID is a service that allows you to log on to many different websites using a single identity.
                Find out <a href="http://openid.net/what/">more about OpenID</a> and <a href="http://openid.net/get/">how to get an OpenID enabled account</a>.</p> 
                </noscript> 
            </div> 
                        
            <p>Or, manually enter your OpenID</p> 
            
            <table id="openid-url-input"> 
                <tr>            
                    <td class="vt large"><input id="openid_identifier" name="openid_identifier" 
                      class="openid-identifier" style="height:28px; width:500px;"  tabindex="100"></td> 
                    <td class="vt large"><input id="submit-button" 
                      style="margin-left:5px; height:36px;" type="submit" value="Log in" tabindex="101"></td> 
                </tr>                                
                
 
            </table> 
            
           
            
        </form> 
  </div>

  <link rel="stylesheet" href="http://sstatic.net/so/openid.css"> 
  <%= AssetPackager.ScriptSrc("jquery") %>
  <script src="http://sstatic.net/so/Js/third-party/openid-jquery.js?v=2" type="text/javascript"></script>

  <script type="text/javascript">
    $().ready(function () {
      openid.init('openid_identifier');
      $("#openid_identifier").focus();
    });
    </script> 
</asp:Content>
