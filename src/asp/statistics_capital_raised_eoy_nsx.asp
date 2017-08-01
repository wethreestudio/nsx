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
    <li><a href="/statistics_capital_raised_eoy_nsx.asp">Capital Raised By Calendar Year</a></li>
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
<div class="editarea">

<h1>Capital Raised By Calendar Year</h1>
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
SQL = " SELECT year([capitalexdate]), Sum((CASE WHEN [capitalconsideration] IS NULL THEN 0.0 ELSE [capitalconsideration] END)) AS [capitalconsideration], sum((CASE WHEN [capitalchange] IS NULL THEN 0.0 ELSE [capitalchange] END)) AS [capitalchange] "
SQL = SQL & " FROM [capital]"
'SQL = SQL & " WHERE ([capitalchange] > 0) and ([capitalconsideration] > 0) AND ([capitaltype] not like '*option*')"
SQL = SQL & " WHERE (((Capital.CapitalType) Not Like '%option%' AND (Capital.CapitalType Not Like '%escrow%')) AND ((Capital.CapitalChange)>0))"
SQL = SQL & " GROUP BY year([capitalexdate])"
SQL = SQL & " ORDER BY year([capitalexdate]) DESC"


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


<p>&nbsp;	</p>


	<p>Page:
      <%if currentpage > 1 then %>
                <a href="statistics_capital_raised_eom_nsx.asp?currentpage=<%=currentpage-1%>">
	<font face="Arial">«</font></a><a href="statistics_capital_raised_eom_nsx.asp?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="statistics_capital_raised_eom_nsx.asp?currentpage=<%=ii%>" class=rhlinks><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="statistics_capital_raised_eom_nsx.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">»</font></a>
      <%end if%>

</p>


<table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
	<th align=right style="text-align:right;">Date</th> 
	<th align=right style="text-align:right;">Capital Raised $</th> 
	<th align=right style="text-align:right;">Securities Issued</th> 
</tr> 
</thead> 
<tbody>
        <%
    if WEOF then 
    	response.write "<tr><td colspan=12 class=plaintext>No statistics available.</td></tr>" 
    else
    
       for jj = st to fh
      	  
      	  capitaldate = alldata(0,jj)
      	  capitalconsideration = CLng(alldata(1,jj))
		  if len(trim(capitalconsideration & " ")) = 0 then capitalconsideration = 0 
		  securities = 0
		  'Response.Write "<tr colspan=""3""><td>" & alldata(2,jj) & "</td></tr>"
		  If IsNumeric(alldata(2,jj) & "") Then 
			securities = CDbl(alldata(2,jj))
		  End If

		  
      	  if securities <> 0 then
      	  	aveprice = capitalconsideration / securities
      	  else
      	  	aveprice = 0
      	  end if
      	  
      	  
cl = array(" class=""odd"""," class=""even""")
	lap = (-lap)+1
			
    %>
<tr<%=cl(lap)%>> 
    <td align=right ><%=capitaldate%></td>
     <td align=right><%=formatnumber(capitalconsideration,0,true,true,true)%>&nbsp;</td>
     <td align="right"><%= formatnumber(securities,0,true,true,true)%>&nbsp;</td>
     	  </tr>	

    
    	<%
    	
    	  NEXT
    end if
    %>
     
      </tbody>
      </table>
<p> Note: Includes primary and secondary issues </p>
</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->