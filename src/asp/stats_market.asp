<%@ LANGUAGE="VBSCRIPT" %>
<%
Response.Redirect "/marketdata/market_summary"
Response.End


Response.Buffer = False
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

%>

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NSX National Stock Exchange of Australia</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" style="background-color: #FFFFFF" >

<div align==center>
<table cellspacing=0 border="0" width="165" id="table100" cellpadding="5" >
	

<%


cr=vbCRLF
qu=""""
tb=","

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")


SQL = "SELECT TOP 2 DATEPART(Year, TradeDate), SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END), SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END),  Count(PricesTrades.prid),  SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) "
SQL = SQL & " FROM PricesTrades"
SQL = SQL & " WHERE (((PricesTrades.ExchID)='COMM' OR (PricesTrades.ExchID)='PROP' OR (PricesTrades.ExchID)='MAIN' OR (PricesTrades.ExchID)='NCRP' OR (PricesTrades.ExchID)='NPRP' OR (PricesTrades.ExchID)='NDBT' OR (PricesTrades.ExchID)='NMIN' OR (PricesTrades.ExchID)='NRST')) "
SQL = SQL & " GROUP BY DATEPART(Year, TradeDate) "
SQL = SQL & " ORDER BY DATEPART(Year, TradeDate) DESC"


'SQL = "SELECT TOP 2 DATEPART(Year, TradeDate), SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END), SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END),  Count(PricesTrades.prid),  SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) FROM PricesTrades WHERE (((PricesTrades.ExchID)='NCRP' Or (PricesTrades.ExchID)='NPRP' Or (PricesTrades.ExchID)='NDBT' Or (PricesTrades.ExchID)='NMIN' Or (PricesTrades.ExchID)='NRST')) GROUP BY DATEPART(Year, TradeDate) ORDER BY DATEPART(Year, TradeDate) DESC"
'response.write SQL & CR
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
IF WEOF THEN 
 eml="No Change"
ELSE
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
  
  
       FOR jj = 0 TO rc
      	  years = alldata(0,jj)
      	  volume = alldata(1,jj) 
      	  value = alldata(2,jj) 
      	  trades = alldata(3,jj)
      	  withdrawn = alldata(4,jj)
      	  trades = trades - withdrawn
      	  aveprice = value / volume
      	  voltrade = volume / trades
      	  valtrade = value / trades
      	  
      	 
 		 	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
	
		allyears = allyears  & years  & ","
		allvolume = allvolume  & volume  & ","
		allvalue = allvalue  & value  & ","
		allaveprice = allaveprice & aveprice  & ","
		allvoltrade = allvoltrade & voltrade  & ","
		allvaltrade = allvaltrade & valtrade & "," 
		alltrades = alltrades & trades  & "," 
		allwithdrawn = allwithdrawn & withdrawn & ","
		
			NEXT
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
 		  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext class=plaintext bgcolor=#959CA0 align=left><font color=white ><b>Market</b></font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext class=plaintext bgcolor=#959CA0 align=right><font color=white ><b><%=allyears(jj)%></b></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr>
    	  	<%lap = (-lap)+1%>
    	    <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext ><font size="1" align=right>Trades No.</font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext align=right><font size="1"><%=alltrades(jj)%></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr> 	<%lap = (-lap)+1%>
    	    <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext ><font size="1" align=right>Volume No.'000</font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext align=right><font size="1"><%=formatnumber(allvolume(jj)/1000000,3)%></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr> 	<%lap = (-lap)+1%>
    	  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext ><font size="1" align=right>Value $mill</font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext align=right><font size="1"><%=formatnumber(allvalue(jj)/1000000,3)%></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr> 	<%lap = (-lap)+1%>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext ><font size="1" align=right>Ave Price $</font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext align=right><font size="1"><%=formatnumber(allaveprice(jj),3)%></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr> 	<%lap = (-lap)+1%>
    	    <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext ><font size="1" align=right>Volume per Trade No.</font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext align=right><font size="1"><%=formatnumber(allvoltrade(jj),0)%></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr> 	<%lap = (-lap)+1%>
    	   <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
 		<td class=plaintext ><font size="1" align=right>Value per Trade $</font></td>
 		<%		
 			for jj = 0 to rc
%>
		<td class=plaintext align=right><font size="1"><%=formatnumber(allvaltrade(jj),0)%></font></td>
<%		  	
    	  NEXT  	  
    	  %> 	  
    	  	</tr>
    	  	
    	  	
    	  	<%
  
END IF
if len(eml)>0 then
	response.write "<tr><td class=plaintext><font size=1>" & eml & "</font></td></tr>"
end if


%>

    	  
    	  	
    	  	
    	  	</table>
</div>
</body>
</html>