<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "CSX" %>
<!--#INCLUDE FILE="member_check.asp"-->
<%
'financial report calculator
Function isleapyear(xx)
  yy = xx mod 4
  isleapyear = false
  if yy = 0 then isleapyear = true else isleapyear = false
  ' special case for centuries
  if right(xx,2) = "00" then
  	yy = xx mod 400
  	if yy = 0 then isleapyear = true else isleapyear = false
  end if
End Function


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
  if  xdd >=0 and xdd <= 11 then fmtddmm = "<span style=""background-color:red;color:white;""><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></span>"
  if xdd > 11 and xdd <= 31 then fmtddmm = "<span style=""background-color:green;color:white;""><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></span>"
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

If len(nsxcodes) <> 0 Then
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")
	srch = srch & " "
	nsxcode=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcode)
	 If Len(Trim(nsxcode(jj))) > 0 Then
		srch = srch & "(" & srchgrp & "='" & SafeSqlParameter(nsxcode(jj)) & "') OR "
	 End If
	next
	srch = left(srch,len(srch)-4)		
End If




page_title = "NSX - National Stock Exchange of Australia"
meta_description = "Official site of the National Stock Exchange of Australia, the market of choice for SME and growth style Australian and International companies."
meta_keywords = "NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW"
alow_robots = "no"
%>

<!--#INCLUDE FILE="header.asp"-->

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "company_side_menu.asp"
%>







<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">



  <div class="editarea">
  
  <h1>Listed Company Services</h1>
  
			<p>Welcome <%=Session("fname")%>, to the NSX Listed Company Services Page for <%=Session("ORG")%>.</p>
			
			<p>You look after the following companies <%=nsxcodes%></p>
      
      <p>The listed company services area allows you to:</p>
        <ul>
          <li>report an announcement;</li>
          <li>get a form;</li>
          <li>find out more about making announcements;</li>
          <li>check your announcements;</li>
          <li>change your contact details;</li>
          <li>change your company details;</li>
          <li>review the listing rules; and</li>
          <li>logout from your session.</li>
        </ul>
      
		


<%
Dim rc
rc = 0
%>
<div class="f-w-table">
  <div class="table-responsive"><table>
    <thead>
        <tr>
            <th colspan="7">
            <p>Time Table for Financial Report Lodgments <span>&nbsp;</span></p>
            <img class="water-mark" src="/images/nsx-water-mark.png" alt=""></th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="7">&nbsp;</td>
    </tr>
    </tfoot>
    <tbody>
        <tr class="sub-header">
          <td>NSX Code</td>
          <td>Balance<br>Date</td>
          <td>Half Yearly<br>75 days<br>(s320)</td>
          <td>Preliminary<br>Reports<br>75 days</td>
          <td>Annual<br>Reports<br>3 Months<br>(s319)</td>
          <td>Reporting to<br>Members<br>4 Months<br>(s315)</td>
          <td>Hold AGM<br>5 Months<br>(s250N)</td>
        </tr>
	
<%  

SQL = "SELECT nsxcode,balancedate,coname FROM codetails " & srch & " ORDER BY nsxcode ASC "
Rows = GetRows(SQL)
RowCount = -1
If VarType(Rows) <> 0 Then RowCount = UBound(Rows,2)
'response.write VarType(Rows)
'response.write RowCount


If RowCount < 0 Then 
%>	
  <tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
    <td class="plaintext" colspan="7">There is no data available.</td>
  </tr>
<% 
Else
  For i = 0 To RowCount
    nsxcode = UCase(Rows(0,i))
    balancedate = UCase(Rows(1,i))
    coname = Rows(2,i)
    If balancedate="31-MAR" Then 
%>
		  <tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
				<td><b><%=nsxcode%></td>
				<td><b>31 Mar</td>
				<td><%=fmtddmm(halfc_mar)%></td>
				<td><%=fmtddmm(pre_mar)%></td>
				<td><%=fmtddmm(ann_mar)%></td>
				<td><%=fmtddmm(rep_mar)%></td>
				<td><%=fmtddmm(agm_mar)%></td>
			</tr>
<% 
    End If
    If balancedate="30-APR" Then 
%>
		  <tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
				<td><%=nsxcode%></td>
				<td>30 Apr</td>
				<td><%=fmtddmm(halfc_apr)%></td>
				<td><%=fmtddmm(pre_apr)%></td>
				<td><%=fmtddmm(ann_apr)%></td>
				<td><%=fmtddmm(rep_apr)%></td>
				<td><%=fmtddmm(agm_apr)%></td>
			</tr>
<% 
    End If
    If balancedate="30-JUN" Then
%>	
			<tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
				<td><%=nsxcode%></td>
				<td>30 Jun</td>
				<td><%=fmtddmm(halfc_jun)%></td>
				<td><%=fmtddmm(pre_jun)%></td>
				<td><%=fmtddmm(ann_jun)%></td>
				<td><%=fmtddmm(rep_jun)%></td>
				<td><%=fmtddmm(agm_jun)%></td>
			</tr>
