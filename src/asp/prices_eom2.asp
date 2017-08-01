<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' Display daily prices for a particular month by year.  Used for June, December, marcha nd September figures.
mth=request("m")
if len(mth)=0 then mth=6

alow_robots = "no" ' long running script?
page_title = "Prices EOM"


objCssIncludes.Add "table_sort_blue", "/css/table_sort_blue.css"

%>

<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">

<%

' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.
id = request.querystring("tradingcode")
coname = replace(request.querystring("coname") & " ","''","'")


mn = monthname(mth,false)
mn_len = Len(mn)
mn_fl = UCase(Left(mn, 1))
mn_rl = LCase(Right(mn, mn_len - 1))
%>

<h1><%=ucase(id)%> - <%=mn_fl & mn_rl%> Price History</h1>



<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1




		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT [tradingcode], CONVERT(varchar,[pricesdaily.tradedatetime],103) as daily, [open], [high], [low], [last], [volume], [bid], [offer],[last],[last]"
SQL = SQL & " FROM pricesdaily"
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') AND DATEPART(Month, tradedatetime)=" & mth
SQL = SQL & " ORDER BY tradingcode, [tradedatetime] DESC"


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
                <a href="prices_eom.asp?tradingcode=<%=id%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="prices_eom.asp?tradingcode=<%=id%>&currentpage=<%=currentpage-1%>&coname=<%=coname%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_eom.asp?tradingcode=<%=id%>&currentpage=<%=ii%>&coname=<%=coname%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="prices_eom.asp?tradingcode=<%=id%>&currentpage=<%=currentpage+1%>&coname=<%=coname%>">Next <%=maxpagesize%> 
	&gt;&gt;</a>
      <%end if%>&nbsp; | 
	  
<% End If %><a href="prices_definitions.asp">Table Definitions</a> |
      <a href="/download_trades.aspx?nsxcode=<%=id%>&amp;format=XLS">Download Trades as Excel</a> |
      <a href="/download_trades.aspx?nsxcode=<%=id%>&amp;format=CSV">Download Trades as CSV</a>
</p>

<table id="myTable" class="tablesorter" width="99%">
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
		<td colspan="10" style="background-color:#034579;color:#fff;font-weight:bold;"><%=yr%></td>
	</tr>
    <%end if%>
  <tr<%=cl(lap)%>>
	<td align="left" nowrap><%=fmtdate(daily)%>&nbsp;</td>
	<td align="right"><%=last%>&nbsp;</td>
	<td align="right"><span style="color:<%=col3%>"><%=dailychange%><%=img2%></span>&nbsp;</td>
	<td align="right"><span style="color:<%=col2%>"><%=change%><%=img1%></font>&nbsp;</td>
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
      
      </table>

</div>


</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->