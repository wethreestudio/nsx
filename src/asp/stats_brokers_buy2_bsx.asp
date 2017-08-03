<div align==center>

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

SQL = "SELECT DATEPART(Year, TradeDate), BuyerId,  SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END),  SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END), Count(PricesTrades.prid) "
SQL = SQL & " FROM PricesTrades "
SQL = SQL & " WHERE (((PricesTrades.ExchID)='COMM' Or (PricesTrades.ExchID)='PROP' Or (PricesTrades.ExchID)='MAIN')) "
SQL = SQL & " GROUP BY DATEPART(Year, TradeDate), BuyerId "
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
<div class="table-responsive"><table cellspacing=0 border="0" width="165" id="table100" cellpadding="5" >
	<tr>
		<td class=plaintext bgcolor=#959CA0><font color="#FFFFFF"><b>Brokers (<%=choose%>)</b></font></td>
		<td class=plaintext bgcolor=#959CA0 align="right"><font color="#FFFFFF"><b>Trades (No.)</b></font></td>
		<td class=plaintext bgcolor=#959CA0 align=right><font color="#FFFFFF"><b>
		Buy.Vol ('000)</b></font></td>
		<td class=plaintext bgcolor=#959CA0 align=right><font color="#FFFFFF"><b>
		Buy.Val ('000)</b></font></td>
	</tr>
  
 <%
       FOR jj = 0 TO rc
      	  broker = trim(ucase(alldata(1,jj)) & " ")
      	  
      	  if broker = "4064" then broker = "ABN Amro"
      	  if broker = "7512" then broker = "Pritchards"
      	  if broker = "1132" then broker = "Camerons"
      	  if broker = "1135" then broker = "Camerons"
      	  if broker = "1543" then broker = "Bell Potter"
      	  if broker = "7502" then broker = "TSM"
      	  if broker = "2442" then broker = "Macquarie"
      	  if broker = "1134" then broker = "Camerons"
      	  if broker = "1782" then broker = "Findlay"
      	  if broker = "1212" then broker = "Reynolds"
		  if broker = "5128" then broker = "Taylor Collison"
		  if broker = "5129" then broker = "Taylor Collison"
		  if broker = "7550" then broker = "AAA Shares"
		  if broker = "7570" then broker = "Strategem"
		  if broker = "1056" then broker = "Westpac"
		  if broker = "1051" then broker = "Westpac"
		  if broker = "4094" then broker = "Burrell"
		  if broker = "7592" then broker = "Centre Capital"
		  if broker = "7582" then broker = "Freeman Fox"
		  if broker = "7547" then broker = "Martin Place"
		  		  if broker = "7560" then broker = "BGF Capital"
		  if broker = "3113" then broker = "ELC Baillieu Capital"

		  
		volume=alldata(2,jj)
		value=alldata(3,jj)
		trades=alldata(4,jj)

       	  
 		 
 	  	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
      
		<td class=plaintext ><font size="1"><%=broker%></font></td>
		<td class=plaintext align=right><font size="1"><%=formatnumber(trades,0)%></font></td>
		<td class=plaintext align=right><font size="1"><%=formatnumber(volume/1000,0)%></font></td>
		<td class=plaintext align=right><font size="1"><%=formatnumber(value/1000,0)%></font></td>
	</tr>
	
<%		  	
    	  NEXT
  
END IF
if len(eml)>0 then
	response.write "<tr><td class=plaintext><font size=1>" & eml & "</font></td></tr>"
end if


%>

</table></div>
</div>
