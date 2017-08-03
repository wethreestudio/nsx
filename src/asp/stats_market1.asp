<%

%>
<html>
<head>
<title>NSX</title>
</head>
  <body>
    <div class="table-responsive"><table border="1" >
<%


cr=vbCRLF
qu=""""
tb=","

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")

SQL = "SELECT TOP 2 DATEPART(Year, TradeDate), SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END),  SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END), Count(PricesTrades.prid), SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) "
SQL = SQL & " FROM PricesTrades"
SQL = SQL & " WHERE (((PricesTrades.ExchID)='NCRP' Or (PricesTrades.ExchID)='NPRP' Or (PricesTrades.ExchID)='NDBT' Or (PricesTrades.ExchID)='NMIN' Or (PricesTrades.ExchID)='NRST')) "
SQL = SQL & " GROUP BY DATEPART(Year, TradeDate) "
SQL = SQL & " ORDER BY DATEPART(Year, TradeDate) DESC"


SQL = "SELECT TOP 2 DATEPART(Year, TradeDate), SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END), SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END),  Count(PricesTrades.prid),  SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) FROM PricesTrades WHERE (((PricesTrades.ExchID)='NCRP' Or (PricesTrades.ExchID)='NPRP' Or (PricesTrades.ExchID)='NDBT' Or (PricesTrades.ExchID)='NMIN' Or (PricesTrades.ExchID)='NRST')) GROUP BY DATEPART(Year, TradeDate) ORDER BY DATEPART(Year, TradeDate) DESC"
'response.write SQL & CR
'response.end

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
    trades = trades - withdrawn
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
      <tr>
        <td><b>Market</b>
        </td>
<%		
  For jj = 0 To rc
%>
        <td><b><%=allyears(jj)%></b></td>
<%		  	
  Next  	  
%> 	  
      </tr>
      <tr>
        <td>Trades No.</td>
<%		
  For jj = 0 To rc
%>
        <td><%=alltrades(jj)%></td>
<%		  	
  Next  	  
%> 	  
      </tr> 	
      <tr>
        <td>Volume No.'000</td>
<%		
  For jj = 0 To rc
%>
        <td><%=formatnumber(allvolume(jj)/1000000,3)%></td>
<%		  	
  Next 	  
%> 	  
      </tr> 	
      <tr>
        <td>Value $mill</td>
<%		
  For jj = 0 To rc
%>
		    <td><%=formatnumber(allvalue(jj)/1000000,3)%></td>
<%		  	
  Next 	  
%>  	  
      </tr>
      <tr>
        <td>Ave Price $</td>
<%		
  For jj = 0 To rc
%>
        <td><%=formatnumber(allaveprice(jj),3)%></td>
<%		  	
  Next 	  
%>  	  
      </tr> 	
      <tr>
        <td>Volume per Trade No.</td>
<%		
  For jj = 0 To rc
%>
        <td><%=formatnumber(allvoltrade(jj),0)%></td>
<%		  	
  Next 	  
%>  	  
      </tr>      
      <tr>
        <td>Value per Trade $</td>
<%		
  For jj = 0 To rc
%>
        <td><%=formatnumber(allvaltrade(jj),0)%></td>
<%		  	
  Next 	  
%>  	  
      </tr> 	  	
<%  
End If
%> 	
    </table></div>
  </body>
</html>