<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<%Server.ScriptTimeout=360%>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

Response.Redirect "/"
Response.End


response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

' Replace single quotes in text before inserting in DB
Function RepAP(str)
         RepAP = Replace(str & " ", "'", "''")

   
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
	srch = " WHERE (issuestatus = '') "
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
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT tradingcode,tradedatetime,open,high,low,last,volume,bid,offer,bidqty,offerqty,tradestatus,exchid,currentsharesonissue,isin,issuedescription,issuetype,industryclass,marketcap,sessionmode,marketdepth,quotebasis,prvclose "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL &  srch 
SQL = SQL & " ORDER BY tradingcode ASC"
'response.write SQL & "<BR>"
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF
sessionmode=""
'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	sessionmode = alldata(19,0)
	tradedatetime = alldata(1,0)
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

<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body style="background-color: #FFFFFF" >






<%


if rc >= 0 then 


%>
<table id="prices_123" aling=center cellspacing="0" width="650" bgcolor="#FFFFFF" style="border-bottom:1px solid #808080; ">
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
		<td valign="top" class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>PRV CLOSE</b></font></td>
			<td valign="top" class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>(last vs PRV) %</b></font></td>

        </tr>

        <tr >
        
         
        <%
        
      
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
			status = ""
			quotebasis = alldata(21,jj)
			status2 = trim(ucase(alldata(11,jj) & " " & quotebasis)) ' status flag
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
		 if last = 0 then
			dchange = 0
			else
			dchange = 100*((last-prvclose)/prvclose)
		end if

		 'display decimals

	
		 locdot = instr(last,".")
		 if locdot = 0 then
		 	deci = 2
		 	else
		 	deci = len(right(prices,len(prices) - instr(prices,".")))
		 end if
	 
		 
		 locdotb = instr(bid,".")
		 if locdotb = 0 then
		 	decib = 2
		 	else
		 	decib = len(right(bid,len(bid) - instr(bid,".")))
		 end if


		locdoto = instr(offer,".")
		 if locdoto = 0 then
		 	decio = 2
		 	else
		 	decio = len(right(offer,len(offer) - instr(offer,".")))
		 end if

		 locdotp = instr(open,".")
		 if locdotp = 0 then
		 	decip = 2
		 	else
		 	decip = len(right(open,len(open) - instr(open,".")))
		 end if

		locdoth = instr(high,".")
		 if locdoth = 0 then
		 	decih = 2
		 	else
		 	decih = len(right(high,len(high) - instr(high,".")))
		 end if

		locdotl = instr(low,".")
		 if locdotl = 0 then
		 	decil = 2
		 	else
		 	decil = len(right(low,len(low) - instr(low,".")))
		 end if
		 
		 locdotz = instr(prvclose,".")
		 if locdotz = 0 then
		 	deciz = 2
		 	else
		 	deciz = len(right(prvclose,len(prvclose) - instr(prvclose,".")))
		 end if


		 
		 'response.write prices & " - " & deci
		 if deci = 0 then deci = 2
		 if deci = 1 then deci = 2
		 if decib = 0 then decib = 2
		 if decib = 1 then decib = 2
		 if decio = 0 then decio = 2
		 if decio = 1 then decio = 2
		if decip = 0 then decip = 2
		 if decip = 1 then decip = 2
		if decih = 0 then decih = 2
		 if decih = 1 then decih = 2
		if decil = 0 then decil = 2
		 if decil = 1 then decil = 2
		  if deciz = 0 then deciz = 2
		   if deciz = 1 then deciz = 2

	 
		 if last = 0 then
		 	last = "-"
		 	else
		 	last = formatnumber(last,deci)
		 end if
		 if prvclose = 0 then
		 	prvclose = "-"
		 	else
		 	prvclose = formatnumber(prvclose,deciz)
		 end if
		
		 if bid = 0 then
		 	bid = "-"
		 	else
		 	bid = formatnumber(bid,decib)
		 end if
		 if offer = 0 then
		 	offer = "-"
		 	else
		 	offer = formatnumber(offer,decio)
		 end if
		 if volume = 0 then
		 	low = "-"
		 	else
		 	low = formatnumber(low,decil)
		 end if
		 if volume = 0 then
		 	high = "-"
		 	else
		 	high = formatnumber(high,decih)
		 end if
		if volume = 0 then
		 	open = "-"
		 	else
		 	open = formatnumber(open,decip)
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
       
       if change > 0 then 
          	img1 = "<img border=""0"" src=""images/up.gif"" align=""middle"">"
       	col2 = "green"
       
		elseif change < 0 then
			img1="<img border=""0"" src=""images/down.gif"" align=""middle"">"
			col2 = "red"
		
		else
			col2 = "navy"
			img1 = "<img border=""0"" src=""images/v2/level.gif"" align=""middle"">"
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


		
		if lap = 0 then
      	  	cl = "#EEEEEE"
      	  	lap = 1
      	  else
      	  	cl = "#FFFFFF"
      	  	lap = 0
      	  end if 

			
    %>
    <td bgcolor=<%=cl%> align=left class="plaintext" valign="middle"><font color="<%=col2%>"><a href="prices_alpha.asp?nsxcode=<%=tradingcode %>" title="click here to see full depth for <%=tradingcode %>"><%=tradingcode %></a></font>
    </td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=last%>&nbsp;</td>
     <td bgcolor=<%=cl%> class="plaintext" align="right"><%=bidqty%></td>
     <td bgcolor=<%=cl%> class="plaintext" align="right"><%=bid%>&nbsp;</td>
     <td bgcolor=<%=cl%> class="plaintext" align="right" valign="middle"><%=offer%>&nbsp;</td>
     <td bgcolor=<%=cl%> class="plaintext" align="right" valign="middle"><%=offerqty%></td>
     <td bgcolor=<%=cl%> class="plaintext" align="right" valign="middle"><font color="<%=col2%>"><%=change%><%=img1%></font>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=open%>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=high%>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=low%>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=volume%>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=marketcap%>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="middle"><%=status%>&nbsp;</td>
     <td bgcolor=<%=cl%>  class="plaintext" align="center" valign="middle"><%=board%></td>
     <td bgcolor=<%=cl%>  class="plaintext" align="center" valign="middle"><%=prvclose%></td>
     <td bgcolor=<%=cl%>  class="plaintext" align="center" valign="middle"><%=dchange%></td>
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
<table id="prices_1234" cellspacing="0" width="650" bgcolor="#FFFFFF">
<tr>
          <td class="plaintext"  rowspan="2"  bgcolor="#666666">
			<font color="#FFFFFF">&nbsp;<b>MARKET DEPTH</b></td>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="3">
			<font color="#FFFFFF"><b>BIDS</b></font></td>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15">
			&nbsp;</td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="3">
			<font color="#FFFFFF"><b>OFFERS</b></font></td>
        </tr>

        <tr>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="80">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-top: 1px solid #FFFFFF" width="80">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="80">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15" >
			&nbsp;</td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="80">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="80">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="80">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
        </tr>

    <tr >
 
    <td bgcolor=<%=cl%> align=left class="plaintext" valign=top>&nbsp;</td>
    
    
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="top" width="80" ><%
     bb = split(bidorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
    
    
     <td bgcolor=<%=cl%>  class="plaintext" align="right" valign="top" width="80" ><%
     bb = split(bidqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
     <td bgcolor=<%=cl%> class="plaintext" align="center" valign="top" width="80"><%
     bb = split(bidprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     %>&nbsp;</td>
 
     <td bgcolor=<%=cl%> class="plaintext" align="center" width="15">&nbsp;</td>
 
 <td bgcolor=<%=cl%> class="plaintext" align="center" valign="top" width="80"><%
 	bb = split(offerprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td bgcolor=<%=cl%> class="plaintext" align="right" valign="top" width="80" ><%
     bb = split(offerqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td bgcolor=<%=cl%> class="plaintext" align="center" valign="top" width="80" ><%
     bb = split(offerorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     
     %>&nbsp;</td>
    </tr>
</table>
 </td></tr>   

<%		end if
	end if 
    	  NEXT
    	 end if
    	  
  end if
    %>
      
      </table>

</body>

</html>