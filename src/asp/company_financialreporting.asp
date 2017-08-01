<%
'financial report calculator

rep_months = 1
'balance dates
yr = year(date)

bal_mar = "31-mar-" & yr
bal_jun = "30-jun-" & yr
bal_jul= "31-jul-" & yr
bal_sep = "30-sep-" & yr
bal_dec = "31-dec-"& yr

half_mar = "30-sep-" & yr
half_jun = "31-dec-" & yr
half_jul = "31-jan-" & yr
half_sep = "31-mar-" & yr
half_dec = "30-jun-" & yr

halfc_mar = cdate("30-sep-" & yr) + 76
halfc_jun = cdate("31-dec-" & yr) + 76
halfc_jul = cdate("31-jan-" & yr) + 76
halfc_sep = cdate("31-mar-" & yr) + 76
halfc_dec = cdate("30-jun-" & yr) + 76

pre_mar = cdate("31-mar-" & yr) + 76
pre_jun = cdate("30-jun-" & yr) + 76
pre_jul= cdate("31-jul-" & yr) + 76
pre_sep = cdate("30-sep-" & yr) + 76
pre_dec = cdate("31-dec-"& yr) + 76

ann_mar = "30-jun-" & yr
ann_jun = "30-sep-" & yr
ann_jul= "31-oct-" & yr
ann_sep = "31-dec-" & yr
ann_dec = "31-mar-"& yr

rep_mar = "31-jul-" & yr
rep_jun = "31-oct-" & yr
rep_jul= "30-nov-" & yr
rep_sep = "31-jan-" & yr
rep_dec = "30-apr-"& yr

agm_mar = "31-aug-" & yr
agm_jun = "30-nov-" & yr
agm_jul= "31-dec-" & yr
agm_sep = "28-feb-" & yr
agm_dec = "31-may-"& yr

function fmtddmm(xx)
xd = day(xx)
xm = monthname(month(xx),true)
xf = xd & "-" & xm

' due now or soon?
curdte = date
fmtddmm = xf
xdd = datediff("d",date,xx)
if  xdd >0 and xdd <= 11 then fmtddmm = "<span style='background-color: #FF3333'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
if  xdd >0 and xdd <= 11 then fmtddmm = "<span style='background-color: #FF3333'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
if xdd > 11 and xdd <= 31 then fmtddmm = "<span style='background-color:green'><font color=white><b>&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</b></font</span>"
end function


%>


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="AUTHOR" content="NSX">
<meta name="DISTRIBUTION" content="GLOBAL">
<meta name="RATING" content="GENERAL">
<meta name="description" content="NSX - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, Hamilton,  enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx, bsx, Bendigo">
<link rel=stylesheet href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" style="background-color: #DDDDDD">
<!--#INCLUDE FILE="header.asp"-->
<div align="center">
  <table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1" bgcolor="#FFFFFF">
    <tr>
      <td class="plaintext" colspan="2" bgcolor="#FFFFFF">
      
        COMPANY FINANCIAL REPORTING</b></font>
      </td>
    </tr>
    <tr>
      <td class="plaintext" valign="top"><!--#INCLUDE FILE="lmenu.asp"--></td>
      <td class="plaintext" valign="top">
      
			<h2>Time Table for Financial Report Lodgments:</h2>
			<table border="0" width="100" id="table3" cellspacing="0" cellpadding="0">
				<tr>
					<td bgcolor="#FF3333" class="plaintext" align="center">
					<font color="#FFFFFF"><b>Due Now</b></font></td>
					<td bgcolor="#008000" class="plaintext" align="center">
					<font color="#FFFFFF"><b>Due Soon</b></font></td>
				</tr>
			</table>
			<table  width="100%" id="table2" cellspacing="1" cellpadding="3" >
				<tr>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Balance Date</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Half Yearly <br>75 days (s320)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Preliminary &nbsp;<br>	Reports <br>
					75 days</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Annual <br>Reports &nbsp;<br>3 Months <br>
					(s319)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="83">
					<b><font color="#FFFFFF">Reporting to <br>members<br>4 Months <br>
					(s315)</font></b></td>
					<td class="plaintext" bgcolor="#666666" align="center" width="84">
					<b><font color="#FFFFFF">Hold AGM<br>5 Months <br>(s250N)</font></b></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#EEEEEE" align="right" nowrap width="83">
					<b>31 March</b></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(halfc_mar)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(pre_mar)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(ann_mar)%></td>
					<td class="plaintext" align="center" nowrap width="83" bgcolor="#EEEEEE"><%=fmtddmm(rep_mar)%></td>
					<td class="plaintext" align="center" nowrap width="84" bgcolor="#EEEEEE"><%=fmtddmm(agm_mar)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#FFFFFF" align="right" nowrap width="83"><b>30 June</b></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(halfc_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(pre_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(ann_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="83"><%=fmtddmm(rep_jun)%></td>
					<td class="plaintext" align="center" bgcolor="#FFFFFF" nowrap width="84"><%=fmtddmm(agm_jun)%></td>
				</tr>
				<tr>
					<td class="plaintext" bgcolor="#EEEEEE" align="right" nowrap width="83">
					<b>31 July</b></td>
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
			<h2>Annual Reports</h2>
			<!--msimagelist--><table class="plaintext" border="0" cellpadding="0" cellspacing="0" width="100%">
				<!--msimagelist--><tr>
					<!--msimagelist--><td valign="top" width="42">
					<img src="images/broker_page1_bullet.gif" width="20" height="15" hspace="11" alt="bullet"></td>
					<td valign="top" width="100%">Statutory Report.<!--msimagelist--></td>
				</tr>
				<!--msimagelist--></table>
			<h2>Reporting to members (at least 33 days before meeting)</h2>
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
			<p>&nbsp;</p>
      
      </td>
    </tr>
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->

</body>

</html>