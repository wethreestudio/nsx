<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Upcoming listings"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"><img src="images/banners/iStock-673667648.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Upcoming Listings</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
            <div class="prop min600px"></div>

<%
RenderContent page,"editarea" 
%>

<div class="f-w-table">
<table>
    <thead>
        <tr>
            <th colspan="6">
            <p>Upcoming Listings</p>
            </th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="6" align="left">All information is subject to change.</td>
    </tr>
    </tfoot>
    <tbody>
        <tr class="sub-header">
            <td align="left" width="40">Code</td>
            <td align="left">Security Details</td>
			 <td width="145">Application Status</td>
            <td width="105">Offer Closes</td>
            <td width="185">Proposed Listing Date</td>
            <td width="105">Announcements</td>
        </tr>
<%
'on error resume next
'sql = "SELECT Tradingcode,IssueDescription,iofferclosedate,ipdate,iCapitalRaised,issuestarted FROM coIssues "
sql = "SELECT coIssues.Tradingcode, coIssues.IssueDescription, coIssues.iofferclosedate, coIssues.ipdate, coIssues.iCapitalRaised, coIssues.issuestarted, PricesCurrent.datelisted, coissues.issuestatus "
sql = sql & "FROM coIssues INNER JOIN PricesCurrent ON coIssues.tradingcode = PricesCurrent.tradingcode "
sql = sql & "WHERE (coissues.iNewFloat='1' AND coissues.ExchID='NSX') "
sql = sql & " OR (PricesCurrent.datelisted >= DATEADD(DAY, -14, GETDATE())) "
sql = sql & " ORDER BY pricescurrent.datelisted DESC,coissues.tradingcode ASC"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="6" align="center">No new floats</td></tr><%
Else
  alt = true
  While Not rs.EOF
    tradingcode = rs("Tradingcode")
    issueDescription = rs("IssueDescription")
    iofferclosedate = rs("iofferclosedate")
	if isdate(iofferclosedate) then 
		iofferclosedate = Day(iofferclosedate) & "-" & MonthName(Month(iofferclosedate),True) & "-" & Year(iofferclosedate) 
		else
		iofferclosedate = "N/A"
	end if
    ipdate = rs("ipdate")
	if isdate(ipdate) then ipdate = Day(ipdate) & "-" & MonthName(Month(ipdate),True) & "-" & Year(ipdate) 
    iCapitalRaised = rs("iCapitalRaised")
	issuestarted = rs("issuestarted")
	datelisted = rs("datelisted")
	issuestatus = ucase(rs("issuestatus"))
		'if isdate(datelisted) then 
		'	status = "Approved"
		'	else
		'	status = "Applying"
		'end if
		select case issuestatus
			case "ACTIVE"
				status = "Approved"
			case "IPO"
				status = "Applying"
			case "DELISTED"
				status = "Delisted"
			case "WITHDRAWN"
				status = "Withdrawn"
			case "SUSPENDED"
				status = "Suspended"
			case else	
				status = issuestatus
		end select

		
%>        
        <tr<%
  If alt = True Then 
    Response.Write " class=""alt"""
  End If
        %>>
            <td align="left"><h3><%=tradingcode%></h3></td>
            <td align="left" valign="absmiddle"><%=issueDescription%></td>
			<td><%=status%></td>
            <td><%=iofferclosedate%></td>
            <td><%=ipdate%></td>
            <td><% if status = "Approved" then%>
			<a href="/summary/<%=tradingcode%>" class="btn-blue small">view</a>
			<%else%>
			<a href="/marketdata/company-directory/<%=tradingcode%>/" class="btn-blue small">view</a>
			
			<%end if%>
			</td>
        </tr>
<%
    rs.MoveNext
    alt = Not alt 
  Wend  
End If
%>      
</tbody>
</table>
</div>
<%
  RenderContent page & "_1","editarea" 
%>
</div>
<div style="clear:both;"></div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->