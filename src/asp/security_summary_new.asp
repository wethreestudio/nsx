<!--#INCLUDE FILE="include_all.asp"-->
<%
security_code = UCase(Trim(SafeSqlParameter(request.querystring("nsxcode"))))
search = Trim(request.querystring("search"))
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(security_code) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If


page_title = UCase(security_code) & " - Security Summary"
' meta_description = ""
' alow_robots = "no"

' objJsIncludes.Add "amstock", "http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"
objJsIncludes.Add "security_summary_new_js", "js/security_summary_new.js.asp?code=" & security_code
' objJsIncludes.Add "raphael", "charting/raphael.js"
' objJsIncludes.Add "security_summary_chart", "security_summary_chart.asp?code=" & security_code
' objCssIncludes.Add "amstock_css", "charting/style.css"

%>
<!--#INCLUDE FILE="header.asp"-->

<div class="container_cont">

<%
If Len(search) > 0 And Len(security_code) = 0 Then
%>
<h1>Search Results</h2>

<%
Else 



Dim high12
Dim high12dte
Dim low12
Dim low12dte
HighCount = 0
LowCount = 0


SQL = "SELECT TOP 1 [last], [tradedatetime] FROM PricesDaily WHERE [tradedatetime] >= DATEADD(year,-1,GETDATE()) AND [tradingcode]='" & security_code & "' ORDER BY [last] DESC"
HighRow = GetRows(SQL)
If VarType(HighRow) <> 0 Then HighCount = UBound(HighRow,2) + 1
If HighCount > 0 Then
  high12 = FormatNumber(HighRow(0,0),3)
  high12dte = CDate(HighRow(1,0))
End If


SQL = "SELECT TOP 1 [last], tradedatetime FROM PricesDaily WHERE tradedatetime >= DATEADD(year,-1,GETDATE()) AND tradingcode='" & security_code & "' AND [last] > 0 ORDER BY [last] ASC"
LowRow = GetRows(SQL)
If VarType(LowRow) <> 0 Then LowCount = UBound(LowRow,2) + 1
If LowCount > 0 Then
  low12 = FormatNumber(LowRow(0,0),3)
  low12dte = CDate(LowRow(1,0))
End If


SQL = "SELECT [last], [prvclose], [open], [high], [low], [volume], [tradedatetime], cod.coName FROM PricesCurrent JOIN coDetails cod ON cod.nsxcode = tradingcode WHERE tradingcode='" & security_code & "'"


PriceRows = GetRows(SQL)
'Response.Write VarType(PriceRows)
'Response.End

PriceRowsCount = 0
EventSummary = ""
If VarType(PriceRows) <> 0 Then 
  PriceRowsCount = UBound(PriceRows,2)
  If PriceRowsCount >= 0 Then
    last = PriceRows(0,0)
    prvclose = PriceRows(1,0)
    opn = PriceRows(2,0)
    high = PriceRows(3,0)
    low = PriceRows(4,0)
    volume = PriceRows(5,0)
    tradedatetime =  CDate(PriceRows(6,0))
    coName = PriceRows(7,0)  
    increase = last-prvclose
    If increase > 0 Then
      increase = "+" & increase
    End If
    percentChange = (increase/prvclose)*100
  End If
End If
%>




    <!--Security Summary Page-->
    <div id="security-header">
    	<!-- div class="security-brand-logo"><img src="/img/african-petroleum.jpg" /></div -->
        <div id="security-header-top">
        	<img class="water-mark" alt="" src="/images/nsx-water-mark.png" />
        	<a class="brand-name"><%=coName%></a>
            <a class="nsx-code"><%=security_code%></a>
        </div>
        <div id="security-header-bottom">
        	<div id="actual">
            	<p id="act-1" title="Last price"><%=FormatNumber(last,3)%></p>
                <p id="act-2"><span title="Previous close"><%=FormatNumber(prvclose,3)%></span><br />
                <span title="Change since previous close"><%=FormatNumber(increase,2)%>%</span></p>
            </div>
            <div id="high">
            	<p id="high-high">High</p>
                <p id="high-date"><%= Day(high12dte) & "/" & Month(high12dte) & "/" & Year(high12dte) %></p>
                <p id="high-value"><%=high12%></p>
            </div>
            <div id="low">
            	<p id="low-low">Low</p>
                <p id="low-date"><%= Day(low12dte) & "/" & Month(low12dte) & "/" & Year(low12dte) %></p>
                <p id="low-value"><%=low12%></p>
            </div>
            <div id="volume">
            	<p id="volume-volume">Volume</p>
                <p id="volume-value" title="Volume"><%=volume%></p>
            </div>
            <div id="last-trade">
            	<p class="last-last">Last</p>
                <div class="clear"></div>
                <p class="last-last">Trade</p>
                <p id="last-date"><%= Day(tradedatetime) & "/" & Month(tradedatetime) & "/" & Year(tradedatetime) %></p>
                <p id="last-hour"><%= timeAMPM(tradedatetime) %> AEST</p>
            </div>
        </div>
    	<div class="clear"></div>    
    </div>
	
