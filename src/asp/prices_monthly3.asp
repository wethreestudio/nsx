<!--#INCLUDE FILE="include_all.asp"-->
<%
alow_robots = "no" ' long running script?
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">
<%
id = request.querystring("tradingcode")
%>
<h1><%=id%> Monthly Price History</h1>
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">


<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.

		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = ""
SQL = SQL & " SELECT	pm.[tradingcode] AS nsxcode,"
SQL = SQL & " (SELECT TOP 1 pc.IssueDescription FROM PricesCurrent pc WHERE pc.tradingcode = pm.[tradingcode]) AS coname, "
SQL = SQL & " pm.[trade_month] AS daily, "
SQL = SQL & " (SELECT TOP 1 spm.[last] FROM [prices_monthly] spm WHERE spm.tradingcode = pm.[tradingcode] AND spm.[trade_month] = pm.[trade_month] ORDER BY spm.tradedatetime ASC) AS [open],"
SQL = SQL & " MAX(pm.[last]) AS [high],"
SQL = SQL & " MIN(pm.[last]) AS [low],"
SQL = SQL & " (SELECT TOP 1 spm.[last] FROM [prices_monthly] spm WHERE spm.tradingcode = pm.[tradingcode] AND spm.[trade_month] = pm.[trade_month] ORDER BY spm.tradedatetime DESC) AS [last],"
SQL = SQL & " SUM(pm.[volume]) AS [volume],"
SQL = SQL & " 0 AS [change],"
SQL = SQL & " 0 AS [dailychange]"
SQL = SQL & " FROM [prices_monthly] AS pm"
SQL = SQL & " GROUP BY pm.tradingcode, pm.[trade_month]"
SQL = SQL & " HAVING (pm.tradingcode = '" & SafeSqlParameter(id) & "')  " & srch
SQL = SQL & " ORDER BY pm.tradingcode, pm.[trade_month] DESC" 

'response.write SQL
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	coname = alldata(1,0)
	If Len(coname) > 0 Then coname = replace(coname,"''","'")
Else
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


  
  <tr>
  
  
    <td class="pagetitle" bgcolor="#FFFFFFF">
	
		<%=ucase(coname)%>
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

	<p align="left">If there have been no trades in a security then the last 
	price used is the Issue or Nominal price on listing otherwise the last price 
	is the last traded price.&nbsp; </p>
	<p align="left">&nbsp;Page:
      <%if currentpage > 1 then %>
                <a href="prices_monthly.asp?tradingcode=<%=id%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="prices_monthly.asp?tradingcode=<%=id%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_monthly.asp?tradingcode=<%=id%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="prices_monthly.asp?tradingcode=<%=id%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>&nbsp; <a href="prices_definitions.asp">Table Definitions</a> 

</p>


<div class="table-responsive"><table border="0" cellspacing="0" width="100%" bgcolor="#FFFFFF" cellpadding="2" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
        <tr>
          <td valign="top" class="plaintext" align="left" bgcolor="#666666">
			<font color="#FFFFFF"><b>DATE</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LAST<br>
            $</b></font></td>
            <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>DAILY CHANGE<br>(last vs prv last)
            &nbsp;%</b></font></td>

          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>(last vs open)
            &nbsp;%</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OPEN<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>HIGH<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LOW<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>VOLUME<br>
            <font size="1">units</font></b></font></td>
        </tr>
        
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available.</td</tr>" 
    else
    dailyprice0 = 0 
    dailyprice1 = 0
    
    For ii = fh to st step -1
 
     	  open = alldata(3,ii)
      	  last = alldata(6,ii)

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
			alldata(8,ii)=change
			alldata(9,ii)=dailychange
    
    next  

       for jj = st to fh

      	  nsxcode = alldata(0,jj)
      	  coname = alldata(1,jj) 
      	  daily = alldata(2,jj)
      	  daily = monthname(month(daily)) & "-" & year(daily)
      	  open = alldata(3,jj)
      	  high = alldata(4,jj)
      	  low = alldata(5,jj)
      	  last = alldata(6,jj)
      	  volume = alldata(7,jj)
      	 change = alldata(8,jj)
      	 dailychange = alldata(9,jj) 
      	  

      	  
      	  if open = 0 then open = last
      	  if low = 0 then low = last
      	  if high = 0 then high = last
      	  
      	  if volume = 0 then open = 0
		 if volume = 0 then low = 0
		 if volume = 0 then high = 0

      	  
      	  if (open<>0) and (open > high) then high = open
		 if (open<>0) and (open < low) then low = open

      	  'if bid = 0 then bid = last
		 'if offer = 0 then offer = last

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
      	 
    

       
       if change > 0 and volume<>0 then 
          	img1 = "<img border=""0"" src=""images/up.gif"" align=""middle"">"
       	col2 = "green"
       
		elseif change < 0 and volume<>0 then
			img1="<img border=""0"" src=""images/down.gif"" align=""middle"">"
			col2 = "red"
		
		else
			col2 = "navy"
			img1 = "<img border=""0"" src=""images/v2/level.gif"" align=""middle"">"
		end if
		if change = 0 then 
			change = "-"
			else
			change = formatnumber(change,2) & "%"
		end if

' do the daily price change formatting
      	  
      	  if dailychange > 0 and volume<>0 then 
          	img2 = "<img border=""0"" src=""images/up.gif"" align=""middle"">"
       		col3 = "green"
       
		elseif dailychange < 0 and volume<>0 then
			img2="<img border=""0"" src=""images/down.gif"" align=""middle"">"
			col3 = "red"
		
		else
			col3 = "navy"
			img2 = "<img border=""0"" src=""images/v2/level.gif"" align=""middle"">"
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

		
cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
        <td   class="plaintext" align="left" valign="middle"><%=daily%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%=last%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><font color="<%=col3%>"><%=dailychange%><%=img2%></font>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><font color="<%=col2%>"><%=change%><%=img1%></font></td>
     <td  class="plaintext" align="right" valign="middle"><%=open%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%=high%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%=low%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%
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
     
      
        
    
      
      
      </table></div>



    </td>
    
  </tr>
</table></div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->