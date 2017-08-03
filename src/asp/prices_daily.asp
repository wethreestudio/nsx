<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
id =  UCase(SafeSqlParameter(Request.QueryString("tradingcode")))
Set regEx = New RegExp
regEx.Pattern = "^[a-zA-Z0-9]+$"
isCodeValid = regEx.Test(id)
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

Function FormatPrice(p,d)
	If Len(p)>0 Then
		FormatPrice = FormatNumber(p,d)
	Else 
		FormatPrice = "-"
	End If
End Function
%>
<%


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
' End flash data
    
page_title = flashdata_coName & " " & UCase(security_code) & " Prices"

%>
<!--#INCLUDE FILE="header.asp"-->
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
<%

' multiple pages
currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If


' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.

coname = replace(request.querystring("coname") & " ","''","'")
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT DISTINCT [tradingcode], [tradedatetime] as daily, [open], [high], [low], [last], [volume], [bid], [offer],[last],[last]"
SQL = SQL & " FROM pricesdaily"
'SQL = SQL & " GROUP BY pricesdaily.tradingcode, CONVERT(VARCHAR(8), [tradedatetime], 5)  "
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') "
SQL = SQL & " ORDER BY tradingcode, [tradedatetime] DESC"

'response.write SQL
'response.end

CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	else
	rc = -1
end if

CmdDD.Close
Set CmdDD = Nothing

ConnPasswords.Close
Set ConnPasswords = Nothing

rowcount = 0
maxpagesize = 100
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc


%>
<h2><%=UCase(id)%> - <%=coname%> - Daily Price History</h2>
<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 nopad">
	<p align="left">If there have been no trades in a security then the last 
	price used is the Issue or Nominal price on listing otherwise the last price 
	is the last traded price.&nbsp;</p>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 nopad">
    <div>
        <p>Download Daily Price Table
            <a href="/download_dailyprices.aspx?nsxcode=<%=id%>&amp;format=XLS" class="blue-link">Excel</a> 
            <a href="/download_dailyprices.aspx?nsxcode=<%=id%>&amp;format=CSV" class="blue-link">CSV</a>
            <!--<a href="prices_definitions.asp" class="">Definitions</a>-->
        </p>
    </div>
	    
    <p>&nbsp;</p>
	<p align="left">&nbsp;Page:
    <%if currentpage > 1 then %>
        <a href="prices_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=currentpage-1%>">
        <font face="Arial">&lt;&lt;</font></a><a href="prices_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=currentpage-1%>&amp;coname=<%=coname%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=ii%>&amp;coname=<%=coname%>" ><%=ii%></a> | 

      <%
      	end if
      next

      %>

      <%if maxpages > CurrentPage then %>
              
        <a href="prices_daily.asp?tradingcode=<%=id%>&amp;currentpage=<%=currentpage+1%>&amp;coname=<%=coname%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>&nbsp; 

  </p>
</div>

<!-- top table -->
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 nopad">
<!--BIDS,OFFERS,TRADES b-o-t-->
<div class="b-o-t table-restyle">
                  
<%                  
Dim row_count
Dim row_class
depth_row = GetRows("SELECT marketDepth FROM pricesCurrent WHERE tradingCode='" & security_code & "'")
If VarType(depth_row) <> 0 Then

depth = depth_row(0,0)
If Len(Trim(depth & "")) > 1 Then
depthParts = Split(depth,"|")
depthPartsCount = UBound(depthParts)

sql = "SELECT TOP 10 PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete,BrokerBuyers.BrokerName,BrokerSellers.BrokerName, PricesTrades.TradeSource "
sql = sql & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
sql = sql & "WHERE tradingcode='" & security_code & "' "
sql = sql & "ORDER BY PricesTrades.TradeDateTime DESC, cast(PricesTrades.TradeNumber as INT) DESC,PricesTrades.prid DESC"
courseofsales = GetRows(sql)
'If VarType(courseofsales) <> 0 Then 
If VarType(depth_row) <> 0 Then 
%>
<div class="table-responsive"><table class="table">
    <thead>
        <tr class="header">
            <td align="left">Date/Time</td>
            <td align="left">Buyer</td>
            <td align="left">Seller</td>
            <td align="right">Price $</td>
            <td align="right">Value $</td>
            <td align="right">Volume</td>
            <td align="right">Trade #</td>
		    <td align="right"><a href="/investors/tradingcodes" title="view status codes">Status</a></td>
        </tr>
    </thead>
    <tbody>
<%