<div class="securitylinks" style="padding-top:8px; padding-bottom:8px; font-size:0.8em;">
  <ul>
    <li><a href="/prices_eom.asp?mth=6&amp;tradingcode=<%=security_code%>">June Prices</a></li>
    <li><a href="/prices_daily.asp?tradingcode=<%=security_code%>">Daily Price History</a></li>
    <li><a href="/prices_monthly.asp?tradingcode=<%=security_code%>">Monthly Price History</a></li>
    <li><a href="/security_capital.asp?nsxcode=<%=security_code%>">Issued Capital</a></li>
    <li><a href="/security_dividends.asp?nsxcode=<%=security_code%>">Dividends</a></li>
    <li><a href="/company_details.asp?nsxcode=<%=security_code%>">Company Details</a></li>
  </ul>
</div>	
	
    <div id="announcements">
    	<div id="announcements-header" >
        	<a href="/ftp/rss/nsx_rss_announcements.xml"><img src="img/rss.png" alt="" /></a>
        	<p>Announcements</p>
        </div>
        <div style="padding-bottom:8px;"></div>
        <div class="scroll-pane" style="height:360px;">
<%

Function FormatDateVal(val)
  If val < 10 Then
    FormatDateVal = "0" & val
    Exit Function
  End If
  FormatDateVal = "" & val
End Function


SQL = "SELECT REPLACE(CONVERT(VARCHAR(10), [annRelease], 111), '/', '-') AS dateformatted, annid, annFile, annTitle, annPriceSensitive, annFile, annPrecise FROM coAnn WHERE nsxcode='" & security_code & "' AND YEAR(annRelease) >= YEAR(GETDATE())-1 AND annRelease IS NOT NULL ORDER BY annRelease DESC"
NewsEventRows = GetRows(SQL)
NewsEventCount = 0
EventSummary = ""
If VarType(NewsEventRows) <> 0 Then NewsEventCount = UBound(NewsEventRows,2)
If NewsEventCount > 0 Then
  For i = 0 To  NewsEventCount
    dt = NewsEventRows(0,i)
    newsDate = CDate(dt)
    newsDateFrom = DateAdd("d", -31, newsDate)
    newsDateTo = DateAdd("d", 30, newsDate)
    ps = NewsEventRows(4,i)
    desc = NewsEventRows(3,i)
    url = "/ftp/news/" & NewsEventRows(5,i)
    precise = NewsEventRows(6,i)
    
    annTime = dateOrdinal(Day(dt)) & " " & monthAbbreviation(Month(dt)) & " " & Year(dt)
    cssClass = "ann"
    bgcolor = ""
    If ps = True Then 
      bgcolor = "FFBA00"
      t = "!"
      mtype = "sign"
      cssClass = "ann ann_ps"
    Else 
      bgcolor = "7CB1CC"
      t = "A"
      mtype = "pin"
    End If
    dashpos = InStr(1, desc, "-", vbTextCompare)
    If dashpos > 0 Then
      desc = Trim(Mid(desc, dashpos+1, Len(desc)-(dashpos)))
    End If   
