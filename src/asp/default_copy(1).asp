<%Server.ScriptTimeout=180%>
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
<link rel="stylesheet" href="newsx2.css" type="text/css">
<link rel="shortcut icon" href="favicon.ico" >
<link rel="shortcut icon" href="favicon.ico" ><meta name="Microsoft Border" content="none">
</head>

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="plaintext" bgcolor="#FFFFFF" colspan="3"><!--#INCLUDE FILE="ticker.asp"--></td>
  </tr>
  <tr>
    <td valign="top" bgcolor="#FFFFFF" width="200" >
<div align="center">
<table cellpadding="5" style="border-collapse: collapse; " width="90%" id="table11">
	<tr>
		<td class="plaintext" bgcolor="#959ca0"><font color="#FFFFFF"><b>Quick 
		Links</b></font></td>
	</tr>
	<tr>
		<td class="plaintext">
		<font face="Arial, helvetica, sans-serif" size="2" color="#000080">
		<img name="floats" border="0" src="images/v2/Dpoint1.jpg">
		<a href="float_list.asp" class="mnlinks" onmouseover="spec('floats','imgtdon')" onmouseout="spec('floats','imgtdoff')">New Floats</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="tp">
		<a class="mnlinks" onmouseover="spec('tp','imgtdon')" onmouseout="spec('tp','imgtdoff')" href="prices_alpha.asp">Prices</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="co">
		<a href="announcements_list.asp" class="mnlinks" onmouseover="spec('co','imgtdon')" onmouseout="spec('co','imgtdoff')">Company News</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="cr">
		<a href="company_research_public.asp" class="mnlinks" onmouseover="spec('cr','imgtdon')" onmouseout="spec('cr','imgtdoff')">
		Company Details</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="wh">
		<a href="market_officiallist.asp" class="mnlinks" onmouseover="spec('wh','imgtdon')" onmouseout="spec('wh','imgtdoff')">Who's Listed?</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="br">
		<a href="broker_list.asp" class="mnlinks" onmouseover="spec('br','imgtdon')" onmouseout="spec('br','imgtdoff')">Find a Broker</a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="ts">
		<a href="inv_how_to_trade.asp" class="mnlinks" onmouseover="spec('ts','imgtdon')" onmouseout="spec('ts','imgtdoff')">Trading </a><br>
		<img border="0" src="images/v2/Dpoint1.jpg" name="tz">
		<a href="news_list.asp" class="mnlinks" onmouseover="spec('tz','imgtdon')" onmouseout="spec('tz','imgtdoff')">What's New</a></font></td>
	</tr>
	<tr>
		<td class="plaintext" bgcolor="#959CA0"><font color="#FFFFFF"><b>
		Newsletter</b></font></td>
	</tr>
	<tr>
		<td class="plaintext" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
		<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form1_onsubmit()
  Set theForm = document.FrontPage_Form1

  If (theForm.enews.value = "") Then
    MsgBox "Please enter a value for the ""Email Address"" field.", 0, "Validation Error"
    theForm.enews.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If
  FrontPage_Form1_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form name="FrontPage_Form1" method="POST" action="newsletter_thx.asp" style="margin-top: 0; margin-bottom: 0" >
		<!--webbot bot="Validation" s-display-name="Email Address" b-value-required="TRUE" --><input type="text" name="enews" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" value="enter email" 
  onFocus="if(this.value=='enter email')this.value='';" onBlur="if(this.value=='')this.value='enter email';" class="plaintext">
		<input onmouseover="spec2('FrontPage_Form1','email','imggoon')" onmouseout="spec2('FrontPage_Form1','email','imggooff')" border="0" src="images/v2/LGOBOX1.jpg" name="email" type="image"  alt="Change your eNewsletter Details" align="middle"><br>
		<input type="radio" value="add" name="action" checked style="border: 0 solid #000080"><font size="1">Add
		<input type="radio" value="remove" name="action" style="border: 0 solid #000080">Remove</font>
		
		</form>
		</td>
	</tr>
	<tr>
		<td class="plaintext" bgcolor="#959CA0">
		<b><font color="#FFFFFF">Member Services</font></b></td>
	</tr>
	<tr>
		<td class="plaintext"><p>
		<%
		if Session("PASSWORDACCESS") = "No" then
					response.write "<font color=red><b>"
					response.write Session("PASSWORDACCESSDESC") 
					response.write "</b></font>"
					Session("PASSWORDACCESSDESC")  = Null
		end if
		%>
		<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form2_onsubmit()
  Set theForm = document.FrontPage_Form2

  If (theForm.username.value = "") Then
    MsgBox "Please enter a value for the ""Username"" field.", 0, "Validation Error"
    theForm.username.focus()
    FrontPage_Form2_onsubmit = False
    Exit Function
  End If

  If (theForm.password.value = "") Then
    MsgBox "Please enter a value for the ""Password"" field.", 0, "Validation Error"
    theForm.password.focus()
    FrontPage_Form2_onsubmit = False
    Exit Function
  End If
  FrontPage_Form2_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form method="POST" name="FrontPage_Form2" action="member_pass.asp" style="margin-top: 0; margin-bottom: 0" language="JavaScript">

	<!--webbot bot="Validation" s-display-name="Username" b-value-required="TRUE" --><input value="username" type="text" name="username" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" class="plaintext" onFocus="if(this.value=='username')this.value='';" onBlur="if(this.value=='')this.value='username';"><br>
  	<!--webbot bot="Validation" s-display-name="Password" b-value-required="TRUE" --><input value="password" type="password" name="password" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" class="plaintext" onFocus="if(this.value=='password')this.value='';" onBlur="if(this.value=='')this.value='password';"> <input onmouseover="spec2('FrontPage_Form2','member','imggoon')" onmouseout="spec2('FrontPage_Form2','member','imggooff')" border="0" src="images/v2/LGOBOX1.jpg" name="member" type="image"  align="middle" alt="Logon to Member Services"><br>
  <font size="1">
		<a href="member_forgot.asp" >Forgot your password?</a></font><input type="hidden" name="STATUS" value="CHKLOGIN"></form>

		
		
		</td>
	</tr>
	</table>
  


      <div align="center">
      <table cellpadding="0" style="border-collapse: collapse; " width="90%" id="table12">
        <tr>
          <td width="100%" class="plaintext" bgcolor="#959CA0">
          <p style="margin-top: 5px; margin-bottom: 5px"><font color="#FFFFFF">
			<b>&nbsp;Events </b></font></td>
        </tr>
        <tr>
          <td width="100%" class="plaintext">
          <!--#INCLUDE FILE="events_list_inc.asp"-->
          </td>
        </tr>
        <tr>
          <td width="100%" class="plaintext">
      <p style="margin-top: 5px; margin-bottom: 5px">
      <font size="1">
		<a href="events_notify.asp">Add an Event</a> | <a href="events_list.asp">More Events</a>&nbsp; </font></td>
        </tr>
        </table>
      </div>
  


    </div>
  


    </td>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
