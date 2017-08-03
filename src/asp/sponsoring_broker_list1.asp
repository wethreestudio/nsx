<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
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

bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() 
    { 
        $("#myTable").tablesorter( { widgets: ["zebra"] } );
    } 
);
</script>
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
  If bySecurity = "1" Then
%>
<div class="editarea">
Filter:&nbsp;<a href="/companies_pre_listed/sponsoring_broker_list">All Sponsoring Brokers</a>
</div>
 
<h2>Sponsoring Brokers by Security</h2> 

<table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
    <th>Broker</th> 
    <th>NSX Code</th>
    <th>Security</th>
</tr> 
</thead> 
<tbody>
<%
sql = "SELECT DISTINCT coDetails.nsxcode, coDetails.coName, coDetails.agbrokers, coIssues.IssueStatus "
sql = sql & " FROM coDetails INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode"
SQL = sql & " WHERE (((coIssues.IssueStatus)='active'))"
sql = sql & " ORDER BY coDetails.agbrokers"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    broker = rs("agbrokers")
    If Len(broker) > 0 Then
      code = rs("nsxcode")
      broker = rs("agbrokers")
      company = rs("coName")

%>
  <tr> 
      <td><%=broker%></td> 
      <td><%=code%></td> 
      <td><%=company%></td> 
  </tr> 
<%
      End If
    rs.MoveNext 
  Wend  
End If

%>
</tbody>
</table>  
  
<%  
  Else
%>

<div class="editarea">
Filter:&nbsp;<a href="/companies_pre_listed/sponsoring_broker_list?bysecurity=1">Sponsoring Brokers by Security</a>
</div>
<h2>All Sponsoring Brokers</h2>
<div> 
<table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Broker</th> 
    <th>State</th>  
    <th>Website</th> 
</tr> 
</thead> 
<tbody>
<%
sql = "SELECT m.agid, m.agName, ls.stateb, m.agweb0 FROM members m JOIN [Lookup - states] ls ON m.agState = ls.[sid] WHERE m.agStatus='1'"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    id = rs("agid")
    broker = rs("agName")
    state = rs("stateb")
    agweb = rs("agweb0")
    agweb1 = Replace(agweb, "http://", "")
%>
  <tr> 
      <td><a href="/broker_profile.asp?id=<%=id%>"><%=broker%></a></td> 
      <td><%=state%></td> 
      <td><a href="<%=agweb%>" target="_blank"><%=agweb1%></a></td> 
  </tr> 
<%
    rs.MoveNext 
  Wend  
End If
%>
</tbody>
</table>
</div>
<%
  End If
  
%>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->