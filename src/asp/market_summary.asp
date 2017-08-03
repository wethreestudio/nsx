<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Market Summary"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If



Sub RenderSummary(sql, empty_message, right_col, right_col_heading, right_col_decimals, prefix, postfix, c)
  Set conn = GetReaderConn()
  Set rs = conn.Execute(SQL)
  style = ""
  i = 0
  If Len(c) > 0 Then
    style = " style=""color:" & c & """ "
  End If
%>
<div class="table-responsive">
    <table class="table tablesorter">
        <thead> 
            <tr> 
                <th>Code</th>
                <th align="right" width="90" style="text-align:right;">Last</th>
                <th align="right" width="90" style="text-align:right;"><%=right_col_heading%></th>
            </tr> 
        </thead>
        <tbody>
<%
  If rs.EOF Then
%>
    <tr>
      <td colspan="3"><%=empty_message%></td>
    </tr>
<%
  Else
    While Not rs.EOF
		c = " class=""odd"""
		If i Mod 2 = 0 Then c = ""
			last = 0
			If IsNumeric(rs("last")) Then last = CDbl(rs("last"))
%>
            <tr<%=c%>>
              <td><a href="/marketdata/company-directory/<%=rs("tradingcode")%>/"><%=rs("tradingcode")%></a></td>
              <td align="right">$<%=FormatNumber(last,3)%></td>
              <td align="right"<%=style%>><%=prefix & FormatNumber(rs(right_col),right_col_decimals) & postfix%></td>
            </tr>
<%
      rs.MoveNext 
	  i=i+1
    Wend  
  End If
%>
          </tbody>
        </table>
    </div>
<%
End Sub

%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Summary</h1>
            </div>
        </div>
    </div>
</div>

<!--#INCLUDE FILE="content_lower_nav.asp"-->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
<%
RenderContent page,"editarea" 
%>

<div>
<%
Server.Execute "/stats_market2.asp"
%>
</div>
<br>
<div class="table-responsive">
<table class="table">
    <tr>
        <td width="50%">
            <div style="padding-right:8px">
            
            
            
            <h2>Volume</h2>
            <div class="disclaimer">(latest business day)</div>
<%
SQL = "SELECT TOP 3 tradingcode, tradedatetime, [open], [last], [sessionmode], [volume], [prvclose], (100 * ([last]-[prvclose])/[prvclose]) AS [change] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND volume > 0 AND [prvclose]>0"
SQL = SQL & " ORDER BY volume DESC, tradingcode ASC"

RenderSummary SQL, "No Trades.", "volume", "Volume", 0, "", "", ""

%>    
   
   
   
   
    </div>   
    </td>
    <td width="50%">
      <div style="padding-left:8px">
      
      
      
     
   
      <h2>Value</h2>
      <div class="disclaimer">(latest business day)</div>
<%
SQL = "SELECT TOP 7 tradingcode, tradedatetime, [open], [last], [sessionmode], [volume], [prvclose], (100 * ([last]-[prvclose])/[prvclose]) AS [change], [volume]*[last] AS svalue "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND volume>0 AND [prvclose]>0"
SQL = SQL & " ORDER BY (last*volume) DESC, tradingcode ASC"

RenderSummary SQL, "No Trades.", "svalue", "Value", 3, "$", "", ""

%>      
   
   
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td width="50%">
      <div style="padding-right:8px">
      
      
       <h2>Advances</h2>
      <div class="disclaimer">(latest business day)</div>
<%
SQL = "SELECT TOP 7 tradingcode, tradedatetime, [open], [last], [sessionmode], [volume], [prvclose], (100 * ([last]-[prvclose])/[prvclose]) AS [change] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND (last-prvclose)>=0 AND volume>0 AND [prvclose]>0"
SQL = SQL & " ORDER BY (prvclose*(last-prvclose)) DESC, tradingcode ASC"

RenderSummary SQL, "No Advances.", "change", "Change", 2, "", "%", "green"

%>

     
     
     
     
      </div>
    </td>
    <td width="50%">
      <div style="padding-left:8px">
      <h2>Declines</h2>
      <div class="disclaimer">(latest business day)</div>
<%
SQL = "SELECT TOP 7 tradingcode, tradedatetime, [open], [last], [sessionmode], [volume], [prvclose], (100 * ([last]-[prvclose])/[prvclose]) AS [change]  "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active') AND (last-prvclose)<0 AND volume>0 AND [prvclose]>0"
SQL = SQL & " ORDER BY (prvclose*(last-prvclose)) DESC, tradingcode ASC"

RenderSummary SQL, "No Declines.", "change", "Change", 2, "", "%", "red"

%>      
      </div>
    </td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>  
  <tr style="display:none;">
    <td width="50%">
      <div style="padding-right:8px">
      <h2>Market</h2>
<%
SQL = "SELECT TOP 2 DATEPART(Year, TradeDate), SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END), SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END),  Count(PricesTrades.prid),  SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) FROM PricesTrades WHERE (((PricesTrades.ExchID)='NCRP' Or (PricesTrades.ExchID)='NPRP' Or (PricesTrades.ExchID)='NDBT' Or (PricesTrades.ExchID)='NMIN' Or (PricesTrades.ExchID)='NRST')) GROUP BY DATEPART(Year, TradeDate) ORDER BY DATEPART(Year, TradeDate) DESC"

' Response.Write SQL
%> 
        </div> 
        </td>
        <td width="50%">
            <div style="padding-left:8px">    
            <h2>General</h2>
<%

%>  
            </div>    
        </td>
    </tr>
</table>
</div>
</div>
</div>
<div style="clear:both;"></div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->