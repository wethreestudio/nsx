<%Server.ScriptTimeout=180
Application("nsx_daylight_saving")=False
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<META NAME="revisit-after" content="4 days">
<META NAME="robots" CONTENT="all">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.  Australia's second official stock exchange.">
<meta name="keywords" content="australian stock exchange, public listing, listed, official list, prices, ipo, float, floats, ipos, investing in innovation, small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel=stylesheet href="newsx2.css" type="text/css">

<link rel="alternate" type="application/rss+xml" title="NSX Company Announcements" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_announcements.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Exchange News" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_news.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Floats" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_floats.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Official List" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_officiallist.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Weekly Diary" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_diary.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Events List" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_events.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Prices Table" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_prices.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Index Table" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_index.xml">

<link rel="shortcut icon" href="favicon.ico" >
<meta name="Microsoft Border" content="none">
</head>

<body >
<!--#INCLUDE FILE="headergoogle.asp"-->
<div id="tooltips" align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="plaintext" bgcolor="#FFFFFF" colspan="3" align="center"><%
    session("region")=""
    server.execute "ticker2.asp"
    %> </td>
  </tr>
  <tr>
    <td valign="top" bgcolor="#FFFFFF" width="200" >
<div align="center">
<table cellpadding="4" style="border:1px solid #666666; padding:0; border-collapse: collapse" width="92%" id="table11" border="0">
	<tr>
		<td class="plaintext" bgcolor="#959ca0"><font color="#FFFFFF"><b>Quick 
		Links</b></font></td>
	</tr>
	<tr>
		<td class="plaintext">
		<font face="Arial, helvetica, sans-serif" size="2" color="#000080">
		<img name="floats" border="0" src="images/v2/Dpoint1.jpg" alt="View upcoming floats on NSX">
		<a href="float_list.asp" class="mnlinks" onmouseover="spec('floats','imgtdon')" onmouseout="spec('floats','imgtdoff')" >New Floats</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="tp" alt="View the latest prices for all stocks">
		<a class="mnlinks" onmouseover="spec('tp','imgtdon')" onmouseout="spec('tp','imgtdoff')" href="prices_alpha.asp?board=ncrp">Prices</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="co" alt="View the latest company announcements">
		<a href="announcements_list.asp" class="mnlinks" onmouseover="spec('co','imgtdon')" onmouseout="spec('co','imgtdoff')">Company News</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="cr" alt="Select various company details">
		<a href="company_research_public.asp" class="mnlinks" onmouseover="spec('cr','imgtdon')" onmouseout="spec('cr','imgtdoff')">
		Company Details</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="wh" alt="View the listed companies register">
		<a href="market_officiallist.asp" class="mnlinks" onmouseover="spec('wh','imgtdon')" onmouseout="spec('wh','imgtdoff')">Who's Listed?</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="id" alt="View the listed companies register">
		<a href="prices_index.asp" class="mnlinks" onmouseover="spec('id','imgtdon')" onmouseout="spec('id','imgtdoff')">
		Index</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="br" alt="View the registered broker list">
		<a href="broker_list.asp" class="mnlinks" onmouseover="spec('br','imgtdon')" onmouseout="spec('br','imgtdoff')">Find a Broker</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="ts" alt="View the trading process">
		<a href="inv_how_to_trade.asp" class="mnlinks" onmouseover="spec('ts','imgtdon')" onmouseout="spec('ts','imgtdoff')">Trading </a>
		<br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="tz0" alt="View reporting due dates">
		<a href="company_calendar.asp" class="mnlinks" onmouseover="spec('tz0','imgtdon')" onmouseout="spec('tz0','imgtdoff')" >
		Reporting</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="tz" alt="View the latest exchange news">
		<a href="news_list.asp" class="mnlinks" onmouseover="spec('tz','imgtdon')" onmouseout="spec('tz','imgtdoff')">What's New</a></font></td>
	</tr>
	</table>
  


    <p style="margin-top: 0; margin-bottom: 0"><font size="1">&nbsp;</font><img border="0" src="images/spacer.gif" width="40" height="1"></p>