If VarType(courseofsales) <> 0 Then
	courseofsalescount = UBound(courseofsales,2)+1
	'Response.Write "courseofsalescount=" & courseofsalescount : Response.End
else
	courseofsalescount = 0
end if

depthType = ""
buycount = 0
sellcount = 0
For i = 0 To depthPartsCount-1 Step 5
  If Trim(LCase(depthParts(i))) = "s" Then
    sellcount = sellcount + 1
  ElseIf Trim(LCase(depthParts(i))) = "b" Then
    buycount = buycount + 1
  End If
Next
row_count = buycount
row_class = "" '"class=""alt"""
If row_count < sellcount Then row_count = sellcount
If row_count < courseofsalescount Then row_count = courseofsalescount
 
For rcc = 0 To row_count-1
%>
<tr>
<%
  j=0 
  i = 0
  printed_td = false
  For i = 0 To depthPartsCount-1 Step 5
    depthType = ""
    If Trim(LCase(depthParts(i))) = "s" Then
      depthType = "sell"
    ElseIf Trim(LCase(depthParts(i))) = "b" Then
      depthType = "buy"
    End If
    If depthType = "buy" Then
      If IsNumeric(depthParts(i+1)) And IsNumeric(depthParts(i+3)) And IsNumeric(depthParts(i+2)) Then
        if rcc = j then

'<td width="50" align="right">=depthParts(i+2)</td>
'<td width="80" align="right">=FormatNumber(depthParts(i+3),0)</td>

if exchid = "SEQY" or exchid = "SRST" or exchid = "SBND" then
'<td width="50" align="right">=FormatNumber((depthParts(i+1)/100),2)</td>
else
'<td width="50" align="right">=FormatNumber((depthParts(i+1)/1000),3)</td>
end if%>
<%
        Response.Write(VbCrLf)
        printed_td = true
        end if
        j = j + 1 
      End If      
    End If
  Next
  if not printed_td then

'<td width="50">&nbsp;</td>
'<td width="80">&nbsp;</td>
'<td width="50">&nbsp;</td>
%><%
  end if

  j=0 
  i = 0
  printed_td = false  
  ' depthPartsCount = depthPartsCount - 10
  For i = 0 To depthPartsCount-1 Step 5
    depthType = ""
    If Trim(LCase(depthParts(i))) = "s" Then
      depthType = "sell"
    ElseIf Trim(LCase(depthParts(i))) = "b" Then
      depthType = "buy"
    End If
    If depthType = "sell" Then
      If IsNumeric(depthParts(i+1)) And IsNumeric(depthParts(i+3)) And IsNumeric(depthParts(i+2)) Then
        if rcc = j then
%>
<% if exchid = "SEQY" or exchid = "SRST" or exchid = "SBND" then 'fiji marketdepth only displays 2 decimal places

'<td width="50" class="orange" align="right">=FormatNumber((depthParts(i+1)/100),2)</td>
else
'<td width="50" class="orange" align="right">=FormatNumber((depthParts(i+1)/1000),3)</td>
end if
'<td width="80" class="orange" align="right">=FormatNumber(depthParts(i+3),0)</td>
'<td width="50" class="orange" align="right">=depthParts(i+2)</td>
%><%
        Response.Write(VbCrLf)
        printed_td = true
        end if
      End If 
      j = j + 1              
    End If
  Next
  if not printed_td then

'<td width="50" class="orange">&nbsp;</td>
'<td width="80" class="orange">&nbsp;</td>
'<td width="50" class="orange">&nbsp;</td>

  end if 
  
  Status = "&nbsp;"
  'If rcc < courseofsalescount-1 Then
    If rcc < courseofsalescount Then
		if courseofsalescount <>0 then
			SalePrice = courseofsales(0,rcc) ' PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete'
			SaleVolume = courseofsales(1,rcc)
			TradeDateTime = courseofsales(2,rcc)
			if isdate(TradeDateTime) then
				TradeDateTime = Day(tradedatetime) & "-" & Monthname(Month(tradedatetime),3) & "-" & Year(tradedatetime) & " " & FormatDateTime(TradeDateTime,3)
			end if
			Status = courseofsales(3,rcc)
			If Status="D" Then 
				Status = "CANCELLED"
				StatusTitle = "Cancelled Trade"
			Else
				Status = "&nbsp;"
				StatusTitle = ""
			End If  
			Buyer = courseofsales(4,rcc)
			Seller = courseofsales(5,rcc)
			TradeSource = trim(courseofsales(6,rcc) & " ")
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
				StatusTitle = ""						
			END SELECT
			
			status = "<a href='/investors/tradingcodes' title='" & statustitle & "'>" & trim(status & " ")  & "</a>"
			
		else
			SalePrice = "" 
			SaleVolume = ""
			TradeDateTime = ""
			Status = ""
			StatusTitle = ""
			buyer = ""
			seller = ""
		end if    

