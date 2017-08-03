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

Function cnvddmmyyyy(xx)
' convert dates in dd-mmm-yyyy format
dd = day(xx)
mm = monthname(month(xx),1)
yy = year(xx)
cnvddmmyyyy = dd &"-"& mm & "-" & yy
End Function


' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1
active=ucase(request("active"))
if len(active)=0 then
	srch = " WHERE (issuestatus = 'Active') "
	else
	srch = " WHERE (issuestatus = '" & active & "') "
end if



' display todays prices
' if multiple codes requested then restrict by that otherwise ALL codes.
nsxcodes=ucase(trim(request("nsxcode") & " "))
board=ucase(trim(request("board") & " "))


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
if len(board)<>0 then
	srch = srch & " AND exchid='" & board & "' "
end if 

'response.write srch & "<BR>"
'response.write request.servervariables("QUERY_STRING")
'response.end

' get date for latest prices
  
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open Application("nsx_ReaderConnectionString")   
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[volume],[bid],[offer],[bidqty],[offerqty],[tradestatus],[exchid],[currentsharesonissue],[isin],[issuedescription],[issuetype],[industryclass],[marketcap],[sessionmode],[marketdepth],[quotebasis],[prvclose] "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL &  srch 
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
	case "AHA"
		secmode=""
	case "ENQUIRY"
		secmode = ""		
	case ""
		secmode=""
end select
if (instr(tradestatus,"SU")>0) and len(tradingcodes)>0 then
	secmode="SUSPENDED"
	secmodecolor="red"
end if


%>

<html>

<head>


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
<link rel="alternate" type="application/rss+xml" title="NSX Company Announcements" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_announcements.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Exchange News" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_news.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Floats" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_floats.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Official List" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_officiallist.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Weekly Diary" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_diary.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Prices Table" href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_prices.xml">
<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >


<div align="center">
<!--#INCLUDE FILE="header.asp"-->
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

	<div align="right">
		<div class="table-responsive"><table border="0" width="100" id="table1" align="right" style="border: 1px dotted #C0C0C0">
			<%if len(tradingcodes)<=0 then %>
			<tr>
				<td class="plaintext" bgcolor="#808080">
				<p align="center"><font color="#FFFFFF"><b>Market Status</b></font></td>
			</tr>
			<tr>
				<td class="plaintext" align="center"><b><font color="<%=smodecolor%>" size="4"><%=smode%></font></b></td>
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
		</table></div>
	</div>
	
	<h1 align="left"> 
	LATEST TRADING IN TRADING CODE ORDER</h1>
	<p align="left"> 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
 Price information on&nbsp; this page is delayed.&nbsp;
Explanations for data can be found on the <a href="prices_definitions.asp">Full
Definitions</a>&nbsp;&nbsp; Page.
	If a security has never traded then the last price is the IPO price.<br>


<%


if rc >= 0 then 


%>
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
	<b>Trading for (<%=formatdatetime(tradedatetime,1)%>):</b>  
<%end if%>&nbsp;
	Number of Listed Securities: <b><%=formatnumber(rc+1,0)%><br>
	</b>Pages:
      <%if currentpage > 1 then %>
                <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage-1%>&board=<%=board%>">
	<font face="Arial">&lt;&lt;</font></a><a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage-1%>&board=<%=board%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
            
 
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=ii%>&board=<%=board%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
 
    
      %>
      <%if maxpages > CurrentPage then 
      
      %>
              
             <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage+1%>&board=<%=board%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%> 
	</p> 
	
<div align="center"><% if len(Tradingcodes)=0 then %>
<p>Boards: <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>" >All</a> | <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=ncrp" >Corporate</a> | <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=nprp" >Property</a> | <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage%>&board=debt" >Debt</a><br>
<%end if%>	

