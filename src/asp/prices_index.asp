<!--#INCLUDE FILE="include_all.asp"-->
<%

Response.Redirect "/marketdata/prices"
Response.End



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
	srch = " WHERE (last <> 0) AND (tradingcode<>'TESTINDEX') "
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
strConnString = Application("nsx_ReaderConnectionString")
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open strConnString 
SQL = "SELECT [tradingcode],[tradedatetime],[open],[high],[low],[last],[status],[issuedescription],[prvclose],[exchid] "
SQL = SQL & " FROM indexcurrent  "
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
	tradedatetime = alldata(1,0)
	tradestatus= alldata(6,0)
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
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
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
	
	<h1 align="left"> 
	CURRENT INDEX</h1>
	<p align="left"> 
	<img border="0" src="images/v2/HEADP1.jpg" width="15" height="7" align="absmiddle" >
	<b>Values for <%=formatdatetime(tradedatetime,1)%></b></p>
	<p align="left"> 
	Pages:
      <%if currentpage > 1 then %>
                <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&amp;currentpage=<%=currentpage-1%>&amp;board=<%=board%>&amp;region=<%=displayboard%>">
	<font face="Arial">«</font></a><a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&amp;currentpage=<%=currentpage-1%>&amp;board=<%=board%>&amp;region=<%=displayboard%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
            
 
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&amp;currentpage=<%=ii%>&amp;board=<%=board%>&amp;region=<%=displayboard%>" class=rhlinks><%=ii%></a> | 

      <%
      	end if
      next
      
 
    
      %>
      <%if maxpages > CurrentPage then 
      
      %>
              
             <a href="prices_alpha.asp?nsxcode=<%=tradingcodes%>&amp;currentpage=<%=currentpage+1%>&amp;board=<%=board%>&amp;region=<%=displayboard%>">Next <%=maxpagesize%> 
	<font face="Arial">»</font></a>
      <%end if%> 
	</p> 
	</blockquote>
<div align="center"><% if len(Tradingcodes)=0 then %>
<p>
<%end if%>	

<table id="prices_123" cellpadding=1 class="sortable" cellspacing="1" width="720" bgcolor="#FFFFFF" style="border-bottom:1px solid #808080; ">
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>INDEX</b></font></td>        
          <td valign="top" class="plaintext" bgcolor="#666666">
			<font color="#FFFFFF"><b>NSX CODE</b></font></td>        
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>OPEN<br>
			&nbsp;</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>HIGH<br>
			&nbsp;</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LOW<br>
			&nbsp;</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>LAST<br>
			&nbsp;</b></font></td>
        		<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>PRV CLOSE<br>
			&nbsp;</b></font></td> 
			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>(last vs PRV) %</b></font></td>
  			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>CHANGE<br>
			(last vs open) %</b></font></td>
  			<td valign="top" class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Daily <br>
			History</b></font></td>
  			<td valign="top" class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Index<br>
			Chart</b></font></td>
        </tr>

        
         
        <%
        
      lap = 0
    if rc=-1 then 
    	response.write "<tr><td colspan=12 class=plaintext>No index details available</td></tr>" 
    else
      
       for jj = st to fh
  

      	  tradingcode = alldata(0,jj)
      	  if left(trim(ucase(tradingcode)),3)<>"" then
      	  
      	  daily = alldata(1,jj)
      	  open = alldata(2,jj)
      	  high = alldata(3,jj)
      	  low = 0 'alldata(4,jj)
      	  last = alldata(5,jj)
			tradestatus=alldata(6,jj)
			status2 = trim(ucase(tradestatus & " " & smode & " " & quotebasis )) ' status flag
			
' [tradingcode],[tradedatetime],[open],[high],[low],[last],[status],[issuedescription],[prvclose],[exchid]			
' Response.Write "<h1>" & alldata(7,jj) & "</h1><br>"			
		issuedescription = "ERROR" ' alldata(7,jj)
		prvclose= 0 ' alldata(8,jj)

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
		
	
		 if low = 0 then
		 	low = "-"
		 	else
		 	low = formatnumber(low,3)
		 end if
		 if high = 0 then
		 	high = "-"
		 	else
		 	high = formatnumber(high,3)
		 end if
		if open = 0 then
		 	open = "-"
		 	else
		 	open = formatnumber(open,3)
		 end if
		 
	
       
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
    <td class="plaintext" nowrap align=left valign="middle"><font color="<%=col3%>"><%=issuedescription %></a></font></td>
    <td class="plaintext" nowrap align=left valign="middle"><font color="<%=col3%>"><%=tradingcode %></font></td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=open%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=high%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col3%>"><%=low%></font>&nbsp;</td>
     <td class="plaintext"  nowrap align="right" valign="middle"><font color="<%=col3%>"><%=last%>&nbsp;</font></td>
       <td class="plaintext" nowrap align="right" valign="middle"><%=prvclose%></td>
     <td class="plaintext" nowrap align="right"><font color="<%=col3%>"><%=dchange%><%=img3%></font>&nbsp;</td>
     <td class="plaintext" nowrap align="right" valign="middle"><font color="<%=col2%>"><%=change%><%=img1%></font>&nbsp;</td>

     <td class="plaintext" nowrap align="center" valign="middle">
		<a href="prices_index_daily.asp?tradingcode=<%=tradingcode%>&coname=<%=issuedescription%>"><img border="0" src="images/icons/txt.gif" width="18" height="18"></a></td>

     <td class="plaintext" nowrap align="center" valign="middle">
		<a href="charts_index.asp?tradingcode=<%=tradingcode%>&coname=<%=issuedescription%>&size=700x350"><img border="0" src="images/chart.gif" width="15" height="15"></a></td>

   </tr>
  
    
<%
end if
NEXT
	end if
%>
</table>
	<p><font face="Arial, helvetica, sans-serif" size="2"><b>Index Method:</b> 
	Price average weighted by the&nbsp;number of shares held if a $1,000&nbsp;parcel of 
	shares was purchased on date of listing.</font></p>
	<p>&nbsp;</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->