<p align="left">NSX is a stock exchange 
	established specifically for the listings of small to medium size companies.&nbsp; 
	We operate a well regulated, transparent orderly and highly efficient 
	market.&nbsp; Because our listing rules are designed to accommodate the 
	unique requirements of emerging companies, the securities listed on our 
	market cover a diverse range in size, activities and geographic location.&nbsp;
<a href="products.asp">Click here for more information.</a></p>
<h2>Why List?</h2>
<p align="left">NSX applies realistic entry requirements including a shareholder spread of 50 
and a market capitalisation of $500k. Offering a streamlined admission process 
choosing to list on NSX can save both time and money. There are companies listed 
from all around Australia, as well as New Zealand, Singapore and China.&nbsp; <a href="why_list.asp">Click here for more information.</a></p>
<h2>How to buy and sell shares?</h2>
<p align="left">NSX provides efficient, well regulated electronic trading and settlement 
systems. All transactions must be conducted through a participating Broker. 
<a href="broker_list.asp">Click here for a list of NSX Brokers</a>.&nbsp; </p>
<h2>Where to get advice?</h2>
<p align="left">NSX Nominated Advisors assist companies through the listing process and with 
their ongoing compliance obligations. <a href="about_nominated_advisers.asp">Click here for more information.</a></p>
<h2 align="justify">What's New?</h2>
          <!--#INCLUDE FILE="news_list_inc.asp"-->
