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

'bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->

<!--div class="container_cont">

<div id="wrap" -->
<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "side_menu.asp"
%>

<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>

<%
  RenderContent page,"editarea" 
%>


<%
	yrdate = year(date) - 1
	yrdate = 2009
		SQL = "SELECT  tradingcode,recorddatestamp,issuedescription,datelisted,[issueprice],[last] "
		SQL = SQL & " FROM PricesCurrent "
		'SQL = SQL & " WHERE (issuestatus='active') AND (exchid<>'SIMV') AND (datelisted > DATEADD(DAY, -400, GETDATE())) "
		SQL = SQL & " WHERE (issuestatus IN ('active','suspended','trading halt','su','th','delisted'))  AND (datelisted > '" & yrdate & "-6-30 00:00:00' )"
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
            <p>Recent Security Floats & Listings<span>from 1 July <%=(year(date)-1)  %></span></p>
            <img alt="" src="/images/nsx-water-mark.png" class="water-mark" /></th>
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
            <td width="75">Listing Date</td>
			<td width="50">Issue Price</td>
			<td width="50">Last Price</td>
            <td width="50">Summary</td>
            <td width="50">News</td>
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
            <td><a href="/marketdata/search_by_company?nsxcode=<%=tradingcode%>" class="btn-blue small" title="View Announcements">view</a></td>
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
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->