<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=360%>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

' Replace single quotes in text before inserting in DB
Function RepAP(str)
         RepAP = Replace(str & " ", "'", "''")

   
End Function

daylightsaving=0
if application("nsx_daylight_saving")=true then
	daylightsaving = 1/24
	else
	daylightsaving = 0
end if

Function cnvddmmyyyy(xx)
' convert dates in dd-mmm-yyyy format
dd = day(xx)
mm = monthname(month(xx),1)
yy = year(xx)
cnvddmmyyyy = dd &"-"& mm & "-" & yy
End Function

DATA_PATH = Server.Mappath("newsxdb\nsxprices.mdb")
' multiple pages
traded = request("traded")
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1
' exch id
board=ucase(trim(request("board") & " "))
' regional display "region"
displayboard=ucase(trim(request("region") & " "))
active=ucase(request("active"))
if len(active)=0 then
	srch = " WHERE (issuestatus = 'Active') "
	else
	srch = " WHERE (issuestatus <> 'DELISTED' and issuestatus<>'PENDING' and issuestatus<>'SUSPENDED') "
end if
if len(displayboard)<>0 then
	srch = "  "
end if





' display todays prices
' if multiple codes requested then restrict by that otherwise ALL codes.
nsxcodes=ucase(trim(request("nsxcode") & " "))


' construct search for multiple codes.
if len(nsxcodes)<>0 then
	tradingcodes=nsxcodes
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = srch & " AND "
	nsxcodes=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcodes)
		srch = srch & "(left(tradingcode,3)='" & left(nsxcodes(jj),3) & "') OR "
	next
	srch = left(srch,len(srch)-4)
	srch = srch & " "
end if

' fudge until trading engine boards align.
If len(traded) > 0 then pagetitle="TRADED TODAY"
extracodes = ""
delcodes= ""
select case board

case "NCRP"
	pagetitle="INDUSTRIAL SECURITIES"
	extracodes = "" ' add extra codes to display
	delcodes = "FMI,LGP,MGS,MMT,PMI,TMH,AFOA,PFB,PIN" ' remove extra codes to display
case "NDBT"
	pagetitle="DEBT SECURITIES"
	extracodes = ""
	delcodes = ""

case "NMIN"
	pagetitle="MINING & ENERGY SECURITIES"
	extracodes = "FMI,LGP,MGS,MMT,PMI,TMH"
	delcodes = ""

case "NRST"
	pagetitle="RESTRICTED SECURITIES"
	extracodes = "AFOA"
	delcodes = ""
	
case "NPRP"
	pagetitle="PROPERTY SECURITIES"
	extracodes = "PIN,VER"
	delcodes = ""

case "COMM"
 	pagetitle="COMMUNITY SECURITIES - CERTIFICATED"
 	extracodes = ""
 	delcodes = ""

case "MAIN"
	pagetitle="INDUSTRIAL SECURITIES - CERTIFICATED"
	extracodes = ""
	delcodes = ""

case "PROP"
	pagetitle="PROPERTY SECURITIES - CERTIFICATED"
	extracodes = ""
	delcodes = ""
	
case "SIMV"
	pagetitle="SIM Venture Securities"
	extracodes = ""
	delcodes = ""
	
case else
	delcodes = ""
	extracodes = ""
end select
If len(board) = 0 and len(traded) = 0 and len(nsxcode)=0 then pagetitle="ALL SECURITIES"

if len(board)<>0 then
	srch = srch & " AND ((pricescurrent.exchid='" & board & "') "
	' fudge until trading engine boards align
	if extracodes <> "" then
		srch = srch & " OR "
		extracodes=split(extracodes,",")
		for jj = 0 to ubound(extracodes)
			srch = srch & "(left(tradingcode,3)='" & left(extracodes(jj),3) & "') OR "
		next
		srch = left(srch,len(srch)-4)
		srch = srch & " "
	end if
	srch = srch & ") "
	' remove codes from display
	if delcodes <> "" then
		srch = srch & " AND ((issuestatus = 'active') AND ("
		delcodes =split(delcodes,",")
		for jj = 0 to ubound(delcodes)
			srch = srch & "(left(tradingcode,3)<>'" & left(delcodes(jj),3) & "') OR "
		next
		srch = left(srch,len(srch)-4)
		srch = srch & ")) "
	end if
