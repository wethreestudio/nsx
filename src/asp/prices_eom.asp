<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' Display daily prices for a particular month by year.  Used for June, December, march and September figures.
id = request.querystring("tradingcode")
coname = replace(request.querystring("coname") & " ","''","'")
Set regEx = New RegExp 
regEx.Pattern = "^[a-zA-Z0-9]+$" 
isCodeValid = regEx.Test(id) 
If Not isCodeValid Then
  Response.Redirect "/"
  Response.End
End If

'mth=request("mth")
'if len(mth)=0 then mth=6
'if not isnumeric(mth) then mth = 6

mth = trim(request("mth"))
if Not IsNumeric(mth) Or len(mth) = 0 Then
	mth=6
Else
	'mth=cint(mth)
	if mth<1 or mth>12 then mth=6
End If




alow_robots = "no" ' long running script?
page_title = "Prices EOM"


objCssIncludes.Add "table_sort_blue", "/css/table_sort_blue.css"

Function FormatPrice(p,d)
	If Len(p)>0 Then
		FormatPrice = FormatNumber(p,d)
	Else 
		FormatPrice = "-"
	End If
End Function


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



%>

<!--#INCLUDE FILE="header.asp"-->
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

' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.



mn = monthname(mth,false)
mn_len = Len(mn)
mn_fl = UCase(Left(mn, 1))
mn_rl = LCase(Right(mn, mn_len - 1))
%>

<h1><%=Server.HTMLEncode(ucase(id))%> - <%=coname%> - <%=mn_fl & mn_rl%> Month End Price History</h1>



<%

' multiple pages
currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If




		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
'SQL = "SELECT [tradingcode], CONVERT(varchar,[pricesdaily.tradedatetime],103) as daily, [open], [high], [low], [last], [volume], [bid], [offer],[last],[last]"
'SQL = SQL & " FROM pricesdaily"
'SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') AND DATEPART(Month, tradedatetime)=" & SafeSqlParameter(mth)
'SQL = SQL & " ORDER BY tradingcode, [tradedatetime] DESC"


SQL = "SELECT [tradingcode], REPLACE(CONVERT(VARCHAR(9), [pricesdaily].[tradedatetime], 6), ' ', '-') as daily, [open], [high], [low], [last], [volume], [bid], [offer],[last],[last]"
SQL = SQL & " FROM pricesdaily"
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') AND DATEPART(Month, [pricesdaily].[tradedatetime]) = " & SafeSqlParameter(mth) & " "
SQL = SQL & " ORDER BY tradingcode, tradedatetime DESC"

'response.write SQL
'response.end
CmdDD.CacheSize=103 
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
maxpagesize = 103
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc


%>




	<p align="left">If there have been no trades in a security then the last 
	price used is the Issue or Nominal price on listing otherwise the last price 
	is the last traded price.&nbsp; </p>
	<p align="left">
	
<%
If maxpages > 1 Then
%>Page:
      <%if currentpage > 1 then %>
                <a href="prices_eom.asp?mth=<%=mth%>&tradingcode=<%=id%>&currentpage=<%=currentpage-1%>">
	&lt;&lt;</a><a href="prices_eom.asp?mth=<%=mth%>&tradingcode=<%=id%>&currentpage=<%=currentpage-1%>&coname=<%=coname%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_eom.asp?mth=<%=mth%>&tradingcode=<%=id%>&currentpage=<%=ii%>&coname=<%=coname%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="prices_eom.asp?mth=<%=mth%>&tradingcode=<%=id%>&currentpage=<%=currentpage+1%>&coname=<%=coname%>">Next <%=maxpagesize%> 
	&gt;&gt;</a>
      <%end if%>&nbsp; | 
	  
<% End If %><div ><strong>Download Daily Price Table</strong>
       <a href="/download_dailyprices.aspx?nsxcode=<%=id%>&amp;format=XLS" class="blue-link">Excel</a> 
       <a href="/download_dailyprices.aspx?nsxcode=<%=id%>&amp;format=CSV" class="blue-link">CSV</a>
	   <a href="prices_definitions.asp" class="">Definitions</a><br><br>
	   <strong>Choose a month end: </strong>
	   <%for iii = 1 to 12	
		if iii <> cint(mth) then %>
		<a href="prices_eom.asp?mth=<%=iii%>&tradingcode=<%=id%>&currentpage=<%=ii%>&coname=<%=coname%>" ><%=monthname(iii,1)%>&nbsp;</a>
		<%else
			response.write "<strong>" & monthname(iii,1) & "</strong>"
			end if%>
		<%next%>
	   
	   </div><br>

<div class="table-responsive"><table id="myTable" class="tablesorter" width="99%">
<thead>
        <tr>
          <th valign="top" align="left">Date<br>&nbsp;</th>
		  <th valign="top" align="right">Last<br>$</th>
		  <th valign="top" align="right">Daily Change<br>(last vs prv last)&nbsp;%</th>
		  <th valign="top" align="right">Change<br>(last vs prv last)&nbsp;%</th>
		  <th valign="top" align="right">Bid<br>&nbsp;</th>
		  <th valign="top" align="right">Ask<br>&nbsp;</th>
		  <th valign="top" align="right">Open<br>&nbsp;</th>
		  <th valign="top" align="right">High<br>&nbsp;</th>
		  <th valign="top" align="right">Low<br>&nbsp;</th>
		  <th valign="top" align="right">Volume<br>&nbsp;</th>
        </tr>
		</thead>
       <tbody> 
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available.</td</tr>" 
    else
    
    dailyprice0 = 0 
    dailyprice1 = 0
    yr = 0
    
    
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
          	img1 = "<img border=""0"" src=""/images/up.gif"" alt="""" style=""vertical-align:middle"">"
       	col2 = "green"
       
		elseif change < 0 and volume<>0 then
			img1="<img border=""0"" src=""/images/down.gif"" alt="""" style=""vertical-align:middle"">"
			col2 = "red"
		
		else
			col2 = "navy"
			img1 = "<img border=""0"" src=""/images/v2/level.gif"" alt="""" style=""vertical-align:middle"">"
		end if
		if change = 0 then 
			change = "-"
			else
			change = formatnumber(change,2) & "%"
		end if
	
      	  
      	  ' do the daily price change formatting
      	  
      	  	
      	  if dailychange > 0 and volume<>0 then 
          	img2 = "<img border=""0"" src=""/images/up.gif"" alt="""" style=""vertical-align:middle"">"
       		col3 = "green"
       
		elseif dailychange < 0 and volume<>0 then
			img2="<img border=""0"" src=""/images/down.gif"" alt="""" style=""vertical-align:middle"">"
			col3 = "red"
		
		else
			col3 = "navy"
			img2 = "<img border=""0"" src=""/images/v2/level.gif"" alt="""" style=""vertical-align:middle"">"
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

	
		
		
   cl = array(" class=""odd"""," class=""even""")
	lap = (-lap)+1
				
    %>
    
    <%if yr <> year(daily) then
    	yr = year(daily)
    %>
    <tr>
		<td colspan="10" style="font-weight:bold;"><%=yr%></td>
	</tr>
    <%end if%>
  <tr<%=cl(lap)%>>
	<td align="left" nowrap><%=fmtdate(daily)%>&nbsp;</td>
	<td align="right"><%=last%>&nbsp;</td>
	<td align="right"><span style="color:<%=col3%>"><%=dailychange%><%=img2%></span>&nbsp;</td>
	<td align="right"><span style="color:<%=col2%>"><%=change%><%=img1%></span>&nbsp;</td>
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

</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->