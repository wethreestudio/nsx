<%
'financial report calculator

Response.Redirect "/companies_listed/company_calendar"
Response.End

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


%>
<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Reporting Calendar"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">
  <table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1" bgcolor="#FFFFFF">
    <tr>
      <td colspan="2"><h1>REPORTING CALENDAR</h1></td>
    </tr>
    <tr>
      <td class="plaintext" valign="top"><!--#INCLUDE FILE="lmenu.asp"--></td>
      <td class="plaintext" valign="top">
      
			<h2>Time Table for Financial Report Lodgments:</h2>
			<table  width="100%" id="table2" cellspacing="1" cellpadding="3" >
				<tr>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Balance Date</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Half Yearly<br>75 days<br>
&nbsp;(s320)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Preliminary&nbsp;<br>	Reports<br>
					75 days</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Annual<br>Reports&nbsp;<br>3 Months<br>
					(s319)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Reporting to<br>members<br>4 Months<br>
					(s315)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="84">
					<b><font color="#FFFFFF">Hold AGM<br>5 Months<br>(s250N)</font></b></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap width="83"><b>31 Mar</b></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(halfc_mar)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(pre_mar)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(ann_mar)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(rep_mar)%></td>
					<td class="plaintext" align="center" nowrap width="84" bgcolor="#FFFFFF"><%=fmtddmm(agm_mar)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#EEEEEE" align="right" nowrap width="83"><b>30 Apr</b></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(halfc_apr)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(pre_apr)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(ann_apr)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(rep_apr)%></td>
					<td class="plaintext" align="center" nowrap width="84" bgcolor="#EEEEEE"><%=fmtddmm(agm_apr)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap width="83"><b>30 Jun</b></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(halfc_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(pre_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(ann_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(rep_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="84"><%=fmtddmm(agm_jun)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#EEEEEE" align="right" nowrap width="83">
					<b>31 Jul</b></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(halfc_jul)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(pre_jul)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(ann_jul)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(rep_jul)%></td>
					<td class="plaintext" align="center" nowrap width="84" bgcolor="#EEEEEE"><%=fmtddmm(agm_jul)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap width="83"><b>30 Sep</b></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(halfc_sep)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(pre_sep)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(ann_sep)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#FFFFFF"><%=fmtddmm(rep_sep)%></td>
					<td class="plaintext" align="center" nowrap width="84" bgcolor="#FFFFFF"><%=fmtddmm(agm_sep)%></td>
				</tr>
				<tr>
					<td class="plaintext" align="right"  bgcolor="#EEEEEE" nowrap width="83" ><b>31 Dec</b></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap width="83" ><%=fmtddmm(halfc_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap width="83" ><%=fmtddmm(pre_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap width="83" ><%=fmtddmm(ann_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap width="83" ><%=fmtddmm(rep_dec)%></td>
					<td class="plaintext" align="center" bgcolor="#EEEEEE" nowrap width="84" ><%=fmtddmm(agm_dec)%></td>
				</tr>
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
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
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
				<!--msimagelist--></table>
			<h2>Preliminary Final Report</h2>
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Appendix 3<br>
					(not required if the <u>statutory annual</u> report is 
					lodged before the preliminary due date)<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table>
			<h2>Annual Reports</h2>
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Statutory Report.<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table>
			<h2>Reporting to members (at least 31 days before meeting -&nbsp; 
			28days notice/3days postage)</h2>
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
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
				<!--msimagelist--></table>
			<h2>Annual General Meeting</h2>
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
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
				<!--msimagelist--></table>
			<h2>Further Information</h2>
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">
					<img border="0" src="images/pdf.gif" width="16" height="16" align="middle">
					<a href="documents/practice_notes/PN09-PeriodicDisclosure.pdf">
					Periodic Disclosure Practice Note</a> #9<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table>
			<p>&nbsp;</p>
      
      </td>
    </tr>
  </table>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->