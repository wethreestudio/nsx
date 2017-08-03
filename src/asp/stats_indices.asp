<%@ LANGUAGE="VBSCRIPT" %>
<%
Response.Buffer = False
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
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel="stylesheet" href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" style="background-color: #FFFFFF" >

<div align==center>
<div class="table-responsive"><table cellspacing=0 border="0" width="100%" id="table100" cellpadding="5" >
	<tr>
		<td class=plaintext bgcolor=#959CA0><font color="#FFFFFF"><b>Index</b></font></td>
		<td class=plaintext bgcolor=#959CA0 align="right">
		<p align="right"><font color="#FFFFFF"><b>Last</b></font></td>
		<td class=plaintext bgcolor=#959CA0 align=right>&nbsp;</td>
		<td class=plaintext bgcolor=#959CA0 align=right><font color="#FFFFFF"><b>% </b></font></td>
	</tr>

<%


cr=vbCRLF
qu=""""
tb=","

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT tradingcode, tradedatetime, [open], last, prvclose,issuedescription"
SQL = SQL & " FROM indexcurrent  "
SQL = SQL & " WHERE (tradingcode<>'TESTINDEX') AND (last<>0)"
SQL = SQL & " ORDER BY tradingcode ASC"

'response.write SQL & CR
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
IF WEOF THEN 
 eml="No Change"
ELSE
    	eml =  ""
  lap=0
       FOR jj = 0 TO rc
      	  nsxcode = ucase(alldata(0,jj))


       	  	last = alldata(3,jj)
       	  	issuedescription = alldata(5,jj)

       	  	prvclose=alldata(4,jj)
          	  	if last=0 then last=prvclose
				if prvclose=0 then prvclose=last
 		 diff = 100 * (last - prvclose)/prvclose 
 		 
 		 	  	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
	
	if diff < 0 then
		clrr = "red"
		clrrimage = "images/down.gif"
	end if
	if diff = 0 then
		clrr = "navy"
		clrrimage = "images/v2/level.gif"
	end if
	if diff > 0 then
		clrr = "green"
		clrrimage = "images/up.gif"
	end if
	
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
      
		<td class=plaintext ><font size="1"><%=nsxcode%></font></td>
		<td class=plaintext align=right><font size="1"><%=formatnumber(last,1)%></font></td>
		<td class=plaintext align=right><img src="<%=clrrimage%>" border=0></td>
		<td class=plaintext align=right><font size="1" color="<%=clrr%>"><%=formatnumber(diff,2)%></font></td>
	</tr>
	
<%		  	
    	  NEXT
  
END IF
if len(eml)>0 then
	response.write "<tr><td class=plaintext><font size=1>" & eml & "</font></td></tr>"
end if


%>

</table></div>
</div>
</body>
</html>