end if 


if len(displayboard)<>0 then
	srchregion = " WHERE ((pricescurrent.displayboard) like '%" & displayboard & "%') "
end if 
if len(traded)<>0 then
	srch = srch & " AND (pricescurrent.volume>0) "
end if 
if len(tradingcodes)=0 then srch = srch & " AND (pricescurrent.exchid<>'SIMV') "
'response.write srch & "<BR>"
'response.write request.servervariables("QUERY_STRING")
'response.end

' get date for latest prices
strConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DATA_PATH 
'strConnString = "Provider=MS Remote; Remote Server=203.147.129.66; Remote Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & DATA_PATH
 
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open "DBQ=" & DATA_PATH &   ";Driver={Microsoft Access Driver (*.mdb)};UID=" & ConnPasswords_RuntimeUserName & ";PASSWORD=" & ConnPasswords_RuntimePassword
ConnPasswords.Open strConnString 
SQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],[sessionmode],[marketdepth],[quotebasis],[prvclose],[currenteps],[currentdps],[currentnta] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL &  srchregion & srch 
SQL = SQL & " ORDER BY tradingcode ASC"
'response.write SQL & "<BR>"
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3
'response.write SQL &  ConnPasswords & ",1,3"
'response.end

WEOF = CmdDD.EOF
sessionmode=""
'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	sessionmode = alldata(19,0)
	tradedatetime = alldata(1,0)
	tradestatus= alldata(11,0)
	if isdate(tradedatetime) then
		tradedatetime = tradedatetime 
		else
		tradedatetime = now
	end if
	else
	rc = -1
	'alldata = cmddd.getrows
	'tradedatetime = alldata(1)
end if

CmdDD.Close
Set CmdDD = Nothing

  ConnPasswords.Close
	Set ConnPasswords = Nothing
	
rowcount = 0
maxpagesize = 200
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
' market status
smodecolor="red"
smode=ucase(trim(sessionmode & " "))
'security status
secmode = smode
secmodecolor = "red"
marketstatus = 0

select case smode
	case "NORMAL"
		smode="TRADING"
		smodecolor="green"
	case "CLOSED"
		smode="CLOSED"
	case "AHA"
		smode="ADJUST"
	case "ENQUIRY"
		smode = "CLOSED"
	case "HALT"
		smode="TRADING"	
		smodecolor="green"
	case "PREOPEN"
		smode="PREOPEN"
		smodecolor="green"
	case ""
		secmode="CLOSED"
		smodecolor="red"
end select
' now for security mode
secmodetest = secmode
select case secmodetest
	case "NORMAL"
		secmode="TRADING"
		secmodecolor="green"
	case "CLOSED"
		secmode =""
		secmodecolor="red"
	case "AHA"
		secmode=""
		secmodecolor="red"
	case "ENQUIRY"
		secmode = ""	
		secmodecolor="green"		
	case ""
		secmode=""
		secmodecolor="red"
end select
if (instr(tradestatus,"SU")>0) and len(tradingcodes)>0 then
	secmode="SUSPENDED"
	secmodecolor="red"
end if


%>

<!--#INCLUDE FILE="head.asp"--><html>

