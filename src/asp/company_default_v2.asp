<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="company_check_exchid_v2.asp"-->
<!--#INCLUDE FILE="member_check_v2.asp"-->
<%
'financial report calculator
function isleapyear(xx)
yy = xx mod 4
isleapyear = false
if yy = 0 then isleapyear = true else isleapyear = false
' special case for centuries
if right(xx,2) = "00" then
	yy = xx mod 400
	if yy = 0 then isleapyear = true else isleapyear = false
end if
end function


'balance dates
yr = year(date)
if isleapyear(yr) then 
	fb = "29-Feb-" 
	else
	fb = "28-Feb-"
end if

bal_mar = "31-mar-" & yr
bal_apr = "30-apr-" & yr
bal_jun = "30-jun-" & yr
bal_jul= "31-jul-" & yr
bal_sep = "30-sep-" & yr
bal_dec = "31-dec-"& yr

half_mar = "30-sep-" & yr
half_apr = "30-apr-" & yr
half_jun = "31-dec-" & yr
half_jul = "31-jan-" & yr
half_sep = "31-mar-" & yr
half_dec = "30-jun-" & yr

halfc_mar = cdate("30-sep-" & yr -1) + 75 
halfc_apr = cdate("30-oct-" & yr -1) + 76 
halfc_jun = cdate("31-dec-" & yr -1) + 75 
halfc_jul = cdate("31-jan-" & yr) + 75 
halfc_sep = cdate("31-mar-" & yr) + 75
halfc_dec = cdate("30-jun-" & yr) + 75

pre_mar = cdate("31-mar-" & yr) + 75 
pre_apr = cdate("30-apr-" & yr) + 75 
pre_jun = cdate("30-jun-" & yr) + 75
pre_jul= cdate("31-jul-" & yr) + 75
pre_sep = cdate("30-sep-" & yr - 1) + 75
pre_dec = cdate("31-dec-"& yr - 1) + 75 

ann_mar = "30-jun-" & yr
ann_apr = "31-july-" & yr
ann_jun = "30-sep-" & yr
ann_jul= "31-oct-" & yr
ann_sep = "31-dec-" & yr
ann_dec = "31-mar-"& yr

SELECT CASE exchid
	case "NSX"
		rep_mar = "31-jul-" & yr
		rep_apr = "31-aug-" & yr
		rep_jun = "31-oct-" & yr
		rep_jul= "30-nov-" & yr
		rep_sep = "31-jan-" & yr
		rep_dec = "30-apr-"& yr
	case "SIMV"
		rep_mar = cdate("31-mar-" & yr) + 119
		rep_apr = cdate("30-apr-" & yr) +119
		rep_jun = cdate("30-jun-" & yr) + 119
		rep_jul= cdate("31-jul-" & yr) + 119
		rep_sep = cdate("30-sep-" & yr) + 119
		rep_dec = cdate("31-dec-"& yr) + 119
END SELECT

agm_mar = "31-aug-" & yr
agm_apr = "30-sep-" & yr
agm_jun = "30-nov-" & yr
agm_jul= "31-dec-" & yr
agm_sep = fb & yr
agm_dec = "31-may-"& yr

function fmtddmm(xx)
xd = day(xx)
xm = monthname(month(xx),true)
xf = xd & "-" & xm

' due now or soon?
curdte = date
fmtddmm = xf
xdd = datediff("d",date,xx)
if  xdd >=0 and xdd <= 11 then fmtddmm = "<span style='background-color:red'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
if xdd > 11 and xdd <= 31 then fmtddmm = "<span style='background-color:green'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
end function

group = "yes"
if group = "yes"  then
	srchgrp="nsxcode"
	else
	srchgrp="nsxcode"
end if
' construct search for multiple codes.
srch = " WHERE  "

comments=trim(session("comments") & " ")
if len(comments)=0 then comments=trim(session("nsxcode") & " ")
nsxcodes=replace(comments,";",",")

if len(nsxcodes)<>0 then
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " "
	nsxcode=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcode)
		srch = srch & "(" & srchgrp & "='" & nsxcode(jj) & "') OR "
	next
	srch = left(srch,len(srch)-4)
		
end if


' GET BALANCE DATE TO CUSTOMISE USER EXPERIENCE
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT nsxcode,balancedate,coname"
SQL = SQL & " FROM codetails "
SQL = SQL & srch
SQL = SQL & " ORDER BY nsxcode ASC "
CmdDD.Open SQL, ConnPasswords,1,3

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

rowcount = 0
maxpagesize = 30
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>

<!--#INCLUDE FILE="head.asp"--><html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=session("exchname")%></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle,enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<%select case exchid
	case "NSX"
	%>
	<link rel=stylesheet href="newsx2.css" type="text/css">
<% case "SIMV"%>
	<!--#file = "include/common/stylesheets.asp" -->
	<link rel=stylesheet href="http://www.nsxa.com.au/newsx2.css" type="text/css">
