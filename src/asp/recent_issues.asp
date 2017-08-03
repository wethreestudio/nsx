<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")

'objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
'objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"
'
'objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

'bySecurity = Request.QueryString("bysecurity") 'List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"><img src="images/banners/iStock-476090471.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Recent Listings</h1>
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

<%
SQL = "SELECT  tradingcode,recorddatestamp,issuedescription,datelisted,[issueprice],[last]"
SQL = SQL & " FROM PricesCurrent "
'SQL = SQL & " WHERE (issuestatus='active') AND (exchid<>'SIMV') AND (datelisted > DATEADD(DAY, -400, GETDATE())) "
'SQL = SQL & " WHERE (issuestatus IN ('active','delisted','suspended','trading halt','su','th')) AND (exchid<>'SIMV') AND (datelisted > '" & year(date)-1 & "-1-1 00:00:00' )"
SQL = SQL & " WHERE (issuestatus IN ('active','delisted','suspended','trading halt','su','th')) AND (exchid<>'SIMV') AND (datelisted > '" & "2015-1-1 00:00:00' )"
SQL = SQL & " ORDER BY datelisted DESC "
'response.write SQL
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
%>
    <div class="f-w-table">
<div class="table-responsive"><table>
    <thead>
        <tr>
            <th colspan="7">
            <p>Recent Listings<span>from 1 January <%=(year(date)-1)  %></span></p>
            </th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="7"></td>
    </tr>
    </tfoot>
    <tbody>
        <tr class="sub-header">
            <td align="left" width="40">Code</td>
            <td align="left">Security</td>
            <td width="120">Listing Date</td>
			<td width="120">Issue Price</td>
			<td width="100">Last Price</td>
            <td width="100">Summary</td>
            <td width="140">Announcements</td>
        </tr>
<%
If rs.EOF Then
  %><tr><td colspan="7" align="center">No recent new security floats</td></tr><%
Else
	lap = 1
  alt = true
  While Not rs.EOF
    tradingcode = rs("Tradingcode")
    issueDescription = rs("IssueDescription")
    datelisted = rs("datelisted")
	if isdate(datelisted) then datelisted = Day(datelisted) & "-" & MonthName(Month(datelisted),True) & "-" & Year(datelisted) 
    issueprice = rs("issueprice")
	if isnumeric(issueprice) then issueprice = "$" & formatnumber(issueprice,2)
	lastprice = rs("last")
	lastprice= "$" & formatnumber(lastprice,3)
%>        
        <tr<%
  If alt = True Then 
    Response.Write " class=""alt"""
  End If
        %>>
            <td align="left"><h3><%=tradingcode%></h3></td>
            <td align="left"><%=issueDescription%></a></td>
            <td ><%=datelisted%></td>
			<td align="right"><%=issueprice%></td>
			<td align="right"><%=lastprice%></td>
            <td><a href="/summary/<%=tradingcode%>" class="btn-blue small" title="View market summary">view</a></td>
            <td><a href="/marketdata/company-directory/announcements/<%=tradingcode%>/" class="btn-blue small" title="View Announcements">view</a></td>
        </tr>
<%
    rs.MoveNext
	lap = lap + 1
	alt = Not alt 
  Wend  
End If
%>      

    </tbody>
</table></div>

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