%>
        <div class="ann-nt">
        	<a class="datea" onclick="javascript:ZoomTo('<%=Year(newsDateFrom)%>-<%=FormatDateVal(Month(newsDateFrom))%>-<%=FormatDateVal(Day(newsDateFrom))%>', '<%=Year(newsDateTo)%>-<%=FormatDateVal(Month(newsDateTo))%>-<%=FormatDateVal(Day(newsDateTo))%>')"><%=annTime%></a>
        	<p class="ann-nt-title">
          <% If ps = True Then %>
            <img onclick="javascript:ZoomTo('<%=Year(newsDateFrom)%>-<%=FormatDateVal(Month(newsDateFrom))%>-<%=FormatDateVal(Day(newsDateFrom))%>', '<%=Year(newsDateTo)%>-<%=FormatDateVal(Month(newsDateTo))%>-<%=FormatDateVal(Day(newsDateTo))%>')" alt="" src="img/ann_ps.png" style="float:left;">&nbsp;
          <% End If %>
          <a href="<%=url%>"><%=Replace(desc,"&","&amp;")%></a></p>
            <p><% If ps = True Then %>Price Sensitive:&nbsp;<% End If %><%=Replace(precise,"&","&amp;")%>&nbsp;</p>
        </div>
<%
  Next
%>    
  <div class="ann-nt">
  <p style="text-align:center"><a href="/marketdata/search_by_company?nsxcode=<%=security_code%>">More Announcements</a></p>
  </div>
  <%
Else
  %>
  <div class="ann-nt">
  <p style="text-align:center">No Announcements</p>
  </div>
  <%
End If
%>    

    

        </div>
    </div>


<%
sSQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
sSQL = sSQL & " FROM pricescurrent WHERE tradingcode='" & security_code & "'"
'Response.Write sSQL
'Response.End
PRow = GetRows(sSQL)
PRowCount = 0
EventSummary = ""
If VarType(PRow) <> 0 Then PRowCount = UBound(PRow,2)
If PRowCount >= 0 Then
    tradingcode = PRow(0,0) 
    last = PRow(5,0) 
    bid = FormatNumber(PRow(7,0),3)
    bidqty = PRow(9,0)   
    offer = FormatNumber(PRow(8,0),3) 
    offerqty = PRow(10,0) 
    open = PRow(2,0) 
    high = FormatNumber(PRow(3,0),3)  
    low = FormatNumber(PRow(4,0),3)
    currentsharesonissue = PRow(13,0) 
    prvclose = PRow(22,0)    
    volume = PRow(6,0)
    currenteps = PRow(23,0)
    tradestatus = PRow(11,0) 
    dim change 
