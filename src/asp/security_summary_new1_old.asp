<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE FILE="include_all.asp"-->
<%
Response.CharSet = "UTF-8"
security_code = UCase(Trim(SafeSqlParameter(request.querystring("nsxcode"))))
search = Trim(request.querystring("search"))
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(security_code) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

Function IsBlank(Value)
'returns True if Empty or NULL or Zero
If IsEmpty(Value) or IsNull(Value) Then
 IsBlank = True
 Exit Function
ElseIf VarType(Value) = 8 Then
 If Value = "" Then
  IsBlank = True
  Exit Function
 End If
ElseIf IsObject(Value) Then
 If Value Is Nothing Then
  IsBlank = True
  Exit Function
 End If
ElseIf IsNumeric(Value) Then
 If Value = 0 Then
  'wscript.echo " Zero value found"
  IsBlank = True
  Exit Function
 End If
Else
 IsBlank = False
End If
End Function

page_title = UCase(security_code) & " - Security Summary"
' meta_description = ""
' alow_robots = "no"

' objJsIncludes.Add "amstock", "http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"
objJsIncludes.Add "security_summary_new_js", "/js/security_summary_new2.js.asp?code=" & security_code
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

Function FormatPrice(p,d)
	If Len(p)>0 Then
		FormatPrice = FormatNumber(p,d)
	Else 
		FormatPrice = "-"
	End If
End Function

company_code = ""
sql = "SELECT TOP 1 [nsxcode], IssueStatus,  (CASE WHEN ISDATE(IssueStopped)!=0 THEN REPLACE(CONVERT(VARCHAR(11), CAST(IssueStopped AS date), 106), ' ', '-') ELSE '' END)  AS sd FROM coIssues WHERE [tradingcode]='" & security_code & "'"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If Not rs.EOF Then
	company_code = rs("nsxcode")
	issue_status = rs("IssueStatus")
	stopped_date = rs("sd")
Else

End If


'SQL = "SELECT TOP 1 [last], [prvclose], [open], [high], [low], [volume], (SELECT TOP 1 tradedatetime FROM PricesTrades WHERE tradingcode='" & security_code & "' ORDER BY prid DESC), cod.coName, [sessionmode] FROM PricesCurrent LEFT JOIN coDetails cod ON cod.nsxcode = tradingcode WHERE tradingcode='" & security_code & "'"
SQL = "SELECT TOP 1 [last], [prvclose], [open], [high], [low], [volume], (SELECT TOP 1 tradedatetime FROM PricesTrades WHERE tradingcode='" & security_code & "' ORDER BY prid DESC), [issuedescription], [sessionmode],[logo_summary],[offexchangetrading_url] FROM PricesCurrent WHERE tradingcode='" & security_code & "'"

' Response.Write SQL : Response.End
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
    noLastDate = false
    If IsDate(PriceRows(6,0)) Then 
      tradedatetime =  CDate(PriceRows(6,0))
    Else
      noLastDate = true
    End If
    coName = PriceRows(7,0)
   '' sessionmode = PriceRows(8,0)
    sessionmode = Ucase(Trim(PriceRows(8,0)) & " ")
		smode = ""
		if sessionmode = "HALT" then smode = "TH"
		if sessionmode = "PREOPEN" then smode = "PRE"
 
	increase = 0
    If prvclose > 0 And prvclose > 0 Then
		increase = ((last-prvclose)/prvclose)*100
		If increase > 0 Then
		  increase = "+" & increase
		End If
	End If
'	If increase > 0 And prvclose > 0 Then percentChange = (increase/prvclose)*100
	
	
	If Not IsNumeric(last) Then last = 0
	If Not IsNumeric(opn) Then opn = 0
	If Not IsNumeric(high) Then high = 0
	If Not IsNumeric(low) Then low = 0
	If Not IsNumeric(volume) Then volume = 0
	
	If last=0 Then last=""
	If opn=0 Then opn=""
	If high=0 Then high=""
	If low=0 Then low=""
	If volume=0 Then volume=""
	
	logo_summary = Trim(PriceRows(9,0) & " ") 
	offexchangetrading_url = Trim(PriceRows(10,0) & " " )

  End If
End If


If LCase(Trim(issue_status)) = "delisted" Then
	If Trim(stopped_date) <> "" Then
%>
<div style="font-size:13px;padding:12px;border:1px solid #ff0000;text-align:center;color:#ff0000;font-weight:bold;margin-bottom:10px">Notice: This security (<%=UCase(security_code)%>) has been delisted from the NSX since <%=stopped_date%>.</div>
<%
	Else