%>
    <td align="left"><%=TradeDateTime%></td>
    <td align="left"><%=buyer%></td>
    <td align="left"><%=seller%></td>
    <td align="right"><%=FormatPrice(SalePrice,3)%></td>
    <td align="right"><%=FormatPrice(SaleVolume,0)%></td>
    <td align="right">-</td>
    <td align="right">-</td>
    <td align="right"><%=status%></td>
</tr>
<%
  Else
%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><%=status%></td>
</tr>
<%
  End If  
  
  if len(row_class) > 0 Then
    row_class = ""
  Else
    row_class = "class=""alt"""
  end if 
Next                  
%>                  
           
</tbody>
</table></div>
<%
End If
End If 
End If  
%>

</div>


<%
  'End If
%>

<%
if len(offexchangetrading_url) > 0 then
		
%>
 <br />
    <div><!--Just a Table Container-->
    <!--Other exchange trading -->
<div class="table-responsive"><table class="table">
    <thead>
        <tr>
            <th colspan="2">
            <p>Other Markets<span>The securities of this Issuer are also listed or traded on other markets.</span></p>
            <img class="water-mark" alt="" src="/images/nsx-water-mark.png" /></th>
        </tr>
    </thead>
    <tbody>
	
	<%
	markets_ary = split(offexchangetrading_url,"}")
	markets_count = ubound(markets_ary)
	for jjj = 0 to markets_count
		agex04 = split(markets_ary(jjj),"|")
		ex_name = agex04(0)
		ex_url = agex04(1)
		  if len(row_class) > 0 Then
			row_class = ""
			Else
			row_class = "class=""alt"""
		  end if 
		
		%>
        <tr <%=row_class%>>
            <td align="left"><%=ex_name%></td>
            <td width="150" align="center"><a href="<%=ex_url%>" target="_blank" class="btn btn-primary">Go to page</a></td>
        </tr>
	<% NEXT ' market
	%>
    </tbody>
</table></div>
</div>
<%
end if  ' end offexchangetrading_url test
%>
<!-- /top table -->

<!-- lower table -->
<div class="table-responsive"><table id="myTable" class="tablesorter table table-restyle"> 
<thead> 
<tr> 
    <th class="text-left">Date</th>
    <th>Last$</th>
    <th>Daily Change</th>
    <th>Change</th>
    <th>Bid</th>
    <th>Ask</th>
    <th>Open</th>
    <th>High</th>
    <th>Low</th>
    <th>Vol.</th>
