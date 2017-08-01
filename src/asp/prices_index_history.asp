<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="header.asp"-->
<div class="container_default">
<div class="editarea">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td class="textheader" bgcolor="#FFFFFF" >
		
			<h1>Security Trading History - <%=request("tradingcode")%></h1>
			<p><span style="font-weight: 400">Full trading history is displayed 
			up to the close of business for the previous business day.</span></p>
		</td>
	</tr>
	<tr>
		<td class="plaintext" valign="top" bgcolor="#FFFFFF" style="line-height: 150%">

<%

CSV = ""

Function cnvtime(xx)
 	' convert signal c time into windows time
	'hhmmss <--> hh:mm:ss
	hh = left(xx,2)
	ss = right(xx,2)
	mm = mid(xx,3,2)
	cnvtime = hh & ":" & mm & ":" & ss
	cnvtime = timeserial(hh,mm,ss)
end function

Function cnvdate(xx)
' convert yyyymmdd <---> windows date
yyyy = left(xx,4)
mm = mid (xx,5,2)
dd = right(xx,2)
'response.write xx & "<br>"
cnvdate=dateserial(yyyy,mm,dd)
End Function

Function cnvddmmyyyy(xx)
' convert dates in dd-mmm-yyyy format
dd = day(xx)
mm = monthname(month(xx),1)
yy = year(xx)
cnvddmmyyyy = dd &"-"& mm & "-" & yy
End Function
		
		

todayfile = ucase(request("tradingcode"))
coname = SafeSqlParameter(request("coname"))

	Set ConnPasswords = CreateObject("ADODB.Connection")
	Set CMDDD = CreateObject("ADODB.Recordset")
	  
	ConnPasswords.Open Application("nsx_ReaderConnectionString")
	' get valid dates
	SQL = "SELECT DISTINCT tradingcode FROM indexcurrent "
	SQL = SQL & "WHERE tradingcode='" & SafeSqlParameter(nsxcode) & "' "
	SQL = SQL & "ORDER by tradingcode ASC "
	CMDDD.Open SQL,Connpasswords
	%>
	
	<form method="POST" name="dates" action="prices_index_history.asp?tradingcode=<%=nsxcode%>&coname=<%=coname%>">
	
	<%
	
if not CMDDD.EOF then
	
	response.write "<h2>Please select an NSX Code to view details</h2>"
	aa = "<SELECT size=1 name=validdates>"
	
	while not CMDDD.EOF
	SecCode = trim(cmddd("tradingcode"))
		aa=aa & "<option value=" & SecCode 
		if todayfile = SecCode then aa = aa &  " SELECTED "
		aa = aa & ">" & SecCode & "</option>"
		CMDDD.Movenext
	wend	
		aa=aa &  "</SELECT>&nbsp;<input type=submit value='Get Trades' name=B1>"
		response.write aa
end if


%>
	
	</form>
	


	

<%
CMDDD.Close
Set CMDDD= Nothing

