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
' exch id
board=ucase(trim(request("board") & " "))
' regional display "region"
displayboard=ucase(trim(request("region") & " "))
active=ucase(request("active"))
if len(active)=0 then
	srch = " WHERE (issuestatus = 'Active') "
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
if len(board)<>0 then
	srch = srch & " AND (pricescurrent.exchid='" & board & "') "
end if 
if len(displayboard)<>0 then
	srchregion = " WHERE ((pricescurrent.displayboard) like '%" & displayboard & "%') "
end if 

'response.write srch & "<BR>"
'response.write request.servervariables("QUERY_STRING")
'response.end

' get date for latest prices
  
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
'ConnPasswords.Open Application("nsx_ReaderConnectionString")   
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
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
maxpagesize = 1000
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

<div id="tooltips" align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

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
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
 Price information on&nbsp; this page is delayed.&nbsp;
Explanations for data can be found on the <a href="prices_definitions.asp?region=<%=displayboard%>">Full
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
                <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage-1%>&board=<%=board%>&region=<%=displayboard%>">
	<font face="Arial">&lt;&lt;</font></a><a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage-1%>&board=<%=board%>&region=<%=displayboard%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
            
 
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=ii%>&board=<%=board%>&region=<%=displayboard%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
 
    
      %>
      <%if maxpages > CurrentPage then 
      
      %>
              
             <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&currentpage=<%=currentpage+1%>&board=<%=board%>&region=<%=displayboard%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%> 
	</p> 
	
<div align="center">

<table id="prices_123" cellpadding=2 class="sortable" cellspacing="0" width="100%" bgcolor="#FFFFFF" >
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>Code</b></font></td>
          
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
			</b></font><b><font color="#FFFFFF">units</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Mkt. Cap.<br>
			$m</b></font></td>

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
      	  if last = 0 and currentcode = "ASJ" then last = 1
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
				status = "<a href=""/marketdata/search_by_company?nsxcode=" & tradingcode & "&region=" & displayboard & """ title='See news on this company'>" & status2 & "</a>&nbsp;" 
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
		if prvclose = 0 or len(prvclose)=0 then ' case where previous close not set yet but stock has traded.
			prvclose = last
		end if
		'response.write last * cdbl(currentsharesonissue)
		'response.end
		if last <> 0 then 
			marketcap = (last * cdbl(currentsharesonissue))/1000000
			else
			marketcap = (prvclose * cdbl(currentsharesonissue))/1000000
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
		
		if pe < 0 then
			pe = formatnumber(pe,1) 
		elseif pe = 0 then
			pe = ""
		elseif pe  > 0 then
			pe = formatnumber(pe,1)
		end if
		
		
		' DIV YIELD % calculation
		dy = ""
		divyield = ""
		currentdps = alldata(24,jj)
		if currentdps = 0 or currentdps = "" or currentdps = null then
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
		 'response.write tradingcode & "****'" & prvclose & "'****/"
		 if prvclose = 0 or len(trim(prvclose & " "))=0 then
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
		 		
			
		if marketcap = 0 Or IsNull(marketcap) then 
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
			elseif change < -9 then
		 	change = formatnumber(change,0)
		 	elseif change < 0 then
		 	change = formatnumber(change,2)
		 	elseif change >=0 then
		 	change = formatnumber(change,2)
		end if
		if dchange = 0 then
		 	dchange = "-"
		 	elseif dchange < -9 then
		 	dchange = formatnumber(dchange,0)
		 	elseif dchange < 0 then
		 	dchange = formatnumber(dchange,2)
		 	elseif dchange >=0 then
		 	dchange = formatnumber(dchange,2)
		 end if
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
     <td class="plaintext" nowrap  align="right"><%=bidqty%></td>
     <td class="plaintext" nowrap align="right"><%=bid%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=offer%>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><%=offerqty%></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=open%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=high%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=low%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=volume%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=marketcap%></font>&nbsp;</td>
   </tr>
   
   
 
 
 <%' check if 20 lines have been output, then put in header
 
 if (0 = (jj+1) mod 19) and jj >10 then
 
 %>        <tr><td>&nbsp;</td></tr>
 <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>Code</b></font></td>
          
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
			</b></font><b><font color="#FFFFFF">units</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>Mkt. Cap.<br>
			$m</b></font></td>

        </tr>


 
 
 <% end if ' end header rows %>
  
  
<% 


	end if 

		marketdepth=""
    	  NEXT
    	 end if
 
    	  
    	  
 

    %>
     
      
        
    
      
      
      </table>







</div>


<p>&nbsp;</td>
    
  </tr>
</table>
</div>

<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>

</body>
<script type="text/javascript" src="BubbleTooltips.js"></script>
<script type="text/javascript">
enableTooltips("tooltips");
</script>
</html>