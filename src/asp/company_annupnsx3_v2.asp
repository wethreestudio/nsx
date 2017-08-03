<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "CSX" 

Response.Expires = -1
Response.CacheControl = "no-cache" 
%>
<!--#INCLUDE FILE="company_check_exchid_v2.asp"-->
<!--#INCLUDE FILE="member_check_v2.asp"-->

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=exchname%></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="-1">
<meta http-equiv="expires" content="-1">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<%select case exchid
	case "NSX"
	%>
	<link rel=stylesheet href="newsx2.css" type="text/css">
<% case "SIMV"%>
	<!--#file = "include/common/stylesheets.asp" -->
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% case else %>
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% end select%>
<SCRIPT>
function startupload() {
		winstyle="height=80,width=400,status=no,toolbar=no,menubar=no,location=no";
		//window.open("progress.asp?progressid=<%=myprogressid%>",null,winstyle);
		//document.FrontPage_Form1.action = "resupload3.asp?progressid=<%=myprogressid%>"
		//uncomment next line to turn on progress indicator
		//window.open("progress.asp?progressid=0",null,winstyle);  
		document.FrontPage_Form1.action = "company_resupload3_v2.asp?progressid=0"
		document.FrontPage_Form1.submit();
}
</script>



<link rel="shortcut icon" href="favicon.ico" ><meta name="Microsoft Border" content="none">
</head>

<body >

<% if len(exchid)<>0 then server.execute "company_header_v2_" & exchid & ".asp"%>
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" valign="top" rowspan="3" bgcolor="#FFFFFF"><%if len(exchid)<>0 then server.execute "company_lmenu_v2_" & exchid & ".asp"%></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><b><font face="Arial">LODGE AN ANNOUNCEMENT</h1>
	
	</td>
  </tr>
  <tr>
  
    

    <td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">
    
      
		<p><font size="2" face="Arial">Use the form below to report a Company
Announcement to the <%=SESSION("EXCHNAME")%>. All fields marked </font>
		<img border="0" src="images/dotgold.gif" align="middle" width="11" height="11">
		<font size="2" face="Arial">are mandatory.&nbsp; If the&nbsp;form fails to submit
correctly press the back button and&nbsp; correct any details and then resubmit the
announcement.</font>
		<p><b>Please note: <u>10 megabyte file upload limit</u>.&nbsp; Please 
		reduce file size to fit under this limit.&nbsp; Adobe PDF files only can 
		be accepted.</b>
      <!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form1_onsubmit()
  Set theForm = document.FrontPage_Form1

  If (theForm.tradingcode.selectedIndex < 0) Then
    MsgBox "Please select one of the ""Trading Code"" options.", 0, "Validation Error"
    theForm.tradingcode.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.tradingcode.selectedIndex = 0) Then
    MsgBox "The first ""Trading Code"" option is not a valid selection.  Please choose one of the other options.", 0, "Validation Error"
    theForm.tradingcode.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.category.selectedIndex < 0) Then
    MsgBox "Please select one of the ""Category"" options.", 0, "Validation Error"
    theForm.category.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.title.value = "") Then
    MsgBox "Please enter a value for the ""Title of Announcement"" field.", 0, "Validation Error"
    theForm.title.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (Len(theForm.title.value) < 1) Then
    MsgBox "Please enter at least 1 characters in the ""Title of Announcement"" field.", 0, "Validation Error"
    theForm.title.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (Len(theForm.title.value) > 54) Then
    MsgBox "Please enter at most 54 characters in the ""Title of Announcement"" field.", 0, "Validation Error"
    theForm.title.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.Description.value = "") Then
    MsgBox "Please enter a value for the ""Short Description of Content"" field.", 0, "Validation Error"
    theForm.Description.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.Person.value = "") Then
    MsgBox "Please enter a value for the ""Contact Person"" field.", 0, "Validation Error"
    theForm.Person.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (Len(theForm.Person.value) < 6) Then
    MsgBox "Please enter at least 6 characters in the ""Contact Person"" field.", 0, "Validation Error"
    theForm.Person.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.Phone.value = "") Then
    MsgBox "Please enter a value for the ""Contact's Phone Number"" field.", 0, "Validation Error"
    theForm.Phone.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (Len(theForm.Phone.value) < 6) Then
    MsgBox "Please enter at least 6 characters in the ""Contact's Phone Number"" field.", 0, "Validation Error"
    theForm.Phone.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.email.value = "") Then
    MsgBox "Please enter a value for the ""Contact's Email Address"" field.", 0, "Validation Error"
    theForm.email.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (Len(theForm.email.value) < 7) Then
    MsgBox "Please enter at least 7 characters in the ""Contact's Email Address"" field.", 0, "Validation Error"
    theForm.email.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If
  FrontPage_Form1_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form method="POST" action="company_resupload3_V2.asp" name="FrontPage_Form1" enctype="multipart/form-data">
  <div align="center">
    <center>
    <%
    ' need to modify form to allow advisers with multiple codes.
    nsxcode = ""
    if session("ADV") > 0 then
    	nsxcode = ucase(trim(session("comments") & " "))
    end if
    if nsxcode = "" then
    	' get a single company
    	nsxcode = ucase(session("nsxcode"))
    else
    	' keep multiple companies
    	nsxcode = nsxcode
    end if
    