<div class="table-responsive"><table id="prices_123" cellpadding=1 class="sortable" cellspacing="1" width="100%" bgcolor="#FFFFFF" style="border-bottom:1px solid #808080; ">
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>NSX CODE</b></font></td>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LAST<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>BID<br>
			</b></font><b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>BID<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OFFER<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OFFER<br>
			</b></font><b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>
			(last vs open) %</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OPEN<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>HIGH<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LOW<br>
			</b></font><b><font color="#FFFFFF">$</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>VOL.<br>
			</b></font><b><font color="#FFFFFF">units</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>MKT CAP<br>
			$m</b></font></td>
        <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>STATUS<br>
			CODE</b></font></td>
        <td valign="top" class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>BOARD</b></font></td>
		<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>PRV CLOSE<br>
			$</b></font></td>
			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>(last vs PRV) %</b></font></td>

        </tr>

        
         
        <%
        
      lap = 0
    if rc=-1 then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available</td></tr>" 
    else
      
       for jj = st to fh
       

      	  tradingcode = alldata(0,jj)
      	  if left(trim(ucase(tradingcode)),3)<>"" then
      	  
      	  daily = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = alldata(4,jj)
      	  last = alldata(5,jj)
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
			status = ""
			quotebasis = alldata(21,jj)
			tradestatus=alldata(11,jj)
			status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
			if status2 <> "" then
				status = "<a href=""/marketdata/search_by_company?nsxcode=" & tradingcode & """>" & status2 & "</a>&nbsp;" 
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
		if last <> 0 then 
			marketcap = (last * currentsharesonissue)/1000000
			else
			marketcap = (prvclose * currentsharesonissue)/1000000
		end if
		
				
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
		 if volume = 0 then 
		 	volume = "-"
		 	else
		 	volume = formatnumber(volume,0)
		 end if
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
		 		
			
		if marketcap = 0 then 
			marketcap = "-"
			else
			marketcap = formatnumber(marketcap,2)
		end if
       
       if change > 0 and volume<>"-" then 
          	img1 = "<img border=""0"" src=""images/up.gif"" align=""middle"">"
       	col2 = "green"
       
		elseif change < 0 and volume<>"-"  then
			img1="<img border=""0"" src=""images/down.gif"" align=""middle"">"
			col2 = "red"
		
		else
			col2 = "navy"
			img1 = "<img border=""0"" src=""images/v2/level.gif"" align=""middle"">"
		end if
		if dchange > 0 and volume<>"-"  then 
          	img3 = "<img border=""0"" src=""images/up.gif"" align=""middle"">"
       	col3 = "green"
       
		elseif dchange < 0 and volume<>"-"  then
			img3="<img border=""0"" src=""images/down.gif"" align=""middle"">"
			col3 = "red"
		
		else
			col3 = "navy"
			img3 = "<img border=""0"" src=""images/v2/level.gif"" align=""middle"">"
		end if

		if change = 0 then 
			change = "-"
			else
			change = formatnumber(change,2)
		end if
		if dchange = 0 then
		 	dchange = "-"
		 	else
		 	dchange = formatnumber(dchange,2)
		 end if
		 if volume = "-" then
		 	change = "-"
		 	dchange = "-"
		 end if
		  


	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
    <td class="plaintext" nowrap align=left valign="middle"><font color="<%=col3%>"><a href="prices_alpha.asp?nsxcode=<%=tradingcode%>&coname='<%=issuedescription%>'" title="click here to see full depth for <%=tradingcode & ": " & issuedescription %>"><%=tradingcode %></a></font></td>
     <td class="plaintext"  nowrap align="right" valign="middle"><%=last%>&nbsp;</td>
     <td class="plaintext" nowrap  align="right"><%=bidqty%></td>
     <td class="plaintext" nowrap align="right"><%=bid%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=offer%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=offerqty%></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col2%>"><%=change%><%=img1%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=open%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=high%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=low%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=volume%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=marketcap%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font size=1><%=status%>&nbsp;</font></td>
     <td class="plaintext" nowrap align="center" valign="middle"><font size=1><%=board%></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=prvclose%></td>
     <td class="plaintext" nowrap align="right"><font color="<%=col3%>"><%=dchange%><%=img3%></font>&nbsp;</td>
   </tr>
  
  
<% if len(tradingcodes)>0 then 


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
<tr><td colspan=16> 
<div class="table-responsive"><table id="prices_123" cellspacing="0" width="718" bgcolor="#FFFFFF" cellpadding="1">
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
			<b><font color="#FFFFFF">LAST 10 TRADES</font></b></td>
        </tr>

        <tr>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="50">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-top: 1px solid #FFFFFF" width="93">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="94">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15" >
			&nbsp;</td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="92">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="92">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="50">
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
    
    
     <td bgcolor="#CCFFFF"  class="plaintext" align="right" valign="top" width="94" nowrap ><%
     bb = split(bidqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
     <td bgcolor="#CCFFFF" class="plaintext" align="right" valign="top" width="94" nowrap><%
     bb = split(bidprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     %>&nbsp;</td>
 
     <td bgcolor=<%=cl(lap)%> class="plaintext" align="center" width="15">&nbsp;</td>
 
 <td bgcolor="#FFFFCC" class="plaintext" align="right" valign="top" width="94"><%
 	bb = split(offerprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td bgcolor="#FFFFCC" class="plaintext" align="right" valign="top" width="94" nowrap ><%
     bb = split(offerqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td bgcolor="#FFFFCC" class="plaintext" align="right" valign="top" width="50" nowrap ><%
     bb = split(offerorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next

     %>&nbsp;</td>
     <%
     
     Set ConnPasswords = CreateObject("ADODB.Connection")
     ConnPasswords.Open Application("nsx_ReaderConnectionString")   

	Set CMDDD = CreateObject("ADODB.Recordset")
	' get valid trades for day
	SQL = "SELECT TOP 10 PricesTrades.SalePrice, PricesTrades.SaleVolume, PricesTrades.TradeDateTime, pricestrades.adddelete "
	SQL = SQL & "FROM BrokerSellers INNER JOIN (BrokerBuyers INNER JOIN (PricesTrades INNER JOIN StockCodes ON PricesTrades.TradingCode = StockCodes.StockCode) ON BrokerBuyers.BrokerId = PricesTrades.BuyerID) ON BrokerSellers.BrokerId = PricesTrades.SellerID "
	SQL = SQL & "WHERE tradingcode='" & tradingcode & "' "
	SQL = SQL & "ORDER BY PricesTrades.TradeDateTime DESC, PricesTrades.TradeNumber DESC"
		
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
     <td bgcolor="#CCFFCC" class="plaintext" align="right" valign="top" nowrap >
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
    <td colspan=4 bgcolor="#FFFFFF" class="plaintext" align="right" valign="top"><a href="prices_trades.asp?tradingcode=<%=tradingcode%>&coname=<%=issuedescription%>">All Trades</a></td>
    </tr>
    
</table></div>
 </td></tr>   

<%		end if
	end if 

		marketdepth=""
    	  NEXT
    	 end if
 
    	  
    	  
 

    %>
     
      
        
    
      
      
      </table></div>







</div>


<p>&nbsp;</td>
    
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>

</body>

</html>