<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Announcements"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
ann_year = UCase(Trim(Request.QueryString("year")))
If Len(ann_year) = 0 Then ann_year = "3MTHS"
Set regEx = New RegExp 
regEx.Pattern = "^\d+$" 
isYearValid = regEx.Test(ann_year) 
If Not isYearValid And ann_year <> "12MTHS" And ann_year <> "6MTHS" And ann_year <> "3MTHS" Then
  Response.Redirect "/"
End If

objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security

If ann_year <> "12MTHS" And ann_year <> "6MTHS" And ann_year <> "3MTHS" Then
  alow_robots = "no"
End If
alow_robots = "no"
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
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"><% If page="company_search" then %><img src="images/listing_hero_banner_1.jpg" /><% End if %></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Announcements</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
                <div class="editarea">
<%
'PrintSearchBox "Search for Company Announcements", "company", "350", "Enter company name or code", "ann"
'If nsxcode2 <> "" Then
%>

<%
  RenderContent page,"editarea" 
%>
<p>
Show announcements for: <% 

If ann_year = "3MTHS" Then 
  %><b>Past 3 Months</b><% 
Else
  %><a href="/marketdata/announcements?year=3MTHS">Past 3 Months</a><%
End If  

Response.Write " | "


If ann_year = "6MTHS" Then 
  %><b>Past 6 Months</b><% 
Else
  %><a href="/marketdata/announcements?year=6MTHS">Past 6 Months</a><%
End If  

Response.Write " | "

If ann_year = "12MTHS" Then 
  %><b>Past 12 Months</b><% 
Else
  %><a href="/marketdata/announcements?year=12MTHS">Past 12 Months</a><%
End If  

Response.Write " | <br/>"

i=0
sy = Year(Now)
'ey = sy-7
ey = 2000

	if (ann_year<>"6MTHS") and (ann_year<>"12MTHS") and (ann_year<>"3MTHS") then ann_year = cint(ann_year)

	For i=sy To ey Step -1
		If ann_year = i Then 
			Response.Write "<b>" & i & "</b>"
		Else
			%><a href="/marketdata/announcements?year=<%=i%>"><%=i%></a><%
		End If 
		If i > ey Then Response.Write " | "
	Next
%>
</p>

<div> 

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

<br>

<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%"> 
<thead> 
<tr> 
    <th>Security</th>
    <th>Headline</th> 
    <th width="140">Date</th>   
</tr> 
</thead> 
<tbody>

<%

srch = ""
If ann_year = "6MTHS" Then
  srch = "AND annUpload >= DATEADD(m, -6, GetDate())"
ElseIf ann_year = "12MTHS" Then
  srch = "AND annUpload >= DATEADD(m, -12, GetDate())"
ElseIf ann_year = "3MTHS" Then
  srch = "AND annUpload >= DATEADD(m, -3, GetDate())"
ElseIf IsNumeric(ann_year) Then
  sdate = ann_year & "-01-01"
  edate = ann_year & "-12-31"
  srch = "AND annUpload BETWEEN '" & sdate & "' AND '" & edate & "'"
End If

sql = "SELECT annid, nsxcode, TradingCode, annPrecise, annUpload, annPriceSensitive, annFile, annTitle,annRelease FROM coAnn WHERE coAnn.annDisplay=1 AND coAnn.displayboard<>'SIMV' AND annRelease IS NOT NULL " & srch & " ORDER BY annUpload DESC"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  i = 0
  While Not rs.EOF
    isd = "0"
    aut = rs("annRelease")
    If IsDate(aut) Then
      dannUpload = CDate(aut)
      hr = Hour(dannUpload)
      mi = Minute(dannUpload)
      se = Second(dannUpload)
      m = Month(dannUpload)  
      d = Day(dannUpload)
	  mthname = monthname(m,true)
	  
      If CInt(Month(dannUpload)) < 10 Then m = "0" & m
      If CInt(Day(dannUpload)) < 10 Then d = "0" & d
      
      If CInt(Hour(dannUpload)) < 10 Then hr = "0" & hr
      If CInt(Minute(dannUpload)) < 10 Then mi = "0" & mi 
      If CInt(Second(dannUpload)) < 10 Then se = "0" & se      
      
      fmtdatetime = d &"-" &  mthname & "-" & year(dannUpload) & " " & formatdatetime(dannupload,3)
      isd = Year(dannUpload) & m & d & hr & mi & se 
    End If     
    c = " class=""odd"""
    If i Mod 2 = 0 Then c = ""
	
	prec = Replace(getSnippet(stripTags(rs("annPrecise")),40),"&", "&amp;")
	ttl = Replace(rs("annTitle"),"&", "&amp;")
%>
  <tr<%=c%>> 
      <td width="80"><a href="/summary/<%=rs("tradingcode")%>"><b><%=UCase(rs("tradingcode"))%></b></a><%
If rs("annPriceSensitive") = "True" Then
%><br><span style="color:green;font-size:10px">Price Sensitive</span><%
End If
      %></td>
      <td><a href="/ftp/news/<%=rs("annFile")%>"><%=ttl%></a><br><%=prec%></td> 
      <td><%=fmtdatetime%><span style="display:none">;<%=isd%></span></td> 
  </tr> 
<%    
    
    
    rs.MoveNext 
    i = i + 1
  Wend  
End If
%>

</tbody>
</table>
</div>
<%
'End If
%>
</div>
</div>
<div style="clear:both;"></div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->