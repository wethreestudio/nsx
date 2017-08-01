<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<!--#INCLUDE FILE="company_check_exchid_v2.asp"-->
<!--#INCLUDE FILE="member_check_v2.asp"-->

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=exchname%></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="ROBOTS" content="INDEX">
<meta http-equiv="Expiry" content="0">
<meta http-equiv="expires" content="0">
<meta name="description" content="The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies.">
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle,enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<%select case exchid
	case "NSX"
	%>
	<link rel=stylesheet href="newsx2.css" type="text/css">
<% case "SIMV"%>
	<!--#file = "include/common/stylesheets.asp" -->
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% case else %>
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% end select%>

<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<% if len(exchid)<>0 then server.execute "company_header_v2_" & exchid & ".asp"%>
<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" rowspan="3" bgcolor="#FFFFFF" width="175"><%if len(exchid)<>0 then server.execute "company_lmenu_v2_" & exchid & ".asp"%>
		</td>
	</tr>
	<tr>
		<td class="textheader" bgcolor="#FFFFFF" >
		
			<h1>&nbsp;</h1>
			<h1><font face="Arial">SECURITY TRADING HISTORY - </font> <b><i> &nbsp;</i></b></h1>
		</td>
	</tr>
	<tr>
		<td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">

<%

CSV = ""

Function cnvtime(xx)
 	' convert signal c time into windows time
	'hhmmss <--> hh:mm:ss
	hh = left(xx,2)
	ss = right(xx,2)
	mm = mid(xx,3,2)
	cnvtime = hh & ":" & mm & ":" & ss
	cnvtime = timeserial(hh,mm,ss)
end function

Function cnvdate(xx)
' convert yyyymmdd <---> windows date
yyyy = left(xx,4)
mm = mid (xx,5,2)
dd = right(xx,2)
'response.write xx & "<br>"
cnvdate=dateserial(yyyy,mm,dd)
End Function

Function cnvddmmyyyy(xx)
' convert dates in dd-mmm-yyyy format
dd = day(xx)
mm = monthname(month(xx),1)
yy = year(xx)
cnvddmmyyyy = dd &"-"& mm & "-" & yy
End Function
		
		
todayfile = request.form("validdates")
'nsxcode = session("nsxcode")
nsxcodes = request("nsxcodes")

group = request("group")
if group = "yes"  then
	srchgrp="left(tradingcode,3)"
	else
	srchgrp="left(tradingcode,3)"
end if


' construct search for multiple codes.
srch = " WHERE "
if len(nsxcodes)<>0 then
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " "
	nsxcode=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcode)
		srch = srch & "(" & srchgrp & "='" & nsxcode(jj) & "') OR "
	next
	srch = left(srch,len(srch)-4)
		
end if

board=ucase(trim(request("board")))
if len(board)<>0 then srch = srch & " AND (coissues.displayboard LIKE '" & board & "') "



	Set ConnPasswords = CreateObject("ADODB.Connection")
	Set CMDDD = CreateObject("ADODB.Recordset")
	 
	ConnPasswords.Open Application("nsx_ReaderConnectionString")
	' get valid codes
	SQL = "SELECT DISTINCT tradingcode FROM pricestrades "
	SQL = SQL & srch
	SQL = SQL & "ORDER by tradingcode"
	CMDDD.Open SQL,Connpasswords
	%>
	
	<form method="POST" name="dates" action="company_trades_v2.asp?nsxcodes=<%=nsxcodes%>">
	
	<%
	
if not CMDDD.EOF then
	
	response.write "<h2>Please select an NSX Code to view details</h2>"
	aa = "<SELECT size=1 name=validdates>"
	
	while not CMDDD.EOF
	SecCode = trim(cmddd("tradingcode"))
		aa=aa & "<option value=" & SecCode 
		if todayfile = SecCode then aa = aa &  " SELECTED "
		aa = aa & ">" & SecCode & "</option>"
		CMDDD.Movenext
	wend	
		aa=aa &  "</SELECT>&nbsp;<input type=submit value='Get Trades' name=B1>"
		response.write aa