%>
  <div class="table-responsive"><table border="0" cellpadding="2" bgcolor="#FFFFFF" cellspacing="0" width="400" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
    <tr>
      <td bgcolor="#FFFFFF" class="textlabel" style="line-height: 100%" nowrap colspan="2">&nbsp;&nbsp;&nbsp;&nbsp; Available
        Securities:<br>
        <%
      Set ConnPasswords = Server.CreateObject("ADODB.Connection")
		Set CmdDD = Server.CreateObject("ADODB.Recordset")
		ConnPasswords.Open Application("nsx_ReaderConnectionString")   
		' 1 second past midnight of current day.
		
		'response.write nsxcode
		'response.end
		nc = split(nsxcode,";")
		
		srch = " AND ("
		for each element in nc 
		'response.write element & "<BR>"
		srch = srch & "(coissues.nsxcode='" & SafeSqlParameter(element) &"') OR "
		next
		srch = left(srch,len(srch)-3) & ")"
		
			
		SQL = "SELECT  tradingcode,issuedescription,displayboard,exchid FROM coIssues "
		SQL = SQL & " WHERE  ((coIssues.Issuestatus ='Active') or (coIssues.Issuestatus ='Suspended') or (coIssues.Issuestatus ='IPO')) " & srch 
		SQL = SQL & " ORDER BY coIssues.tradingcode"
		'response.write SQL
		'response.end
		CmdDD.CacheSize=100 
		CmdDD.Open SQL, ConnPasswords
		
		WEOF = CmdDD.EOF

		'can only do getrows if there is more than one record.
		if not WEOF then 
			alldata = cmddd.getrows
			rc = ubound(alldata,2) 
			
			else
			rc = -1
		end if

		CmdDD.Close
		Set CmdDD = Nothing

		ConnPasswords.Close
		Set ConnPasswords = Nothing
		
		if rc = -1 then 
			response.write Session("nsxcode")
			response.write "<input type=hidden name=tradingcode value=" & Session("nsxcode") & ">"
		else %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<!--webbot bot="Validation" s-display-name="Trading Code" b-value-required="TRUE" b-disallow-first-item="TRUE" --><select size="1" name="tradingcode" style="background-color: #EEEEEE">
        <%
        response.write "<option value='Select}}}'>Select Security to Report</option>"
      
      
            Set ConnPasswords = Server.CreateObject("ADODB.Connection")
			ConnPasswords.Open Application("nsx_ReaderConnectionString")   

			anncopycodes=""
			FOR jj = 0 TO rc
				tradingcode = alldata(0,jj)
				issuedesc = alldata(1,jj)
				anncopycodes = anncopycodes & "," & tradingcode
				displayboard = alldata(2,jj)
				exchid = alldata(3,jj)
				
				Set CmdDD3 = Server.CreateObject("ADODB.Recordset")
				SQL = "SELECT  nsxcode,coname,agacn FROM coDetails WHERE (nsxcode='" & SafeSqlParameter(ucase(left(tradingcode,3))) & "')"
				CmdDD3.CacheSize=10 
				CmdDD3.Open SQL, ConnPasswords
		
			if CmdDD3.EOF then
					nsxcode = ""
					coname = ""
					acn= ""

				else
					nsxcode=CmdDD3("nsxcode")
					coname=CmdDD3("coname")
					acn=CmdDD3("agacn")

				end if
				response.write "<option value='" & tradingcode & "}" & coname & "}" & acn & "}" & displayboard & "'>" & tradingcode & left("-" & issuedesc,50) & "</option>"
					NEXT
			
			
			CmdDD3.Close 
			Set CmdDD3 = Nothing
			ConnPasswords.Close
			Set ConnPasswords = Nothing

	
		END IF
      
      Dim category_prefix
	  category_prefix = "3"
	  
      %>
      </select> <img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="textlabel" style="line-height: 100%" nowrap colspan="2">
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp; Category:<br>
&nbsp;&nbsp;&nbsp;&nbsp; </font>
      &nbsp;<!--webbot bot="Validation" s-display-name="Category" b-value-required="TRUE" --><select size="1" name="category" style="background-color: #EEEEEE">
