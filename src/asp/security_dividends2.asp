<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%
Function remcrlf(xx)
  remcrlf = replace(xx & " ",vbCRLF,"")
  remcrlf = trim(Replace(remcrlf & " ", "''", "'"))
End Function

is_odd = false

Function trClass()
	if is_odd then
		trClass = " class=""odd"""
	else
		trClass = ""
	end if
	is_odd = Not is_odd
End Function

id = request.querystring("nsxcode")
coname=ucase(request("coname"))
%>

<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">

<h1>Dividend Details - <%=Server.HTMLEncode(UCase(id))%> </h1>


<%
errmsg=""

currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


uptodate = request.querystring("uptodate")
if len(id)=0 then id="pmi"
if len(uptodate)=0 then 
	srch =""
	else
	uptodate = cdate(uptodate)
	srch = " AND capitalexdate<='" & FormatSQLDate(uptodate,false) & "' "
end if

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL=" SELECT nsxcode,tradingcode,DivType,DivExDate,DivAnnDate,DivPayDate,DivBooksCloseDate,DivRecDate,DivFreq,DivPeriodCovered,DivFrankRate,DivDesc,DivAmt,DivTaxRate,DivAnnFile"
SQL = SQL & " FROM dividends "
SQL = SQl & " WHERE (nsxcode='" & left(id,3) & "') " & srch
SQL = SQL & " ORDER BY tradingcode,divanndate DESC,id DESC"

'response.write SQL

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

ConnPasswords.Close
Set ConnPasswords = Nothing

rowcount = 0
maxpagesize = 1000
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc
 
    lap = 0
    cl = array("#FFFFFF","#EEEEEE")
    prvcode=""
 


%>



<%  if WEOF then %>
	<p>There is no record available.</p>

  <% else %>
  
  		
  
  		
  

<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="3" align=center>
  <tr>
    <td class="plaintext" nowarp align=left><b><font color="#FFFFFF">Security</font></b></td>
    <td class="plaintext" nowrap align=right><font color="#FFFFFF"><b>Amount $/s</b></font></td>
    <td class="plaintext" nowrap align=right><font color="#FFFFFF"><b>Ex-Date</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" nowrap align=right><font color="#FFFFFF"><b>Record Date</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" nowrap align=right><font color="#FFFFFF"><b>Pay Date</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" nowrap align=right><font color="#FFFFFF"><b>Franking %</b></font></td>
	<td class="plaintext" bgcolor="#666666" height="4" nowrap align=right><font color="#FFFFFF"><b>Type</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" nowrap align="right"><font color="#FFFFFF"><b>Reference</b></font></td>
  </tr>
  	<%
  	lap=1
      	 
      	 for jj = st to fh
      	 tradingcode=alldata(1,jj)
      	 if (prvcode<>tradingcode) and prvcode<>"" then

%>
 <tr><td class=plaintext colspan=8>
<hr noshade color=#808080 width=710 size=1>
</td></tr>
<%
lap = 1
end if

      	 
      	 
      	 
      
 			nsxcode=alldata( 0,jj)
 			DivType=alldata(2,jj)
 			DivExDate=alldata(3,jj)
 			if isdate(DivExDate) then DivExDate = fmtdate(DivExDate)
 			DivAnnDate=alldata(4,jj)
 			if isdate(DivAnnDate) then DivAnnDate = fmtdate(DivAnnDate)
 			DivPayDate=alldata(5,jj)
 			if isdate(DivPayDate) then DivPayDate = fmtdate(DivPayDate)
 			DivBooksCloseDate=alldata(7,jj)
 			if isdate(DivBooksCloseDate) then DivBooksCloseDate= fmtdate(DivBooksCloseDate)
 			DivRecDate=alldata(7,jj)
 			if isdate(DivRecDate) then DivRecDate= fmtdate(DivRecDate)
 			DivFreq=alldata(8,jj)
 			DivPeriodCovered=alldata(9,jj)
 			DivFrankRate=alldata(10,jj) * 100
 			DivDesc=alldata(11,jj)
 			DivAmt=alldata(12,jj)
 			if divamt=0 or divamt=null then divamt="No Dividend"
 			DivTaxRate=alldata(13,jj)
 			DivAnnFile=alldata(14,jj)
			
			
			divurl = "ftp/news/"
			'if (instr(divannfile,"BSX"))>0 then divurl = "http://www.bsx.com.au/dataRepository/"

			
			if divannfile <> "" then
			divannfile="<a href=" & divurl & divannfile & " target=_blank><img src=images/icons/txt.gif border=0></a>"
			else
			divannfile=""
			end if
	  

				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
       <td  valign="top" class="plaintext" align=left><%=tradingcode%>&nbsp;</td>
    <td valign="top" class="plaintext" align=right><%=DivAmt%>&nbsp;</td>
    <td valign="top" class="plaintext" align=right><%=DivExDate%>&nbsp;</td>
    <td valign="top" class="plaintext" align=right><%=DivRecDate%>&nbsp;</td>
    <td valign="top" class="plaintext" align=right><%=DivPayDate%>&nbsp;</td>
    <td valign="top" class="plaintext" align=right><%=DivFrankRate%>&nbsp;</td>
    <td valign="top" class="plaintext" align=right><%=DivType%>&nbsp;</td>
    <td valign="top" class="plaintext" align=center><%=divannfile%>&nbsp;</td>

  </tr>
 
  <%lap = (-lap)+1%>
    
<%

prvcode = tradingcode
NEXT %>

<tr>
<td colspan="8">&nbsp;</td>
</tr>
</table></div>




<%
	end if
	%>



	
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
