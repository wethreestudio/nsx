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
<%
Server.Execute "side_menu.asp"
%>
<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Data</h1>
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
yrdate = year(date) - 1
'yrdate = 2012
'SQL = "SELECT  tradingcode,recorddatestamp,issuedescription,datelisted,[issueprice],[last] "
'SQL = SQL & " FROM PricesCurrent "
''SQL = SQL & " WHERE (issuestatus='active') AND (exchid<>'SIMV') AND (datelisted > DATEADD(DAY, -400, GETDATE())) "
'SQL = SQL & " WHERE (issuestatus IN ('active','suspended','trading halt','su','th','delisted'))  AND (datelisted > '" & yrdate & "-6-30 00:00:00' )"
'SQL = SQL & " ORDER BY datelisted DESC "
		
SQL = "SELECT  nsxcode,recorddatestamp,coname,aglisteddate,agdomicile "
SQL = SQL & " FROM coDetails "
SQL = SQL & " WHERE (aglisteddate > '" & yrdate & "-6-30 00:00:00' )"
SQL = SQL & " ORDER BY aglisteddate DESC "
		
'response.write SQL
'response.end
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)

%>
<div class="f-w-table">
<table>
    <thead>
        <tr>
            <th colspan="7">
            <p>Recent Company Listings<span>from 1 July <%=yrdate  %></span></p>
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
            <td align="left" width="40">Issuer Code</td>
            <td align="left">Issuer Name</td>
			<td align="left">Domicile</td>
            <td width="75">Listing Date</td>

        </tr>
<%
If rs.EOF Then
  %><tr><td colspan="7" align="center">No recent new issuer details</td></tr><%
Else
	lap = 1
  alt = true
  While Not rs.EOF
    tradingcode = rs("nsxcode")
    issueDescription = rs("coname")
    datelisted = rs("aglisteddate")
	    datelisted = rs("aglisteddate")
	if isdate(datelisted) then datelisted = Day(datelisted) & "-" & MonthName(Month(datelisted),True) & "-" & Year(datelisted) 
	    domicile = rs("agdomicile")
 %>        
        <tr<%
  If alt = True Then 
    Response.Write " class=""alt"""
  End If
        %>>
            <td align="left"><h3><a href=/summary/<%=tradingcode%>><%=tradingcode%></a></h3></td>
            <td align="left"><%=issueDescription%></a></td>
			<td align="left"><%=domicile%></a></td>
            <td ><%=datelisted%></td>
        </tr>
<%
    rs.MoveNext
	lap = lap + 1
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