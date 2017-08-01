<%
	Response.Redirect "/market_eom_nsx.asp"
	Response.End
	
	
	
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"

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
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><b><font face="Arial">MONTHLY 
	TRADING STATISTICS&nbsp;</font></b></h1>
	
	</td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

<p>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


		
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT monthend,totalvolume,totalvalue,numtrades,mktcap,moversup,moversdown,securities FROM monthlystatistics ORDER BY monthend DESC"
CmdDD.CacheSize=50 
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
maxpagesize = 50
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>


	</p>


	<p>Page:
      <%if currentpage > 1 then %>
                <a href="market_statistics_monthly.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="market_statistics_monthly.asp?nsxcodes=<%=nsxcodes%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="market_statistics_monthly.asp?nsxcodes=<%=nsxcodes%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="market_statistics_monthly.asp?nsxcodes=<%=nsxcodes%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>

</p>

<div align="center">

<table  bgcolor="#FFFFFF"  cellpadding="5" style="border-bottom:1px solid #666666; border-collapse: collapse" width="100%">
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666">
			<p align="right">
			<font color="#FFFFFF"><b><br>
          <br>
          DATE</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font size="2" face="Arial" color="#FFFFFF"><b>TOTAL
            <br>
          VOLUME<br>
          No.</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>TOTAL <br>
          VALUE<br>
            $</b></font></td>
            <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>AVERAGE<br>PRICE<br>
            $</b></font></td>

          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>TRADES<br>
            No.</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>MARKET <br>
          CAPITALISATION<br>
            $</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>SECURITIES<br>
          LISTED<br>
            No.</b></font></td>
        </tr>
        <tr >
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No statistics available.</td</tr>" 
    else
    
       for jj = st to fh
      	  
      	  monthend = alldata(0,jj)
      	  totalvolume = alldata(1,jj)
      	  totalvalue= alldata(2,jj)
      	  numtrades= alldata(3,jj)
      	  mktcap= alldata(4,jj)
      	  moversup= alldata(5,jj)
      	  moversdown= alldata(6,jj)
      	  securities=alldata(7,jj)
      	  
      	  if totalvalue = 0 then
      	  	aveprice = 0
      	  	else
      	  	aveprice = totalvalue / totalvolume
      	  end if
      	  
   cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
      

    <td height=12 align=right class="plaintext"><%=MonthName(Month(monthend),true) & "-" & year(monthend)%>
    </td>
     <td align=right class="plaintext"><%=formatnumber(totalvolume,0,true,true,true)%>&nbsp;</td>
     <td class="plaintext" align="right"><%= formatnumber(totalvalue,0,true,true,true)%>&nbsp;</td>
     <td  class="plaintext" align="right"><%= formatnumber(aveprice,2,true,true,true)%>&nbsp;</td>

     <td class="plaintext" align="right"><%= formatnumber(numtrades,0,true,true,true)%>&nbsp;</td>
     <td class="plaintext" align="right"><%= formatnumber(mktcap,0,true,true,true)%>&nbsp;</td>
     <td class="plaintext" align="right"><%= formatnumber(securities,0,true,true,true)%>&nbsp;</td>
    </tr>
    
    	<%
    	
    	  NEXT
    end if
    %>
     
      
        
    
      
      
      </table>







</div>







<p>&nbsp;
    </td>
    
  </tr>
</table>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

</body>

</html>