<table cellpadding="4" style="border:1px solid #666666; border-collapse: collapse; padding-left:4px; padding-right:4px; padding-top:1px; padding-bottom:1px" width="92%" id="table37" cellspacing="0">
	<tr>
		<td class="plaintext" bgcolor="#959CA0">
		<b><font color="#FFFFFF">Member Services</font></b></td>
		<td class="plaintext" bgcolor="#959CA0" align="right">
			<font color="#FFFFFF">|</font>
			<a class="bodylinks" href="myNSX.asp" title="Sign up for the free myNSX service and keep tabs on your favourite NSX stocks.">MyNSX</a></td>
	</tr>
	<tr>
		<td class="plaintext" colspan="2">
		<%
		if Session("PASSWORDACCESS") = "No" then
					response.write "<font color=red><b>"
					response.write Session("PASSWORDACCESSDESC") 
					response.write "</b></font>"
					Session("PASSWORDACCESSDESC")  = Null
		end if
		%>
		<font size="1">For Investors, Companies, Advisers & Brokers
		</font>
		<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form1_onsubmit()
  Set theForm = document.FrontPage_Form1

  If (theForm.username.value = "") Then
    MsgBox "Please enter a value for the ""Username"" field.", 0, "Validation Error"
    theForm.username.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.password.value = "") Then
    MsgBox "Please enter a value for the ""Password"" field.", 0, "Validation Error"
    theForm.password.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If
  FrontPage_Form1_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form method="POST" name="FrontPage_Form1" action="<%= Application("nsx_AdminSiteRootURL") %>/member_pass.asp" style="margin-top: 0; margin-bottom: 0">

	<!--webbot bot="Validation" s-display-name="Username" b-value-required="TRUE" --><input value="username" type="text" name="username" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" class="plaintext" onFocus="if(this.value=='username')this.value='';" onBlur="if(this.value=='')this.value='username';"><br>
  	<!--webbot bot="Validation" s-display-name="Password" b-value-required="TRUE" --><input value="password" type="password" name="password" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" class="plaintext" onFocus="if(this.value=='password')this.value='';" onBlur="if(this.value=='')this.value='password';"> <input border="0" src="images/v2/LGOBOX1.jpg" name="member" type="image"  align="middle" alt="Logon to Member Services"><br>
	<font size="1"><a href="myNSX.asp">About MyNSX</a> <br>
		<a href="member_forgot.asp" >Forgot your password?</a></font><input type="hidden" name="STATUS" value="CHKLOGIN"></form>
		</td>
	</tr>
	</table>
  
    <p style="margin-top: 0; margin-bottom: 0"><font size="1">&nbsp;</font></p>
<table cellpadding="4" style="border-collapse: collapse; " width="92%" id="table38" border="1" cellspacing="0">
	<tr>
		<td class="plaintext" bgcolor="#959CA0"><font color="#FFFFFF"><b>
		Newsletter</b></font></td>
	</tr>
	<tr>
		<td class="plaintext" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form2_onsubmit()
  Set theForm = document.FrontPage_Form2

  If (theForm.enews.value = "") Then
    MsgBox "Please enter a value for the ""Email Address"" field.", 0, "Validation Error"
    theForm.enews.focus()
    FrontPage_Form2_onsubmit = False
    Exit Function
  End If
  FrontPage_Form2_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form name="FrontPage_Form2" method="POST" action="newsletter_thx.asp" style="margin-top: 0; margin-bottom: 0" >
		&nbsp;<!--webbot bot="Validation" s-display-name="Email Address" b-value-required="TRUE" --><input type="text" name="enews" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" value="enter email" onFocus="if(this.value=='enter email')this.value='';" onBlur="if(this.value=='')this.value='enter email';" class="plaintext">
		<input border="0" src="images/v2/LGOBOX1.jpg" name="email" type="image"  alt="Change your eNewsletter Details" align="middle"><br>
		<input type="radio" value="add" name="action" checked style="border: 0 solid #000080"><font size="1">Add
		<input type="radio" value="remove" name="action" style="border: 0 solid #000080">Remove</font></form>
		</td>
	</tr>
	</table>
  


    <p style="margin-top: 0; margin-bottom: 0"><font size="1">&nbsp;</font></p>
  


      <table cellpadding="2" style="border-collapse: collapse; " width="92%" id="table40">
		<tr>
			<td width="50%" class="plaintext" bgcolor="#959CA0">
			<p style="margin-top: 5px; margin-bottom: 5px">
			<font color="#FFFFFF"><b>&nbsp;Events </b></font></td>
			<td width="50%" class="plaintext" bgcolor="#959CA0" align="right">
			<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_events.xml">
			<img border="0" src="images/rss/rss.png" width="36" height="14" align="middle"></a>
			<font color="#FFFFFF">|</font>
			<a href="events_list.asp" class=bodylinks title="Click to see full events list">More</a></td>
		</tr>
		<tr>
			<td width="100%" class="plaintext" colspan="2">
          <%session("rsstr")="ftp\rss\nsx_rss_events.xml"
			session("rssdesc")=false
			session("rssmaxx")=14
			session("rssdate")=false
			session("rsstitle")=true
          server.execute "nsxrssreader.asp"%>
          </td>
		</tr>
		<tr>
			<td width="100%" class="plaintext" colspan="2">
			<p style="margin-top: 5px; margin-bottom: 5px">&nbsp;</td>
		</tr>
