<%@ LANGUAGE="VBSCRIPT" %>
<%
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

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Data</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF" >
	
		<h1><font face="Arial">END OF MONTH STATISTICS&nbsp;- 
		BSX</font></b></h1>
	
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


		
' *********  BSX DATA  *************

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
  
ConnPasswords.Open Application("nsx_ReaderConnectionString") 

Set CmdEditUser = Server.CreateObject("ADODB.Recordset")

' TODO: Remove all Format statements from SQL
SQL = " SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, [TradeDate]), 0) AS TD, SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END) AS Expr1, SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END) AS Expr2, Count(PricesTrades.tradingcode) AS CountOftradingcode, SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END AS Expr3"
SQL = SQL & " FROM PricesTrades"
SQL = SQL & " WHERE (exchid='MAIN' or exchid='PROP' or exchid='COMM')"
SQL = SQL & " GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, [TradeDate]), 0)"
SQL = SQL & " ORDER BY DATEADD(MONTH, DATEDIFF(MONTH, 0, [TradeDate]), 0) DESC"
CmdEditUser.Open SQL, ConnPasswords,1,3
'response.write SQL & cr

WEOF = CmdEditUser.EOF

'can only do getrows if there is more than one record.
if not WEOF then 
	alldata = CmdEditUser.getrows
	rc = ubound(alldata,2) 
	
	else
	rc = -1
end if



CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing



rowcount = 0
maxpagesize = 100
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>


	</p>


	<p>Page:
      <%if currentpage > 1 then %>
                <a href="market_eom_bsx.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="market_eom_bsx.asp?nsxcodes=<%=nsxcodes%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="market_eom_bsx.asp?nsxcodes=<%=nsxcodes%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="market_eom_bsx.asp?nsxcodes=<%=nsxcodes%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>

</p>

<div align="center">

<table  bgcolor="#FFFFFF"  cellpadding="5" style="border-bottom:1px solid #666666; border-collapse: collapse" width="100%">
        <tr>
          <td valign="top" class="plaintext" bgcolor="#666666"><p align="right"><font color="#FFFFFF"><b><br><br>
          DATE</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font size="2" face="Arial" color="#FFFFFF"><b>TRADES
            <br>
          No.</b></font></td>
          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>TRADE <br>
          VALUE<br>
            $</b></font></td>
            <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>TRADES<br>VOLUME<br>
            NUMBER OF SHARES</b></font></td>

          <td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>AVERAGE<br>
			PRICE<br>
            PER SHARE
            $</b></font></td>
			<td valign="top" class="plaintext" align="right" bgcolor="#666666">
			<font color="#FFFFFF"><b>VALUE<br>
				PER TRADE<br>
            $</b></font></td>
        </tr>
        <tr >
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No statistics available.</td></tr>" 
    else
    
       for jj = st to fh
      	  
      	  tradedate = alldata(0,jj)
      	  tradevolume = alldata(1,jj)
      	  tradevalue= alldata(2,jj)
      	  numtrades=alldata(3,jj)
      	  withdrawn=alldata(4,jj)
      	  actualnumtrades=numtrades-withdrawn
      	  if tradevalue <> 0 then
      	  	aveprice = tradevalue / tradevolume
      	  else
      	  	aveprice = 0
      	  end if
      	  
      	  
   cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">  
    <td  align=right class="plaintext"><%=MonthName(Month(tradedate),true) & "-" & year(tradedate)%></td>
     <td align=right class="plaintext"><%=formatnumber(numtrades,0,true,true,true)%>&nbsp;</td>
     <td class="plaintext" align="right"><%= formatnumber(tradevalue,0,true,true,true)%>&nbsp;</td>
     <td  class="plaintext" align="right"><%= formatnumber(tradevolume,0,true,true,true)%>&nbsp;</td>
     <td class="plaintext" align="right"><%= formatnumber(aveprice,2,true,true,true)%>&nbsp;</td>
	 <td class="plaintext" align="right"><%if actualnumtrades>0 then 
		response.write formatnumber((tradevalue/actualnumtrades),0,true,true,true)
		else
		response.write "0"
		end if%>&nbsp;</td>
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
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

</body>

</html>