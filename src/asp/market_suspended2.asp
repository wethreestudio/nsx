<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Delisted & Suspended"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  ' Response.Redirect "/"
End If

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"
objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript">
$(document).ready(function() 
{
    $.tablesorter.addParser({
        // set a unique id          
        id: 'delisted',
        is: function(s) {
            // return false so this parser is not auto detected
            return false;
        },
        format: function(s) {
            var x = s.split(";")
            return x[1];
        },
        // set type, either numeric or text
        type: 'numeric'
    });

    $.tablesorter.addParser({
        // set a unique id          
        id: 'suspended',
        is: function (s) {
            // return false so this parser is not auto detected
            return false;
        },
        format: function (s) {
            var x = s.split(";")
            return x[1];
        },
        // set type, either numeric or text
        type: 'numeric'
    });

    // call the tablesorter plugin 
    $("#myTable").tablesorter({ 
        // sort on the first column and third column, order asc 
        widgets: ["zebra"],
        headers: { 
          2: {sorter:'suspended'} 
        }          
    });

    $("#myTable_delisted").tablesorter({
        // sort on the first column and third column, order asc 
        widgets: ["zebra"],
        headers: {
            2: { sorter: 'delisted' }
        }
    });
    
    var pagesize = 20;

    if ($("#pager select").length > 0) {
        pagesize = $("#pager select").val();
    }
    $("#myTable").tablesorter({ widgets: ["zebra"] });
    $("#myTable").tablesorterPager({ container: $("#pager"), positionFixed: false, size: pagesize });

    $("#myTable_delisted").tablesorter({ widgets: ["zebra"] });
    $("#myTable_delisted").tablesorterPager({ container: $("#pager"), positionFixed: false, size: pagesize });

    //$("#myTable").tablesorter( { widgets: ["zebra"] } );
});
</script>
<%
Server.Execute "side_menu.asp"
%>
<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Delisted & Suspended</h1>
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

<h2>Suspended Listings</h2>
<br />
<table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
    <th>Code</th> 
    <th>Security Name</th>
    <th>Suspended Date</th>
</tr> 
</thead> 
<tbody>
<%


SQL = "SELECT  nsxcode,issuedescription,tradingcode,issuestopped FROM coIssues "
SQL = SQL & " WHERE (coIssues.iNewFloat=0) AND (coIssues.Issuestatus ='SUSPENDED') AND (coIssues.exchid='NSX')"  'use SIMV for SIMVSE companies
SQL = SQL & " ORDER BY coIssues.TradingCode"

Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    nsxcode = rs("nsxcode")
    tradingcode = rs("tradingcode")
    issuedescription = rs("issuedescription")
    issuestopped = rs("issuestopped")
    isd = ""
    If IsDate(issuestopped) Then
      m = Month(issuestopped)  
	  mthname = monthname(m,true)
      d = Day(issuestopped)
      If CInt(Month(issuestopped)) < 10 Then m = "0" & m
      If CInt(Day(issuestopped)) < 10 Then d = "0" & d
      isd = Year(issuestopped) & m & d
      issuestopped = d & "-" & mthname & "-" & Year(issuestopped)  'Day(issuestopped) & "-" & MonthName(Month(issuestopped),True) & "-" & Year(issuestopped) 
    End If
%>
  <tr> 
      <td><%=tradingcode%></td> 
      <td><a href="/summary/<%=tradingcode%>"><%=issuedescription%></a></td> 
      <td><%=issuestopped%><span style="display:none">;<%=isd%></span></td> 
  </tr> 
<%
    rs.MoveNext 
  Wend  
End If

%>
</tbody>
</table>
<br />
<!-- /suspended -->

<h2>Delisted Listings</h2>
<br />
<!--<div class="pager2" id="pager">	
  <form action="javascript:void(0)" method="get">
	<span>
		<img class="first" src="/js/addons/pager/icons/first.png" alt="" style="vertical-align: middle;">
		<img class="prev" src="/js/addons/pager/icons/prev.png" alt="" style="vertical-align: middle;">
		<input type="text" class="pagedisplay" style="border:none;width:40px;text-align:center;vertical-align: middle;">
		<img class="next" src="/js/addons/pager/icons/next.png" alt="" style="vertical-align: middle;">
		<img class="last" src="/js/addons/pager/icons/last.png" alt="" style="vertical-align: middle;">
		<select class="pagesize"  style="vertical-align: middle;">
			<option value="20" selected="selected">20</option>
			<option value="40">40</option>
			<option value="100">100</option>
			<option value="200">200</option>
		</select>
	</span>
	</form>
</div>-->
<div class="pager2" id="pager">	
  <form action="javascript:void(0)" method="get">
	<span>
        <i class="first fa fa-step-backward"></i>
        <i class="prev fa fa-backward"></i>
        <input type="text" class="pagedisplay" style="border:none;width:70px;text-align:center">
        <i class="next fa fa-forward"></i>
        <i class="last fa fa-step-forward"></i>

		<select class="pagesize">
			<option value="20" selected="selected">20</option>
			<option value="40">40</option>
			<option value="100">100</option>
			<option value="200">200</option>
		</select>
	</span>
	</form>
</div>

<!-- delisted -->
<table id="myTable_delisted" class="tablesorter"> 
<thead> 
<tr> 
    <th>Code</th> 
    <th>Security Name</th>
    <th>Delisted Date</th>
</tr> 
</thead> 
<tbody>
<%

nsxcode = Request.QueryString("nsxcode")

SQL = "SELECT  nsxcode,issuedescription,tradingcode,issuestopped FROM coIssues "
SQL = SQL & " WHERE (coIssues.iNewFloat=0) AND (coIssues.Issuestatus ='Delisted') "
If Len(nsxcode) > 0 Then SQL = SQL & " AND nsxcode= '" & SafeSqlParameter(nsxcode) & "'"
SQL = SQL & " ORDER BY coIssues.TradingCode"


If Len(nsxcode) > 0 Then
%>
<p><a href="/marketdata/delisted">Remove '<%=UCase(nsxcode)%>' Filter</a></p>
<%
End If

Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    nsxcode = rs("nsxcode")
    tradingcode = rs("tradingcode")
    issuedescription = rs("issuedescription")
    issuestopped = rs("issuestopped")
    isd = ""
    If IsDate(issuestopped) Then
      m = Month(issuestopped)  
	  mthname = monthname(m,true)
      d = Day(issuestopped)
      If CInt(Month(issuestopped)) < 10 Then m = "0" & m
      If CInt(Day(issuestopped)) < 10 Then d = "0" & d
      isd = Year(issuestopped) & m & d
      issuestopped = d & "-" & mthname & "-" & Year(issuestopped)  'Day(issuestopped) & "-" & MonthName(Month(issuestopped),True) & "-" & Year(issuestopped) 
    End If
%>
  <tr> 
      <td><%=tradingcode%></td> 
      <td><a href="/summary/<%=tradingcode%>"><%=Server.HTMLEncode(issuedescription)%></a></td> 
      <td><%=issuestopped%><span style="display:none">;<%=isd%></span></td> 
  </tr> 
<%
    rs.MoveNext 
  Wend  
End If

%>
</tbody>
</table>  
<!-- /delisted -->

</div>
<div style="clear:both;"></div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->