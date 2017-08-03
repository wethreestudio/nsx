<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Reporting Calendar"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

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
if  xdd >=0 and xdd <= 11 then fmtddmm = "<span class=""calendar-key-due-now"">&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</span>"
if xdd > 11 and xdd <= 31 then fmtddmm = "<span class=""calendar-key-due-soon"">&nbsp;&nbsp;" & xf & "&nbsp;&nbsp;</span>"
end function

%>
<!--#INCLUDE FILE="header.asp"-->

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Reporting Calendar</h1>
            </div>
        </div>
    </div>
</div>

<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<%
  RenderContent page,"editarea" 
%>

<h1>Reporting Calendar</h1> 
<br>

<div class="f-w-table">
<div class="table-responsive"><table>
    <thead>
        <tr>
            <th colspan="6">
            <p>Time Table <span>for Financial Report Lodgments</span></p>
            <img class="water-mark" src="/images/nsx-water-mark.png" alt="" /></th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="6"></td>
    </tr>
    </tfoot>
    <tbody>
        <tr class="sub-header">
            <td>Balance Date</td>
			<td>Half Yearly<br>75 days<br>(s320)</td>
            <td>Preliminary Reports<br>75 days</td>
            
            <td>Annual Reports<br>3 Months<br>(s319)</td>
            <td>Report to members<br>4 Months<br>(s315)</td>
            <td>Hold AGM<br>5 Months<br>(s250N)</td>
        </tr>
				<tr class="alt">
					<td><b>31 Mar</b></td>
					<td><%=fmtddmm(halfc_mar)%></td>
					<td><%=fmtddmm(pre_mar)%></td>
					<td><%=fmtddmm(ann_mar)%></td>
					<td><%=fmtddmm(rep_mar)%></td>
					<td><%=fmtddmm(agm_mar)%></td>
				</tr>
				<tr>
					<td><b>30 Apr</b></td>
					<td><%=fmtddmm(halfc_apr)%></td>
					<td><%=fmtddmm(pre_apr)%></td>
					<td><%=fmtddmm(ann_apr)%></td>
					<td><%=fmtddmm(rep_apr)%></td>
					<td><%=fmtddmm(agm_apr)%></td>
				</tr>
				<tr class="alt">
					<td><b>30 Jun</b></td>
					<td><%=fmtddmm(halfc_jun)%></td>
					<td><%=fmtddmm(pre_jun)%></td>
					<td><%=fmtddmm(ann_jun)%></td>
					<td><%=fmtddmm(rep_jun)%></td>
					<td><%=fmtddmm(agm_jun)%></td>
				</tr>
				<tr>
					<td><b>31 Jul</b></td>
					<td><%=fmtddmm(halfc_jul)%></td>
					<td><%=fmtddmm(pre_jul)%></td>
					<td><%=fmtddmm(ann_jul)%></td>
					<td><%=fmtddmm(rep_jul)%></td>
					<td><%=fmtddmm(agm_jul)%></td>
				</tr>
				<tr class="alt">
					<td><b>30 Sep</b></td>
					<td><%=fmtddmm(halfc_sep)%></td>
					<td><%=fmtddmm(pre_sep)%></td>
					<td><%=fmtddmm(ann_sep)%></td>
					<td><%=fmtddmm(rep_sep)%></td>
					<td><%=fmtddmm(agm_sep)%></td>
				</tr>
				<tr>
					<td><b>31 Dec</b></td>
					<td><%=fmtddmm(halfc_dec)%></td>
					<td><%=fmtddmm(pre_dec)%></td>
					<td><%=fmtddmm(ann_dec)%></td>
					<td><%=fmtddmm(rep_dec)%></td>
					<td><%=fmtddmm(agm_dec)%></td>
				</tr>
    </tbody>
</table></div>



</div>


<div class="editarea">
<div style="padding-bottom:8px;">
<div class="table-responsive"><table>
<tr>
  <td><div style="padding:5px;"><span class="calendar-key-due-now">Due Now</span></div></td>
  <td><div style="padding:5px;"><span class="calendar-key-due-soon">Due Soon</span></div></td>
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
<b>Half Year Reports</b>
<ul>
  <li>Statutory Half Year Report;</li>
  <li>Appendix 3 (for information not included in the statutory report).</li>
</ul>

<b>Preliminary Final Report</b>
<ul>
  <li>Appendix 3(not required if the statutory annual report is lodged before the preliminary due date).</li>
</ul>

<b>Annual Reports</b>
<ul>
  <li>Statutory Report.</li>
</ul>

<b>Reporting to members</b> (at least 31 days before meeting -  28days notice/3days postage)
<ul>
  <li>Notice of meeting;</li>
  <li>Proxy form sample;</li>
  <li>Explanatory memorandum (if applicable);</li>
  <li>Full Annual report (if different from the statutory report);</li>
  <li>Employee share plan documents;</li>
  <li>Other documentation required to be reviewed by shareholders.</li>
</ul>

<b>Annual General Meeting</b>
<ul>
  <li>Results of meeting resolutions including proxies tabled for each resolution;</li>
  <li>Chairman's Address (if prepared);</li>
  <li>CEO's Address (if prepared).</li>
</ul>

<b>Further Information</b>
<ul>
  <li><a href="/documents/practice_notes/PN09-PeriodicDisclosure.pdf">Periodic Disclosure Practice Note #9.</a></li>
</ul>

</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->