<% case else %>
	<link rel=stylesheet href="http://www.nsxa.com.au/newsx2.css" type="text/css">
<% end select%>

<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" >
</head>

<body >
<% if len(exchid)<>0 then server.execute "company_header_v2_" & exchid & ".asp"%>
<div align="center">
<div class="table-responsive"><table border="0" width="797" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" rowspan="3" bgcolor="#FFFFFF" width="175">
		<%if len(exchid)<>0 then server.execute "company_lmenu_v2_" & exchid & ".asp"%>
		</td>
	</tr>
	<tr>
		<td class="textheader" bgcolor="#FFFFFF" >
		<blockquote>
			<h1>LISTED COMPANY SERVICES</h1>
		</blockquote></td>
	</tr>
	<tr>
		<td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">
		<blockquote>
			<p>Welcome <b><i><font color="#6D7BA0"><font face="Arial" size="3"><%=Session("fname")%></font><font size="2" face="Arial">
			</font><font face="Arial" size="3"><%=Session("ORG")%>&nbsp;</font></font></i></b><font size="2" face="Arial">to 
			the Listed Company Services Page.</font><b><i><font face="Arial" size="3" color="#6D7BA0"><br>
			</font></i></b>
			You look after the following companies<b><font face="Arial" size="3" color="#6D7BA0"><i> <%=nsxcodes%></i></font></b><font size="2" face="Arial">.</font><p>The listed company services area allows you to:</blockquote>
		<blockquote>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">report an announcement;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">check your announcements;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">check trade history;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">change your account details;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">logout from your account.<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
<% if exchid = "NSX" or exchid="SIMV" then %>
		
			<h2>Time Table for Financial Report Lodgments:</h2>
			<div class="table-responsive"><table  width=500 id="table2" cellspacing="1" cellpadding="3" >
			<% if exchid = "NSX" then%>
				<tr>
				<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Code</font></b></td>

					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Balance Date</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Half Yearly<br>75 days<br>(s320)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Preliminary&nbsp;<br>Reports<br>75 days</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Annual <br>Reports<br>3 Months<br>(s319)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="72" >
					<b><font color="#FFFFFF">Reporting to<br>members<br>4 Months<br>(s315)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="72" >
					<b><font color="#FFFFFF">Hold AGM<br>5 Months (s250N)</font></b></td>
				</tr>
			<% elseif exchid = "SIMV" then %>
				<tr>
				<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Code</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Balance Date</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Half Yearly<br>75 days<br>(s320, LR3.3)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Annexure 3A<br>75 days<br>(LR3.6)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Financial<br>Documents<br>3 Months<br>(s319, LR3.9)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="72" >
					<b><font color="#FFFFFF">Reporting to<br>members<br>119 days<br>(LR3.12)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="72" >
					<b><font color="#FFFFFF">Hold AGM<br>5 Months (s250N)</font></b></td>
				</tr>
			<% end if%>
				
<%  if WEOF then %>
	
  <tr>
    <td class="plaintext" colspan="7">There is no data available.</td>
  </tr>