<head>
<meta http-equiv="REFRESH" content="600">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
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
<link rel="alternate" type="application/rss+xml" title="NSX Company Announcements" href="http://www.nsxa.com.au/ftp/rss/nsx_rss_announcements.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Exchange News" href="http://www.nsxa.com.au/ftp/rss/nsx_rss_news.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Floats" href="http://www.nsxa.com.au/ftp/rss/nsx_rss_floats.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Official List" href="http://www.nsxa.com.au/ftp/rss/nsx_rss_officiallist.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Weekly Diary" href="http://www.nsxa.com.au/ftp/rss/nsx_rss_diary.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Prices Table" href="http://www.nsxa.com.au/ftp/rss/nsx_rss_prices.xml">
<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >
<!--#INCLUDE FILE="header.asp"-->
<div id="tooltips" align="center">
<table border="0" width="797" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
<blockquote>
	<div align="right">
		<table border="0" width="100" id="table1" align="right" style="border: 1px dotted #C0C0C0">
			<%if len(tradingcodes)<=0 then %>
			<tr>
				<td class="plaintext" bgcolor="#808080">
				<p align="center"><font color="#FFFFFF"><b>Market Status</b></font></td>
			</tr>
			<tr>
				<td class="plaintext" align="center"><b><font color="<%=smodecolor%>" size="4"><%=Application("http_cache_nsxmarket_sessionmode_")%></font></b></td>
			</tr>
		<%end if%>
	<%if len(tradingcodes)>0 then %>
			<tr>
				<td class="plaintext" align="center" bgcolor="#808080"><b>
				<font color="#FFFFFF">Security Status</font></b></td>
			</tr>
			<tr>
				<td class="plaintext" align="center"><b><font color="<%=secmodecolor%>" size="4"><%=secmode%></font></b></td>
			</tr>
	<%end if%>
		</table>
	</div>
	
	<h1 align="left"> 
	LATEST TRADING IN TRADING CODE ORDER</h1>
	<p align="left"> 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="absmiddle" >
 Price information on&nbsp; this page is delayed.&nbsp;
Explanations for data can be found on the <a href="prices_definitions.asp?region=<%=displayboard%>">Full
Definitions</a>&nbsp;&nbsp; Page.
	<br><img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="absmiddle" > If a security has never traded then the last price is the IPO price.<br>


<%


if rc >= 0 then 


%>
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="absmiddle" >
	<b>Trading for (<%=formatdatetime(tradedatetime,1)%>):</b>  
<%end if%>&nbsp;
	Number of Displayed Securities: <b><%=formatnumber(rc+1,0)%><br><br>
	<h2><%=pagetitle%></h2>
	</b>Pages:
      <%if currentpage > 1 then %>
                <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage-1%>&board=<%=board%>&region=<%=displayboard%>">
	<font face="Arial">�</font></a><a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage-1%>&board=<%=board%>&region=<%=displayboard%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
            
 
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=ii%>&board=<%=board%>&region=<%=displayboard%>" class=rhlinks><%=ii%></a> | 

      <%
      	end if
      next
      
 
    
      %>
      <%if maxpages > CurrentPage then 
      
      %>
              
             <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage+1%>&board=<%=board%>&region=<%=displayboard%>">Next <%=maxpagesize%> 
	<font face="Arial">�</font></a>
      <%end if%> 
	</p> 
	</blockquote>
<div align="center"><% if len(Tradingcodes)=0 then %>
	<blockquote>
		<p align="left">Filter Securities: 
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&region=<%=displayboard%>" class=rhlinks>All</a> | 
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&traded=true" class=rhlinks>Traded Today</a>&nbsp; Sector: <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=ncrp&region=<%=displayboard%>" class=rhlinks>Industrial</a> | 
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=nprp&region=<%=displayboard%>" class=rhlinks>Property</a> | 
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=ndbt&region=<%=displayboard%>" class=rhlinks>Debt</a> |
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=nmin&region=<%=displayboard%>" class=rhlinks>Mining &amp; Energy</a> |
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=nrst&region=<%=displayboard%>" class=rhlinks>Restricted</a>
		 <br>Certficated Securities: 
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=comm&region=<%=displayboard%>" class=rhlinks>Community Banks</a> |
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=main&region=<%=displayboard%>" class=rhlinks>Industrial</a> |
		<a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=prop&region=<%=displayboard%>" class=rhlinks>Property</a> 
	</blockquote>
		<%end if%>
