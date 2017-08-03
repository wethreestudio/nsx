<%@ LANGUAGE="VBSCRIPT" %>
<%Server.ScriptTimeout=360%>

<%
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

' Replace single quotes in text before inserting in DB
Function RepAP(str)
         RepAP = Replace(str & " ", "'", "''")

   
End Function

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
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle,enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >

<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><b><font face="Arial">DELAYED
      PRICES&nbsp;</font></b></h1>
	
	</td>
  </tr>
  <tr>
    <td  class="textheader" bgcolor="#FFFFFF">
	
      LATEST
      TRADING BY SECURITY TYPE
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

	<p align="left"> 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
 Price information on&nbsp; this page is delayed
by at least 30 minutes. <br> 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" > 
Order Page by: <a href="prices_industry.asp">Industry Group</a> | 
	<a href="prices_securities.asp">Security Type</a> | 
	<a href="prices_alpha.asp">Trading Code</a><br> 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
Explanations for data can be found on the <a href="prices_definitions.asp">Full
Definitions</a> Page</p>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.
nsxcodes=trim(request("nsxcode") & " ")
' construct search for multiple codes.
if len(nsxcodes)=0 then
	srch = "WHERE (issuestatus='Active')"
	else
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = " WHERE ("
	nsxcodes=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcodes)
		srch = srch & "(tradingcode='" & nsxcodes(jj) & "') OR "
	next
	srch = left(srch,len(srch)-4)
	srch = srch & ")"
end if





Set alldata = Nothing

' plug date back into summary to summ up trading volumes.
	Set ConnPasswords = CreateObject("ADODB.Connection")
	Set CMDDD = CreateObject("ADODB.Recordset")
	ConnPasswords.Open Application("nsx_ReaderConnectionString")   

SQL = "SELECT tradingcode,tradedatetime,open,high,low,last,volume,bid,offer,issuetype,currentsharesonissue,issuedescription,issuestatus "
SQL = SQL & " FROM pricescurrent  "
SQL = SQL &  srch
SQL = SQL & " ORDER BY issuetype ASC"
'response.write SQL & "<BR>"
'response.end
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords,1,3

WEOF = CmdDD.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = cmddd.getrows
	rc = ubound(alldata,2) 
	tradedatetime = alldata(0,0)

	else
	rc = -1
end if

CmdDD.Close
Set CmdDD = Nothing


rowcount = 0
maxpagesize = 100
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>

<%if rc > -1 then
tradedatetime = maxdate
%>
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
	<b>Trading for (<%=formatdatetime(tradedatetime,0)%>):</b>  
<%end if%> 
<br>
	Number of Listed Securities: <b><%=formatnumber(rc+1,0)%><br>
	</b>Pages:
      <%if currentpage > 1 then %>
                <a href="prices_securities.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="prices_securities.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_securities.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="prices_securities.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>



<div align="center">
<div class="table-responsive"><table  cellspacing="0" width="100%" bgcolor="#FFFFFF" cellpadding="3" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666">
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>CODE</b></font></td>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font size="2" face="Arial" color="#FFFFFF"><b>NAME</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LAST<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>BID<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OFFER<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>
			(last vs open)<br>
            &nbsp;%</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OPEN<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>HIGH<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LOW<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>VOL.<br>
            <font size="1">units</font></b></font></td>
        </tr>
        <tr >
        <%
    if rc=-1 then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available</td</tr>" 
    else
      
       for jj = st to fh
      	  
      	  tradingcode = alldata(0,jj)
      	  issuetype = alldata(9,jj)
      	  currentsharesonissue = alldata(10,jj)
      	  issuedescription = alldata(11,jj)    	  	
	      IssueDesc = replace(trim(IssueDescription & " "),"''","'")      	  
      	  daily = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = alldata(4,jj)
      	  last = alldata(5,jj)
      	  volume = alldata(6,jj)
			bid = alldata(7,jj) ' buy
			offer = alldata(8,jj) ' sell
	
      	  
      	  
      	  if open = 0 then open = last
      	  if high = 0 then high = last
      	  if low = 0 then low = last
      	  if (open<>0) and (open > high) then high = open
		  if (open<>0) and (open < low) then low = open
		' calculate the percentage change
      	 if open = 0 then
		change = 0
	else
		change = 100*((last-open)/open)
	end if
		 'display decimals
		 'prices = bid + offer + last
		 prices = cstr(last)
		 locdot = instr(prices,".")
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

	 
		 if last = 0 then
		 	last = "-"
		 	else
		 	last = formatnumber(last,deci)
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

		cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
   
    <td   align=left class="plaintext" valign="middle"><%=img1%><font color="<%=col2%>"><%=tradingcode %></font>
    </td>
     <td align=left class="plaintext" valign="middle"><%="<a href=security_details.asp?nsxcode=" & tradingcode & " title=click for issue details>" & IssueDesc & "</a>"%>&nbsp;</td>
     <td   class="plaintext" align="right" valign="middle"><%=last%>&nbsp;</td>
     <td class="plaintext" align="right" valign="middle"><%=bid%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%=offer%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><font color="<%=col2%>"><%=change%></font>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%=open%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%=high%>&nbsp;</td>
     <td   class="plaintext" align="right" valign="middle"><%=low%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="middle"><%
     	if volume<>0 then
     	response.write "<b>" & formatnumber(volume,0) & "</b>"
     	else
     	response.write formatnumber(volume,0)
     	end if
     	%>&nbsp;</td>
    </tr>
    
    	<%
    		
    	  NEXT
    	 end if

    	  %>
    	  
        
        
    
      
      
      </table></div>







</div>







<p>&nbsp;&nbsp;&nbsp;
    </td>
    
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

</body>

</html>