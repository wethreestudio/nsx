<!--#INCLUDE FILE="include_all.asp"-->

<%
page_title = "User Registration"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left comp-info">
                <h1>Registration</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
                <h1>Registration</h1>
  <div class="editarea">
  <h1>myNSX Registration</h1>
  
  <% If Len(Session("PASSWORDACCESSDESC")) > 0 Then %>
  <div style="border:1px solid #ff0000;padding:8px; color:#ff0000; font-weight:bold; margin:8px;">
  <%= Session("PASSWORDACCESSDESC") %>
  </div>
  <% End If %>
  
  <div align="center" style="padding-bottom:20px;">
    This is a free service.&nbsp; Registration is 
    required to access email and sms alert services.&nbsp; Please read the 
    disclaimer below.
  </div>
  
  <form method="POST" action="<%= Application("nsx_SiteRootURL") %>/user_save_registration.asp" name="FrontPage_Form1">
    <div align="center">
      <div class="table-responsive"><table border="0" width="450" bgcolor="#FFFFFF" cellpadding="3" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
      <tr>
      	<td align="right">Username:</td>
      	<td align="left"><input type="text" name="username" size="20" maxlength="100" value="<%=Server.HTMLEncode(session("username"))%>"> *</td>
      </tr>      
      <tr>
        <td align="right">First Name:</td>
        <td align="left"><input type="text" name="fname" size="15" value="<%=Server.HTMLEncode(session("fname"))%>"> *</td>
      </tr>
      <tr>
        <td align="right">Last Name:</td>
        <td align="left"><input type="text" name="lname" size="15" value="<%=Server.HTMLEncode(session("lname"))%>"> *</td>
      </tr>
      <tr>
      	<td align="right">Email:</td>
      	<td align="left"><input type="text" name="email" size="50" maxlength="255" value="<%=Server.HTMLEncode(session("email"))%>"> *</td>
      </tr>
      <tr>
      	<td align="right">Mobile Phone</td>
      	<td align="left"><input type="text" name="mobile" size="20" maxlength="20" value="<%=Server.HTMLEncode(session("mobile"))%>"> *</td>
      </tr>

      <tr>
      	<td align="right">Password:</td>
      	<td align="left"><input type="password" name="password" size="20" value="<%=Server.HTMLEncode(session("password"))%>"> *</td>
      </tr>
      <tr>
      	<td align="right" nowrap >Confirm Password:</td>
      	<td align="left"><input type="password" name="confirmpassword" size="20" value="<%=Server.HTMLEncode(session("confirmpassword"))%>" > *</td>
      </tr>
      <tr>
      	<td valign="top" align="right" colspan="2">
        	<p align="left">
            * Please supply all details to complete your 
          	registration.<br>
          	* For the SMS services only Australian and New Zealand mobile phones are supported 
          	at this time. Please <a href="/about/contact_us">contact us</a> and 
          	register your interest in receiving alerts to an overseas mobile 
          	phone.
          </p>
        </td>
      </tr>
      </table></div></div>
      <div align="center">
      <input type="submit" name="register" id="register" value="Register" class="btn nsx-blue request-kit popup">
    </div>
  </form>
  <fieldset style="padding: 2; width:550">
  <legend><b>Disclaimer and rights</b></legend>
  NSX accepts no responsibility if many messages are generated on your 
  phone or email services. This service is made available as a 
  curtsey only. NSX reserves the right to remove the service at any 
  time or to suspend or disable the alerts service. If you no longer 
  require this service please log on and delete your portfolio or your SMS/Email 
  selections. To avoid spam, NSX reserves the right to disable SMS 
  or email alerts on a user account if NSX believes this account has 
  incorrect details. NSX reserves the right to suspend or delete a 
  user account at any time. NSX reserves the right to charge for 
  services in the future. If NSX charges for services in the future, 
  users will be able to sign up for subscription based content. 
  Services that become chargeable will be removed from the free section of 
  the site.
  </fieldset>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->