<!--#INCLUDE FILE="header_tables.asp"-->
<table id="prices_123" cellpadding=2 class="sortable" cellspacing="0" width="720" bgcolor="#FFFFFF" style="border-bottom:1px solid #808080; ">
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>NSX Code</b></font></td>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Last<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Bid<br>
			Qty</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Bid<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Offer<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Offer<br>
			Qty</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Open<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>High<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Low<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Vol.<br>
			</b></font><b><font color="#FFFFFF">&nbsp;</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Mkt. Cap.<br>
			$m</b></font></td>
		<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Prev Cls<br>
			$</b></font></td>
			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Chge<br>(last vs Prv) %</b></font></td>

			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Chge<br>
			(last vs open) %</b></font></td>

			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>PE<br>
			x</b></font></td>

			<!--<td valign="top" class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Div Yld<br>
			%</b></font></td> -->

			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Stat</b></font><b><font color="#FFFFFF"><br>
			Code</font></b></td>

        </tr>

        
         
        <%
        
      lap = 1
    if rc=-1 then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available</td></tr>" 
    else
    	' used to group codes into colour bars
    	prvcode = ""
      
       for jj = st to fh
       

      	  tradingcode = alldata(0,jj)
      	  if left(trim(ucase(tradingcode)),3)<>"" then
      	  
      	  currentcode = left(trim(ucase(tradingcode)),3)
      	  daily = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = alldata(4,jj)
      	  last = alldata(5,jj)
		  if currentcode = "ASJ" and last = 0 then 
			last = 1 ' case if ASJ prvclose has not been set in SAI yet.
			prvclose = 1
		  end if
      	  volume = alldata(6,jj)
		  bid = alldata(7,jj) ' buy
		
		offer = alldata(8,jj) ' sell
		  bidqty = alldata(9,jj)
		offerqty = alldata(10,jj)
			' hyperlink announcements
			sessionmode = ucase(trim(alldata(19,jj) & " "))
			smode = ""
			if sessionmode = "HALT" then smode = "TH"
			if sessionmode = "PREOPEN" then smode = "PRE"
			if sessionmode="NORMAL" then marketstatus = marketstatus+1
			status = ""
			quotebasis = alldata(21,jj)
			tradestatus=alldata(11,jj)
			status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
			if status2 <> "" then
				status = "<a href=announcements_list.asp?nsxcode=" & tradingcode & "&region=" & displayboard & " title='See news on this company'>" & status2 & "</a>&nbsp;" 
			end if
			
		board = alldata(12,jj)
		if board = "NCRP" then BOARD="CORP"
		if board = "MAIN" then BOARD="CORP"
		if board = "NPRP" then BOARD="PROP"
		if trim(board & " ") = "" then BOARD="CORP"
		currentsharesonissue = alldata(13,jj)
		if len(trim(currentsharesonissue & " "))= 0 then currentsharesonissue = 0
		isin = alldata(14,jj)
		issuedescription = alldata(15,jj)
		issuetype = alldata(16,jj)
		industryclass = alldata(17,jj)
		marketdepth=""
		marketdepth = alldata(20,jj)
		prvclose=alldata(22,jj)
		if prvclose = 0 then ' case where previous close not set yet but stock has traded.
			prvclose = last
		end if
		if last <> 0 then 
			marketcap = (last * currentsharesonissue)/1000000
			else
			marketcap = (prvclose * currentsharesonissue)/1000000
		end if
		
		' PE times calculation
		pe = ""
		currenteps = alldata(23,jj)
		if currenteps = 0 or currenteps = "" or currenteps = null then
			pe = 0
		else
			calcprice = prvclose
			if last <> 0 then calcprice = last
			pe = calcprice / (currenteps / 100)
		end if
		
		if pe < 0 then pe_fmt = formatnumber(pe,0) 
		if pe  < -9 then pe_fmt = formatnumber(pe,0)
		if pe = 0 then pe_fmt = ""
		if pe  > 0 then pe_fmt = formatnumber(pe,0)
		if pe  > 10 then pe_fmt = formatnumber(pe,0)

		
		
		' DIV YIELD % calculation
		dy = ""
		divyield = ""
		currentdps = alldata(24,jj)
		if currentdps = 0 or currentdps = "" or currentdps = null or calprice = 0 then
			dy = 0
		else
			dy = 100 * ((currentdps / 100)  / calcprice)
		end if
		if dy < 0 then
			divyield = formatnumber(dy,1) 
		elseif dy = 0 then
			divyield = ""
		elseif dy  > 0 then
			divyield = formatnumber(dy,1)
		end if
		
		
		
		currentnta = alldata(25,jj)
		
				
      	  if volume<>0 and open = 0 then open = last
      	  if volume<>0 and high = 0 then high = last
      	  if volume<>0 and low = 0 then low = last
      	  if (open<>0) and (open > high) then high = open
		  if (open<>0) and (open < low) then low = open
		  'if bid = 0 then bid = last
		 'if offer = 0 then offer = last

		' calculate the percentage change
		' intra-day movement
      	 if open = 0 then
			change = 0
			else
			change = 100*((last-open)/open)
		end if
		' interday movement
		 if last = 0 or prvclose=0 then
			dchange = 0
			else
			dchange = 100*((last-prvclose)/prvclose)
		end if

		 'display decimals	 
	 
		 if last = 0 then
		 	last = "-"
		 	else
		 	last = formatnumber(last,3)
		 end if
		 if prvclose = 0 then
		 	prvclose = "-"
		 	else
		 	prvclose = formatnumber(prvclose,3)
		 end if
		
		 if bid = 0 then
		 	bid = "-"
		 	else
		 	bid = formatnumber(bid,3)
		 end if
		 if offer = 0 then
		 	offer = "-"
		 	else
		 	offer = formatnumber(offer,3)
		 end if
		 if volume = 0 then
		 	low = "-"
		 	else
		 	low = formatnumber(low,3)
		 end if
		 if volume = 0 then
		 	high = "-"
		 	else
		 	high = formatnumber(high,3)
		 end if
		if volume = 0 then
		 	open = "-"
		 	else
		 	open = formatnumber(open,3)
		 end if

		IF volume = 0 then volume_fmt = "-"
		IF volume > 0 then volume_fmt = formatnumber(volume,0)
		'IF volume > 999 then volume_fmt = formatnumber(volume/1000,0) & "<a href=prices_alpha.asp?nsxcode=" & tradingcode & "&region=" & displayboard & " title='volume: " & formatnumber(volume,0) & " shares'>T</a>"
		'IF volume > 999999 then volume_fmt = formatnumber(volume/1000000,0) & "<a href=prices_alpha.asp?nsxcode=" & tradingcode & "&region=" & displayboard & " title='volume: " & formatnumber(volume,0) & " shares'>M</a>"
		'IF volume > 9999999 then volume_fmt = formatnumber(volume/1000000000,0) & "<a href=prices_alpha.asp?nsxcode=" & tradingcode & "&region=" & displayboard & " title='volume: " & formatnumber(volume,0) & " shares'>B</a>"
		 
		 if bidqty = 0 then 
		 	bidqty = "-"
		 	else
		 	bidqty = formatnumber(bidqty,0)
		 end if
		 if offerqty = 0 then 
		 		offerqty = "-"
		 		else
		 		offerqty = formatnumber(offerqty,0)
		 end if
		 
		IF marketcap = 0 then marketcap_fmt = "-"
		IF marketcap > 0 then marketcap_fmt = formatnumber(marketcap,1)
		IF marketcap > 99 then 	marketcap_fmt = formatnumber(marketcap,1)
		IF marketcap > 999 then marketcap_fmt = formatnumber(marketcap,1)
		
       
       if change > 0 and volume<>"-" then 
          	img1 = "<img border=""0"" src=""images/up.gif"" align=""absmiddle"">"
       	col2 = "green"
       
		elseif change < 0 and volume<>"-"  then
			img1="<img border=""0"" src=""images/down.gif"" align=""absmiddle"">"
			col2 = "red"
		
		else
			col2 = "navy"
			img1 = "<img border=""0"" src=""images/v2/level.gif"" align=""absmiddle"">"
		end if
		if dchange > 0 and volume<>"-"  then 
          	img3 = "<img border=""0"" src=""images/up.gif"" align=""absmiddle"">"
       	col3 = "green"
       
		elseif dchange < 0 and volume<>"-"  then
			img3="<img border=""0"" src=""images/down.gif"" align=""absmiddle"">"
			col3 = "red"
		
		else
			col3 = "navy"
			img3 = "<img border=""0"" src=""images/v2/level.gif"" align=""absmiddle"">"
		end if

		IF change = 0 then change_fmt = "-"
		IF change < 0 then change_fmt = formatnumber(change,1)
		IF change < -9 then change_fmt = formatnumber(change,0)
		IF change > 0 then change_fmt = formatnumber(change,1)
		IF change >=10 then change_fmt = formatnumber(change,1)
		IF change >=100 then change_fmt = formatnumber(change,1)
		
		
		IF dchange = 0 then dchange_fmt = "-"
		IF dchange < 0 then dchange_fmt = formatnumber(dchange,1)
		IF dchange < -9 then dchange_fmt = formatnumber(dchange,0)
		IF dchange > 0 then dchange_fmt = formatnumber(dchange,1)
		IF dchange >=10 then dchange_fmt = formatnumber(dchange,1)
		IF dchange >=100 then dchange_fmt = formatnumber(dchange,1)

		 if volume = "-" then
		 	change = "-"
		 	dchange = "-"
		 end if
		  


	cl = array("#EEEEEE","#FFFFFF")
	
	if prvcode <> currentcode then
	lap = (-lap)+1
	prvcode=currentcode
	else
	prvcode=currentcode
	end if
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
    <td class="plaintext" nowrap align=left valign="middle"><font color="<%=col3%>"><a href="prices_alpha.asp?nsxcode=<%=tradingcode%>&coname='<%=issuedescription%>'&region=<%=displayboard%>" title="<%=tradingcode & ": " & issuedescription %>.  Click to see full depth."><%=tradingcode %></a></font></td>
     <td class="plaintext"  nowrap align="right" valign="middle"><%=last%>&nbsp;</td>
     <td class="plaintext" nowrap  align="right"><%=bidqty%>&nbsp;</td>
     <td class="plaintext" nowrap align="right"><%=bid%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=offer%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=offerqty%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=open%></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=high%></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=low%></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=volume_fmt%></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=marketcap_fmt%></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=prvclose%></td>
     <td class="plaintext" nowrap align="right"><font color="<%=col3%>"><%=dchange_fmt%><%=img3%></font></td>
     <td class="plaintext" nowrap align="right"><font color="<%=col2%>"><%=change_fmt%><%=img1%></font></td>
     <td class="plaintext" nowrap align="right"><%=pe_fmt%></td>
    <!-- <td class="plaintext" nowrap align="right"><%=divyield%></td> -->
     <td class="plaintext" nowrap align="right"><font size=1><%=status%></font></td>
   </tr>
  
  
