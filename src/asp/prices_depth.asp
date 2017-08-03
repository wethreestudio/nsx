<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
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

<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><b><font face="Arial">PRICES&nbsp;- MARKET DEPTH BY PRICE</font></b></h1>
	
	</td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF">
	&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

	<p align="left">&nbsp; 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
 Price information on&nbsp; this page is delayed
by at least 20 minutes. <br>
	&nbsp; 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
Explanations for data can be found on the <a href="prices_definitions.asp">Full
Definitions</a> Page <br>
&nbsp; 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
	If a security has never traded then the last price is the IPO price.</p>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


' display todays prices
' if mutliple codes requested then restrict by that otherwise ALL codes.
nsxcodes=trim(request.querystring("nsxcode") & " ")
if len(nsxcodes)=0 then
	nsxcodes=trim(request.form("nsxcode") & " ")
end if

' construct search for multiple codes.
if len(nsxcodes)=0 then
	srch = ""
	else
	
	nsxcodes=replace(nsxcodes," ","")
	nsxcodes=replace(nsxcodes,";",",")
	nsxcodes=replace(nsxcodes,vbCRLF,"")
	nsxcodes=replace(nsxcodes,".","")
	nsxcodes=replace(nsxcodes,",,",",")

	srch = " WHERE ("
	nsxcodes=split(nsxcodes,",")
	for jj = 0 to ubound(nsxcodes)
		srch = srch & "(left(tradingcode,3)='" & left(nsxcodes(jj),3) & "') OR "
	next
	srch = left(srch,len(srch)-4)
	srch = srch & ")"
end if


' get date for latest prices
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT tradingcode, tradedatetime , marketdepth, exchid  "
SQL = SQL & " FROM pricesdepth  "
SQL = SQL &  srch 
SQL = SQL & " ORDER BY tradingcode ASC"
'response.write SQL & "<BR>"
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
 


rowcount = 0
maxpagesize = 200
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>

<%
if rc > 0 then 
tradedatetime = alldata(1,1)


%>
&nbsp; 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="middle" >
	<b>Trading for (<%=formatdatetime(tradedatetime,1)%>):</b>  
<%end if%> 
	<br>
	Number of Listed Securities: <b><%=formatnumber(rc+1,0)%><br>
	</b>Pages:
      <%if currentpage > 1 then %>
                <a href="prices_depth.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="prices_depth.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_depth.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="prices_depth.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%> 
	

<div align="center">
<div class="table-responsive"><table id="prices_123" class="sortable" cellspacing="0" width="100%" bgcolor="#FFFFFF" style="border-bottom:1px solid #808080; " cellpadding="3">
        <tr>
          <td class="plaintext" bgcolor="#666666" rowspan="2" width="131">
			<font color="#FFFFFF"><b>NSX CODE</b></font></td>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="3">
			<font color="#FFFFFF"><b>BIDS</b></font></td>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15">
			&nbsp;</td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" colspan="3">
			<font color="#FFFFFF"><b>OFFERS</b></font></td>
        </tr>

        <tr>
          
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="93">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
          
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-top: 1px solid #FFFFFF" width="93">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="94">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" width="15" >
			&nbsp;</td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="92">
			<b><font color="#FFFFFF">PRICE $</font></b></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="92">
			<b><font color="#FFFFFF">QTY</font></b></td>
          <td valign="top" class="plaintext" align="center" bgcolor="#666666" style="border-left-width: 1px; border-right-width: 1px; border-top: 1px solid #FFFFFF; border-bottom-width: 1px" width="93">
			<font color="#FFFFFF"><b>ORDERS</b></font></td>
        </tr>

        <tr >
        <%
    if rc=-1 then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available</td></tr>" 
    else
      
       for jj = st to fh
      	  
      	  tradingcode = alldata(0,jj)
      	  if left(trim(ucase(tradingcode)),3)<>"" then

      	       	  
      	  tradedatetime = alldata(1,jj)
      	  marketdepth = alldata(2,jj)
      	  exchid = alldata(3,jj)
			status = ""
			status2 = trim(ucase(alldata(0,jj) & " ")) ' status flag
			if status2 <> "" then
				status = "<a href=""/marketdata/search_by_company?nsxcode=" & tradingcode & """>" & status2 & "</a>&nbsp;" 
			end if
		
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
		
		
		cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
      

    <td height=12 align=left class="plaintext" valign=top width="131"><%=tradingcode%></td>
    
    
     <td  class="plaintext" align="center" valign="top" width="93" ><%
     bb = split(bidorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
    
    
     <td class="plaintext" align="right" valign="top" width="93" ><%
     bb = split(bidqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     %>&nbsp;</td>
     <td  class="plaintext" align="center" valign="top" width="94"><%
     bb = split(bidprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     %>&nbsp;</td>
 
     <td class="plaintext" align="center" width="15">&nbsp;</td>
 
 <td  class="plaintext" align="center" valign="top" width="92"><%
 	bb = split(offerprices,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td  class="plaintext" align="right" valign="top" width="92" ><%
     bb = split(offerqtys,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     next
     
%>&nbsp;</td>
     <td class="plaintext" align="center" valign="top" width="93" ><%
     bb = split(offerorders,"|")
     bbcount = ubound(bb)
     for ii = 0 to bbcount
     	if len(trim(bb(ii) & " ")) <> 0 then
     	response.write bb(ii) & "<br>"
     	end if
     	
     next
     
     %>&nbsp;</td>
    </tr>
    
    	<%
    		end if  
    	  NEXT
    	 end if
    	  
    	  
    	  
 

    %>
     
 
      
      </table></div>
</div>


<%

  ConnPasswords.Close
	Set ConnPasswords = Nothing
	%>



    </td>
    
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