</table>
  


    </div>
  
<p align="center">
<a target="_blank" href="http://www.growthmarkets.org">
<img border="0" src="images/GrowthMarkets/GMOMEMBER.jpg" width="124" height="152"></a></td>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF" width="410">
<h1 align="left"><b><font size="3" color="#000080">NSX is a stock exchange 
	established specifically for the listing of small to medium sized companies.</font></b></h1>
<h2 align="left">About NSX</h2>
<p align="justify">NSX operates a well regulated, transparent orderly and highly efficient 
	market.&nbsp; Because our listing rules are designed to accommodate the 
	unique requirements of emerging companies, the securities listed on our 
	market cover a diverse range in size, activities and geographic location.&nbsp;
<a href="products.asp" title="More information on NSX products and markets">more information.</a></p>
<p align="center"><%server.execute "charts_google_index.asp"%><br>
<span style="font-weight: 400"><font size="1"><a href="prices_index.asp" title="Click to see more Indices">More 
Indices</a></font></span><br><%server.execute "company_calendar_inc.asp"%></p>
<h2>
<img border="0" src="images/badge/nsx_badge150.jpg" width="150" height="150" align="right">Why List?</h2>
<p>NSX applies realistic entry requirements including a shareholder spread of 50 
and a market capitalisation of AUD $500,000. Offering a streamlined admission process 
choosing to list on NSX can save both time and money. There are companies listed 
from all around Australia and internationally.&nbsp; <a href="why_list.asp" title="Details on why list">more information</a> 
or review our list of <a href="listing_factsheets.asp" title="Fact sheet list">fact sheets</a>.</p>
<h2>How to buy and sell shares?</h2>
<p align="justify">NSX provides efficient, well regulated electronic trading and settlement 
systems. All transactions must be conducted through a participating Broker. 
<a href="broker_list.asp" title="Broker list and profiles">View a list of NSX Brokers</a>.&nbsp; </p>
<h2>Where to get advice?</h2>
<p align="justify">NSX Nominated Advisers assist companies through the listing process and with 
their ongoing compliance obligations. <a href="about_nominated_advisers.asp" title="The role of nominated advisers">Click here for more information 
about Nominated Advisers.</a>&nbsp; Brokers can provide investor advice to 
buyers and sellers of shares.&nbsp; 
<a href="broker_list.asp" title="Broker list and profiles">Click here for a list of NSX Brokers</a>.&nbsp; </p>
<table width="100%" id="table43" cellspacing="0" cellpadding="4">
	<tr>
		<td bgcolor="#959CA0" class="plaintext"><font color="#FFFFFF"><b>New 
		Floats </b></font></td>
		<td bgcolor="#959CA0" class="plaintext" align="right">
