<!--#INCLUDE FILE="include_all.asp"-->
<%
objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<!-- breadcrumbs - manual -->
<div class="subnav-cont  " style="border:none;background:none;">
<div class="container">
<div class="row subnav-holder"><div class="col-sm-8 breadcrumb-nav">
   <ol class="breadcrumb">
    <li><a href="/default.asp">home</a></li>
    <li><a href="/marketdata/">Market data</a></li>
    <li><a href="/marketdata/statistics/">Statistics</a></li>
    <li><a href="/market_eom_nsx.asp">END OF MONTH STATISTICS</a></li>
    </ol></div></div>
</div><!-- /row --> 
</div>


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
		        <h1>END OF MONTH STATISTICS&nbsp;</h1>
	
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

' multiple pages
currentpage = trim(request("currentpage"))
if Not IsNumeric(currentpage) Or len(currentpage) = 0 Then
	currentpage=1
Else
	currentpage=cint(currentpage)
	if currentpage<1 then currentpage=1
End If


		
' *********  NSX DATA  *************

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
                      
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
SQL = " SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, [TradeDate]), 0) AS TD, SUM(CASE WHEN AddDelete='D' THEN SaleVolume*-1 ELSE SaleVolume END) AS Expr1, SUM(CASE WHEN AddDelete='D' THEN SaleValue*-1 ELSE SaleValue END) AS Expr2, Count(PricesTrades.tradingcode) AS CountOftradingcode, SUM(CASE WHEN AddDelete='D' THEN 1 ELSE 0 END) AS Expr3"
SQL = SQL & " FROM PricesTrades"
SQL = SQL & " WHERE (PricesTrades.[exchid] IN ('NCRP','NPRP','NDBT','NMIN','NRST','MAIN','PROP','COMM')) " 
'SQL = SQL & " WHERE (PricesTrades.[exchid] IN ('NCRP','NPRP','NDBT','NMIN','NRST','MAIN','PROP','COMM')) AND (PricesTrades.tradingcode<>'AOQ')" 
'SQL = SQL & " WHERE PricesTrades.tradingcode='AOQ' " 
SQL = SQL & " GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, [TradeDate]), 0)"
SQL = SQL & " ORDER BY DATEADD(MONTH, DATEDIFF(MONTH, 0, [TradeDate]), 0) DESC"

'Response.Write SQL
'Response.End

CmdEditUser.Open SQL, ConnPasswords,1,3


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
maxpagesize = 60
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
%>

	<p>&nbsp;</p><p>Page:
      <%if currentpage > 1 then %>
    
	<a href="market_eom_nsx.asp?currentpage=<%=currentpage-1%>"> &lt;&lt; Previous <%=maxpagesize%></a> | 
            <%
			end if
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="market_eom_nsx.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
  
      if maxpages > CurrentPage then %>
              
            <a href="market_eom_nsx.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> &gt;&gt;</a>
      <%end if%>

<p><p>&nbsp;</p>

<div align="center">

<table id="myTable" class="tablesorter"> 
<thead>
        <tr>
          <th align=right style="text-align:right;">Date</th>
		  <th align=right style="text-align:right;">Trades (No.)</th>
		  <th align=right style="text-align:right;">Trade Value ($)</th>
		  <th align=right style="text-align:right;">Trade Volume (No.of Shares)</th>
		  <th align=right style="text-align:right;">Average Price per Share ($)</th>
		  <th align=right style="text-align:right;">Value per Trade ($)</th>
           </tr>
		  </thead>
		  <tbody>
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
      	  actualnumtrades=numtrades-(2*withdrawn)
      	  if tradevalue <> 0 then
      	  	aveprice = tradevalue / tradevolume
      	  else
      	  	aveprice = 0
      	  end if
      	  
      	  
   cl = array("odd","even")
	lap = (-lap)+1
				
    %>
  <tr class="<%=cl(lap)%>" >  
    <td  align=right ><%=MonthName(Month(tradedate),true) & "-" & year(tradedate)%></td>
     <td align=right ><%=formatnumber(actualnumtrades,0,true,true,true)%>&nbsp;</td>
     <td align="right"><%= formatnumber(tradevalue,0,true,true,true)%>&nbsp;</td>
     <td   align="right"><%= formatnumber(tradevolume,0,true,true,true)%>&nbsp;</td>
     <td  align="right"><%= formatnumber(aveprice,2,true,true,true)%>&nbsp;</td>
	  <td  align="right"><%if actualnumtrades>0 then 
		response.write formatnumber((tradevalue/actualnumtrades),0,true,true,true)
		else
		response.write "0"
		end if%>&nbsp;</td>
    </tr>
    
    	<%
    	
    	  NEXT
    end if
    %>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->