''    mktCap = PRow(3,0) 
''    prevCls = PRow(3,0) 
''    change = PRow(3,0) 
''    pe = PRow(3,0) 
''    divYid = PRow(3,0) 
''    start = PRow(3,0) 
    
    marketcap = 0
    If Len(CStr(last)) > 0 And Len(CStr(currentsharesonissue)) Then
      marketcap = (CDbl(last) * CDbl(currentsharesonissue))/1000000.0
    End If
    If Len(CStr(prvclose)) > 0 And Len(CStr(currentsharesonissue)) Then
    	marketcap = (CDbl(prvclose) * CDbl(currentsharesonissue))/1000000.0
    End If 
    
    Dim dchange
    If last = 0 Or prvclose=0 Then
      dchange = 0
    Else
      dchange = 100*((last-prvclose)/prvclose) 
    End If 
    
    Dim ochange
    If open = 0 Or prvclose = 0 Then
      ochange = 0
    Else
      ochange = 100*((last-open)/open) 
    End If 
       
    'Response.Write "100*((" & last & "-" & prvclose & ")/" & prvclose & ")"
		If dchange > 0 And Not IsNull(volume) Then 
      img3 = "<img border=""0"" src=""images/up.gif"" alt="""" align=""middle""  alt="""">"
      col3 = "green"
		ElseIf dchange < 0 And Not IsNull(volume) Then
			img3="<img border=""0"" src=""images/down.gif"" alt="""" align=""middle""  alt="""">"
			col3 = "red"
		End If
    
    If change > 0 And volume <> 0 Then 
      img1 = "<img border=""0"" src=""images/up.gif"" alt="""" align=""middle""  alt="""">"
      col2 = "green"
    ElseIf change < 0 And volume <> 0 Then
      img1="<img border=""0"" src=""images/down.gif"" alt="""" align=""middle""  alt="""">"
      col2 = "red"
    End If
    
		' PE times calculation
		pe = ""
		currenteps = currenteps '(23,jj)
		if currenteps = 0 or currenteps = "" or currenteps = null then
			pe = 0
		else
			calcprice = prvclose
			if last <> 0 then calcprice = last
			pe = calcprice / (currenteps / 100)
		end if  
          
    if (instr(tradestatus,"SU")>0) then
    	secmode="SUSPENDED"
    	secmodecolor="red"
    Else
      secmode = "&nbsp;"
    end if

		sessionmode = Ucase(Trim(PRow(19,0)) & " ")
		smode = ""
		if sessionmode = "HALT" then smode = "TH"
		if sessionmode = "PREOPEN" then smode = "PRE"
		' if sessionmode="NORMAL" then marketstatus = marketstatus+1
    
		status = ""
		quotebasis = PRow(21,0) ' rs("quotebasis")
	'	tradestatus = PRow(11,0)  ' rs("tradestatus")
		status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
		if status2 <> "" then
			status = "<a href=""/marketdata/search_by_company?nsxcode=" & tradingcode & """ title='See news for " & tradingcode & "'>" & status2 & "</a>&nbsp;" 
		end if    
    
%> 
    <br />
    
    
    <script type="text/javascript" src="js/hs/highstock.js"></script>
    <script type="text/javascript" src="js/hs/modules/exporting.js"></script>    
    <div id="container" style="height: 400px; min-width: 705px;border:1px solid #ff0000;"></div>
    <!-- div id="chartdiv" style=" width:705px; height:400px; background:#CCCCCC; border:#999999 1px solid; margin:-55px auto 12px 0px; "-->
    <!-- /div -->
    <div style="clear:both;height:20px;"></div>
    <div style=" width:996px; margin:auto;">
    	<div class="security-values">
          <div class="table-responsive"><table>
            <thead>
              <tr>
                <th>&nbsp;</th>
                <th>Last</th>
                <th>Bid</th>
                <th>Bid</th>
                <th>Offer</th>
                <th>Offer</th>
                <th>Open</th>
                <th>High</th>
                <th>Low</th>
                <th>Volume</th>
                <th>Mkt.Cap</th>
                <th>Prev.Cls</th>
                <th>Change</th>
                <th>Change</th>
                <th>PE</th>
                <th>STAT</th>
              </tr>
            </thead>
            <tbody>
              <tr class="alt">
                <td>NSX Code</td>
                <td>$</td>
                <td>$</td>
                <td>Qty</td>
                <td>$</td>
                <td>Qty</td>
                <td>$</td>
                <td>$</td>
                <td>$</td>
                <td>Qty</td>
                <td>$m</td>
                <td>$</td>
                <td class="double-row"><p>last vs prv<br>%</p></td>
                <td class="double-row"><p>last vs open<br>%</p></td>
                <td>x</td>
                <td>code</td>
              </tr>
              <tr>
                <td class="bold"><%=tradingcode%></td>
                <td><%=FormatNumber(last,3)%></td>
                <td><%=bid%></td>
                <td><%=bidqty%></td>
                <td><%=offer%></td>
                <td><%=offerqty%></td>
                <td><%=FormatNumber(open,3)%></td>
                <td><%=high%></td>
                <td><%=low%></td>
                <td><%=volume%></td>
                <td><%=FormatNumber(marketcap,3)%></td>
                <td><%=FormatNumber(prvclose,3)%></td>
                <td><%=FormatNumber(dchange,3)%></td>
                <td><%=FormatNumber(ochange,3)%></td>
                <td><%=FormatNumber(pe,3)%></td>
                <td><%=status%></td>
              </tr>
            </tbody>
          </table></div>
		</div>
    </div>
    <br />
<%
End If
%> 
   
    <div style=" width:996px; margin:auto;"><!--Just a Table Container-->
    <!--BIDS,OFFERS,TRADES b-o-t-->
    	<div class=" b-o-t">

                  
<%                  
Dim row_count
Dim row_class
depth_row = GetRows("SELECT marketDepth FROM pricesDepth WHERE tradingCode='" & security_code & "'")
depth = depth_row(0,0)
depthParts = Split(depth,"|")
depthPartsCount = UBound(depthParts)


sql = "SELECT TOP 20 PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete "
sql = sql & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
sql = sql & "WHERE tradingcode='" & security_code & "' "
sql = sql & "ORDER BY PricesTrades.TradeDateTime DESC, PricesTrades.TradeNumber DESC"
courseofsales = GetRows(sql)
If VarType(courseofsales) <> 0 Then 
%>

            <div class="table-responsive"><table>
                <thead>
                  <tr class="header">
                    <th colspan="3"><p>BIDS</p></th>
                    <th colspan="3"><p>OFFERS</p></th>
                    <th colspan="4"><p>LAST 20 TRADES</p></th>
                  </tr>
                </thead>
                <tbody>
                 <tr class="sub-header">
                    <td width="80">PRICE $</td>
                    <td width="80">QTY</td>
                    <td width="80">ORDERS</td>
                    <td width="80">PRICE $</td>
                    <td width="80">QTY</td>
                    <td width="80">ORDERS</td>
                    <td width="250">TRADE DATE</td>
                    <td width="80">PRICE $</td>
                    <td width="80">QTY</td>
                    <td width="80">STA</td>
                  </tr>	
<%




  
courseofsalescount = UBound(courseofsales,2)


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
row_count = sellcount
row_class = "class=""alt"""
If row_count < buycount Then row_count = buycount
If row_count < courseofsalescount Then row_count = courseofsalescount