<option>*** Official list ***}</option>
<option><%=category_prefix%>0010 <%=exchshort%> Admission to Official List}</option>
<option><%=category_prefix%>0020 <%=exchshort%> Commencement of Official Quotation}</option>
<option><%=category_prefix%>0021 <%=exchshort%> Trust Deed}</option>
<option><%=category_prefix%>0022 <%=exchshort%> Articles of Association/Constitution}</option>
<option><%=category_prefix%>0023 <%=exchshort%> Director's Declaration & Undertaking}</option>
<option><%=category_prefix%>0024 <%=exchshort%> Nominated Adviser's Declaration}</option>
<option><%=category_prefix%>0025 <%=exchshort%> Sponsor's Declaration}</option>
<option><%=category_prefix%>0030 <%=exchshort%> Trading Halt}</option>
<option><%=category_prefix%>0031 <%=exchshort%> Trading Halt Status}</option>
<option><%=category_prefix%>0050 <%=exchshort%> Suspension from Official Quotation}</option>
<option><%=category_prefix%>0051 <%=exchshort%> Reinstatement to Official Quotation}</option>
<option><%=category_prefix%>0060 <%=exchshort%> Removal from Official List}</option>
<option><%=category_prefix%>0080 <%=exchshort%> Query}</option>
<option><%=category_prefix%>0081 <%=exchshort%> Response to Query}</option>
<option><%=category_prefix%>0090 <%=exchshort%> Change to Basis of Quotation}</option>
<option><%=category_prefix%>0099 <%=exchshort%> Official List Other}</option>
<option>*** Interests ***}</option>
<option><%=category_prefix%>0110 <%=exchshort%> Becoming a Substantial Shareholder}</option>
<option><%=category_prefix%>0120 <%=exchshort%> Change in Substantial Shareholder}</option>
<option><%=category_prefix%>0130 <%=exchshort%> Ceasing to be a Substantial Shareholder}</option>
<option><%=category_prefix%>0140 <%=exchshort%> Section 205G Notice Initial/Final Director's Interests}</option>
<option><%=category_prefix%>0150 <%=exchshort%> Section 205G Notice Change in Director's Interests}</option>
<option><%=category_prefix%>0199 <%=exchshort%> Interests Other}</option>
<option>*** Takeovers ***}</option>
<option><%=category_prefix%>0220 <%=exchshort%> Takeover Offer Document}</option>
<option><%=category_prefix%>0230 <%=exchshort%> Takover Offeree Director's Statement}</option>
<option><%=category_prefix%>0240 <%=exchshort%> Variation of Takeover Offer}</option>
<option><%=category_prefix%>0250 <%=exchshort%> Supplementary Bidder's Statement}</option>
<option><%=category_prefix%>0260 <%=exchshort%> Supplementary Target's Statement}</option>
<option><%=category_prefix%>0299 <%=exchshort%> Takeover Other}</option>
<option>*** Capital ***}</option>
<option><%=category_prefix%>0310 <%=exchshort%> Bonus Issue}</option>
<option><%=category_prefix%>0315 <%=exchshort%> Placement}</option>
<option><%=category_prefix%>0320 <%=exchshort%> Issues to Public}</option>
<option><%=category_prefix%>0325 <%=exchshort%> Capital Reconstruction}</option>
<option><%=category_prefix%>0330 <%=exchshort%> New Issue Letter of Offer & Acceptance Form}</option>
<option><%=category_prefix%>0335 <%=exchshort%> Alteration to Issued Capital}</option>
<option><%=category_prefix%>0340 <%=exchshort%> Non Renounceable Issue}</option>
<option><%=category_prefix%>0341 <%=exchshort%> Renounceable Issue}</option>
<option><%=category_prefix%>0399 <%=exchshort%> Issued Capital Other}</option>
<option><%=category_prefix%>0350 <%=exchshort%> Prospectus}</option>
<option><%=category_prefix%>0360 <%=exchshort%> Disclosure Document}</option>
<option><%=category_prefix%>0365 <%=exchshort%> Extension of Offer}</option>
<option><%=category_prefix%>0370 <%=exchshort%> On Market BuyBack}</option>
<option><%=category_prefix%>0380 <%=exchshort%> Exercise of Options}</option>
<option>*** Assets ***}</option>
<option><%=category_prefix%>0410 <%=exchshort%> Asset Acquisition}</option>
<option><%=category_prefix%>0420 <%=exchshort%> Asset Disposal}</option>
<option><%=category_prefix%>0430 <%=exchshort%> Strategic Alliance Notice}</option>
<option><%=category_prefix%>0440 <%=exchshort%> Joint Venture Notice}</option>
<option><%=category_prefix%>0450 <%=exchshort%> Major Contract Notice}</option>
<option><%=category_prefix%>0460 <%=exchshort%> Agreement Notice}</option>
<option><%=category_prefix%>0470 <%=exchshort%> Patent Notice}</option>
<option><%=category_prefix%>0490 <%=exchshort%> Merger Notice}</option>
<option><%=category_prefix%>0499 <%=exchshort%> Assets Other}</option>
<option>*** Periodic Disclosure ***}</option>
<option><%=category_prefix%>0510 <%=exchshort%> Annual Report}</option>
<option><%=category_prefix%>0515 <%=exchshort%> Change of Balance Date}</option>
<option><%=category_prefix%>0516 <%=exchshort%> Chairman's Address}</option>
<option><%=category_prefix%>0517 <%=exchshort%> Letter to Shareholder's}</option>
<option><%=category_prefix%>0520 <%=exchshort%> Top 20 Shareholders}</option>
<option><%=category_prefix%>0530 <%=exchshort%> Preliminary/Final Statement}</option>
<option><%=category_prefix%>0540 <%=exchshort%> Half Yearly Report}</option>
<option><%=category_prefix%>0550 <%=exchshort%> Half Yearly Report Audit Review}</option>
<option><%=category_prefix%>0560 <%=exchshort%> Quarterly Report}</option>
<option><%=category_prefix%>0570 <%=exchshort%> Interest Payment Notification}</option>
<option><%=category_prefix%>0571 <%=exchshort%> Dividend Notification}</option>
<option><%=category_prefix%>0572 <%=exchshort%> NTA Notification}</option>
<option><%=category_prefix%>0573 <%=exchshort%> Income Distribution Notification}</option>
<option><%=category_prefix%>0585 <%=exchshort%> Drilling Program Report}</option>
<option><%=category_prefix%>0586 <%=exchshort%> Clinical Trial Report}</option>
<option><%=category_prefix%>0587 <%=exchshort%> Investor/Analyst Briefing}</option>
<option><%=category_prefix%>0588 <%=exchshort%> Media Release}</option>
<option><%=category_prefix%>0599 <%=exchshort%> Periodic Disclosure Other}</option>
<option>*** Details Notification *** }</option>
<option><%=category_prefix%>0720 <%=exchshort%> Details of Company Address}</option>
<option><%=category_prefix%>0730 <%=exchshort%> Details of Registered Office}</option>
<option><%=category_prefix%>0750 <%=exchshort%> Details of Share Registry}</option>
<option><%=category_prefix%>0760 <%=exchshort%> Company Name Change Notification}</option>
<option><%=category_prefix%>0770 <%=exchshort%> Trading Code Change Notification}</option>
<option><%=category_prefix%>0780 <%=exchshort%> Principal Activities Change Notification}</option>
<option><%=category_prefix%>0799 <%=exchshort%> Details Other}</option>
<option>*** Officers and Entities *** }</option>
<option><%=category_prefix%>0810 <%=exchshort%> Director Appointment/Resignation}</option>
<option><%=category_prefix%>0811 <%=exchshort%> Chairman Appointment/Resignation}</option>
<option><%=category_prefix%>0812 <%=exchshort%> CEO Appointment/Resignation}</option>
<option><%=category_prefix%>0813 <%=exchshort%> Key Officer Appointment/Resignation}</option>
<option><%=category_prefix%>0814 <%=exchshort%> Company Secretary Appointment/Resignation}</option>
<option><%=category_prefix%>0815 <%=exchshort%> Sponsor Appointment/Resignation}</option>
<option><%=category_prefix%>0816 <%=exchshort%> Nominated Adviser Appointment/Resignation}</option>
<option><%=category_prefix%>0817 <%=exchshort%> Responsible Entity Appointment/Resignation}</option>
<option><%=category_prefix%>0818 <%=exchshort%> Trustee Appointment/Resignation}</option>
<option><%=category_prefix%>0819 <%=exchshort%> Trust Manager Appointment/Resignation}</option>
<option><%=category_prefix%>0829 <%=exchshort%> Appointment/Resignation Other}</option>
<option>*** Meetings ***}</option>
<option><%=category_prefix%>0910 <%=exchshort%> Notice of Annual General Meeting}</option>
<option><%=category_prefix%>0920 <%=exchshort%> Notice of Extraordinary Meeting}</option>
<option><%=category_prefix%>0930 <%=exchshort%> Results of Meeting}</option>
<option><%=category_prefix%>0940 <%=exchshort%> Proxy Form}</option>
<option><%=category_prefix%>0950 <%=exchshort%> Alteration to Notice of Meeting}</option>
<option><%=category_prefix%>0999 <%=exchshort%> Notice of Meeting Other}</option>
<option>*** Other *** }</option>
<option><%=category_prefix%>1901 <%=exchshort%> Censure / Disciplinary Action / Sanction Notice}</option>
<option><%=category_prefix%>1911 <%=exchshort%> ASIC Determination}</option>
<option><%=category_prefix%>1999 <%=exchshort%> General Market Disclosure Other}</option>
      </select> <img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="textlabel" style="line-height: 100%" nowrap colspan="2"><b><font size="2" face="Arial">&nbsp;&nbsp;&nbsp; Title
        of Announcement:
        (54 Characters Max.)<br>