%>
<div style="font-size:13px;padding:12px;border:1px solid #ff0000;text-align:center;color:#ff0000;font-weight:bold;margin-bottom:10px">Notice: This security (<%=UCase(security_code)%>) is currently delisted from the NSX.</div>
<%	
	End If

ElseIf LCase(Trim(issue_status)) <> "active" And Len(Trim(issue_status)) > 0 Then
%>
<div style="font-size:13px;padding:12px;border:1px solid #ff0000;text-align:center;color:#ff0000;font-weight:bold;margin-bottom:10px">Notice: This security (<%=UCase(security_code)%>) is currently listed as <%=UCase(Trim(issue_status))%>.</div>
<%
End If

' commencement of trading notice
if (security_code = "A2H" )  then
com_msg = "<div style='font-size:13px;padding:12px;border:1px solid green;text-align:center;color:green;font-weight:bold;margin-bottom:10px'>Notice: This security (" & UCase(security_code) & ") will commence trading at 11:00 AM AEST.</div>"
'response.write com_msg
end if
%>


    <!--Security Summary Page-->
    <div id="security-header">
		<% if len(logo_summary) > 0 then %>
    	<div class="security-brand-logo"><img src="/images/company_images/<%=logo_summary%>" /></div>
		<%end if%>
        <div id="security-header-top">
        	<img class="water-mark" alt="" src="/images/nsx-water-mark.png" />
			<a class="nsx-code"><%=Server.HTMLEncode(security_code)%></a>
        	<a class="brand-name"><%
			If Len(coName) > 0 Then
				Response.Write Server.HTMLEncode(left(coName,70))
			Else 
				Response.Write "&nbsp;"
			End If
			%></a>
            
        </div>
        <div id="security-header-bottom">
        	<div id="actual">
            	<p id="act-1" title="Last price"><%=FormatPrice(last,3)%></p>
                <p id="act-2"><span title="Previous close"><%
				If IsBlank(prvclose) Then
					Response.Write "-"
				Else
					Response.Write FormatPrice(prvclose,3)
				End If
				%></span><br />
                <span title="Change since previous close"><%=FormatPrice(increase,2)%>%</span></p>
            </div>
            <div id="high">
            	<p id="high-high">High</p>
                <p id="high-date">&nbsp;</p>
                <p id="high-value"><%=FormatPrice(high,3)%></p>
            </div>
            <div id="low">
            	<p id="low-low">Low</p>
            	  <p id="low-date">&nbsp;</p>
                <p id="low-value"><%=FormatPrice(low,3)%></p>
            </div>
            <div id="volume">
            	<p id="volume-volume">Volume</p>
                <p id="volume-value" title="Volume"><%=FormatPrice(volume,0)%></p>
            </div>
            <div id="last-trade">
            	<p class="last-last">Last</p>
                <div class="clear"></div>
                <p class="last-last">Trade</p>
                <% If noLastDate Then %>
                  <p>&nbsp;</p>
                <% Else %>
                <p id="last-date"><%= Day(tradedatetime) & "-" & Monthname(Month(tradedatetime),3) & "-" & Year(tradedatetime) %></p>
                <p id="last-hour"><%= timeAMPM(tradedatetime) %> AEST</p>
                <% End If %>
            </div>
        </div>
    	<div class="clear"></div> 
    </div>

<div class="securitylinks" style="padding-top:15px; padding-bottom:15px;" align="center">
  <ul>
    <li><a href="/company_details.asp?nsxcode=<%=company_code%>" class="btn btn-primary">Company Details</a></li>
    <li><a href="/security_details.asp?nsxcode=<%=security_code%>" class="btn btn-primary">Security Details</a></li>
    <li><a href="/prices_eom.asp?mth=6&tradingcode=<%=security_code%>&coname=<%=coname%>" class="btn btn-primary">Month End Prices</a></li>
    <li><a href="/prices_daily.asp?tradingcode=<%=security_code%>&coname=<%=coname%>" class="btn btn-primary">Daily Prices</a></li>
   <!-- <li><a href="/prices_monthly.asp?tradingcode=<%=security_code%>" class="btn btn-primary">Monthly Price History</a></li>-->
    <li><a href="/security_capital.asp?nsxcode=<%=company_code%>" class="btn btn-primary">Capital</a></li>
    <li><a href="/security_dividends.asp?nsxcode=<%=security_code%>&coname=<%=coname%>" class="btn btn-primary">Dividends</a></li>
	<li><a href="/prices_trades.asp?tradingcode=<%=security_code%>" class="btn btn-primary">Trades</a></li> 
	<li><a href="/statements/<%=company_code%>" class="btn btn-primary">Statements</a></li> 
	<li><a href="http://www.hotcopper.com.au/nsxa/<%=security_code%>" class="btn btn-primary" target="_blank">Forum &#x21D7;</a></li>
	<!-- class="btn btn-primary" -->
		<!-- li><%
	'session("nsxcode")=security_code
	'server.execute "display_almanac.asp"
	%></li -->
  </ul>
