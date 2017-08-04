<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Search for NSX Company Announcements"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

nsxcode2 = Trim(Request.QueryString("nsxcode"))
keyword = Trim(Request.QueryString("keyword"))
page = Request.QueryString("page")
Set regEx = New RegExp
regEx.Pattern = "^[\w_\-]+$"
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  'Response.Redirect "/"
End If

objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

bySecurity = Request.QueryString("bysecurity") ' List brokers by security

' Get flash company info, Name of company, nsxcode, currentprice, highprice, % change, lowprice, volume, last trade date
security_code = UCase(Trim(SafeSqlParameter(request.querystring("nsxcode"))))
SQL_flash_data = "SELECT TOP 1 [last], [prvclose], [open], [high], [low], [volume], (SELECT TOP 1 tradedatetime FROM PricesTrades WHERE tradingcode='" & security_code & "' ORDER BY prid DESC), [issuedescription], [sessionmode],[logo_summary],[offexchangetrading_url] FROM PricesCurrent WHERE tradingcode='" & security_code & "'"
flash_data = GetRows(SQL_flash_data)
If VarType(flash_data) <> 0 Then
    flash_data_RowsCount = UBound(flash_data,2)
    If flash_data_RowsCount >= 0 Then
        flashdata_last = flash_data(0,0)
        flashdata_prvclose = flash_data(1,0)
        flashdata_opn = flash_data(2,0)
        flashdata_high = flash_data(3,0)
        flashdata_low = flash_data(4,0)
        flashdata_volume = flash_data(5,0)
        If IsDate(flash_data(6,0)) Then 
            flashdata_tradedatetime = CDate(flash_data(6,0))
        Else
          flashdata_tradedatetime = ""
        End If
        flashdata_coName = flash_data(7,0)
        Dim dchange2
        If flashdata_last = 0 Or flashdata_prvclose=0 Then
          dchange2 = 0
        Else
          'dchange2 = 100*((flashdata_last-flashdata_prvclose)/flashdata_prvclose)
            dchange2 = FormatPercent((flashdata_last-flashdata_prvclose)/flashdata_prvclose)
        End If

        If Not IsNumeric(flashdata_last) Then flashdata_last = 0
	    If Not IsNumeric(flashdata_open) Then flashdata_opn = 0
	    If Not IsNumeric(flashdata_high) Then flashdata_high = 0
	    If Not IsNumeric(flashdata_low) Then flashdata_low = 0
	    If Not IsNumeric(flashdata_volume) Then flashdata_volume = 0
	
	    If flashdata_last=0 Then flashdata_last=""
	    If flashdata_open=0 Then flashdata_open=""
	    If flashdata_high=0 Then flashdata_high=""
	    If flashdata_low=0 Then flashdata_low=""
	    If flashdata_volume=0 Then flashdata_volume=""
    End If
End If
 
 Function FormatPrice(p,d)
	If Len(p)>0 Then
		FormatPrice = FormatNumber(p,d)
	Else 
		FormatPrice = "-"
	End If
End Function
 
' End flash data
page_title = "Search results - " & flashdata_coName & " " & UCase(security_code) & " - Security Summary"
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

<div class="hero-banner hero-banner-company subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left comp-info">
                <h1><span><%=flashdata_coName%></span></h1>
                <div class="comp-info">
                    <div class="comp-info-large">
                        <span class="large"><%=security_code%></span><span class="large"><%=FormatPrice(flashdata_last,3)%></span>
                    </div>
                    <div class="comp-info-small">
                        <ul>
                            <li>CHANGE<br /><span class="red"><%=dchange2%></span></li>
                            <li>LAST<br /><span><%=flashdata_last%></span></li>
                            <li>VOLUME<br /><span><%=flashdata_volume%></span></li>
                            <li>LAST TRADE<br /><span class="light"><%=flashdata_tradedatetime%></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
                <div class="editarea">
<%
'PrintSearchBox "Search for Company Announcements", "company", "350", "Enter company name or code", "ann"

If nsxcode2 <> "" Then
%>
<br>
<h2>Announcements For <%=UCase(nsxcode2)%></h2>
<%
  RenderContent page,"editarea" 
%>

<div> 

<div class="pager2" id="pager">	
  <form action="javascript:void(0)" method="get">
	<span>
		<i class="first fa fa-step-backward"></i>
        <i class="prev fa fa-backward"></i>
        <input type="text" class="pagedisplay" style="border:none;width:70px;text-align:center">
        <i class="next fa fa-forward"></i>
        <i class="last fa fa-step-forward"></i>

		<select class="pagesize"  style="vertical-align: middle;">
			<option value="20" selected="selected">20</option>
			<option value="40">40</option>
			<option value="100">100</option>
			<option value="200">200</option>
		</select>
	</span>
	</form>
</div>

<br>

<div class="table-responsive"><table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
    <th width="80">Code</th>
    <th>Headline</th> 
    <th width="140">Date</th>   
</tr> 
</thead> 
<tbody>

<%
sql = "SELECT annid, nsxcode, TradingCode, annPrecise, annUpload, annPriceSensitive, annFile, annTitle FROM coAnn "
sql = sql & " WHERE annDisplay=1 and tradingcode='" & SafeSqlParameter(nsxcode2) & "' AND annRelease IS NOT NULL ORDER BY annUpload DESC"

' Response.Write "<!-- SQL: " & sql & " -->"

Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="4" align="center">No Records</td></tr><%
Else
  i = 0
  While Not rs.EOF
    isd = "0"
    aut = rs("annUpload")
    If IsDate(aut) Then
      dannUpload = CDate(aut)
      hr = Hour(dannUpload)
      mi = Minute(dannUpload)
      se = Second(dannUpload)
      m = Month(dannUpload)    
	  mthname = monthname(m,true)
      d = Day(dannUpload)
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
%>
  <tr<%=c%>> 
      <td><a href="/summary/<%=rs("tradingcode")%>"><h3><%=UCase(rs("tradingcode"))%></h3></a><%
If rs("annPriceSensitive") = "True" Then
%><small class="text-success">Price Sensitive</small><%
End If
      %></td>
      <td><a href="/ftp/news/<%=rs("annFile")%>"><%=Server.HTMLEncode(rs("annTitle"))%></a><br><%=Server.HTMLEncode(rs("annPrecise"))%></td> 
      <td><%=fmtdatetime%><span style="display:none">;<%=isd%></span></td> 
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
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->