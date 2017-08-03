<%
cr=vbCRLF
qu=""""
tb=","
choose = request("choose")
if len(choose)=0 then choose = Year(Date())
choose=session("choose")
if len(choose)=0 then choose = Year(Date())
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")

SQL = "SELECT DATEPART(Year, TradeDate), SellerId,  SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END),  SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END), Count(PricesTrades.prid) "
SQL = SQL & " FROM PricesTrades "
'SQL = SQL & " WHERE (PricesTrades.ExchID)='NCRP' Or (PricesTrades.ExchID)='NDBT' Or (PricesTrades.ExchID)='NPRP' Or (PricesTrades.ExchID)='NMIN' Or (PricesTrades.ExchID)='NRST' or (PricesTrades.ExchID)='COMM' or (PricesTrades.ExchID)='PROP' or (PricesTrades.ExchID)='MAIN'"
SQL = SQL & " WHERE (PricesTrades.[exchid] IN ('NCRP','NPRP','NDBT','NMIN','NRST','MAIN','PROP','COMM')) " 
SQL = SQL & " GROUP BY DATEPART(Year, TradeDate), SellerId "
SQL = SQL & " HAVING DATEPART(Year, TradeDate)=" & choose & " "
SQL = SQL & " ORDER BY Count(prid) DESC"


'response.write SQL & CR
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
IF WEOF THEN 
 eml="No Change"
ELSE
    	eml =  ""
  lap=0
  
%>
<div class="table-responsive"><table id="myTable2" class="tablesorter" width="90%"> 
<thead>
	<tr>
		<th align="left">Brokers (<%=choose%>)</th>
		<th  align="right">Trades (No.)</th>
		<th align="right">Sell Volume (No.)</th>
		<th align="right">Sell Value ($)</th>
	</tr>
</thead>
<tbody>  
 <%
       FOR jj = 0 TO rc
      	  broker = trim(ucase(alldata(1,jj)) & " ")
      	  
      	  if broker = "4064" then broker = "Morgans Financial"
      	  if broker = "7512" then broker = "Pritchards"
      	  if broker = "1132" then broker = "Camerons"
      	  if broker = "1135" then broker = "OpenMarkets"
      	  if broker = "1543" then broker = "Bell Potter"
      	  if broker = "7502" then broker = "TSM"
      	  if broker = "2442" then broker = "Macquarie"
      	  if broker = "1134" then broker = "OpenMarkets"
      	  if broker = "1782" then broker = "Findlay"
      	  if broker = "1212" then broker = "Reynolds"
		  if broker = "5128" then broker = "Taylor Collison"		  
		  if broker = "5129" then broker = "Taylor Collison"
		  if broker = "5127" then broker = "Taylor Collison"
		  if broker = "7550" then broker = "AAA Shares"
		  if broker = "7570" then broker = "Strategem"
		  if broker = "1056" then broker = "Westpac"
		  if broker = "1051" then broker = "Westpac"
		  if broker = "4094" then broker = "Burrell"
		  if broker = "7592" then broker = "Centre Capital"
		  'if broker = "7582" then broker = "Freeman Fox"
		  if broker = "7582" then broker = "Leyland"
		  if broker = "7547" then broker = "Martin Place"
		  if broker = "7560" then broker = "Canaccord"
		  if broker = "3113" then broker = "Baillieu"
		  if broker = "6046" then broker = "DJ Carmichaels"
		  if broker = "6776" then broker = "Patersons"
		  if broker = "6777" then broker = "Patersons"
		  if broker = "2339" then broker = "Ord Minnett"
		  if broker = "2982" then broker = "Shaw"
		  if broker = "7572" then broker = "Dayton Way"
		  if broker = "7532" then broker = "Triple C"
		  if broker = "2922" then broker = "Phillip Capital"
		  if broker = "1792" then broker = "Pershing"
		  if broker = "1791" then broker = "Pershing"
		  if broker = "7534" then broker = "CPS Capital"
		  if broker = "1242" then broker = "APP Securities"

		  
		volume=alldata(2,jj)
		value=alldata(3,jj)
		trades=alldata(4,jj)

       	  
 		 
   cl = array("odd","even")
	lap = (-lap)+1
				
    %>
  <tr class="<%=cl(lap)%>" >       
		<td  align=left><%=broker%></td>
		<td align=right><%=formatnumber(trades,0)%></font></td>
		<td align=right><%=formatnumber(volume,0)%></td>
		<td  align=right><%=formatnumber(value,0)%></td>
	</tr>	
<%		  	
    	  NEXT
  
END IF
if len(eml)>0 then
	response.write "<tr><td>" & eml & "</td></tr>"
end if


%>
</tbody>
</table></div>
<p>&nbsp;</p>
