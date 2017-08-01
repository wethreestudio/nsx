<table class="tablesorter" style="width:100%">
<%

cr=vbCRLF
qu=""""
tb=","

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")

ConnPasswords.Open Application("nsx_ReaderConnectionString")

'daily version
'SQL = "SELECT TOP 5 PricesTrades.TradeDate,SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END), SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END), Count(PricesTrades.tradingcode),SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END)"
'SQL = SQL & " FROM PricesTrades"
'SQL = SQL & " WHERE exchid IN ('NCRP','NPRP','NDBT','NMIN','NRST','MAIN','PROP','COMM') " 
'SQL = SQL & " GROUP BY PricesTrades.TradeDate"
'SQL = SQL & " ORDER BY PricesTrades.TradeDate DESC"

' yearly version
SQL = " SELECT TOP 3 DATEPART(Year, [TradeDate]) AS TD, SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END)  AS Expr1, SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END) AS Expr2, Count(PricesTrades.tradingcode) AS CountOftradingcode, SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) AS Expr3"
SQL = SQL & " FROM PricesTrades"
SQL = SQL & " WHERE PricesTrades.[exchid] IN ('NCRP','NPRP','NDBT','NMIN','NRST','MAIN','PROP','COMM') " 
SQL = SQL & " GROUP BY DATEPART(Year, [TradeDate])"
SQL = SQL & " ORDER BY DATEPART(Year, [TradeDate]) DESC"

CmdDD.CacheSize = 100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
If Not WEOF then 
  alldata = cmddd.getrows
  rc = ubound(alldata,2) 
Else
  rc = -1
End If

CmdDD.Close
Set CmdDD = Nothing
If WEOF then 
  eml="No Change"
Else
  eml =  ""
  lap=0
  allyears = ""
  allvolume = ""
  allvalue = ""
  allaveprice = ""
  allvoltrades = ""
  allvaltrade = ""
  alltrades = ""
  allwithdrawn=""

  For jj = 0 To rc
    years = alldata(0,jj)
    volume = alldata(1,jj) 
    value = alldata(2,jj) 
    trades = alldata(3,jj)
    withdrawn = alldata(4,jj)
    trades = trades - 2 * withdrawn
    aveprice = value / volume
    voltrade = volume / trades
    valtrade = value / trades
    
    allyears = allyears  & years  & ","
    allvolume = allvolume  & volume  & ","
    allvalue = allvalue  & value  & ","
    allaveprice = allaveprice & aveprice  & ","
    allvoltrade = allvoltrade & voltrade  & ","
    allvaltrade = allvaltrade & valtrade & "," 
    alltrades = alltrades & trades  & "," 
    allwithdrawn = allwithdrawn & withdrawn & ","
		
  Next
	allyears = split(allyears,",")
	allvolume = split(allvolume,",")
	allvalue = split(allvalue,",")
	alltrades = split(alltrades,",")
	allaveprice = split(allaveprice,",")
	allvoltrade = split(allvoltrade,",")
	allvaltrade = split(allvaltrade,",")	
	allwithdrawn = split(allwithdrawn,",")		
	rc= ubound(allyears) - 1	

%>
    <thead> 
        <tr>
          <th style="text-align:left;">Year</th>
          <th style="text-align:right;">Number of Trades</th>
          <th style="text-align:right;">Volume</th>
          <th style="text-align:right;">Value</th>
          <th style="text-align:right;">Ave Price Per Share</th>
          <% ' <th>Volume per Trade No.</th> %>
          <th style="text-align:right;">Value per Trade $</th>
        </tr>
    </thead>
    <tbody>      
<%		
  For jj = 0 To rc
	c = " class=""odd"""
	If jj Mod 2 = 0 Then c = ""  
%>
        <tr<%=c%>>
          <td><%=allyears(jj)%></td>
          <td align="right"><%=alltrades(jj)%></td>
          <td align="right"><%=formatnumber(allvolume(jj),0)%></td>
          <td align="right"><%=formatnumber(allvalue(jj),0)%></td>
          <td align="right"><%=formatnumber(allaveprice(jj),3)%></td>
          <% '<td align="right">=formatnumber(allvoltrade(jj),0)</td> %>
          <td align="right"><%=formatnumber(allvaltrade(jj),0)%></td>
        </tr>
<%		  	
  Next 	   
End If
%> 	 
    </tbody>  
</table>