else
		response.write "<b>No trading records are available.</b>"

end if


%>
	
	</form>
	


	

<%
CMDDD.Close
Set CMDDD= Nothing

if todayfile<>"" then
	Set CMDDD = CreateObject("ADODB.Recordset")
	SQL = "SELECT PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.SaleValue, PricesTrades.TradeDateTime, PricesTrades.SettleDate, StockCodes.StockName, BrokerBuyers.BrokerName AS Buyer, BrokerSellers.BrokerName AS Seller, PricesTrades.TradeNumber, pricestrades.adddelete "
	SQL = SQL & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
	SQL = SQL & "WHERE tradingcode='" & SafeSqlParameter(todayfile) & "' "
	SQL = SQL & "ORDER BY PricesTrades.TradeDateTime DESC, PricesTrades.TradeNumber DESC"
	
	CMDDD.Open SQL,Connpasswords,1,3

	WEOF = CmdDD.EOF
	
	if not WEOF then 
		alldata = cmddd.getrows
		rc = ubound(alldata,2) 
	else
		rc = -1
	end if

	CmdDD.Close
	Set CmdDD = Nothing

	
	TXT = ""
	cr=vbCRLF
	qu=""""
	'tb=","
	tb=vbTAB
	
	ppath = Server.MapPath("ftp/profiles/" & "company_" & todayfile & ".xls")
		%>
		<img border="0" src="images/broker_page1_bullet.gif" width="20" height="15"><a href="ftp/profiles/company_<%=todayfile%>.xls" target=_blank>Right click to save file to disk or left click to view</a>

<div align="center">
<table border="0" style="border-collapse: collapse" width="550" cellpadding="0" cellspacing="1">
  <tr>
  <td class="plaintext" bgcolor="#666666" colspan=9><font color="#FFFFFF"><b><%=coname & " (" & todayfile & ")"%></b></font></td>
  </tr>
  
  <tr>
     <td nowrap class="plaintext" bgcolor="#666666" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Code</b></font></td>
   <td nowrap class="plaintext" bgcolor="#666666" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Date/Time</b></font></td>
    <td class="plaintext" bgcolor="#666666" align="right" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Price $ </b> 
	</font> </td>
    <td class="plaintext" bgcolor="#666666" align="right" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Volume</b></font></td>
    <td class="plaintext" bgcolor="#666666" align="right" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Value $</b></font></td>
   
    <td class="plaintext" bgcolor="#666666" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Buyer</b></font></td>
    <td class="plaintext" bgcolor="#666666" style="border: 1px solid #666666"><font color="#FFFFFF"><b>Seller</b></font></td>
    
    <td class="plaintext" bgcolor="#666666" style="border: 1px solid #666666">
	<font color="#FFFFFF"><b>Trade Number</b></font></td>
        <td class="plaintext" bgcolor="#666666" style="border: 1px solid #666666">
	<font color="#FFFFFF"><b>Trade Status</b></font></td>
  </tr>
  <%
  
  TXT = TXT & qu & "Date" & qu & tb
  TXT = TXT & qu & "Price" & qu & tb
  TXT = TXT & qu & "Volume" & qu & tb
  TXT = TXT & qu & "Value" & qu & tb
  TXT = TXT & qu & "Buyer" & qu & tb
  TXT = TXT & qu & "Seller" & qu & tb
  TXT = TXT & qu & "TradingCode" & qu & tb
  TXT = TXT & qu & "IssueDescription" & qu & tb
  TXT = TXT & qu & "TradeNumber" & qu & tb
  TXT = TXT & qu & "TradeStatus" & qu & cr
  
  
  totprice = 0
  totvolume = 0
  totvalue = 0
  lap = 1
  cllap = 0
  
	for jj = 0 to rc
	price=alldata(0,jj)
	Volume=alldata(1,jj)
	Value=alldata(2,jj)
	tradedatetime=alldata(3,jj)
	settledate=alldata(4,jj)
	coname=alldata(5,jj)
	buyer=alldata(6,jj)
	seller=alldata(7,jj)
	tradenumber=alldata(8,jj)
	tradestatus=alldata(9,jj)
	
	cl = array("#EEEEEE","#FFFFFF")
	clap = (-clap)+1
	
	withdrawn=alldata(9,jj)
	if withdrawn="D" then 
		value = -value
		volume = -volume
		lap = lap - 1
		price = -price
	end if

				
    %>
  <tr bgcolor="<%=cl(clap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(clap)%>'">
       <td nowrap class="texthint" style="border: 1px solid #666666"><%=todayfile%></td>
     <td nowrap class="texthint" style="border: 1px solid #666666"><%=cnvddmmyyyy(tradedatetime) & " " & formatdatetime(tradedatetime,3)%></td>
    <td nowrap class="texthint" align=right  style="border: 1px solid #666666"><%=price%>&nbsp;</td>
    <td nowrap class="texthint" align=right style="border: 1px solid #666666"><%=formatnumber(volume,0)%>&nbsp;</td>
    <td nowrap class="texthint" align=right style="border: 1px solid #666666"><%=formatnumber(value,2)%>&nbsp;</td>
    
    <td nowrap class="texthint"  style="border: 1px solid #666666"><%=buyer %>&nbsp;</td>
    <td nowrap class="texthint" style="border: 1px solid #666666"><%=seller %>&nbsp;</td>
    <td nowrap class="texthint" style="border: 1px solid #666666"><%=tradenumber%></td>
    <td nowrap class="texthint" style="border: 1px solid #666666"><%=tradestatus%></td>
  </tr>
  
	<%
	TXT = TXT & qu & cnvddmmyyyy(tradedatetime) & " " & formatdatetime(tradedatetime,3) & qu & tb
	TXT = TXT & price  & tb
  	TXT = TXT & volume & tb
  	TXT = TXT & value  & tb
  	TXT = TXT & qu & buyer & qu & tb
  	TXT = TXT & qu & seller & qu & tb
  	TXT = TXT & qu & todayfile & qu & tb
  	TXT = TXT & qu & coname & qu & tb
  	TXT = TXT & qu & tradenumber & qu & tb
  	TXT = TXT & qu & tradestatus & qu & cr
	
	totprice=totprice + price
	totvolume = totvolume + volume
	totvalue = totvalue + value
	
	
		lap = lap + 1
	NEXT
		lap = lap - 1
	%>
	<tr>
    <td class="plaintext" colspan="7"><b>Total Trades: </b><%=Lap%>&nbsp;<br>
	<b>Average Price: </b>$<%
	if totvolume <> 0 then 
	 response.write formatnumber(totvalue/totvolume,2)
	 else
	 response.write "-"
	 end if
	 %>&nbsp;<br>
	<b>Total Volume:</b> <%=formatnumber(totvolume,0)%>&nbsp;securities<br>
	<b>Total Value:</b> $<%=formatnumber(totvalue,2)%>&nbsp;</td>
  </tr>

	</table>
</div>
<p>
<%

' create company trade file for download PRN/TXT style file for inport into excel.
'response.write ppath & "<br>"
Set MyFileObject=CreateObject("Scripting.FileSystemObject")
Set MyTextFile=MyFileObject.CreateTextFile(ppath)
MyTextFile.Write TXT
MyTextFile.Close
Set MyTextFile = nothing
Set TXT = nothing



end if

		
	
ConnPasswords.Close
Set ConnPasswords = Nothing

%>    </td>
</table>
</div>
<% if len(exchid)<>0 then server.execute "company_footer_v2_" & exchid & ".asp"%>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>



</body>

</html>