</tr> 
</thead> 
<tbody>
       
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available.</td</tr>" 
    else
    
    dailyprice0 = 0 
    dailyprice1 = 0
    
    
    For ii = fh to st step -1
 
     	  open = alldata(2,ii)
      	  last = alldata(5,ii)

      	  	dailyprice1 = last
      	  	dailychange = 0
   			if dailyprice0 <> 0 then
      	  		dailychange = 100*((dailyprice1-dailyprice0)/dailyprice0)
      	  	end if
      	  		dailyprice0 = dailyprice1
      	  		
      	  	if open = 0 then
				change = 0
			else
				change = 100*((last-open)/open)
			end if
			alldata(9,ii)=change
			alldata(10,ii)=dailychange
    
    next  
    
       for jj = st to fh

      	  nsxcode = alldata(0,jj)
      	  daily = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = alldata(4,jj)
      	  last = alldata(5,jj)
      	  volume = alldata(6,jj)
      	  bid = alldata(7,jj)
      	  ask = alldata(8,jj)
      	 change = alldata(9,jj)
      	 dailychange = alldata(10,jj) 
      	  
		 if open = 0 then open = last
		 if low = 0 then low = last
		 if high = 0 then high = last
		 if volume = 0 then open = 0
		 if volume = 0 then low = 0
		 if volume = 0 then high = 0
		 
		 
		 if (open<>0) and (open > high) then high = open
		 if (open<>0) and (open < low) then low = open
     	 
  
	'display decimals
		 'prices = bid + offer + last
		 prices = cstr(last)
		 locdot = instr(prices,".")
		 if locdot = 0 then
		 	deci = 2
		 	else
		 	deci = len(right(prices,len(prices) - instr(prices,".")))
		 end if
	 
		 
		 locdotp = instr(open,".")
		 if locdotp = 0 then
		 	decip = 2
		 	else
		 	decip = len(right(open,len(open) - instr(open,".")))
		 end if

		locdoth = instr(high,".")
		 if locdoth = 0 then
		 	decih = 2
		 	else
		 	decih = len(right(high,len(high) - instr(high,".")))
		 end if

		locdotl = instr(low,".")
		 if locdotl = 0 then
		 	decil = 2
		 	else
		 	decil = len(right(low,len(low) - instr(low,".")))
		 end if
		 
		 		locdotl = instr(ask,".")
		 if locdotl = 0 then
		 	decie = 2
		 	else
		 	decie = len(right(ask,len(ask) - instr(ask,".")))
		 end if
		 
		 locdotl = instr(bid,".")
		 if locdotl = 0 then
		 	decid = 2
		 	else
		 	decid = len(right(bid,len(bid) - instr(bid,".")))
		 end if

		 
		 'response.write prices & " - " & deci
		 if deci = 0 then deci = 2
		 if deci = 1 then deci = 2
		 if decib = 0 then decib = 2
		 if decib = 1 then decib = 2
		 if decio = 0 then decio = 2
		 if decio = 1 then decio = 2
		if decip = 0 then decip = 2
		 if decip = 1 then decip = 2
		if decih = 0 then decih = 2
		 if decih = 1 then decih = 2
		if decil = 0 then decil = 2
		 if decil = 1 then decil = 2

	 
		 if last = 0 then
		 	last = "-"
		 	else
		 	last = formatnumber(last,deci)
		 end if
		 
		 if low = 0 then
		 	low = "-"
		 	else
		 	low = formatnumber(low,decil)
		 end if
		 if high = 0 then
		 	high = "-"
		 	else
		 	high = formatnumber(high,decih)
		 end if
		if open = 0 then
		 	open = "-"
		 	else
		 	open = formatnumber(open,decip)
		 end if
		 if bid = 0 then
		 	bid = "-"
		 	else
		 	bid = formatnumber(bid,decid)
		 end if
		 if ask = 0 then
		 	ask = "-"
		 	else
		 	ask = formatnumber(ask,decie)
		 end if

    
       
       if change > 0 and volume<>0 then 
          	img1 = img1 = "<img border=""0"" src=""images/up.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
       	col2 = "color:green"
       
		elseif change < 0 and volume<>0 then
			img1= "<img border=""0"" src=""images/down.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
			col2 = "color:red"
		
		else
			col2 = "" 'color:navy"
			img1 = ""
		end if
		if change = 0 then 
			change = "-"
			else
			change = formatnumber(change,2) & "%"
		end if
	
      	  ' do the daily price change formatting
      	  
        if dailychange > 0 and volume<>0 then 
          	img2 = img1 = "<img border=""0"" src=""images/up.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
       		col3 = "color:green"
       
		elseif dailychange < 0 and volume<>0 then
			img2="<img border=""0"" src=""images/down.gif"" style=""vertical-align:middle;padding-left:4px;"" alt="""">"
			col3 = "color:red"
		
		else
			col3 = "" 'color:navy"
			img2 = ""
		end if

		if dailychange = 0 then 
			dailychange = "-"
			else
			dailychange = formatnumber(dailychange,2) & "%"
		end if

		if volume = 0 then
			change = "-"
			dailychange = "-"
		end if

   cl = array("class=""odd""","class=""even""")
	lap = (-lap)+1
				
    %>
  <tr <%=cl(lap)%>>
    <td nowrap><%=fmtdate(daily)%>&nbsp;</td>
    <td align="right"><%=last%>&nbsp;</td>
    <td align="right"><span style="<%=col3%>"><%=dailychange%><%=img2%></span>&nbsp;</td>
    <td align="right"><span style="<%=col2%>"><%=change%><%=img1%></span>&nbsp;</td>
    <td align="right"><%=bid%>&nbsp;</td>
    <td align="right"><%=ask%>&nbsp;</td>
    <td align="right"><%=open%>&nbsp;</td>
    <td align="right"><%=high%>&nbsp;</td>
    <td align="right"><%=low%>&nbsp;</td>
    <td align="right"><%
     if volume = 0 then
     	response.write "-"
     	else
     	response.write formatnumber(volume,0) 
     end if
     	%>&nbsp;</td>
  </tr>
    
    	<%
    	
    	  NEXT
    end if
    %>
</tbody>
</table></div>
<!-- /lower table -->
</div>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->