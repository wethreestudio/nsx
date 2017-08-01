<!--#INCLUDE FILE="include/sql_functions.asp"-->
<%
function fmtDate(val)
' standard date display
val = cdate(val) 
yr = year(val)
if yr < 1000 then yr = yr + 2000
dy = day(val)
mt = monthname(month(val),1)
fmtDate = dy & "-" & mt & "-" & yr 
end function



' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

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
id = request.querystring("nsxcode")
coname = replace(request.querystring("coname") & " ","''","'")
if len(id)=0 then
	response.write "need symbol"
	response.end
end if
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT [tradingcode], DATEADD(dd, 0, DATEDIFF(dd, 0, tradedatetime)) as daily, [open], [high], [low], [last], [volume], [bid], [offer],[last],[last]"
SQL = SQL & " FROM pricesdaily"
'SQL = SQL & " GROUP BY pricesdaily.tradingcode, DATEADD(dd, 0, DATEDIFF(dd, 0, tradedatetime)) "
SQL = SQL & " WHERE (tradingcode='" & SafeSqlParameter(id) & "') " & srch
SQL = SQL & " ORDER BY tradingcode, DATEADD(dd, 0, DATEDIFF(dd, 0, tradedatetime)) ASC"


'response.write SQL
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

ConnPasswords.Close
Set ConnPasswords = Nothing




%>
        
       
        <%
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
    
    
    For ii = rc  to 0 step -1
 
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
    
       for jj = 0 to rc

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
     	 
  
	
			change = formatnumber(change,2) & "%"
		
			dailychange = formatnumber(dailychange,2) & "%"
		
	
		
	'eml = eml & qu & nsxcode & qu & tb	
 eml = eml & qu & fmtdate(daily) & qu & tb
 eml = eml & last  & tb
  eml = eml & qu & dailychange & qu & tb
  eml = eml & qu & change & qu & tb
  eml = eml & bid  & tb
   eml = eml & ask  & tb
    eml = eml & open  & tb
    eml = eml & high  & tb
     eml = eml & low  & tb
     eml = eml & volume  
     eml = eml & cr
      
     	
     	
    	
    	  NEXT
    end if
    response.write eml
    %>
     
      
  