<% if len(tradingcodes)>0 then 
	
				offerprices = ""
				offerqtys = ""
				offertotals = ""
				offerorders = ""
									
				bidprices = ""
				bidqtys = ""
				bidorders = ""
				bidtotals = ""

		ss = instr(marketdepth,"B")-1
		if ss > 0 then 
			alloffers = mid(marketdepth,1,ss)
			alloffers = split(alloffers,"S")
			offercount =  ubound(alloffers)
				offerprices = ""
				offerqtys = ""
				offertotals = ""
				offerorders = ""
				' collect the offer prices and qtys
				FOR ii = 1 to offercount
					
					offers = split(alloffers(ii),"|")
					offerqty = offers(3)
					offerprice = offers(1)
					offerorder = offers(2)
					offertotal = offers(4)
					if len(trim(offerprice & " ")) <> 0 then 
						offerprice = formatnumber(offerprice/1000,3)
						else
						offerprice = "-"
					end if
					
					if len(trim(offerqty & " ")) = 0 then 
						offerqty = "-"
					else
						offerqty = formatnumber(offerqty,0)
					end if
					
					offerprices = offerprices & offerprice & "|"
					offerqtys = offerqtys & offerqty & "|"
					offerorders = offerorders & offerorder & "|"
					offertotals = offertotals & offertotal & "|"
				NEXT
		
		end if
		
		bb = instr(marketdepth,"B")
		if bb > 0 then
				allbids = mid(marketdepth,bb,len(marketdepth))	
				allbids = split(allbids,"B")
				bidcount =  ubound(allbids)
					
				bidprices = ""
				bidqtys = ""
				bidorders = ""
				bidtotals = ""
				FOR ii = 1 to bidcount
				
					' collect the bid prices and qtys
					bids = split(allbids(ii),"|")
					bidqty = bids(3)
					bidprice = bids(1)
					bidorder = bids(2)
					bidtotal = bids(4)
					if len(trim(bidprice & " ")) <> 0 then 
						bidprice = formatnumber(bidprice/1000,3)
						else
						bidprice = " "
					end if
					
					if len(trim(bidqty & " ")) = 0 then 
						bidqty = " "
						else
						bidqty = formatnumber(bidqty,0)
					end if

					bidprices = bidprices & bidprice & "|"
					bidqtys = bidqtys & bidqty & "|"
					bidorders = bidorders & bidorder & "|"
					bidtotals = bidtotals & bidtotal & "|"
				NEXT
				
				
		end if





