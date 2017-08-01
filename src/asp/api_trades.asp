<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

%>
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
		
		

	TXT = ""
	cr=vbCRLF
	'cr="<br>"
	qu=""""
	tb=","
	'tb=vbTAB
	srch = ""

datefrom=request("datefrom")
if isdate(datefrom) then
  datefrom = cdate(datefrom)
	srch = srch & " AND recorddatestamp>='" & FormatSQLDate(datefrom,false) & "'"
end if

dateto=request("dateto")
if isdate(dateto) then
  dateto = cdate(dateto)
	srch = srch & " AND recorddatestamp<='" & FormatSQLDate(dateto,false) & "'"
end if

nsxcode = trim(ucase(request("nsxcode")) & " ")
if len(nsxcode)=0 then
	response.write "need symbol"
	response.end
end if


	Set ConnPasswords = CreateObject("ADODB.Connection")
	Set CMDDD = CreateObject("ADODB.Recordset")
	  
	ConnPasswords.Open Application("nsx_ReaderConnectionString")
	
	
if nsxcode<>"" then
	Set CMDDD = CreateObject("ADODB.Recordset")
	' get valid trades for day
	SQL = "SELECT PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.SaleValue, PricesTrades.TradeDateTime, PricesTrades.SettleDate, StockCodes.StockName, BrokerBuyers.BrokerName AS Buyer, BrokerSellers.BrokerName AS Seller, PricesTrades.TradeNumber, pricestrades.adddelete "
	SQL = SQL & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
	SQL = SQL & "WHERE tradingcode='" & SafeSqlParameter(nsxcode) & "' " & srch
	SQL = SQL & "ORDER BY PricesTrades.TradeDateTime DESC, PricesTrades.TradeNumber DESC"
		
	'response.write SQL
	'response.end
	
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

	

  
  'TXT = TXT & qu & "Date" & qu & tb
  'TXT = TXT & qu & "Price" & qu & tb
  'TXT = TXT & qu & "Volume" & qu & tb
  'TXT = TXT & qu & "Value" & qu & tb
  'TXT = TXT & qu & "Buyer" & qu & tb
  'TXT = TXT & qu & "Seller" & qu & tb
  'TXT = TXT & qu & "TradingCode" & qu & tb
  'TXT = TXT & qu & "IssueDescription" & qu & tb
  'TXT = TXT & qu & "TradeNumber" & qu & tb
  'TXT = TXT & qu & "Status" & qu & cr
  
 
  	maxtrades=rc+1

  end if
  totprice = 0
  totvolume = 0
  totvalue = 0
  lap = 1
  cllap = 0
  cancel = 0
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

	withdrawn=alldata(9,jj)
	status = " "
	if withdrawn="D" then 
		value = -value
		volume = -volume
		lap = lap - 1
		price = -price
		status = "Cancelled"
		cancel = cancel + 1
	end if

		
	TXT = TXT & qu & cnvddmmyyyy(tradedatetime) & " " & formatdatetime(tradedatetime,3) & qu & tb
	TXT = TXT & price  & tb
  	TXT = TXT & volume & tb
  	TXT = TXT & value  & tb
  	TXT = TXT & qu & buyer & qu & tb
  	TXT = TXT & qu & seller & qu & tb
  	TXT = TXT & qu & nsxcode & qu & tb
  	TXT = TXT & qu & coname & qu & tb
  	TXT = TXT & qu & tradenumber & qu & tb
  	TXT = TXT & qu & status & qu & cr
	
	totprice=totprice + price
	totvolume = totvolume + volume
	totvalue = totvalue + value
	
	
		lap = lap + 1
	NEXT
		lap = lap - 1
		
		response.write TXT
	





%>