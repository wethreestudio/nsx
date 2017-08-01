<% CHECKFOR = "NSX" %>
<!--#INCLUDE FILE="chkuser.asp"-->
<%
MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="admin.css" type="text/css">
<META NAME="ROBOTS" CONTENT="NOINDEX">
<META NAME="ROBOTS" CONTENT="NOFOLLOW">
<title>NSX National Stock EXchange of Australia</title>
<meta name="Microsoft Border" content="none">
<link rel=stylesheet href="admin.css" type="text/css">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body bgcolor="#FFFFFF"  leftmargin="0">

	<h1 align="left">NSX Administration Menu</h1>

&nbsp;
        <div align="center">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td class="plaintext" width="315">
					<p>Welcome<font size="3" face="Arial"> </font><b>
					<font face="Arial" size="2"> <%=Session("fname")%></font></b><font size="3" face="Arial">.&nbsp;</font> The following options are available: 
              		<hr noshade size="1" color="#000000"></td>
					<td valign="top" rowspan="11" width="185" align="right">
					<table width="175" border="0" cellspacing="1" style="border: 1 solid #000000" bgcolor="#FFFFFF">
						<tr >
							<td bgcolor="#CCCCCC" class="rhlinks">
							<font face="Verdana" size="1"><b>
							<a href="member_end.asp">Logout</a></b></font> </td>
						</tr>
					</table></td>
				</tr>
				<tr>
					<td width="315" class="plaintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15">Delayed 
			Prices</td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
			(only after market close) - Daily Summary
					<ul>
						<li><a href="../Prices/prices_resend.asp?who=afr">Resend to AFR</a> 
						daily | <a href="../Prices/data_weekly.asp?dow=6">Resend 
						to AFR</a> - weekly</li>
						<li><a href="../Prices/prices_resend.asp?who=aap">Resend to APP 
						NSX</a> |
						<a href="../Prices/prices_resend_bsx.asp?who=aap">Resend to APP 
						BSX</a></li>
						<li><a href="../Prices/prices_resend.asp?who=telekurs">Resend to Telekurs</a></li>
						<li><a href="../Prices/prices_resend.asp?who=fax">Resend to FAX</a></li>
						<li>
						<a href="../Prices/netstradingreportformat_automatic.asp">
						Resend to NSX Brokers</a> - auto version</li>
						<li>
						<a href="../Prices/bsxtradingreportformat_automatic.asp">
						Resend to BSX Brokers</a> - auto version</li>
						<li><a href="../Prices/data_omx.asp?type=resend">Resend 
						Everything</a> - send all files to everyone</li>
						<li><a href="../Prices/adminftpprices.asp">Update FTP Prices</a></li>
						<li><a href="adminvwCurrentPrices.asp">Edit Current 
						Prices Table</a></li>
					</ul>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="annapp.asp">Manage
              Announcements</a> </td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">Upload a company or NSX announcement, change
        details, view users and new registrations.<br><a href="annpend.asp">Pending</a> | 
						<a href="annall.asp">All 
        Announcements</a> | <a href="annupnsx3.asp">Upload</a></font>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><font size="2">Trading 
            Reports</font></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p> <br>
						NSX: <br>
						<a href="../jec/netstradingreport.asp">Daily Trading Report</a>
            | <a href="../JEC/netsbrokerreport.asp">Monthly Broker Report</a>&nbsp;
						<br>
						<a href="../jec/marketdisplay.asp">Daily</a> |
            			<a href="../jec/marketdisplaymonthly.asp">Monthly</a> 
            | <a href="../jec/marketdisplayyearly.asp">Yearly</a> |
            			<a href="../JEC/marketdisplaycode.asp">By Code</a> |
            			<a href="../JEC/marketdisplaybroker.asp">By Broker</a>
						</p>
						<p>BSX: <br>
						<a href="../JEC/bsxstradingreport.asp">Daily Trading 
						Report</a> | <a href="../JEC/bsxsbrokerreport.asp">Monthly Broker Report</a><br>
						<a href="../jec/bsxmarketdisplay.asp">Daily</a> |
            			<a href="../jec/bsxmarketdisplaymonthly.asp">Monthly</a> 
            | <a href="../jec/bsxmarketdisplayyearly.asp">Yearly</a> |
            			<a href="../JEC/bsxmarketdisplaycode.asp">By Code</a> |
            			<a href="../JEC/bsxmarketdisplaybroker.asp">By Broker</a>
						</p>
						<p>Both: <a href="../JEC/marketdisplaycodedelete.asp">Delete Trade</a> |
						<a href="../trades_raw.asp">Trades Raw</a></p>
					</td>
				</tr>
				<tr>
					<td width="315" class="subcat2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwDiary.asp">Weekly 
            Diary</a> </td>
				</tr>
				<tr>
					<td width="315" class="subcat2"><font color="#000080">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Add or edit Weekly Diary Documents.<br>&nbsp;</font></td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="adminvwstats.asp" class="category2">Monthly
              Statistics</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">View, Add, Edit, or delete Monthly NSX Statistics.
            			<br>
						<a href="../market_eod_nsx.asp">NSX EOD Daily</a> |
						<a href="../market_eod_bsx.asp">BSX EOD Daily</a></font></td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="adminvwIssues.asp" class="category2">Issue
              Details</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">View, Add, Edit, Delist or Suspend Security Issue Details.
						<br><a href="admin_updateissuedshares.asp">Update Current Shares</a> |
						<a href="inc_txt_officiallist.asp">Update Details File</a> 
						| <a href="admin_updatelistedshares.asp">Listed Shares</a></font>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="adminvwMerchDetails.asp" class="category2">Company Details</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">View, Add, Edit, Delist or Suspend Companies.<br>
						</font><a href="adminvwCtry.asp" class="rhlinks">Add a Country</a>, 
						<a href="adminvwCity.asp" class="rhlinks">Add a City</a>,
            			<a href="adminvwstate.asp" class="rhlinks">Add
        a State</a>
					<br>
						<br>
						<a href="../admin_company_calendar.asp">Reporting 
						Calendar</a></td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="adminvwBus.asp" class="category2">Business
              Connections</a> </td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">Add or edit Business Connections profiles.</font>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="stats.asp" class="category2">Email Users</a>
					</td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">Add or edit Email Users.</font>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="adminvwNews.asp" class="category2">News
              Articles</a> </td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">Add or edit News Articles/Press releases.</font>
					</td>
				</tr>
				<tr>
					<td width="315" class="plaintext">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="adminvwNews.asp" class="category2">News 
			Feeds</a> (RSS)</td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<ul>
						<li><a href="inc_rss_announcements.asp">Update Announcements RSS</a></li>
						<li><a href="inc_rss_diary.asp">Update Weekly Diary RSS</a></li>
						<li><a href="inc_rss_news.asp">Update Exchange News RSS</a></li>
						<li><a href="inc_rss_officiallist.asp">Update Officiallist RSS</a></li>
						<li><a href="inc_rss_floats.asp">Update Floats RSS</a></li>
						<li><a href="inc_rss_events.asp">Update Events RSS</a></li>
						<li><a href="/prices/inc_rss_prices.asp">Update Prices RSS</a></li>
						<li><a href="/prices/inc_rss_index.asp">Update Index RSS</a></li>
					</ul>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwEvents.asp">Events
              Articles</a> </td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">Add or edit News Articles/Press releases.</font>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a href="admindefault.asp" class="category2">System
              Users</a> </td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					<font color="#000080">Display an edit user details</font>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwAdvDetails.asp">Nominated 
            Advisers</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">View, Add, Edit, Nominated Adviser Details</font></p>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwfacDetails.asp">Facilitators</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">View, Add, Edit, Nominated Adviser Details</font></p>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwBroDetails.asp">Member 
            Brokers</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">View, Add, Edit, Member Broker Details<br>
						<a href="adminvwBrokers.asp">Broker Trading Details</a></font></p>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwWaiver.asp">Waiver 
            Register</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">View, Add, Edit, Waiver Register</font></p>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="../jec/marketdisplay.asp">Surveillance</a> 
            - <a class="category2" href="../jec/marketdisplay.asp">Daily</a> |
            		<a class="category2" href="../jec/marketdisplaymonthly.asp">Monthly</a> 
            | <a class="category2" href="../jec/marketdisplayyearly.asp">Yearly</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">Check trade details - daily, monthly or yearly 
            summaries</font></p>
					</td>
				</tr>
				<tr>
					<td width="315" class="subcat2">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15">Site 
					Statistics</td>
				</tr>
				<tr>
					<td width="315" class="subcat2">
					<ul>
						<li>
						<a class="subcat2" href="http://wic007s.server-statistics.com/livestats/login.aspx?Domain=www.nsxa.com.au">Site 
            Statistics - NSXA</a></li>
						<li>
						<a class="subcat2" href="http://wic006s.server-statistics.com:80/livestats/login.aspx?Domain=www.newsx.com.au">Site 
            Statistics - NEWSX</a></li>
						<li>
						<a target="_blank" class="subcat2" href="http://stats.dtdesign.com/LiveStats/login.aspx?Domain=bsx.com.au&User=bsx&Password=93kar387">Site Statistics - BSX</a></li>
						<li>
						<a class="subcat2" target="_blank" href="http://wic005s.server-statistics.com:80/livestats/login.aspx?Domain=www.nsx.net.au">Site Statistics - NSXL</a></li>
						<li>
						<a class="subcat2" target="_blank" href="http://wic018u.server-statistics.com:87/stats?action=login&username=&password=&serverid=vs215347">Site Statistics - WSX</a></li>
						<li>
						<a target="_blank" class="subcat2" href="http://stats.dtdesign.com/LiveStats/login.aspx?Domain=bsxtaxismarket.com.au&User=bsx&Password=93kar387">Site Statistics - BSX 
				Taxis</a></li>
						<li>
						<a href="<%= Application("nsx_AdminSiteRootURL") %>/serverstatus.asp">
						Server Status</a></li>
					</ul>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminvwBanners.asp">Banners</a> 
            | <a class="category2" href="adminbannerstats.asp">Banner Statistics</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">Add, View, Edit, Delete Edit Banner Adverts</font></p>
					</td>
				</tr>
				<tr>
					<td width="315">&nbsp;&nbsp;&nbsp;&nbsp;
					<img border="0" src="../images/broker_page1_bullet.gif" width="20" height="15"><a class="category2" href="adminfeescalc.asp">Fee 
            Calculator</a></td>
				</tr>
				<tr>
					<td class="subcat2" width="315">
					
						<p><font color="#000080">Calculate NSX Listing Fees</font></p>
					</td>
				</tr>
			</table></div>
<p>
&nbsp;
<p>&nbsp;
</body>

</html>