<br>
<font size="1"><a href="news_list.asp">More News</a> | </font>
<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_announcements.xml">
<img border="0" src="images/rss/rss.png" width="36" height="14" align="middle"></a>
<font size="1">| <a href="whatis_rss.asp">What is RSS?</a> </font><p>&nbsp;</td>
    <td width="200" class="plaintext" valign="top" bgcolor="#FFFFFF">



  <table border="0" cellpadding="4" style="border-collapse: collapse" width="100%">
    <tr>
      <td width="100%" class="plaintext">
      <div align="center">
      <table cellpadding="5" style="border-collapse: collapse; " width="90%">
        <tr>
          <td width="34%" class="plaintext" bgcolor="#959CA0">
          <font color="#FFFFFF"><b>Statistics</b></font></td>
          <td width="33%" class="plaintext" bgcolor="#959CA0" align="right"><b>
          <a href="<%= Application("nsx_SiteRootURL") %>"><font color="#FFFFFF">NSX</font></a></b></td>
          <td width="33%" class="plaintext" bgcolor="#959CA0" align="right"><b>
          <a target="_blank" href="http://www.bsx.com.au"><font color="#FFFFFF">BSX</font></a></b></td>
        </tr>
        <tr>
          <td width="50%" class="plaintext"><font color="#000000" size="1">
          Issuers</font></td>
          <td width="50%" class="plaintext" align="right">
          <a href="market_officiallist.asp"><font size="1">31</font></a></td>
          <td width="50%" class="plaintext" align="right">
          <a href="http://www.bsx.com.au/markets_pricesresearch.asp">
			<font size="1">51</font></a></td>
        </tr>
        <tr>
          <td width="50%" class="plaintext" bgcolor="#eeeeee"><font color="#000000" size="1">
          Securities</font></td>
          <td width="50%" class="plaintext" align="right" bgcolor="#eeeeee">
          <font size="1"><a href="market_officiallist.asp">54</a></font></td>
          <td width="50%" class="plaintext" align="right" bgcolor="#eeeeee">
          <a href="http://www.bsx.com.au/markets_pricesresearch.asp">
			<font size="1">51</font></a></td>
        </tr>
        <tr>
          <td width="50%" class="plaintext"><font color="#000000" size="1">
          Market 
          Capitalisation</font></td>
          <td width="50%" class="plaintext" align="right">
          <a href="market_statistics.asp"><font size="1">$394m</font></a></td>
          <td width="50%" class="plaintext" align="right">
          <font color="#000000" size="1">
          $388m</font></td>
        </tr>
        <tr>
          <td width="50%" class="plaintext" bgcolor="#eeeeee"><font color="#000000" size="1">
          Brokers</font></td>
          <td width="50%" class="plaintext" align="right" bgcolor="#eeeeee">
          <a href="broker_list.asp"><font size="1">10</font></a></td>
          <td width="50%" class="plaintext" align="right" bgcolor="#eeeeee">
          <font color="#000000" size="1">
          <a href="http://www.bsx.com.au/markets_bsxbrokers.asp">3</a></font></td>
        </tr>
        <tr>
          <td width="50%" class="plaintext"><font color="#000000" size="1">
          Advisers</font></td>
          <td width="50%" class="plaintext" align="right">
          <font size="1"><a href="adviser_list.asp">27</a></font></td>
          <td width="50%" class="plaintext" align="right">
          <font color="#000000" size="1">n/a</font></td>
        </tr>
        <tr>
          <td width="50%" class="plaintext" bgcolor="#eeeeee"><font size="1">Facilitators</font></td>
          <td width="50%" class="plaintext" align="right" bgcolor="#eeeeee">
          <font size="1"><a href="facilitator_list.asp">2</a></font></td>
          <td width="50%" class="plaintext" align="right" bgcolor="#eeeeee">
          <font color="#000000" size="1">n/a</font></td>
        </tr>
        <tr>
          <td width="100%" class="plaintext" colspan="3">