</div>	


    <div id="announcements">
    	<div id="announcements-header" >
        	<a href="/ftp/rss/byissuer/nsx_rss_announcements_<%=company_code%>.xml"><img src="img/rss.png" alt="" /></a>
        	<p>Announcements</p>
        </div>
        <div style="padding-bottom:8px;"></div>
        <div class="scroll-pane" style="height:428px;">
        
        
<script type="text/javascript">

function ZoomTo(from, to){
  var fdteParts = from.split("-");
  var fd=Date.UTC(fdteParts[0], fdteParts[1]-1, fdteParts[2]);
  var tdteParts = to.split("-");
  var td=Date.UTC(tdteParts[0], tdteParts[1]-1, tdteParts[2]);
  
  //alert (fd + " " + td);
  chart.xAxis[0].setExtremes(fd, td);
}

</script>        
<%

Function FormatDateVal(val)
  If val < 10 Then
    FormatDateVal = "0" & val
    Exit Function
  End If
  FormatDateVal = "" & val
End Function


sql = "SELECT TOP 200 REPLACE(CONVERT(VARCHAR(10), [annRelease], 111), '/', '-') AS dateformatted, annid, annFile, annTitle, annPriceSensitive, annPrecise FROM coAnn WHERE tradingcode='" & security_code & "' AND annRelease IS NOT NULL AND annDisplay='1' ORDER BY annRelease DESC"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %>  <div class="ann-nt">
  <p style="text-align:center">No Announcements</p>
  </div><%
