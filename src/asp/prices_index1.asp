<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Indices"
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
        $("#myTable").tablesorter( { widgets: ["zebra"] , headers: { 8: { sorter: false } } }  );
    } 
);
</script>

<%
Server.Execute "side_menu.asp"
%>
<div class="hero-banner subpage">
    <div class="hero-banner-img"><img src="images/banners/iStock-611868428.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Indices</h1>
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
  'RenderContent page,"editarea" 
%>

<div class="table-responsive"><table id="myTable" class="tablesorter">
<thead> 
<tr> 
    <th>Index</th>
    <th>Code</th>  
    <th>Open</th>
    <th>High</th>
    <th>Low</th>
    <th>Last</th>
    <th>Prv Close</th>
    <th>%Chg<sup>1</sup></th>
    <th>Data</th>
    <!-- th>%Chg<sup>2</sup></th -->   
</tr> 
</thead> 
<tbody>
<%
sql = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[status],[issuedescription],[prvclose],[exchid] FROM indexcurrent WHERE (last <> 0) AND (tradingcode<>'TESTINDEX') ORDER BY tradingcode ASC"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><tr><td colspan="11" align="center">No Records</td></tr><%
Else
  While Not rs.EOF
    tradingcode = rs("tradingcode")
    tradedatetime = rs("tradedatetime")
    open = rs("open")
    high = rs("high")
    low = rs("low")
    last = rs("last")
    low = rs("low")
    last = rs("last")
    status = rs("status")
    issuedescription = rs("issuedescription")
    prvclose = rs("prvclose")
    exchid = rs("exchid")
    

    
    change1 = 0
    change2 = 0
    
    If last = 0 or prvclose=0 Then
      change1 = 0
    Else
      change1 = 100*((last-prvclose)/prvclose)
    End If  
    
    If change1 = 0 Then 
      change1 = "-"
    Else
      If change1 < 0 Then
        change1 = "<span style=""color:red;"">" & FormatNumber(change1,2) & "</span>"
      Else
        change1 = "<span style=""color:green;"">" & FormatNumber(change1,2) & "</span>"
      End If
    End If      
    
    
    If open = 0 Then
      change2 = 0
    Else
      change2 = 100*((last-open)/open)
    End If
        
    If change2 = 0 Then 
      change2 = "-"
    Else
      If change2 < 0 Then
        change2 = "<span style=""color:red;"">" & FormatNumber(change2,2) & "</span>"
      Else
        change2 = "<span style=""color:green;"">" & FormatNumber(change2,2) & "</span>"
      End If
    End If
    
    
    If open = 0 Then open = "-"
    If high = 0 Then high = "-"
    If low = 0 Then low = "-"
    If last = 0 Then last = "-"
    
    If last = 0 Then 
      last = "-"
    Else
      last = FormatNumber(last,3)
    End If    
    
    If prvclose = 0 Then 
      prvclose = "-"
    Else
      prvclose = FormatNumber(prvclose,3)
    End If    
    

%>
  <tr> 
      <td><%=issuedescription%></td>
      <td><%=tradingcode%></td> 
      <td align="right"><%=open%></td>
      <td align="right"><%=high%></td>
      <td align="right"><%=low%></td>
      <td align="right"><%=last%></td>
      <td align="right"><%=prvclose%></td>
      <td align="right"><%=change1%></td>
      <td>
      <a href="prices_index_daily.asp?tradingcode=<%=tradingcode%>&amp;coname=<%=Server.URLEncode(issuedescription)%>"><img height="18" border="0" width="18" src="/img/stock_chart-data-in-columns.png" alt=""></a>&nbsp;
      <a href="charts_index.asp?tradingcode=<%=tradingcode%>&amp;coname=<%=Server.URLEncode(issuedescription)%>&amp;size=700x350"><img height="15" border="0" width="15" src="/img/chart.gif" alt="" ></a>
      </td>
      <!-- td align="right"><%=change2%></td -->
  </tr> 
<%
    rs.MoveNext 
  Wend  
End If
%>
</tbody>

</table></div>
<br>
<div class="editarea">
<%
  RenderContent page,"editarea" 
%>

</div>
<div style="clear:both"></div>    
</div> 
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->