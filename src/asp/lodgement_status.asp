<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Search for NSX Company Announcements"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

nsxcode2 = Trim(Request.QueryString("nsxcode"))

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-,]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  'Response.Redirect "/"
End If

objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List by security
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
            3: { sorter:'date'  } 
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
Server.Execute "company_side_menu.asp"
%>

<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div class="editarea">
<%
' PrintSearchBox "Search for Company Announcements", "company", "350", "Enter company name or code", "ann"
If nsxcode2 <> "" Then
  nsxcodes = Split(nsxcode2, ",")
  nsxcodesin = ImpolodeCollection(nsxcodes, "','")
%>
<br>
<h2>Recent Announcements For <%=UCase(ImpolodeCollection(nsxcodes, ", "))%></h2>
<p>
Below are the 200 most recent announcemnts for <%=UCase(ImpolodeCollection(nsxcodes, ", "))%>.
</p>
<div> 
<!--
<div class="pager2" id="pager">	
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

<br>




<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Code</th>
    <th>Headline</th> 
    <th>Status</th> 
	<th>Pending/Released</th> 	
</tr> 
</thead> 
<tbody>

<%

sql = "SELECT TOP 200 coAnn.annid, coAnn.nsxcode,annPrecise,annFile,annRelease,annTitle,annFileSize,coAnn.tradingcode,annUpload,coIssues.IssueDescription, annPriceSensitive "
sql = sql & "FROM coIssues "
sql = sql & "INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode " 
sql = sql & "WHERE (coAnn.annDisplay=1) AND (coAnn.nsxcode IN ('" & nsxcodesin & "')) OR (coAnn.nsxcode='') "
sql = sql & "ORDER BY coAnn.annUpload DESC"

' sql = "SELECT TOP 200 annid, nsxcode, TradingCode, annPrecise, annUpload, annPriceSensitive, annFile, annTitle, annRelease FROM coAnn WHERE nsxcode IN ('" & nsxcodesin & "') ORDER BY annUpload DESC"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  i = 0
  While Not rs.EOF
    isd = "0"
    aut = rs("annUpload")
	annFile = rs("annFile")
	annPrecise = rs("annPrecise")
	annTitle = rs("annTitle")
	annReleased = rs("annRelease")
	
    If IsDate(aut) Then
      dannUpload = CDate(aut)
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
    End If     
    c = " class=""odd"""
    If i Mod 2 = 0 Then c = ""
%>
  <tr<%=c%>> 
      <td width="80"><a href="/summary/<%=rs("tradingcode")%>"><h3><%=UCase(rs("tradingcode"))%></h3></a><%
If rs("annPriceSensitive") = "True" Then
%><small class="text-success">Price Sensitive</small><%
End If
      %></td>
      <td><a href="/ftp/news/<%=annFile%>"><%=Server.HTMLEncode(annTitle)%></a><br><%=Server.HTMLEncode(annPrecise)%></td> 
	  <td width="50"><%
'	  response.write lodged/released
	  If isdate(annReleased) Then 
		Response.Write "Released"
	Else
		Response.Write "Pending"
	End If
	  %></td>
      <td width="140"><%
	  if  not isdate(annReleased) then
		'response.write cdate(annReleased)
			m = monthname(Month(aut),1)
			d = Day(aut)
			yr = year(aut)
			timereleased = formatdatetime(aut,3)
			response.write d & "-" & m & "-" & yr & " " & timereleased
		else
		'response.write cdate(aut)
			m = monthname(Month(annReleased),1)
			d = Day(annReleased)
			yr = year(annReleased)
			timereleased = formatdatetime(annReleased,3)
			response.write d & "-" & m & "-" & yr & " " & timereleased
		end if
		%><span style="display:none">;<%=isd%></span></td> 
  </tr> 
<%    
    
    
    rs.MoveNext 
    i = i + 1
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

</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->