&nbsp;&nbsp;&nbsp;&nbsp; </font></b>
      &nbsp;<!--webbot bot="Validation" s-display-name="Title of Announcement" b-value-required="TRUE" i-minimum-length="1" i-maximum-length="54" --><textarea rows="2" name="title" cols="48" style="border: 1px solid #6D7BA0; background-color:#EEEEEE"></textarea><img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="textlabel" style="line-height: 100%" nowrap colspan="2"><b><font size="2" face="Arial">&nbsp;&nbsp;&nbsp;&nbsp; Short
        Description of&nbsp;Announcement (Precise):<br>
&nbsp;&nbsp;&nbsp;&nbsp; </font></b>
      &nbsp;<!--webbot bot="Validation" s-display-name="Short Description of Content" b-value-required="TRUE" --><textarea rows="4" name="Description" cols="48" style="border: 1px solid #6D7BA0; background-color:#EEEEEE"></textarea><img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap>
      <font face="Arial">Price Sensitive:</font></td>
      <td bgcolor="#FFFFFF" style="line-height: 100%" class="plaintext">
      <input type="radio" value="Yes" name="annPriceSensitive"> Yes
      <input type="radio" name="annPriceSensitive" value="No" checked>No</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap>
		Copy to underlying:</td>
      <td bgcolor="#FFFFFF" style="line-height: 100%" class="plaintext">
      <input type="radio" name="annCopy" value="Yes"> Yes
      <input type="radio" name="annCopy" value="No" checked>No <br>
		(copy this announcement to all underlying securities)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap><b><font size="2" face="Arial">Contact
        person for&nbsp;<br>
        this announcement:</font></b></td>
      <td bgcolor="#FFFFFF" style="line-height: 100%">
      &nbsp;<!--webbot bot="Validation" s-display-name="Contact Person" b-value-required="TRUE" i-minimum-length="6" --><input type="text" name="Person" size="30" value="<%=Session("Full_Name")%>" style="border: 1px solid #6D7BA0; background-color:#EEEEEE"><img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap><b><font size="2" face="Arial">Contact's
        Direct Phone:</font></b></td>
      <td bgcolor="#FFFFFF" style="line-height: 100%">
      &nbsp;<!--webbot bot="Validation" s-display-name="Contact's Phone Number" b-value-required="TRUE" i-minimum-length="6" --><input type="text" name="Phone" size="30" value="<%=Session("phone")%>" style="border: 1px solid #6D7BA0; background-color:#EEEEEE"><img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap><b><font size="2" face="Arial">Contact's
        Email Address:</font></b></td>
      <td bgcolor="#FFFFFF" style="line-height: 100%">
      &nbsp;<!--webbot bot="Validation" s-display-name="Contact's Email Address" b-value-required="TRUE" i-minimum-length="7" --><input type="text" name="email" size="30" value="<%=Session("email")%>" style="border: 1px solid #6D7BA0; background-color:#EEEEEE"><img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap><b><font size="2" face="Arial">Announcement<br>
        File Name:</font></b></td>
      <td bgcolor="#FFFFFF" style="line-height: 100%">
      &nbsp;<input type=file name="f1" size="30" style="border: 1px solid #6D7BA0; background-color:#EEEEEE"><img border="0" src="images/dotgold.gif" width="11" height="11"></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" align="right" class="textlabel" style="line-height: 100%" nowrap valign="bottom">
      <p align="left"><textarea rows="1" name="cattemplate" cols="1"><p>&nbsp;</p></textarea></td>
      <td bgcolor="#FFFFFF" style="line-height: 100%">
      <input type="button" value="Upload" name="B1" onclick="startupload()" style="background-color: #FFFFFF; color: #6D7BA0; font-weight: bold"><p>&nbsp;</td>
    </tr>
  </table></div>
    </center>
  </div>
  
	
		<p><b>Note</b>: If a button
      labeled
