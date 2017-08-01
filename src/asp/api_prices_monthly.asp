<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%Server.ScriptTimeout=360%>
<%
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"
function fmtDate(val)
' standard date display
val = cdate(val) 
yr = year(val)
if yr < 1000 then yr = yr + 2000
dy = day(val)
mt = monthname(month(val),1)
fmtDate = dy & "-" & mt & "-" & yr 
end function

function fmtmth(val)
' standard date display
val = cdate(val) 
yr = year(val)
if yr < 1000 then yr = yr + 2000
dy = day(val)
mt = monthname(month(val),1)
fmtmth =  mt & "-" & yr 
end function
%>


<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1
datefrom=request("datefrom")
srch = ""


datefrom=request("datefrom")
if isdate(datefrom) then
  datefrom = cdate(datefrom)
	srch = srch & " AND pricesdaily.tradedatetime>='" & FormatSQLDate(datefrom,false) & "'"
end if

dateto=request("dateto")
if isdate(dateto) then
  dateto = cdate(dateto)
	srch = srch & " AND pricesdaily.tradedatetime<='" & FormatSQLDate(dateto,false) & "'"
end if

' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.
id = request.querystring("nsxcode")
if len(id)=0 then
	response.write "need symbol"
	response.end                                                                         S
end if
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = ""
SQL = SQL & " SELECT	pm.[tradingcode] AS nsxcode,"
SQL = SQL & " '' AS coname, "  ' (SELECT TOP 1 pc.IssueDescription FROM PricesCurrent pc WHERE pc.tradingcode = pm.[tradingcode]) AS coname, "
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
SQL = SQL & " ORDER BY pm.tradingcode, pm.[trade_month] ASC" 


SQL = ""
SQL = "SELECT [tradingcode] AS nsxcode,[coname],[month_start] AS daily,[open_price] AS [open],[high_price] AS [high],[low_price] AS [low],[last_price] AS [last],[volume] "
SQL = SQL & ",0 AS [change], 0 AS [dailychange] "
SQL = SQL & "FROM [nsx].[dbo].[PricesMonthly1] "
SQL = SQL & "WHERE tradingcode='" & SafeSqlParameter(id) & "' "
SQL = SQL & " ORDER BY tradingcode, [month_start] DESC" 

'response.write SQL
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	coname = replace(alldata(1,0),"''","'")
	else
	rc = -1
end if

CmdDD.Close
Set CmdDD = Nothing

ConnPasswords.Close
Set ConnPasswords = Nothing

 
 cr=vbCRLF
 'cr="<br>"
	qu=""""
	tb=","
        eml = ""
    if WEOF then 
    	eml = eml & "No records available."  
    else
    
    dailyprice0 = 0 
    dailyprice1 = 0
    
   For ii = rc to 0 step -1
   'For ii = 0 to rc 
 
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

       for jj = 0 to rc

      	  nsxcode = alldata(0,jj)
      	  coname = alldata(1,jj) 
      	  daily = alldata(2,jj)
      	  daily = fmtmth(daily)
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

			change = formatnumber(change,2) & "%"
			dailychange = formatnumber(dailychange,2) & "%"

	
 eml = eml & qu & daily & qu & tb
 eml = eml & last  & tb
  eml = eml & qu & dailychange & qu & tb
  eml = eml & qu & change & qu & tb
 
    eml = eml & open  & tb
    eml = eml & high  & tb
     eml = eml & low  & tb
     eml = eml & volume  
     eml = eml & cr
      
     	
     	
    	
    	  NEXT
    end if
    response.write eml
    
%>