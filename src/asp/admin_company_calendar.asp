<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "ADMIN" %>
<!--#INCLUDE FILE="member_check.asp"-->

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

rep_mar = "31-jul-" & yr
rep_apr = "31-aug-" & yr
rep_jun = "31-oct-" & yr
rep_jul= "30-nov-" & yr
rep_sep = "31-jan-" & yr
rep_dec = "30-apr-"& yr

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


' GET BALANCE DATE TO CUSTOMISE USER EXPERIENCE
 
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
ConnPasswords.Open Application("nsx_ReaderConnectionString")  
 
Set CmdDD = Server.CreateObject("ADODB.Recordset")

SQL = "SELECT DISTINCT nsxcode,issuestatus"
SQL = SQL & " FROM coissues "
SQL = SQL & " WHERE IssueStatus='Active'"
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


	for ii = 0 to ubound(alldata,2)
		srch = srch & "(" & srchgrp & "='" & alldata(0,ii) & "') OR "
	next
	srch = left(srch,len(srch)-4)



' GET BALANCE DATE TO CUSTOMISE USER EXPERIENCE

Set CmdDD = Server.CreateObject("ADODB.Recordset")
SQL = "SELECT nsxcode, balancedate,coname "
SQL = SQL & " FROM codetails "
SQL = SQL & srch
SQL = SQL & " ORDER BY nsxcode ASC "

' , CAST(DAY(balancedate) AS VARCHAR(3)) + '-' + LEFT(DATENAME(MM, balancedate),3) AS balancedate_formatted
'response.write SQL
'response.end 

CmdDD.Open SQL, ConnPasswords ',1,3




'WEOF = CmdDD.EOF



'can only do getrows if there is more than one record.
'if not WEOF then 
'	alldata = cmddd.getrows
'	rc = ubound(alldata,2) 
'	else
'	rc = -1
'end if

'CmdDD.Close
'Set CmdDD = Nothing


'rowcount = 0
'maxpagesize = 30
'maxpages = round(.5 + (rc / maxpagesize),0)
'st = (currentpage * maxpagesize ) - maxpagesize
'fh = st + maxpagesize - 1
'if fh > rc then fh = rc

%>


<!--#INCLUDE FILE="header.asp"-->
    	<div class="container_cont">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" rowspan="3" bgcolor="#FFFFFF">
		</td>
	</tr>
	<tr>
		<td class="textheader" bgcolor="#FFFFFF" >
		
			<h1><font face="Arial">COMPANY CALENDAR</h1>
		</td>
	</tr>
	<tr>
		<td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">
		
			<h2>Time Table for Financial Report Lodgments as at: <%=now%></h2>
			<table  width="100%" id="table2" cellspacing="1" cellpadding="3" >
				<tr>
				<td class="plaintext" bgcolor="#666666" align="center" colspan="2" >
					<p align="left">
					<b><font color="#FFFFFF">NSX Code - Name </font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Balance Date</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Half Yearly<br>75 days<br>
&nbsp;(s320)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Preliminary&nbsp;<br>	Reports<br>
					75 days</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="71" >
					<b><font color="#FFFFFF">Annual <br>Reports<br>3 Months<br>
					(s319)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="72" >
					<b><font color="#FFFFFF">Reporting to<br>members<br>4 Months<br>
					(s315)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="72" >
					<b><font color="#FFFFFF">Hold AGM<br>5 Months (s250N)</font></b></td>
				</tr>
				
<%  if WEOF then %>
	
  <tr>
    <td class="plaintext" colspan="7">There is no data available.</td>
  </tr>
<% else



	lap=1
	issuercount=0
	
	
While Not CmdDD.EOF
	' response.write CmdDD("balancedate") & "<BR>"

      	  'for jj = 0 to rc
      	  
      	  nsxcode = ucase(CmdDD("nsxcode")) 'ucase(alldata(0,jj))
      	  balancedate = ucase(CmdDD("balancedate")) 'ucase(alldata(1,jj))
      	  coname = CmdDD("coname") ' alldata(2,jj)
		 ' balancedate_formatted = ucase(alldata(3,jj)) ' e.g. 1

      	  
     		cl = array("#EEEEEE","#FFFFFF")
			lap = (-lap)+1
			issuercount = issuercount + 1
'response.write balancedate ': response.end
    %>

				
				

	<%if balancedate="31-MAR" then %>
		  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext"  align="center" nowrap ><%=issuercount%>.</td>
				<td class="plaintext"  align="center" nowrap ><b>
				<p align="left"><%=nsxcode%></b><font size="1"> <%=coname%></font></td>
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
				<td class="plaintext"  align="center" nowrap ><%=issuercount%>.</td>
				<td class="plaintext"  align="center" nowrap ><b>
				<p align="left"><%=nsxcode%> </b><font size="1"><%=coname%></font></td>
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
				<td class="plaintext"  align="center" nowrap ><%=issuercount%>.</td>
				<td class="plaintext"  align="center" nowrap ><b>
				<p align="left"><%=nsxcode%> </b><font size="1"><%=coname%></font></td>
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
				<td class="plaintext"  align="center" nowrap ><%=issuercount%>.</td>
				<td class="plaintext"  align="center" nowrap ><b>
				<p align="left"><%=nsxcode%> </b><font size="1"><%=coname%></font></td>
					<td class="plaintext"  align="right" nowrap width="71" ><b>31 Jul</b></td>
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
				<td class="plaintext"  align="center" nowrap ><%=issuercount%>.</td>
				<td class="plaintext"  align="center" nowrap ><b>
				<p align="left"><%=nsxcode%> </b><font size="1"><%=coname%></font></td>
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
					<td class="plaintext"  align="center" nowrap ><%=issuercount%>.</td>
					<td class="plaintext"  align="center" nowrap ><b>
					<p align="left"><%=nsxcode%> </b><font size="1"><%=coname%></font></td>
 				<td class="plaintext" align="right"   nowrap width="71"  ><b>31 Dec</b></td>
					<td class="plaintext" align="center"  nowrap width="71"  ><%=fmtddmm(halfc_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="71"  ><%=fmtddmm(pre_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="71"  ><%=fmtddmm(ann_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="72"  ><%=fmtddmm(rep_dec)%></td>
					<td class="plaintext" align="center"  nowrap width="72"  ><%=fmtddmm(agm_dec)%></td>
				</tr>
	<%END IF%>
	
	<% 
	
	CmdDD.MoveNext
Wend
CmdDD.Close
'response.end		
	
	'NEXT
	end if
	%>
			</table>
			<table border="0" width="300" id="table3" cellspacing="0" cellpadding="0">
				<tr>
					<td bgcolor="#FF3333" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>Due Now</b></font></td>
					<td bgcolor="#008000" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>Due Soon</b></font></td>
					<td bgcolor="#808080" class="plaintext" align="center">
					<font color="#FFFFFF" size="1"><b>&nbsp;
					<%
					if isleapyear(yr) then
					response.write "note: " & yr & " is a leap year"
					end if
					%>
					</font>
					</td>
				</tr>
			</table>

		
    
    </td>
</table>
</div>
<%
ConnPasswords.Close()
Set ConnPasswords = Nothing
%>
<!--#INCLUDE FILE="footer.asp"-->