&quot;<b>Browse</b>...&quot; or &quot;<b>Choose File</b>...&quot; does not appear, then your browser does not support File
Upload.&nbsp; You will need to upgrade to the latest browser version or check 
		your browser settings.</p>
		<p><b>Copy to underlying</b>:&nbsp; When selected a duplicate record 
		will be added for all securities attached&nbsp; to the root of the 
		security.&nbsp; For example;&nbsp; if releasing an announcement for 
		options of ABCOA&nbsp; then all securities will receive a duplicate 
		record of the announcement e.g. ABC, ABCA, ABCB, ABCOA, ABCOB etc when 
		the copy to underlying is set to &quot;Yes&quot;.&nbsp; This saves on having to 
		lodge the same&nbsp; announcement multiple times.</p>
		<p><b>Upload: </b>If the upload is successful you will see an acknowledgement receipt 
		page and receive a email acknowledgement.&nbsp; Otherwise you will see a 
		red error message requesting you to take corrective action.&nbsp; If you 
		do not get the receipt messages then the upload was not successful.&nbsp; 
		Please note that the file size limit is 10 megabytes and that only Adobe 
		acrobat PDF files can be accepted.</p>
		<p><b>What happens next: </b>Once <%=exchshort%> was reviewed the announcement&nbsp; and released it, you 
		will get an email stating that <%=exchshort%> has released the announcement.</p>
		<p>If you do not receive the above notifications then it is likely an 
		announcement ahs not been submitted.&nbsp; Please check the <%=exchshort%> website 
		and if the announcement has not appeared then resubmit the document.</p>
		<p><b>Maximum File size:&nbsp; </b>Files must not be larger than 10 megabytes.&nbsp; 
		If it is the announcement will be rejected.&nbsp; Files larger than 
		10megabytes are usually scanned documents.&nbsp; Look at reducing the 
		resolution settings on your scanner or create a PDF file from the 
		original document, then only scan and insert the pages that have to be 
		scanned.&nbsp; For example signature pages.</p>
	
	
  <input type="hidden" name="coname" value="<%=coname%>">
  <input type="hidden" name="acn" value="<%=acn%>">
  <input type="hidden" name="display" value="1">
  <input type="hidden" name="username" value="<%=Session("username")%>">
  <input type="hidden" name="nsxcode" value="<%=nsxcode%>">
	<input type="hidden" name="anncopycodes" value="<%=anncopycodes%>">
</form>


      <p> &nbsp;&nbsp;&nbsp;&nbsp;
    
    </td>
        
    

</table></div>
</div>
<% if len(exchid)<>0 then server.execute "company_footer_v2_" & exchid & ".asp"%>
</body>

</html>