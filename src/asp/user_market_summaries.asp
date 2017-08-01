<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "USR" %>
<!--#INCLUDE FILE="member_check.asp"-->
<%
page_title = "myNSX User Services"
alow_robots = "no"
%>

<!--#INCLUDE FILE="header.asp"-->

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "user_side_menu.asp"
%>


<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">

  <div class="editarea">
    <h1>Market Summary Alerts</h1>

	<form method="POST" action="user_market_summaries_save.asp">
		<% 
      
portfolioname=trim(request("portfolioname") & " ")
if len(portfolioname="") then portfolioname="default"
      

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
  
ConnPasswords.Open Application("nsx_ReaderConnectionString") 

SQL = "SELECT username,smseod,emaileod,smsindices,emailindices"
SQL = SQL & " FROM usubscribers "
SQL = SQL & " WHERE (username='" & session("username") & "') "
CmdEditUser.Open SQL, ConnPasswords,1,3

WEOF = CmdEditUser.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = CmdEditUser.getrows
	rc = ubound(alldata,2) 
	else
	rc = -1
end if

CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing

' only allow a maximum of 20 stocks in the portfolio.


smseod = alldata(1,0)
emaileod= alldata(2,0)
smsindices=alldata(3,0)
emailindices=alldata(4,0)
%>

		<b>Market Summaries</b><br>
		Select which end of day market summaries you would like to receive:<br>
			<table width="100%" id="table1">
				<tr>
					<td valign="top">
					<input type="checkbox" name="smseod" value="true" <%if smseod = true then response.write " CHECKED"%>> </td>
					<td>
					SMS summary of trading - includes 
					number of trades, value, volume, NSXAEI index value (up/down), 
					once per day at end of market.</td>
				</tr>
				<tr>
					<td valign="top">
					<input type="checkbox" name="emaileod" value="true" <%if emaileod = true then response.write " CHECKED"%>> </td>
					<td>
					Email summary of trading - 
					includes number of trades, value, volume, NSXAEI index value 
					(up/down), once per day at end of market.</td>
				</tr>
				<tr>
					<td valign="top">
					<input type="checkbox" name="smsindices" value="true" <%if smsindices = true then response.write " CHECKED"%>> </td>
					<td>
					SMS summary of indices - a 
					selection of indices that have traded that day including 
					NSXAEI (up/down), once per day at end of market.</td>
				</tr>
				<tr>
					<td valign="top">
					<input type="checkbox" name="emailindices" value="true" <%if emailindices = true then response.write " CHECKED"%>> </td>
					<td>
					Email summary of indices - 
					a selection of indices that have traded that day including 
					NSXAEI (up/down), once per day at end of market.</td>
				</tr>
				<tr>
					<td valign="top" colspan="2">
	         <input type="submit" value="Save Selections"></td>
				</tr>
				<tr>
					<td valign="top" colspan="2">
					<br>
					Summaries are sent once per day only via Email or SMS to your mobile phone.  Please note at this stage only Australian mobile phones are able to receive these alerts.&nbsp; 
		You must have a current mobile phone number and email address stored in 
		your <a href="/user_edit_your_details.asp">profile</a> to take advantage 
		of SMS and email services </td>
				</tr>
			</table>		
			


  <p>Test your SMS and Email connections: <a href="user_test.asp?pss=nsxa">Start Test Now</a> 
<%
		if session("errmsg")<>"OK" then
		  response.write "<br><font color=red size=1 face=arial><b>" & session("errmsg") & "</b></font><br>"
		else
		  response.write "<br><font color=green size=1 face=arial><b>Please check your mobile and email in box for a welcome message.</b></font>"
		end if 
%>
  </p>
</form>



    <p><b>Disclaimer and rights</b><br>
		NSX accepts no responsibility if many messages are generated on your 
		phone or email services. This service is made available as a 
		curtsey only. NSX reserves the right to remove the service at any 
		time or to suspend or disable the alerts service. If you no longer 
		require this service please log on and delete your portfolio or your SMS/Email 
		selections. To avoid spam, NSX reserves the right to disable SMS 
		or email alerts on a user account if NSX believes this account has 
		incorrect details.  NSX reserves the right to suspend or delete a 
		user account at any time. NSX reserves the right to charge for 
		services in the future. If NSX charges for services in the future 
		users will be able to sign up for subscription based content.  
		Services that become chargeable will be removed from the free section of 
		the site.</fieldset><p>


  </div>

</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>


<!--#INCLUDE FILE="footer.asp"-->