For rcc = 0 To row_count-1    
%>
<tr <%=row_class%>>
<%
  j=0 
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
%>
<td width="80"><%=FormatNumber((depthParts(i+1)/1000),3)%></td>
<td width="80"><%=depthParts(i+3)%></td>
<td width="80"><%=depthParts(i+2)%></td>
<%
        Response.Write(VbCrLf)
        printed_td = true
        end if
        j = j + 1 
      End If      
    End If
  Next
  if not printed_td then
%>
<td width="80">&nbsp;</td>
<td width="80">&nbsp;</td>
<td width="80">&nbsp;</td>
<% 
  end if


  j=0 
  printed_td = false  
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
<td width="80" class="orange"><%=FormatNumber((depthParts(i+1)/1000),3)%></td>
<td width="80" class="orange"><%=depthParts(i+3)%></td>
<td width="80" class="orange"><%=depthParts(i+2)%></td>
<%
        Response.Write(VbCrLf)
        printed_td = true
        end if
      End If 
      j = j + 1              
    End If
  Next
  if not printed_td then
%>
<td width="80" class="orange">&nbsp;</td>
<td width="80" class="orange">&nbsp;</td>
<td width="80" class="orange">&nbsp;</td>
<%
  end if 
  If rcc < courseofsalescount-1 Then
    SalePrice = courseofsales(0,rcc) ' PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete'
    SaleVolume = courseofsales(1,rcc)
    TradeDateTime = courseofsales(2,rcc)

%>
<td width="250" class="green"><%=TradeDateTime%></td>
<td width="80" class="green"><%=FormatNumber(SalePrice,3)%></td>
<td width="80" class="green"><%=SaleVolume%></td>
<td width="80" class="green"><p>0</p></td>
</tr>
<%
  Else  
%>
<td width="250" class="green">&nbsp;</td>
<td width="80" class="green">&nbsp;</td>
<td width="80" class="green">&nbsp;</td>
<td width="80" class="green"><p>&nbsp;</p></td>
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
%>

</div>


<%
  End If  
%>
</div>




































































<script type="text/javascript" src="charting/swfobject.js"></script>







<script type="text/javascript">



    var params = 
    {
        bgcolor:"#FFFFFF"
    };
    var flashVars = 
    {
        settings_file: "security_summary_settings.asp?nsxcode=<%=security_code%>&amp;ps=1", 
    };
    swfobject.embedSWF("charting/amstock.swf", "chartdiv", "705", "400", "8.0.0", "charting/expressInstall.swf", flashVars, params)
    
function ZoomTo(from, to){
  flashMovie = document.getElementById('chartdiv');
  flashMovie.setZoom(from, to)

}    
    
    ; 
</script>






<div style="width:100%;clear:both;height:10px;"></div>








</div>


<!--#INCLUDE FILE="footer.asp"-->