<font size="1">Market Hrs: 9am to 2:30pm<br>
Office Hrs: 8am to 5pm</font></td>
        </tr>
      </table>
      </div>
      </td>
    </tr>
  </table>
<div align="center">
  <center>
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
--></script><!--webbot BOT="GeneratedScript" endspan --><form method="POST" name="FrontPage_Form3" style="margin-top: 0; margin-bottom: 0" action="market_get.asp" language="JavaScript">
  <table width="100%" id="table8">
    <tr>
      <td width="100%" class="plaintext">
      <div align="center">
      <table cellpadding="5" style="border-collapse: collapse; " width="90%" id="table9">
        <tr>
          <td width="100%" class="plaintext" bgcolor="#959CA0">
          <font color="#FFFFFF"><b>Market Data</b></font></td>
        </tr>
        <tr>
          <td width="100%" class="plaintext" align="left">
          <!--webbot bot="Validation" s-display-name="NSX Code(s)" b-value-required="TRUE" --><input type="text" name="nsxcode" size="24" style="border: 1px solid #000080; ; background-color:#EEEEEE" value="NSX Code" onFocus="if(this.value=='NSX Code')this.value='';" onBlur="if(this.value=='')this.value='NSX Code';" class="plaintext"><br>
      <select size="1" name="marketdata" style="border:1px solid #BBBBBB; font-size: 10pt; background-color:#EEEEEE" class="plaintext">
		<option selected value="PRICES">Latest Price</option>
		<option value="Announcements">Announcements</option>
		<option value="AIRESEARCH">Research</option>
		<option value="DAILYPRICES">Daily Prices</option>
		<option value="MONTHLYPRICES">Monthly Prices</option>
		<option value="Chart">Chart</option>
		<option value="COMPANYDETAILS">Company Details</option>
		<option value="SecurityDetails">Security Details</option>
		</select> <input onmouseover="spec2('FrontPage_Form3','prices','imggoon')" onmouseout="spec2('FrontPage_Form3','prices','imggooff')" src="images/v2/LGOBOX1.jpg" name="prices" type="image"  align="middle" alt="Retrieve Delayed Trading Data." border="0"><br>
		<font size="1"><a href="market_officiallist.asp" >Find a code</a></font></td>
        </tr>
        </table>
      </div>
      </td>
    </tr>
  </table>
  </form>
<div align="center">
  <center>
  <table border="0" cellpadding="4" style="border-collapse: collapse" width="100%">
    <tr>
      <td width="100%" class="plaintext">
      <div align="center">
      <table cellpadding="0" style="border-collapse: collapse; " width="90%" id="table5">
        <tr>
          <td width="100%" class="plaintext" bgcolor="#959CA0">
          <p style="margin-top: 5px; margin-bottom: 5px"><font color="#FFFFFF">
			<b>&nbsp;Announcements </b></font></td>
        </tr>
        <tr>
          <td width="100%" class="subcat">
          <!--#INCLUDE FILE="announcements_list_inc.asp"--></td>
        </tr>
        <tr>
          <td width="100%" class="plaintext">
      <p style="margin-top: 5px; margin-bottom: 5px">
      <font size="1"><a href="announcements_list.asp">More Announcements</a> | </font>
		<a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_announcements.xml">
		<img border="0" src="images/rss/rss.png" width="36" height="14" align="middle"></a>
		<font size="1">| <a href="whatis_rss.asp">What is RSS?</a></font></td>
        </tr>
        </table>
      </div>
      </td>
    </tr>
  </table>
  </center>
</div>



    </td>
  </tr>
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->

</body>

</html>