<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_floats.xml">
<img border="0" src="images/rss/rss.png" width="36" height="14" align="middle"></a>
		<font color="#FFFFFF">|</font> <a href="float_list.asp" class=bodylinks title="Click to see full floats list">More</a></td>
	</tr>
</table>
     
          <%session("rsstr")="ftp\rss\nsx_rss_floats.xml"
			session("rssdesc")=false
			session("rssmaxx")=11
			session("rssdate")=false
			session("rsstitle")=true
			server.execute "nsxrssreader.asp"%><table width="100%" id="table41" cellspacing="0" cellpadding="4">
	<tr>
		<td bgcolor="#959CA0" class="plaintext"><font color="#FFFFFF"><b>
		Exchange 
		News </b></font></td>
		<td bgcolor="#959CA0" class="plaintext" align="right">
<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_news.xml">
<img border="0" src="images/rss/rss.png" width="36" height="14" align="middle"></a>
<font color="#FFFFFF">|</font>
<a href="news_list.asp" class=bodylinks title="Click to see full NSX exchange news items.">More</a></td>
	</tr>
</table>
          <%session("rsstr")="ftp\rss\nsx_rss_news.xml"
			session("rssdesc")=false
			session("rsstitle")=true
			session("rssmaxx")=5
			session("rssdate")=false
			
          server.execute "nsxrssreader.asp"%>
</td>
    <td width="200" class="plaintext" valign="top" bgcolor="#FFFFFF">


<div align="center">
  <center>
      <table cellpadding="4" style="border-collapse: collapse; " width="92%" id="table28" border="1" cellspacing="0">
        <tr>
          <td width="100%" class="plaintext" bgcolor="#959CA0">
          <font color="#FFFFFF"><b>Market Data</b></font></td>
        </tr>
        <tr>
          <td width="100%" class="plaintext" align="left">
                  <!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form3_onsubmit()
  Set theForm = document.FrontPage_Form3

  If (theForm.nsxcode.value = "") Then
    MsgBox "Please enter a value for the ""NSX Code(s)"" field.", 0, "Validation Error"
    theForm.nsxcode.focus()
    FrontPage_Form3_onsubmit = False
    Exit Function
  End If
  FrontPage_Form3_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form method="POST" name="FrontPage_Form3" style="margin-top: 0; margin-bottom: 0" action="market_get.asp">
          <!--webbot bot="Validation" s-display-name="NSX Code(s)" b-value-required="TRUE" --><input type="text" name="nsxcode" size="19" style="border: 1px solid #000080; ; background-color:#EEEEEE" value="NSX Code" onFocus="if(this.value=='NSX Code')this.value='';" onBlur="if(this.value=='')this.value='NSX Code';" class="plaintext"><br>
      <select size="1" name="marketdata" style="border:1px solid #BBBBBB; font-size: 10pt; background-color:#EEEEEE" class="plaintext">
		<option selected value="PRICES">Latest Price</option>
		<option value="Announcements">Announcements</option>
		<option value="AIRESEARCH">Research</option>
		<option value="DAILYPRICES">Daily Prices</option>
		<option value="MONTHLYPRICES">Monthly Prices</option>
		<option value="Chart">Chart</option>
		<option value="COMPANYDETAILS">Company Details</option>
		<option value="SecurityDetails">Security Details</option>
		</select> <input src="images/v2/LGOBOX1.jpg" name="prices" type="image"  align="middle" alt="Retrieve Delayed Trading Data." border="0"><br>
		<font size="1"><a href="market_officiallist.asp" title="Look for the relevant NSX code.  For multiple codes separate with a comma.">Find a code</a></font>
		</form>
		</td>
        </tr>
        </table>
      
   <p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
    <div align="center">
    <table width="92%" cellspacing="0" cellpadding="4" border="1" style="border-collapse: collapse" id="table36">
	<tr>
		<td width=100% class=plaintext valign="top" bgcolor="#959CA0">
		<font color="#FFFFFF"><b>Statistics</b></font></td>
	</tr>  
	<tr>
		<td width=100% class=plaintext valign="top" align="center">
		<p align="left" style="margin-top: 0">
		<a target="main22" class="mnlinks" href="stats_advances.asp" title="view the top 7 securities that have risen in price during the day">advances</a> | 
		<a target="main22" class="mnlinks" href="stats_declines.asp" title="view the top 7 securities that have declined in price during the day">declines</a> 
		| <a target="main22" class="mnlinks" href="stats_volume.asp" title="view the top 7 securities by volume for the day">volume</a> |
		<a target="main22" class="mnlinks" href="stats_value.asp" title="view the top 7 securities by value for the day">value</a> |
		<a href="stats_market.asp" target="main22" class=mnlinks title="view the year to date market trading statistics">market</a> | 
		<a target="main22" class="mnlinks" href="stats_general.asp" title="view the general market statistics">general</a> 
		| 
		<a target="main22" class="mnlinks" href="stats_indices.asp" title="view the market indices">index</a><br>
		<iframe name="main22" src="stats_general.asp" width="100%" height="210" frameborder="0" scrolling="no" ></iframe>	
		</td>
	</tr>  
      </table>
