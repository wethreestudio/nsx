<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Adviser List"
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
        $("#myTable").tablesorter( { widgets: ["zebra"], headers: { 2: { sorter: false } } });
    } 
);
</script>

<%
'Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left ">
                <h1>Adviser List</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<%
  RenderContent page,"editarea" 
  
SQL = "SELECT a.adid, a.adlogo, a.adname, a.listeddate, ls.stateb FROM advisers a JOIN [lookup - states] ls ON ls.sid = a.adstate WHERE adStatus=1 ORDER BY a.adname ASC"

Set conn = GetReaderConn()
'Set rs = conn.Execute(sql)
set rs=Server.CreateObject("ADODB.recordset")
rs.Open SQL,conn,1,3
rc = rs.recordcount
%>

 
<h2>All Advisers (<%=rc%>)</h2> 

<table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
    <th>Adviser</th> 
    <th>Member<br>Since</th>
    <th>Profile</th>
</tr> 
</thead> 
<tbody>


<%
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    id = rs("adid")
    name = Server.HTMLEncode(rs("adName")) 
    state = rs("stateb")
    listeddate = rs("listeddate")
    listedyear = ""
    If isdate(listeddate) Then
      listedyear=year(listeddate)
	  listeddatefmt = day(listeddate) & "-" & monthname(month(listeddate),1) & "-" & year(listeddate)
    End If
%>
  <tr> 
      <td><%=name%></td> 
      <td><%=listedyear%></td>
      <td><div style="padding:8px"><a href="/adviser_profile.asp?id=<%=id%>" class="btn-blue small" title="view details on this adviser">view</a></div></td>  
  </tr> 
<%
    rs.MoveNext 
  Wend  
End If

%>
</tbody>
</table>  
<br>
<div class="editarea">
<p>For a printable contact sheet please <a href="/adviser_list_print.asp">click here</a></p>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->