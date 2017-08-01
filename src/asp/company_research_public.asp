<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "USR" %>
<%

Response.Redirect "/marketdata/company_search"
Response.End

page_title = "Company Research"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td  class="textheader" bgcolor="#FFFFFF" >
    
		<h1><b><font face="Arial">SECURITY 
    RESEARCH&nbsp;CONSOLE<br>
		<span style="font-weight: 400"><font size="2" color="#000099">Click on 
		an icon to retrieve data for that security or issuer.</font></span></font></b></h1>
	
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
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
		srch = srch & "(nsxcode='" & SafeSqlParameter(nsxcodes(jj)) & "') OR "
	next
	srch = left(srch,len(srch)-4)
	srch = srch & ")"
end if

'board=ucase(trim(request("board")))
Board="SIMV"
if len(board)<>0 then srch = srch & " AND (coissues.displayboard <> '" & SafeSqlParameter(board) & "') "

		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
' 1 second past midnight of current day.
dd = fmttf(date & " 00:00:01")
SQL = "SELECT  nsxcode,issuedescription,tradingcode FROM coIssues "
SQL = SQL & " WHERE (coIssues.iNewFloat=0) AND (coIssues.Issuestatus ='Active')" & srch
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
maxpagesize = 10
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>


  <p>Page:
      <%if currentpage > 1 then %>
                <a href="company_research_public.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="company_research_public.asp?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="company_research_public.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="company_research_public.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>

</p>

<div align="center">

<table width="100%" bgcolor="#FFFFFF" cellpadding="2" style="border-bottom:1px solid #666666; border-collapse: collapse">
        <tr>
          <td class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>Code</b></font></td>
          <td class="plaintext" bgcolor="#666666">
			<b><font face="Arial" size="2" color="#FFFFFF">Name</font></b></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Current<br>
            Trading</b></font></td>
           <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Depth</b></font></td>
           <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>News</b></font></td>
            <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Chart</b></font></td>
           <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Aust.<br>
			Invest<br>
            Research</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Daily<br>
            Prices</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Monthly<br>
            Prices</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF">
			<b>Trades</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Security<br>
            Details</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Issuer<br>
            Details</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Capital</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>Divs.</b></font></td>
          <td class="plaintext" align="center" bgcolor="#666666">
			<font color="#FFFFFF"><b>News<br>
			RSS</b></font></td>
        </tr>
   
        <%
        lap=0
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No price details available.</td</tr>" 
    else
    
       for jj = st to fh
      	  
      	  nsxcode = alldata(0,jj)
      	  coname = alldata(1,jj) 
      	  tradingcode = alldata(2,jj)
      

     	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
		lap = (-lap)+1
    %>
        
   
<tr>
    <td align=left class="plaintext" valign="middle" colspan="15"><%=tradingcode %>&nbsp; <%=adjtextarea(CoName)%></td></tr>
<tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
    <td   align=left class="plaintext" valign="middle">&nbsp;</td>
     <td align=left class="plaintext">&nbsp;</td>
     <td  class="plaintext" align="center"><a href="prices_alpha.asp?nsxcode=<%=tradingcode %>" title="click to view Todays Prices for <%=adjtextarea(CoName)%>" onmouseover="spec('LK1<%=tradingcode %>','imgmnon')" onmouseout="spec('LK1<%=tradingcode %>','imgmnoff')"><img name="LK1<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7"  ></a></td>
     <td  class="plaintext" align="center"><a href="prices_depth.asp?nsxcode=<%=tradingcode %>" title="click to view Market Depth for <%=adjtextarea(CoName)%>" onmouseover="spec('LK4<%=tradingcode %>','imgmnon')" onmouseout="spec('LK4<%=tradingcode %>','imgmnoff')"><img name="LK4<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td class="plaintext" align="center"><a href="/marketdata/search_by_company?nsxcode=<%=tradingcode %>" title="click to view News for <%=adjtextarea(CoName)%>" onmouseover="spec('LK5<%=tradingcode %>','imgmnon')" onmouseout="spec('LK5<%=tradingcode %>','imgmnoff')"><img name="LK5<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td  class="plaintext" align="center"><a href="charts_nsx.asp?tradingcode=<%=tradingcode%>&coname='<%=coname%>'" title="click to view Trading Chart on <%=adjtextarea(CoName)%>" onmouseover="spec('LK9<%=tradingcode %>','imgmnon')" onmouseout="spec('LK9<%=tradingcode %>','imgmnoff')"><img name="LK9<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td  class="plaintext" align="center"><a href="company_research_ai.asp?tradingcode=<%=tradingcode %>&coname=<%=coname%>" title="click to view AI Research on <%=adjtextarea(CoName)%>" onmouseover="spec('LK10<%=tradingcode %>','imgmnon')" onmouseout="spec('LK10<%=tradingcode %>','imgmnoff')"><img name="LK10<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td  class="plaintext" align="center"><a href="prices_daily.asp?tradingcode=<%=tradingcode %>&coname=<%=coname%>" title="click to view Daily Price History for <%=adjtextarea(CoName)%>" onmouseover="spec('LK2<%=tradingcode %>','imgmnon')" onmouseout="spec('LK2<%=tradingcode %>','imgmnoff')"><img name="LK2<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td class="plaintext" align="center"><a href="prices_monthly.asp?tradingcode=<%=tradingcode %>&coname=<%=coname%>" title="click to view Monthly Price History for <%=adjtextarea(CoName)%>" onmouseover="spec('LK3<%=tradingcode %>','imgmnon')" onmouseout="spec('LK3<%=tradingcode %>','imgmnoff')"><img name="LK3<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td   class="plaintext" align="center"><a href="prices_trades.asp?tradingcode=<%=tradingcode %>&coname=<%=coname%>" title="click to view Detailed Trading History for <%=adjtextarea(CoName)%>" onmouseover="spec('LK8<%=tradingcode %>','imgmnon')" onmouseout="spec('LK8<%=tradingcode %>','imgmnoff')"><img name="LK8<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td  class="plaintext" align="center"><a href="security_details.asp?nsxcode=<%=tradingcode %>" title="click to view Security Details for <%=adjtextarea(CoName)%>" onmouseover="spec('LK6<%=tradingcode %>','imgmnon')" onmouseout="spec('LK6<%=tradingcode %>','imgmnoff')"><img name="LK6<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td  class="plaintext" align="center"><a href="company_details.asp?nsxcode=<%=nsxcode %>" title="click to view Issuer Details such as address, web, email , phone for <%=adjtextarea(CoName)%>" onmouseover="spec('LK7<%=tradingcode %>','imgmnon')" onmouseout="spec('LK7<%=tradingcode %>','imgmnoff')"><img name="LK7<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td   class="plaintext" align="center"><a href="security_capital.asp?nsxcode=<%=tradingcode %>&coname=<%=coname%>" title="click to view changes in Issued Capital for each security in <%=adjtextarea(CoName)%>" onmouseover="spec('LK11<%=tradingcode %>','imgmnon')" onmouseout="spec('LK11<%=tradingcode %>','imgmnoff')"><img name="LK11<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td   class="plaintext" align="center"><a href="security_dividends.asp?nsxcode=<%=tradingcode %>&coname=<%=coname%>" title="click to view dividends paid by <%=adjtextarea(CoName)%>" onmouseover="spec('LK12<%=tradingcode %>','imgmnon')" onmouseout="spec('LK12<%=tradingcode %>','imgmnoff')"><img name="LK12<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
     <td   class="plaintext" align="center"><a href="ftp/rss/byissuer/nsx_rss_announcements_<%=left(tradingcode,3)%>.xml" title="click to subscribe to RSS News Feed on <%=adjtextarea(CoName)%> " onmouseover="spec('LK13<%=tradingcode %>','imgmnon')" onmouseout="spec('LK13<%=tradingcode %>','imgmnoff')"><img name="LK13<%=tradingcode %>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" ></a></td>
    </tr>
    
    	<%
    	
    	  NEXT
    end if
    %>
      </table>
</div>
<p>&nbsp;</td>
    
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->