<% else
	lap=1
      	  for jj = 0 to rc
      	  
      	  nsxcode = ucase(alldata(0,jj))
      	  balancedate = ucase(alldata(1,jj))
      	  coname = alldata(2,jj)
      	  
     cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>

				
				

	<%if balancedate="31-MAR" then %>
		  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext"  align="center" nowrap width="71" ><b><%=nsxcode%></b></td>
					<td class="plaintext"  align="right" nowrap width="71" ><b>31 Mar</b></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(halfc_mar)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(pre_mar)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(ann_mar)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(rep_mar)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(agm_mar)%></td>
				</tr>
	<%
	end if
	if balancedate="30-APR" then %>
		  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext"  align="center" nowrap width="71" ><b><%=nsxcode%></b></td>
					<td class="plaintext"  align="right" nowrap width="71" ><b>30 Apr</b></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(halfc_apr)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(pre_apr)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(ann_apr)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(rep_apr)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(agm_apr)%></td>
				</tr>
	<%
	end if

	if balancedate="30-JUN" then
	%>	
				  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext"  align="center" nowrap width="71" ><b><%=nsxcode%></b></td>
					<td class="plaintext"  align="right" nowrap width="71" ><b>30 Jun</b></td>
					<td class="plaintext" align="center"  nowrap width="71" ><%=fmtddmm(halfc_jun)%></td>
					<td class="plaintext" align="center"  nowrap width="71" ><%=fmtddmm(pre_jun)%></td>
					<td class="plaintext" align="center"  nowrap width="71" ><%=fmtddmm(ann_jun)%></td>
					<td class="plaintext" align="center"  nowrap width="72" ><%=fmtddmm(rep_jun)%></td>
					<td class="plaintext" align="center"  nowrap width="72" ><%=fmtddmm(agm_jun)%></td>
				</tr>
	<%
	end if
	if balancedate="31-JUL" then
	%>

				  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext"  align="center" nowrap width="71" ><b><%=nsxcode%></b></td>
					<td class="plaintext"  align="right" nowrap width="71" >
					<b>31 Jul</b></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(halfc_jul)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(pre_jul)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(ann_jul)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(rep_jul)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(agm_jul)%></td>
				</tr>
	<%
	end if
	if balancedate="30-SEP" then
	%>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext"  align="center" nowrap width="71" ><b><%=nsxcode%></b></td>
					<td class="plaintext"  align="right" nowrap width="71" ><b>30 Sep</b></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(halfc_sep)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(pre_sep)%></td>
					<td class="plaintext" align="center" nowrap width="71"  ><%=fmtddmm(ann_sep)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(rep_sep)%></td>
					<td class="plaintext" align="center" nowrap width="72"  ><%=fmtddmm(agm_sep)%></td>
				</tr>
	<%
	end if
	if balancedate="31-DEC" then
	%>

				  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
					<td class="plaintext"  align="center" nowrap width="71" ><b><%=nsxcode%></b></td>
					<td class="plaintext" align="right"   nowrap width="71"  ><b>31 Dec</b></td>
					<td class="plaintext" align="center"  nowrap width="71"  ><%=fmtddmm(halfc_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="71"  ><%=fmtddmm(pre_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="71"  ><%=fmtddmm(ann_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="72"  ><%=fmtddmm(rep_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="72"  ><%=fmtddmm(agm_dec)%></td>
				</tr>
	<%END IF%>
	
	<% NEXT
	end if
	%>
			</table></div>
			<div class="table-responsive"><table border="0" width="300" id="table3" cellspacing="0" cellpadding="0">
				<tr>
					<td bordercolor="#FF0000" bgcolor="#FF3333" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>Due Now</b></font></td>
					<td bordercolor="#008000" bgcolor="#008000" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>Due Soon</b></font></td>
					<td bordercolor="#808080" bgcolor="#808080" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>&nbsp;
					<%
					if isleapyear(yr) then
					response.write "note: " & yr & " is a leap year"
					end if
					%>
					</font>
					</td>
				</tr>
			</table></div>
<% end if
if exchid = "NSX"  then %>
			<h2>DUAL LODGEMENT RELIEF</h2>
			<p>Please note that NSX has applied for and obtained dual lodgement 
			relief from ASIC.&nbsp; This relief <u>only</u> relates to annual 
			and half yearly financial reports.&nbsp; That is, those reports that 
			are lodged with ASIC using a 388 form.&nbsp; When an Issuer lodges a 
			half year report or annual report, they do not need to also lodge 
			the report with ASIC at the same time.&nbsp; To maintain this 
			relief. Issuers must lodge their reports by 5pm of the day that the 
			report is due (please see the table above).&nbsp; If an issuer fails 
			to lodge a financial report by the due date the NSX will place the 
			Issuer into a trading halt until such time as the document is lodged 
			but also the Issuer must. at the same time, lodge the document with 
			ASIC.</p>
			<p>Issuers must still lodge, direct with ASIC, all other documents 
			required by ASIC.&nbsp; NSX Listing Rules require that any document 
			lodged with ASIC must also be lodged with NSX at the same time.</p>
			<h2>REQUIRED DOCUMENTS</h2>
			<h2>Half Year Reports</h2>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Statutory Half Year Report;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Appendix 3 (for information not included in the statutory 
				report).<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
			<h2>Preliminary Final Report</h2>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Appendix 3<br>
					(not required if the <u>statutory annual</u> report is 
					lodged before the preliminary due date)<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
			<h2>Annual Reports</h2>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Statutory Report.<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
			<h2>Reporting to members (at least 31 days before meeting -&nbsp; 
			28days notice/3days postage)</h2>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Notice of meeting;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Proxy form sample;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Explanatory memorandum (if applicable);<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Full Annual report (if different from the statutory report).<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Employee share plan documents<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Other documentation required 
					to be reviewed by shareholders<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
			<h2>Annual General Meeting</h2>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Results of meeting resolutions including proxies tabled for 
				each resolution;<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Chairman's Address (if prepared);<!--msimagelist--></td>
				</tr>
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="baseline" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">CEO's Address (if prepared).<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
			<h2>Further Information</h2>
			<!--msimagelist--><div class="table-responsive"><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">
					<img border="0" src="images/pdf.gif" width="16" height="16" align="middle">
					<a href="documents/practice_notes/PN09-PeriodicDisclosure.pdf">
					Periodic Disclosure Practice Note</a> #9<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table></div>
<% end if %>
		</blockquote>
    
    </td>
</table></div>
</div>
<% if len(exchid)<>0 then server.execute "company_footer_v2_" & exchid & ".asp"%>
</body>

</html>