<font size="1"><div>&nbsp;<table cellpadding="4" style="padding:0; border-collapse: collapse" width="92%" id="table42" border="1" cellspacing="0">
	<tr>
		<td class="plaintext" bgcolor="#959ca0"><font color="#FFFFFF"><b>Desktop 
		News &amp; Quotes</b></font></td>
	</tr>
	<tr>
		<td class="plaintext">
		<p align="center">
		<font size="1">Get our News Widget for your desk top |
		<a href="whatis_widgets.asp" title="Find out more on how to us ethe NSX widget on your desktop" >About Widgets</a></font><br>
		<font size="1">
		<a href="http://widgets.yahoo.com/gallery/view.php?widget=41953"><img src="images/rss/41953-chit.jpg" alt="Get National Stock Exchange of Australia Announcements at the Yahoo! Widget gallery!" border="0"></a><noscript><a href="http://widgets.yahoo.com/gallery/view.php?widget=39905"><img src="http://widgets.yahoo.com/images/badges/generated/badge_39905_20619e_ffffff.png" alt="Get IBEX 35 at the Yahoo! Widget gallery!" border="0"></a>
		<br>
		<br>
&nbsp;</noscript></font></td>
	</tr>
	</table>
   </div></font>
      <p align="left" style="margin-top: 0; margin-bottom: 0"><font size="1">&nbsp;</font></p>


      <div align="center">
      <table cellpadding="2" style="padding:0; border-collapse: collapse" width="92%" id="table39">
        <tr>
          <td width="50%" class="plaintext" bgcolor="#959CA0">
          <p style="margin-top: 5px; margin-bottom: 5px"><font color="#FFFFFF">
			<b>&nbsp;Announcements </b></font></td>
          <td width="50%" class="plaintext" bgcolor="#959CA0" align="right">
      	<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_announcements.xml">
		<img border="0" src="images/rss/rss.png" width="36" height="14" align="middle"></a>
		<font color="#FFFFFF">|</font>
      <a href="announcements_list.asp" class=bodylinks title="Click to see all announcements.">More</a></td>
        </tr>
        <tr>
          <td width="100%" class="subcat" colspan="2">
			<%session("rsstr")="ftp\rss\nsx_rss_announcements.xml"
			session("rssdesc")=false
			if month(date)=3 or month(date)=9 then
				session("rssmaxx")=11
			else
				session("rssmaxx")=9
			end if
			session("rssdate")=true
			session("rsstitle")=true
          server.execute "nsxrssreader.asp"%>
          
          </td>
        </tr>
        <tr>
          <td width="100%" class="plaintext" colspan="2">
      <p style="margin-top: 5px; margin-bottom: 5px">
      &nbsp;</td>
        </tr>
        </table>
      </div>

      </div>

      </td>
  </tr>
  </table>
</div>
<!--#INCLUDE FILE="footergoogle.asp"-->

</body>
<script type="text/javascript" src="BubbleTooltips.js"></script>
<script type="text/javascript">
enableTooltips("tooltips");
</script>
</html>