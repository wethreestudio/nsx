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

// call the tablesorter plugin 
$("#myTable").tablesorter({ 
    // sort on the first column and third column, order asc 
    widgets: ["zebra"],
    headers: { 
      2: { sorter:'delisted'  } 
    }          
});     
    
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
                <h1>Suspended and De-Listed</h1>
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


SQL = "SELECT nsxcode,issuedescription,tradingcode,issuestopped FROM coIssues "
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
</div>
<div style="clear:both;"></div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->