if todayfile<>"" then
	Set CMDDD = CreateObject("ADODB.Recordset")
	' get valid trades for day
	SQL = "SELECT tradingcode,tradedatetime,[open],high,low,[last] "
	SQL = SQL & "FROM indexdaily "
	SQL = SQL & "WHERE tradingcode='" & SafeSqlParameter(todayfile) & "' "
	SQL = SQL & "ORDER BY TradeDateTime ASC"
		
	'response.write SQL
	'response.end
	
	CMDDD.Open SQL,Connpasswords,1,3

	WEOF = CmdDD.EOF
	
	if not WEOF then 
		alldata = cmddd.getrows
		rc = ubound(alldata,2) 
	else
		rc = -1
	end if

	CmdDD.Close
	Set CmdDD = Nothing

	
	TXT = ""
	cr=vbCRLF
	qu=""""
	'tb=","
	tb=vbTAB
	todayfile = Replace(todayfile,"/","-")
	todayfile = Replace(todayfile,"\","-")
	todayfile = Replace(todayfile,".","-")
	ppath = Server.MapPath("ftp/profiles/" & "index_" & todayfile & ".xls")
		%>
		<img border="0" src="images/broker_page1_bullet.gif" width="20" height="15"><a href="ftp/profiles/index_<%=todayfile%>.xls" target=_blank>Right 
click to save file to disk</a>

<div align="center">
<table border="0" style="border-collapse: collapse" width="650" cellpadding="0" cellspacing="1">
  <tr>
  <td class="plaintext" bgcolor="#666666" colspan=8><font color="#FFFFFF"><b><%=coname & " (" & todayfile & ")"%></b></font></td>
  </tr>
  
  <tr>
   <td class="plaintext" bgcolor="#666666" style="border: 1px solid #666666" nowrap><font color="#FFFFFF"><b>Date/Time</b></font></td>
    <td class="plaintext" bgcolor="#666666" align="right" style="border: 1px solid #666666" nowrap><font color="#FFFFFF"><b>Open </b> 
	</font> </td>
    <td class="plaintext" bgcolor="#666666" align="right" style="border: 1px solid #666666" nowrap><font color="#FFFFFF"><b>High</b></font></td>
    <td class="plaintext" bgcolor="#666666" align="right" style="border: 1px solid #666666" nowrap><font color="#FFFFFF"><b>Low $</b></font></td>
   
    <td class="plaintext" bgcolor="#666666" style="border: 1px solid #666666" align="right" nowrap><font color="#FFFFFF"><b>Last</b></font></td>
    
  </tr>
  <%
  
  TXT = TXT & qu & "Date" & qu & tb
  TXT = TXT & qu & "Open" & qu & tb
  TXT = TXT & qu & "High" & qu & tb
  TXT = TXT & qu & "Low" & qu & tb
  TXT = TXT & qu & "Last" & qu & tb
  TXT = TXT & qu & "Code" & qu & tb
  TXT = TXT & qu & "Description" & qu & tb
  TXT = TXT & cr
  
  maxtrades=request("maxtrades")
  if maxtrades="all" then 
  	maxtrades=rc+1
  	else
  	maxtrades = 50 ' # of trades to display on screen.
  end if
  
  lap = 1
  cllap = 0
 
	for jj = 0 to rc
	
		SQL = "SELECT tradingcode,tradedatetime,[open],high,low,[last] "

	tradingcode=alldata(0,jj)
	tradedatetime=alldata(1,jj)
	open=alldata(2,jj)
	high=alldata(3,jj)
	low=alldata(4,jj)
	last=alldata(5,jj)
	
	cl = array("#EEEEEE","#FFFFFF")
	cllap = (-cllap)+1
	status = " "
	
	if open = 0 then open = last
	if high = 0 then high = last
	if low = 0 then low = last

	' server loaded and only write out 20 values to screen.  Everything still goes to file.
	if rc <= maxtrades then			
    %>
  <tr bgcolor="<%=cl(cllap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(cllap)%>'">
     <td class="texthint"  style="border: 1px solid #666666" nowrap><%=cnvddmmyyyy(tradedatetime) & " " & formatdatetime(tradedatetime,3)%></td>
    <td class="texthint" align=right style="border: 1px solid #666666" nowrap><%=formatnumber(open,3)%>&nbsp;</td>
    <td class="texthint" align=right  style="border: 1px solid #666666" nowrap><%=formatnumber(high,3)%>&nbsp;</td>
    <td class="texthint" align=right style="border: 1px solid #666666" nowrap><%=formatnumber(low,3)%>&nbsp;</td> 
    <td class="texthint" style="border: 1px solid #666666" align="right" nowrap><%=formatnumber(last,3)%>&nbsp;</td>
  </tr>
  
	<%
	end if
	
	TXT = TXT & qu & cnvddmmyyyy(tradedatetime) & qu & tb
	TXT = TXT & open  & tb
  	TXT = TXT & high & tb
  	TXT = TXT & low  & tb
  	TXT = TXT & last  & tb
  	TXT = TXT & qu & tradingcode & qu & tb
  	TXT = TXT & qu & coname & qu & cr
	
	
		lap = lap + 1
	NEXT
		lap = lap - 1
	%>
	<tr>
    <td class="plaintext" colspan="8">
    <%
    if rc > maxtrades then
    response.write "<br>The above data for all trades has been written to file.  Please download the above spreadsheet to see all trades."
    end if
    %> 
    </td>
  </tr>

	</table>
</div>
<p>
<%

' create company trade file for download PRN/TXT style file for inport into excel.
'response.write ppath & "<br>"
'response.end
Set MyFileObject=CreateObject("Scripting.FileSystemObject")
Set MyTextFile=MyFileObject.CreateTextFile(ppath)
MyTextFile.Write TXT
MyTextFile.Close
Set MyTextFile = nothing
Set TXT = nothing



end if


%>    </td>
</table>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->