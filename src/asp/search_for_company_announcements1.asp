<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Search for NSX Company Announcements"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

nsxcode2 = Trim(Request.QueryString("nsxcode"))
page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
 ' Response.Redirect "/"
End If

objJsIncludes.Add "jquery_autocomplete_js", "js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "css/jquery.autocomplete.css"

objJsIncludes.Add "tablesorter", "js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "js/addons/pager/jquery.tablesorter.pager.js"
objCssIncludes.Add "tablesortercss", "css/table_sort_blue.css"
objCssIncludes.Add "tablesorterpcss", "js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() 
    { 
      var pagesize = 20;
      
      if ($("#pager select").length>0) 
      {
        pagesize=$("#pager select").val();
      }        
    
      $.tablesorter.addParser({
        // set a unique id          
        id: 'date',
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
            2: { sorter:'date'  } 
          }          
      });        
 
      $("#myTable").tablesorterPager({ container: $("#pager"), positionFixed: false, size: pagesize });        
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
<div class="editarea">
<%
PrintSearchBox "Search for Company Announcements", "company", "350", "Enter company name or code", "ann"
If nsxcode2 <> "" Then
%>
<br>
<h2>Announcements For <%=UCase(nsxcode2)%></h2>
<div> 

<div class="pager2" id="pager">
	<span>
  <form>
	 
		<img class="first" src="/js/addons/pager/icons/first.png" alt="" style="vertical-align: middle;">
		<img class="prev" src="/js/addons/pager/icons/prev.png" alt="" style="vertical-align: middle;">
		<input type="text" class="pagedisplay" style="border:none;width:40px;text-align:center;" style="vertical-align: middle;">
		<img class="next" src="/js/addons/pager/icons/next.png" alt="" style="vertical-align: middle;">
		<img class="last" src="/js/addons/pager/icons/last.png" alt="" style="vertical-align: middle;">
		<select class="pagesize"  style="vertical-align: middle;">
			<option value="20" selected="selected">20</option>
			<option value="40">40</option>
			<option value="100">100</option>
			<option value="200">200</option>
		</select>
	</form>
	</span>
</div>
<br>

<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Issuer</th>
    <th>Headline</th> 
    <th>Date</th>   
</tr> 
</thead> 
<tbody>
<%
'sql = "SELECT m.agid, m.agName, ls.stateb, m.agweb0 FROM members m JOIN [Lookup - states] ls ON m.agState = ls.[sid] WHERE m.agStatus='1'"

srch = " WHERE coAnn.tradingcode = '" & SafeSqlParameter(nsxcode2) & "' AND (coAnn.DisplayBoard<>'SIMV') AND [annNETSConfirmed] IS NOT NULL "
sql = "SELECT coAnn.annid, coAnn.tradingcode, coAnn.annPrecise, coAnn.annPriceSensitive, coAnn.annUpload " ',annFile,annRelease,annTitle,annFileSize,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard "
sql = sql & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
sql = sql & srch
sql = sql & " ORDER BY coAnn.annUpload DESC"


sql = "SELECT [annid], [nsxcode], [TradingCode], [annPrecise], annUpload, [annPriceSensitive], [annFile], [annTitle] FROM coAnn WHERE [nsxcode]='" & SafeSqlParameter(nsxcode2) & "' ORDER BY annUpload DESC"


'response.write SQL
'response.end

Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    id = rs("annid")
    tradingcode = rs("tradingcode")
    annPriceSensitive = rs("annPriceSensitive")
    ' displayboard = rs("displayboard")
    annUpload = rs("annUpload")
    annPrecise = rs("annPrecise")
    annFile = rs("annFile")
    annTitle = rs("annTitle") 
    x ="XXX"
    annUploadFormatted = ""
    If IsDate(annUpload) Then
      dannUpload = CDate(annUpload)
      hr = Hour(dannUpload)
      mi = Minute(dannUpload)
      se = Second(dannUpload)
      m = Month(dannUpload)  
      d = Day(dannUpload)
      If CInt(Month(dannUpload)) < 10 Then m = "0" & m
      If CInt(Day(dannUpload)) < 10 Then d = "0" & d
      
      If CInt(Hour(dannUpload)) < 10 Then hr = "0" & hr
      If CInt(Minute(dannUpload)) < 10 Then mi = "0" & mi 
      If CInt(Second(dannUpload)) < 10 Then se = "0" & se      
      
      
      isd = Year(dannUpload) & m & d & hr & mi & se
      annUploadFormatted = d & "-" & m & "-" & Year(dannUpload) 
    End If    
       
%>
  <tr> 
      <td width="80px"><a href="/summary/<%=nsxcode2%>"><h3><%=tradingcode%></h3></a><%
If annPriceSensitive Then
%><small class="text-success">Price Sensitive</small><%
End If
      %></td>
      <td><a href="/ftp/news/<%=annFile%>"><%=annTitle%></a><br>|<%=annPrecise%>|</td> 
      <td><%=rs("annUpload")%><span style="display:none">;<%=isd%></span></td> 
  </tr> 
<%
    rs.MoveNext 
  Wend  
End If
%>
</tbody>
</table></div>
</div>
<%
End If
%>
</div>
<%
  RenderContent page,"editarea" 
%>

</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->