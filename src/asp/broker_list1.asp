<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Broker Directory"
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
objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() 
    {
        $("#myTable").tablesorter( { widgets: ["zebra"] ,  headers: { 2: { sorter: false }, 3: { sorter: false }, 4: { sorter: false }, 5: { sorter: false } } } );
    } 
);
</script>

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"><img src="images/banners/iStock-184352977.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Broker Directory</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
                <div class="prop min600px"></div>
<%
RenderContent page,"editarea" 
  
sql = "SELECT m.agid, m.agName, ls.stateb, m.agweb0, m.tradingauthorisation, m.BrokerServiceType,m.listeddate FROM members m JOIN [Lookup - states] ls ON m.agState = ls.[sid] WHERE m.agStatus='1' ORDER BY m.agName ASC"

Set conn = GetReaderConn()
'Set rs = conn.Execute(sql)
set rs=Server.CreateObject("ADODB.recordset")
rs.Open SQL,conn,1,3
rc = rs.recordcount
%>

<h2>All Brokers (<%=rc%>)</h2>
<div>
<div class="table-responsive">
<table id="myTable" class="table tablesorter"> 
<thead> 
<tr> 
    <th>Broker</th>
	<th>Member<br>Since</th> 
    <th>Service<br>Type</th>
    <th>CHESS<br>Securities<br>T+2</th>
    <th>Certificated<br>Securities<br>T+5</th>  
    <th>Profile</th> 
</tr> 
</thead> 
<tbody>
<%

If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    id = rs("agid")
    broker = Server.HTMLEncode(rs("agname"))
    state = rs("stateb")
    agweb = rs("agweb0")
    agweb1 = Replace(agweb, "http://", "")
    tradingauthorisation = rs("tradingauthorisation")
	brokerservicetype = trim(rs("BrokerServiceType") & " ")
	if len(brokerservicetype) = 0 then
		brokerservicetype = "Full&nbsp;Service"
	end if
    chess_auth = false
    cert_auth = false
    
	  if instr(tradingauthorisation,"CHESS") > 0 then
			chess_auth = true 
		else 
			chess_auth = false
		end if

	  if instr(tradingauthorisation,"CERTIFICATED") > 0 then
			cert_auth = true 
		else 
			cert_auth = false
		end if  

	listeddate = rs("listeddate")
		if isdate(listeddate) then	
			listeddate = year(listeddate)
			else
			listeddate = ""
		end if
    
%>
  <tr> 
      <td><%=broker%></td>
      <!-- td><a href="<%=agweb%>" target="_blank"><%=agweb1%></a></td -->
      <!--<td>Full&nbsp;Service</td> -->
	  <td><%=listeddate%></td>
	   <td><%=brokerservicetype%></td> 
      <td width="80" align="center">
      <%
      If chess_auth Then
      %>
      <img src="/img/tick.png" title="CHESS Capable"/>
      <%
      Else
        Response.Write "&nbsp;"
      End If
      %>
      </td>
      <td width="80" align="center">
      <%
      If cert_auth Then
      %>
      <img src="/img/tick.png" title="Certificated Capable"/>
      <%
      Else
        Response.Write "&nbsp;"
      End If
      %>      
      </td>
      
      <td><div style="padding:8px"><a href="/broker_profile.asp?id=<%=id%>" class="btn-blue small" title="view details on this broker">view</a></div></td>
  </tr> 
<%
    rs.MoveNext 
    Wend  
End If
%>
</tbody>
</table>
</div>
<br>
<div class="editarea">
<p>For a printable contact sheet please <a href="/broker_list_print.asp">click here</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->