Else
  i = 0
  While Not rs.EOF
    dt = rs("dateformatted")
    newsDate = CDate(dt)
    newsDateFrom = DateAdd("d", -16, newsDate)
    newsDateTo = DateAdd("d", 15, newsDate)
    ps = rs("annPriceSensitive")
    desc = rs("annTitle")
	desc = replace(desc,"""","'")
    url = "/ftp/news/" & rs("annFile")
    precise = rs("annPrecise") & " "
	precise = replace(precise,"""","'")
    
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
            <img onclick="javascript:ZoomTo('<%=Year(newsDateFrom)%>-<%=FormatDateVal(Month(newsDateFrom))%>-<%=FormatDateVal(Day(newsDateFrom))%>', '<%=Year(newsDateTo)%>-<%=FormatDateVal(Month(newsDateTo))%>-<%=FormatDateVal(Day(newsDateTo))%>')" title="Price Sensitive" alt="Price Sensitive" src="img/ann_ps1.png" style="float:left;">&nbsp;
          <% End If %>
          <a href="<%=url%>"><%=Replace(desc,"&","&amp;")%></a></p>
            <p><% If ps = True Then %>Price Sensitive:&nbsp;<% End If %><%=Replace(precise,"&","&amp;")%>&nbsp;</p>
        </div>
<%
    rs.MoveNext 
    i = i + 1
  Wend  
End If
%>  
<div class="ann-nt">
<p style="text-align:center"><a href="/marketdata/search_by_company?nsxcode=<%=security_code%>">More Announcements</a></p>
</div>
  

    

        </div>
    </div>


<%
sSQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
sSQL = sSQL & " FROM pricescurrent WHERE tradingcode='" & security_code & "'"
PRow = GetRows(sSQL)
PRowCount = 0
EventSummary = ""
If VarType(PRow) <> 0 Then PRowCount = UBound(PRow,2)
Response.Write "<!--" & vbCrLf
Response.Write " VarType=" & VarType(PRow) & vbCrLf
Response.Write " Count=" & PRowCount & vbCrLf
Response.Write "-->"
If PRowCount >= 0 And VarType(PRow) <> 0 Then
    tradingcode = PRow(0,0) 
	tradedatetime = PRow(1,0)
    last = PRow(5,0) 
	bid = ""
    If IsNumeric(PRow(7,0)) Then bid = FormatNumber(PRow(7,0),3)
    bidqty = PRow(9,0)   
	offer = ""
    If IsNumeric(PRow(8,0)) Then offer = FormatNumber(PRow(8,0),3) 
    offerqty = PRow(10,0) 
    open = PRow(2,0) 
	high = ""
    If IsNumeric(PRow(3,0)) Then high = FormatNumber(PRow(3,0),3)  
    If IsNumeric(PRow(4,0)) Then low = FormatNumber(PRow(4,0),3)
    currentsharesonissue = PRow(13,0) 
    prvclose = PRow(22,0)    
    volume = PRow(6,0)
    currenteps = PRow(23,0)
    tradestatus = PRow(11,0) 
	exchid = PRow(12,0)
    ' sessionmode = PRow(19,0)
    dim change 

	' **** MAKET CAP CALC ********
    marketcap = 0
	If NOT IsNull(prvclose) AND Not IsNull(currentsharesonissue) and prvclose<>0 Then
		marketcap = (CDbl(prvclose) * CDbl(currentsharesonissue))/1000000.0
	End If 
	
	If NOT IsNull(last) AND Not IsNull(currentsharesonissue) and last <> 0 Then
      marketcap = (CDbl(last) * CDbl(currentsharesonissue))/1000000.0
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

		sessionmode = Trim(Ucase(PRow(19,0)) & " ")
		smode = ""
		
		SELECT CASE sessionmode
			CASE "HALT"
				smode = "TH"
			CASE "PREOPEN"
				smode = "PRE"
			CASE "ENQUIRY"
				smode = "ENQ"
			CASE "NORMAL"
				smode = ""
			CASE "CLOSING"
				smode = "CLS"
			CASE else
				smode = sessionmode
		END SELECT
		'if sessionmode="NORMAL" then marketstatus = marketstatus+1
				
    
		status = smode
		quotebasis = PRow(21,0) ' rs("quotebasis")
	'	tradestatus = PRow(11,0)  ' rs("tradestatus")
		status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
		if status2 <> "" then
			status = "<a href=""/marketdata/search_by_company?nsxcode=" & tradingcode & """ title='See news for " & tradingcode & "'>" & status2 & "</a>&nbsp;" 
		end if 
	'If IsBlank(last) Then last = ""
	'If IsBlank(open) Then open = ""
	'If IsBlank(high) Then high = ""
	'If IsBlank(low) Then low = ""
	'If IsBlank(volume) Then volume = ""
	If Not IsNumeric(last) Then last = 0
	If Not IsNumeric(open) Then opn = 0
	If Not IsNumeric(high) Then high = 0
	If Not IsNumeric(low) Then low = 0
	If Not IsNumeric(volume) Then volume = 0
	If Not IsNumeric(bid) Then bid = 0
	If Not IsNumeric(bidqty) Then bidqty = 0
	If Not IsNumeric(offer) Then offer = 0
	If Not IsNumeric(offerqty) Then offerqty = 0
	If Not IsNumeric(pe) Then pe = 0
	
	If last=0 Then last=""
	If open=0 Then open=""
	If high=0 Then high=""
	If low=0 Then low=""
	If volume=0 Then volume=""
	If bid=0 Then bid=""
	If bidqty=0 Then bidqty=""
	If offer=0 Then offer=""
	If offerqty=0 Then offerqty=""
	If pe=0 Then pe=""
  
%> 
    <br />
    
    
    <script type="text/javascript" src="js/hs/highstock.js"></script>
    <script type="text/javascript" src="js/hs/modules/exporting.js"></script> 

    <div id="cd" style=" width:755px; height:500px; margin-left:-14px; margin-top:-15px; position:relative;">  
	
<div style="display:none;width:150px;position:absolute;top:9px;left:340px;z-index:100000;" id="hideshowann"><input style="vertical-align:middle" type="checkbox" id="showann" checked><label class="editarea" style="padding-left:5px; cursor:default;" for="showann">Show Announcements</label></div>

	
	
    <div id="container" style="height: 500px; width: 755px"></div>
    </div>

    <div style="clear:both;height:20px;"></div>
				
    <div style=" width:996px; margin:auto;">
    	<div class="security-values">
          <div class="table-responsive"><table>
            <thead>
              <tr>
                <th><%
				If Year(tradedatetime) > 1980 Then
				Response.Write Day(tradedatetime) & "/" & Month(tradedatetime) & "/" & Year(tradedatetime)
				End If
				%></th>
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
                <th>Status</th>
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
                <td><%=FormatPrice(last,3)%></td>
                <td><%=FormatPrice(bid,3)%></td>
                <td><%=FormatPrice(bidqty,0)%></td>
                <td><%=FormatPrice(offer,3)%></td>
                <td><%=FormatPrice(offerqty,0)%></td>
                <td><%=FormatPrice(open,3)%></td>
                <td><%=FormatPrice(high,3)%></td>
                <td><%=FormatPrice(low,3)%></td>
                <td><%=FormatPrice(volume,0)%></td>
                <td><%=FormatPrice(marketcap,3)%></td>
                <td><%=FormatPrice(prvclose,3)%></td>
                <td><%=FormatPrice(dchange,3)%></td>
                <td><%=FormatPrice(ochange,3)%></td>
                <td><%=FormatPrice(pe,3)%></td>
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
    	<div class="b-o-t">

                  
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

            <div class="table-responsive"><table >
                <thead>
                  <tr class="header">
                    <th colspan="3"><p>BIDS</p></th>
                    <th colspan="3"><p>OFFERS</p></th>
                    <th colspan="6"><p>TRADES</p></th>
                  </tr>
                </thead>
                <tbody>
                 <tr class="sub-header alt">
                    <td align="right" width="50">ORDERS</td>
                    <td align="right" width="80">VOLUME</td>
                    <td align="right" width="50">PRICE $</td>
                    <td align="right" width="50">PRICE $</td>
                    <td align="right" width="80">VOLUME</td>
                    <td align="right" width="50">ORDERS</td>
                    <td align="right" width="150">TRADE DATE</td>
                    <td align="right" width="80">PRICE $</td>
                    <td align="right" width="80">VOLUME</td>
                    <td >BUYER</td>
					<td >SELLER</td>
					<td width="50"><a href="/investors/tradingcodes" title="view status codes">STATUS</a></td>
                  </tr>	
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
<tr <%=row_class%>>
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
%>
<td width="50" align="right"><%=depthParts(i+2)%></td>
<td width="80" align="right"><%=FormatNumber(depthParts(i+3),0)%></td>
<% if exchid = "SEQY" or exchid = "SRST" or exchid = "SBND" then%>
<td width="50" align="right"><%=FormatNumber((depthParts(i+1)/100),2)%></td>
<%else%>
<td width="50" align="right"><%=FormatNumber((depthParts(i+1)/1000),3)%></td>
<%end if%>
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
<td width="50">&nbsp;</td>
<td width="80">&nbsp;</td>
<td width="50">&nbsp;</td>
<% 
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
%>
<td width="50" class="orange" align="right"><%=FormatNumber((depthParts(i+1)/100),2)%></td>
<%else%>
<td width="50" class="orange" align="right"><%=FormatNumber((depthParts(i+1)/1000),3)%></td>
<%end if%>
<td width="80" class="orange" align="right"><%=FormatNumber(depthParts(i+3),0)%></td>
<td width="50" class="orange" align="right"><%=depthParts(i+2)%></td>
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
<td width="50" class="orange">&nbsp;</td>
<td width="80" class="orange">&nbsp;</td>
<td width="50" class="orange">&nbsp;</td>
<%
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
<td width="150" class="green" align="right" ><%=TradeDateTime%></td>
<td width="80" class="green" align="right"><%=FormatPrice(SalePrice,3)%></td>
<td width="80" class="green" align="right"><%=FormatPrice(SaleVolume,0)%></td>
<td class="green"  ><%=buyer%></td>
<td class="green"  ><%=seller%></td>
<td width="50" class="green"><%=status%></td>
</tr>
<%
  Else  
%>
<td width="150" class="green">&nbsp;</td>
<td width="80" class="green">&nbsp;</td>
<td width="80" class="green">&nbsp;</td>
<td class="green">&nbsp;</td>
<td class="green">&nbsp;</td>
<td width="50" class="green"><%=status%></td>
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
  End If 

%>

<%
if len(offexchangetrading_url) > 0 then
		
%>
 <br />
    <div style=" width:996px; margin:auto;"><!--Just a Table Container-->
    <!--Other exchange trading -->
	<div class="f-w-table">
	<div class="table-responsive"><table>
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
	</div>
<%
end if  ' end offexchangetrading_url test
%>
	
	




</div>


<!-- script type="text/javascript" src="charting/swfobject.js"></script -->

<div style="width:100%;clear:both;height:10px;"></div>

</div>


<!--#INCLUDE FILE="footer.asp"-->