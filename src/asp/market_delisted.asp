<!--#INCLUDE FILE="include_all.asp"-->
<%
Response.Redirect "/marketdata/delisted"
Response.End
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">

<h1>Delisted Securities</h1>
<p>The following securities have delisted from the NSX.</p>


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
		srch = srch & "(nsxcode='" & nsxcodes(jj) & "') OR "
	next
	srch = left(srch,len(srch)-4)
	srch = srch & ")"
end if
		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
' 1 second past midnight of current day.
dd = fmttf(date & " 00:00:01")
SQL = "SELECT  nsxcode,issuedescription,tradingcode,issuestopped FROM coIssues "
SQL = SQL & " WHERE (coIssues.iNewFloat=0) AND (coIssues.Issuestatus ='Delisted')"
SQL = SQL & " ORDER BY coIssues.TradingCode"
CmdDD.CacheSize=100 
CmdDD.Open SQL, ConnPasswords

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

rowcount = 0
maxpagesize = 100
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>

	<p>There are <b><%=rc+1%></b> delisted securities.</p>
	<p>Page:
      <%if currentpage > 1 then %>
                <a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="market_delisted.asp?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="market_delisted.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="market_delisted.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>

</p>

		



<div align="center">
<div class="table-responsive"><table cellspacing="0" width="100%" bgcolor="#FFFFFF" cellpadding="5" style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" >
        <tr>
          <td class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>CODE</b></font></td>
          <td class="plaintext" bgcolor="#666666">
			<font size="2" face="Arial" color="#FFFFFF"><b>NAME</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Daily<br>
            Prices</b></font></td>

          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Monthly<br>
            Prices</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>News</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Security<br>
            Details</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Issuer<br>
            Profile</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Delisted<br>
          Date</b></font></td>
        </tr>
   
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>There are no delisted securities.</td</tr>" 
    else
    
       for jj = st to fh
      	  
      	  nsxcode = alldata(0,jj)
      	  coname = alldata(1,jj) 
      	  tradingcode = alldata(2,jj)
      	  delisteddate = alldata(3,jj)
      	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
       <td height=12  align=left class="plaintext" valign="middle"><%=tradingcode %></td>
     <td  align=left class="plaintext" valign="middle"><%=adjtextarea(CoName)%>&nbsp;</td>
     <td class="plaintext" align="center"><a href="prices_daily.asp?tradingcode=<%=tradingcode %>&coname=<%=coname%>" onmouseover="spec('LK2<%=tradingcode %>','imgmnon')" onmouseout="spec('LK2<%=tradingcode %>','imgmnoff')"><img name="LK2<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" alt="click to view Daily Prices"></a></td>
     <td class="plaintext" align="center"><a href="prices_monthly.asp?tradingcode=<%=tradingcode %>" onmouseover="spec('LK3<%=tradingcode %>','imgmnon')" onmouseout="spec('LK3<%=tradingcode %>','imgmnoff')"><img name="LK3<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" alt="click to view Monthly Prices"></a></td>
     <td  class="plaintext" align="center"><a href="/marketdata/search_by_company?nsxcode=<%=tradingcode %>" onmouseover="spec('LK5<%=tradingcode %>','imgmnon')" onmouseout="spec('LK5<%=tradingcode %>','imgmnoff')"><img name="LK5<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" alt="click to view News"></a></td>
     <td  class="plaintext" align="center"><a href="security_details.asp?nsxcode=<%=tradingcode %>" onmouseover="spec('LK6<%=tradingcode %>','imgmnon')" onmouseout="spec('LK6<%=tradingcode %>','imgmnoff')"><img name="LK6<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" alt="click to view Security Details"></a></td>
     <td class="plaintext" align="center"><a href="company_details.asp?nsxcode=<%=nsxcode %>" onmouseover="spec('LK7<%=tradingcode %>','imgmnon')" onmouseout="spec('LK7<%=tradingcode %>','imgmnoff')"><img name="LK7<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" alt="click to view Issuer Details"></a></td>
     <td class="plaintext" align="center">
     <%
     if isdate(delisteddate) then
     	response.write formatdatetime(cdate(delisteddate),1)
     	else
     	response.write delisteddate
     end if
     %>&nbsp;</td>
    </tr>
    
    	<%
    	
    	  NEXT
    end if
    %>
      
      </table></div>







</div>

</div>
<!--#INCLUDE FILE="footer.asp"-->