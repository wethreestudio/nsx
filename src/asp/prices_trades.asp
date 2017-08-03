<!--#INCLUDE FILE="include_all.asp"-->
<%
tradingcode = UCase(SafeSqlParameter(Request.QueryString("tradingcode")))
issuedesc = ""
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(tradingcode) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

sql = "SELECT [iid], [tradingcode], [IssueDescription] FROM [nsx].[dbo].[coIssues] WHERE [tradingcode] = '" & tradingcode & "' AND IssueStatus='Active'"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If Not rs.EOF Then 
	tradingcode = rs("tradingcode")
	issuedesc = rs("IssueDescription")
End If
rs.Close()
Set rs = Nothing

page_title = "Trading History - " & issuedesc
meta_description = "View or download trade history for " & issuedesc & " (" & tradingcode & ")"

alow_robots = "no"

objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

' Get flash company info, Name of company, nsxcode, currentprice, highprice, % change, lowprice, volume, last trade date
security_code = UCase(Trim(SafeSqlParameter(request.querystring("tradingcode"))))
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
	  
    $.tablesorter.addParser({
        id: 'fancyNumber',
        is:function(s){return false;},
        format: function(s) {return s.replace(/[\,\.]/g,'');},
        type: 'numeric'
	});	  

      // call the tablesorter plugin 
      $("#myTable").tablesorter({ 
          // sort on the first column and third column, order asc 
          widgets: ["zebra"],
          headers: { 
            0: { sorter:'date' }
			
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
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left comp-info">
                <h1><%=flashdata_coName%></h1>
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
<h1>Trading History for <%=issuedesc & " (" & tradingcode & ")"%></h1>
<p>Full trading history is displayed up to the close of business for the previous business day.</p>
	<div >Download Trade Table 
       <a href="/download_trades.aspx?nsxcode=<%=tradingcode%>&amp;format=XLS" class="blue-link">Excel</a> 
       <a href="/download_trades.aspx?nsxcode=<%=tradingcode%>&amp;format=CSV" class="blue-link">CSV</a>
	   <a href="prices_definitions.asp" class="blue-link">Definitions</a>
	</div>
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
</div>
-->
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
<div class="table-responsive"><table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
    <th>Date/Time</th> 
    <th nowrap>Price $</th> 
    <th>Volume</th> 
    <th nowrap>Value $</th> 
    <th>Buyer</th>
    <th>Seller</th>
    <th nowrap>Trade #</th>
    <th>Status</th>
</tr> 
</thead> 
<tbody>
<%
sql = "SELECT PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.SaleValue, PricesTrades.TradeDateTime, PricesTrades.SettleDate, StockCodes.StockName, BrokerBuyers.BrokerName AS Buyer, BrokerSellers.BrokerName AS Seller, PricesTrades.TradeNumber, pricestrades.adddelete, PricesTrades.TradeSource "
sql = sql & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
sql = sql & "WHERE tradingcode='" & tradingcode & "' "
sql = sql & "ORDER BY PricesTrades.TradeDateTime DESC, CAST(PricesTrades.TradeNumber AS INT) DESC, PricesTrades.prid DESC"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If Not rs.EOF Then
	alt_row = false
	While Not rs.EOF
		datetime = rs("TradeDateTime")
		price = rs("SalePrice")
		volume = rs("SaleVolume")
		value = rs("SaleValue")
		buyer = rs("Buyer")
		seller = rs("Seller")
		tradeno = rs("TradeNumber")
		status = rs("adddelete")
		TradeSource = rs("TradeSource")
		
		row_class = " class=""odd"""
		If alt_row Then row_class = " class=""even"""

		
		isd = ""
		If IsDate(datetime) Then
			dt = CDate(datetime)
			hr = Hour(dt)
			mi = Minute(dt)
			se = Second(dt)
			m = Month(dt)  
			d = Day(dt)
			If CInt(Month(dt)) < 10 Then m = "0" & m
			If CInt(Day(dt)) < 10 Then d = "0" & d
			If CInt(Hour(dt)) < 10 Then hr = "0" & hr
			If CInt(Minute(dt)) < 10 Then mi = "0" & mi 
			If CInt(Second(dt)) < 10 Then se = "0" & se      
			isd = Year(dt) & m & d & hr & mi & se 
		End If 	
		
		'status = ""
		If status = "D" Then
			status = "Cancelled"
			Statustitle = "Cancelled Trade"
			value = value * -1
			volume = volume * -1
		ElseIf status = "A" Then
			status = ""
		End If
		
		status = status & " "
		SELECT CASE TradeSource
			Case "A"
				status = status ' normal autotrade
				StatusTitle = ""
			Case "B"
				status = status & "B"' best execution
				StatusTitle = "Best Execution"
			Case "C"
				status = status & "C"
				StatusTitle = "Off Market Automatic"
			Case "D"
				status = status & "D"
				StatusTitle = "Off Market or Directed Reporting"
			Case "E"
				status = status & "E"
				StatusTitle = "Special Crossing – less than a marketable parcel"
			Case "F"
				status = status & "F"
				StatusTitle = "Forward Delivery"
			Case "I"
				status = status & "I"
				StatusTitle = "Approved Index"
			Case "K"
				status = status & "K"
				StatusTitle = "Buy Back Sales"
			Case "M"
				status = status & "M"
				StatusTitle = "Marriage"
			Case "N"
				status = status & "N"
				StatusTitle = "Trades includes crossing – outside normal trading hours"
			Case "O"
				status = status & "O"
				StatusTitle = "Foreign Residents or Recognised Overseas Stock Exchange"
			Case "P"
				status = status & "P"
				StatusTitle = "Block Special Crossing or Loan Securities"
			Case "Q"
				status = status & "Q"
				StatusTitle = "Special Crossing less than a marketable parcel"
			Case "R"
				status = status & "R"
				StatusTitle = "Strategy"
			Case "S"
				status = status & "S"
				StatusTitle = "Short Sell"
			Case "U"
				status = status & "U"
				StatusTitle = "FOR – Foreign to Foreign Securities"
			Case "V"
				status = status & "V"
				StatusTitle = "Book Value Switch Sales"
			Case "X"
				status = status & "X"
				StatusTitle = "Portfolio Special Crossing"
			Case "Y"
				status = Status & "Y"
				StatusTitle = "Special"
			Case "Z"
				status = Status & "Z"
				StatusTitle = "Special Crossing – Underwriting Disposal or Exchange Approval"	
			Case Else
				'StatusTitle = ""
			
			END SELECT
			
			status = "<a href='/regulation/exchange/trading-codes/' title='" & statustitle & "'>" & trim(status & " ") & "</a>"
		
	
		If IsNumeric(price) Then price = FormatNumber(price, 3)
		If IsNumeric(value) Then value = FormatNumber(value, 2)
		If IsNumeric(volume) Then volume = FormatNumber(volume,0)		
%>
	<tr<%=row_class%>> 
		<td width="150"><%=datetime%><span style="display:none">;<%=isd%></span></td> 
		<td align="right"><%=price%></td> 
		<td align="right"><%=volume%></td> 
		<td align="right"><%=value%></td> 
		<td><%=buyer%></td>
		<td><%=seller%></td>
		<td align="right"><%=tradeno%></td>
		<td align="center"><%=status%></td>
	</tr>
<%
		alt_row = Not alt_row
		rs.MoveNext 
	Wend
	rs.Close
	Set rs = Nothing
Else
%>
	<tr> 
		<td colspan="8" align="center">No trades</td> 
	</tr>
<%
End If
%>
</tbody>
</table></div>
<p>
<b>Note:</b> When manipulating cancelled trades the cancelled trade notification line plus the original trade line should be taken into account as a pair. Information on cancelled trades is given for clarity only.
</p>


<% If False Then %>
    <br><br><u>Statistics Summary</u>:<br>
    <b>Total Trades: </b><%=Lap%>&nbsp;<br>
	<b>Average Price: </b>$<%
	if totvolume <> 0 then 
	 response.write formatnumber(totvalue/totvolume,2)
	 else
	 response.write "-"
	 end if
	 %>&nbsp;<br>
	<b>Total Volume:</b> <%=formatnumber(totvolume,0)%>&nbsp;securities<br>
	<b>Total Value:</b> $<%=formatnumber(totvalue,2)%>&nbsp;<br>
	<b>Cancelled Trades:</b> <%=cancel%><p>Note: When manipulating cancelled 
	trades the cancelled trade notification line plus the original trade line 
	should be taken into account as a pair.&nbsp; Information on cancelled 
	trades is given for clarity only.</td>
  </tr>

<%
End If
%>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->