<% 
    End If
    If balancedate="31-JUL" Then
%>
			<tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
				<td><%=nsxcode%></td>
				<td>31 Jul</td>
				<td><%=fmtddmm(halfc_jul)%></td>
				<td><%=fmtddmm(pre_jul)%></td>
				<td><%=fmtddmm(ann_jul)%></td>
				<td><%=fmtddmm(rep_jul)%></td>
				<td><%=fmtddmm(agm_jul)%></td>
			</tr>
<% 
    End If
    If balancedate="30-SEP" Then
%>
      <tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
				<td><%=nsxcode%></td>
				<td>30 Sep</td>
				<td><%=fmtddmm(halfc_sep)%></td>
				<td><%=fmtddmm(pre_sep)%></td>
				<td><%=fmtddmm(ann_sep)%></td>
				<td><%=fmtddmm(rep_sep)%></td>
				<td><%=fmtddmm(agm_sep)%></td>
			</tr>
<% 
    End If
    If balancedate="31-DEC" Then
%>
			<tr <% If rc mod 2 = 0 Then Response.Write " class=""alt""" %>>
				<td><%=nsxcode%></td>
				<td>31 Dec</td>
				<td><%=fmtddmm(halfc_dec)%></td>
				<td><%=fmtddmm(pre_dec)%></td>
				<td><%=fmtddmm(ann_dec)%></td>
				<td><%=fmtddmm(rep_dec)%></td>
				<td><%=fmtddmm(agm_dec)%></td>
			</tr>
<% 
    End If
    rc = rc + 1 
  Next
End If
%>
  </table></div>
</div>


<div class="editarea">
<div style="padding-bottom:8px;">
<div class="table-responsive"><table>
<tr>
  <td><div style="padding:5px;"><span style="padding:2px;background:#ff0000;color:#ffffff;font-weight:bold;">Due Now</span></div></td>
  <td><div style="padding:5px;"><span style="padding:2px;background:#008000;color:#ffffff;font-weight:bold;">Due Soon</span></div></td>
<%
If isleapyear(Year(Now())) Then
%>
<td><div style="padding:5px;"><span style="padding:2px;">Note <%=Year(Now())%> is a leap year</span></div></td>
<%
End If
%>
				</tr>

</table></div>
</div>
		
			
			<h2>Dual Lodgement Relief</h2>
			
			<p>Please note that NSX has applied for and obtained dual lodgement 
			relief from ASIC. This relief <u>only</u> relates to annual 
			and half yearly financial reports. That is, those reports that 
			are lodged with ASIC using a 388 form. When an Issuer lodges a 
			half year report or annual report, they do not need to also lodge 
			the report with ASIC at the same time. To maintain this 
			relief. Issuers must lodge their reports by 5pm of the day that the 
			report is due (please see the table above). If an issuer fails 
			to lodge a financial report by the due date the NSX will place the 
			Issuer into a trading halt until such time as the document is lodged 
			but also the Issuer must. at the same time, lodge the document with 
			ASIC.</p>
			
			<p>Issuers must still lodge, direct with ASIC, all other documents 
			required by ASIC. NSX Listing Rules require that any document 
			lodged with ASIC must also be lodged with NSX at the same time.</p>
			
			
			<h2>Required Documents</h2>
			
			
			
			<h3>Half Year Reports</h3>
			<ul>
        <li>Statutory Half Year Report;</li>
				<li>Appendix 3 (for information not included in the statutory report).</li>
			</ul>
				
				
			<h3>Preliminary Final Report</h3>
			<ul>
        <li>Appendix 3<br> (not required if the <u>statutory annual</u> report is lodged before the preliminary due date)</li>
			</ul>
			
			
			<h3>Annual Reports</h3>
			<ul>
        <li>Statutory Report.</li>
			</ul>
			
			
			<h3>Reporting to members</h3>
      <p>(at least 31 days before meeting -	28days notice/3days postage)</p>
			<ul>
        <li>Notice of meeting;</li>
				<li>Proxy form sample;</li>
				<li>Explanatory memorandum (if applicable);</li>
				<li>Full Annual report (if different from the statutory report);</li>
				<li>Employee share plan documents;</li>
				<li>Other documentation required to be reviewed by shareholders.</li>
			</ul>
				
				
			<h3>Annual General Meeting</h3>
			<ul>
        <li>Results of meeting resolutions including proxies tabled for each resolution;</li>
				<li>Chairman's Address (if prepared);</li>
				<li>CEO's Address (if prepared).</li>
			</ul>
				
				
				
			<h3>Further Information</h3>
			<ul>
        <li><a href="documents/practice_notes/PN09-PeriodicDisclosure.pdf">Periodic Disclosure Practice Note</a> #9</li>
			</ul>
				
				
		







</div>
</div>

</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>


<!--#INCLUDE FILE="footer.asp"-->