%>
<tr><td colspan=17> 
<table id="prices_123" cellspacing="0" width="718" bgcolor="#FFFFFF" cellpadding="2">
<tr>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="3">
			<font color="#FFFFFF"><b>BIDS</b></font></td>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15">
			&nbsp;</td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="3">
			<font color="#FFFFFF"><b>OFFERS</b></font></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15">
			&nbsp;</td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="4">
			<b><font color="#FFFFFF">LAST 20 TRADES</font></b></td>
        </tr>

        <tr>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="50">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-top: 1px solid #FFFFFF">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15" >
			&nbsp;</td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" width="15">
			<p align="center">&nbsp;</td>
          <td valign="top" class="plaintext" align="left" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<font color="#FFFFFF"><b>TRADE DATE</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" nowrap>
			<font color="#FFFFFF"><b>PRICE $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<font color="#FFFFFF"><b>QTY</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px">
			<font color="#FFFFFF"><b>STA</b></font></td>
        </tr>

    <tr >
 
    
     <td bgcolor="#CCFFFF"  class="plaintext" align="right" valign="top" width="50" ><%
     bb = split(bidorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
    
    
     <td bgcolor="#CCFFFF"  class="plaintext" align="right" valign="top" nowrap ><%
     bb = split(bidqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
     <td bgcolor="#CCFFFF" class="plaintext" align="right" valign="top" nowrap><%
     bb = split(bidprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     %>&nbsp;</td>
 
     <td bgcolor="#FFFFFF" class="plaintext" align="center" width="15">&nbsp;</td>
 
 <td bgcolor="#FFFFCC" class="plaintext" align="right" valign="top"><%
 	bb = split(offerprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td bgcolor="#FFFFCC" class="plaintext" align="right" valign="top" nowrap ><%
     bb = split(offerqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td bgcolor="#FFFFCC" class="plaintext" align="right" valign="top" nowrap ><%
     bb = split(offerorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next

     %>&nbsp;</td>
     <%
     DATA_PATH = Server.Mappath("newsxdb/nsxprices.mdb")
     strConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DATA_PATH  
     Set ConnPasswords = CreateObject("ADODB.Connection")
     ConnPasswords.Open strConnString 
	Set CMDDD = CreateObject("ADODB.Recordset")
	' get valid trades for day
	SQL = "SELECT TOP 20 PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete "
	SQL = SQL & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
	SQL = SQL & "WHERE tradingcode='" & tradingcode & "' "
	SQL = SQL & "ORDER BY PricesTrades.TradeDateTime DESC, cint(PricesTrades.TradeNumber) DESC"
		
	'response.write SQL
	'response.end
	
	CMDDD.Open SQL,Connpasswords,1,3

	WEOF = CmdDD.EOF
	
	if not WEOF then 
		alldata2 = cmddd.getrows
		rc2 = ubound(alldata2,2) 
	else
		rc2 = -1
	end if

	CmdDD.Close
	Set CmdDD = Nothing
 
  jjj = 0
	

%>
     
     
     
     <td bgcolor="#FFFFFF" class="plaintext" align="right" valign="top" width="15" >
		<p align="center">&nbsp;</td>
     <td bgcolor="#CCFFCC" class="plaintext" align="left" valign="top" nowrap >
<font size="1">
<%
jjj = 0
if rc2 <> -1 then
	for jjj = 0 to rc2
	tradedatetime=alldata2(2,jjj)
	response.write cnvddmmyyyy(tradedatetime) & " " & formatdatetime(tradedatetime,3) & "<br>"
	NEXT
end if
	%>
     </font>
     <td bgcolor="#CCFFCC" class="plaintext" align="right" valign="top" nowrap >
		<font size="1">
		<%
		jjj = 0
		if rc2 <> -1 then
	for jjj = 0 to rc2
	price=alldata2(0,jjj)
	response.write formatnumber(price,3) & "<br>"
	NEXT
	end if
	%>
</font>
</td>
     <td bgcolor="#CCFFCC" class="plaintext" align="right" valign="top" nowrap >
		<font size="1">
		<%
		jjj = 0
		if rc2 <> -1 then
	for jjj = 0 to rc2
		Volume=alldata2(1,jjj)
		response.write formatnumber(volume,0) & "<br>"
	NEXT
	end if
		%>
	</font>
	</td>
     <td bgcolor="#CCFFCC" class="plaintext" align="right" valign="top" nowrap >
	<font size="1">
	<%
	jjj = 0
	if rc2 <> -1 then
	for jjj = 0 to rc2
	withdrawn=alldata2(3,jjj)
	status = " "
	if withdrawn="D" then 
		status = "CAN"
	end if
	response.write status & "<br>"
	NEXT
	end if
	%>
</font>
</td>
    </tr>
    <%
    'alldata2=nothing
    

    %>
    <tr >
    <td colspan=4 class=plaintext> &nbsp;</td>
    <td colspan="4" class=plaintext> &nbsp;</td>
    <td colspan=4 bgcolor="#FFFFFF" class="plaintext" align="right" valign="top"><a href="announcements_list.asp?nsxcode=<%=tradingcode%>&coname=<%=issuedescription%>&region=<%=displayboard%>" title="Click to see announcements">Announcements</a> | 
	<a href="prices_trades.asp?tradingcode=<%=tradingcode%>&coname=<%=issuedescription%>&region=<%=displayboard%>" title="Click to see trading history">All Trades</a></td>
    </tr>
    
</table>
 </td></tr>   

<%		end if
	end if 

		marketdepth=""
    	  NEXT
    	 end if
 
    	  
    	  
 

    %>
     
      
        
    
      
      
      </table>







</div>
	</td>
    
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>

</body>
<script type="text/javascript" src="BubbleTooltips.js"></script>
<script type="text/javascript">
enableTooltips("tooltips");
</script>
</html>