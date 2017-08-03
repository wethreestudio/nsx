<%
Function remcrlf(xx)
remcrlf = replace(xx & " ",vbCRLF,"")
remcrlf = trim(Replace(remcrlf & " ", "''", "'"))

End Function


coname=ucase(request("coname"))
%>

<!--#INCLUDE FILE="head.asp"--><html>

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

<body >
<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<div class="table-responsive"><table border="0" width="797" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF">
	<blockquote>
		<h1><b><font face="Arial">CAPITAL RAISED BY SECURITY<br><%=coname%></font></b></h1>
	</blockquote>
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    <blockquote>
    <!--#INCLUDE FILE="admin/merchtools.asp"-->

<%
errmsg=""
DATA_PATH = Server.Mappath("newsxdb\nsxcorporateactions.mdb")
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

id = request.querystring("nsxcode")
uptodate = request.querystring("uptodate")
'if len(id)=0 then id="pmi"
if len(uptodate)=0 then 
	srch =""
	else
	uptodate = cdate(uptodate)
	srch = " AND capitalexdate<=#" & uptodate & "# "
end if

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
strConnString = Application("nsx_ReaderConnectionString") 
ConnPasswords.Open strconnstring
SQL=" SELECT nsxcode,tradingcode,capitalexdate,capitaltype,capitaldescription,capitalchange,capitalannfile,capitalanndate,listedtype,capitalconsideration"
SQL = SQL & " FROM capital "
if len(id)<>0 then
	SQL = SQl & " WHERE (nsxcode='" & left(id,3) & "') " & srch
	SQL = SQL & " ORDER BY tradingcode,capitalexdate,id"
else
	SQL = SQL & " ORDER BY capitalexdate DESC"
end if

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
    
 


%>


<%  if WEOF then %>
	 
   There is no record available.
  <% else %>
  
  		
  
  		
    
	</blockquote>
	<div align="center">
<!--#INCLUDE FILE="header_tables.asp"-->  
<div class="table-responsive"><table border="0" width="720" cellspacing="0" cellpadding="3">
  <tr>
    <td class="plaintext" bgcolor="#666666" height="4"><b><font color="#FFFFFF">Security</font></b></td>
    <td class="plaintext" bgcolor="#666666" height="4" nowrap><font color="#FFFFFF"><b>
	Event Date</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4"><font color="#FFFFFF"><b>
	Type</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4"><font color="#FFFFFF"><b>
	Description</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" align="right"><font color="#FFFFFF"><b>Securities</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" align="right"><font color="#FFFFFF"><b>
	Capital raised $</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4" align="center"><font color="#FFFFFF"><b>
	Reference</b></font></td>
    <td class="plaintext" bgcolor="#666666" height="4"><font color="#FFFFFF"><b>Status</b></font></td>
  </tr>
  	<%
  	lap=1
      	  listed = 0
      	  unlisted = 0
      	  prvcode=""
		  totalconsideration = 0
		  capitalconsideration = 0
		  prvyear = 0
		  curyear = 0
      	 for jj = st to fh
      	 	tradingcode=alldata(1,jj)
      	 

if (prvcode<>tradingcode) and prvcode<>"" then
prvyear = 0 
%>
 <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
   

    <td  bgcolor="#dddddd" valign="top" class="textlabel">&nbsp;</td>
    <td bgcolor="#dddddd" valign="top" class="plaintext" nowrap>Capital Raised in <%=curyear%></td>
    <td bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
    <td bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align="right" nowrap>&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align="right" nowrap><%=formatnumber(totalconsideration,0)%></td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align=center>&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
  </tr>
 <tr><td class=plaintext colspan=8>
Total <%=prvcode%> Listed: <%=formatnumber(listed,0)%><br>
Total <%=prvcode%> Unlisted: <%=formatnumber(unlisted,0)%><br>
Current <%=prvcode%> Issued Capital: <%=formatnumber(unlisted+listed,0)%>
<hr noshade color=#808080 width=700 size=1>
<%totalconsideration =0 %>
</td></tr>
<%
lap = 1
listed = 0
unlisted = 0 
'totalconsideration = 0
capitalconsideration = 0
end if
 
			nsxcode=alldata( 0,jj)
		
			capitalexdate=alldata(2,jj)
			if isdate(capitalexdate) then 
				capitalexdate = fmtdate(capitalexdate)
				curyear = year(capitalexdate)
			end if
			capitaltype=alldata(3,jj)
			capitaldescription=alldata(4,jj)
			capitalchange=formatnumber(alldata(5,jj),0)
			capitalannfile=trim(alldata(6,jj) & " ")
			capitalanndate=alldata(7,jj)
			listedtype=ucase(alldata(8,jj))
			if listedtype="LISTED" then 
				listed = listed + capitalchange
				else
				unlisted = unlisted + capitalchange
			end if
			if isdate(capitalanndate) then capitalanndate = fmtdate(capitalanndate)

			if capitalannfile <> "" then
			
			capurl = "ftp/news/"
			'if (instr(capitalannfile,"BSX"))>0 then capurl = "http://www.bsx.com.au/dataRepository/"
			
			capitalannfile="<a href=" & capurl & capitalannfile & " target=_blank><img src=images/icons/txt.gif border=0></a>"
			else
			capitalannfile=""
			end if
			capitalconsideration=alldata(9,jj)
			if len(trim(capitalconsideration & " ")) = 0 then capitalconsideration =0
			totalconsideration = totalconsideration + capitalconsideration


				
    %>
	<% if (prvyear <> curyear) and prvyear<>0 then %>

  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
   

    <td  bgcolor="#dddddd" valign="top" class="textlabel">&nbsp;</td>
    <td bgcolor="#dddddd" valign="top" class="plaintext" nowrap>Capital Raised in <%=prvyear%></td>
    <td bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
    <td bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align="right" nowrap>&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align="right" nowrap><%=formatnumber(totalconsideration,0)%></td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align=center>&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
  </tr>
  <% 
  'capitalconsideration = 0
 totalconsideration = 0
  end if%>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
   

    <td  valign="top" class="textlabel"><%=tradingcode%></td>
    <td valign="top" class="plaintext" nowrap><%=capitalexdate%></td>
    <td valign="top" class="plaintext"><%=capitaltype%></td>
    <td valign="top" class="plaintext"><%=capitaldescription%></td>
    <td  valign="top" class="plaintext" align="right" nowrap><%=capitalchange%></td>
    <td  valign="top" class="plaintext" align="right" nowrap><%=formatnumber(capitalconsideration,0)%></td>
    <td  valign="top" class="plaintext" align=center><%=capitalannfile%></td>
    <td  valign="top" class="plaintext"><%=listedtype%></td>
  </tr><%lap = (-lap)+1%>
   

<%

prvcode = tradingcode
prvyear = curyear

NEXT %>

  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
   

    <td  bgcolor="#dddddd" valign="top" class="textlabel">&nbsp;</td>
    <td bgcolor="#dddddd" valign="top" class="plaintext" nowrap>Capital Raised in <%=prvyear%></td>
    <td bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
    <td bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align="right" nowrap>&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align="right" nowrap><%
	if totalconsideration=0 then 
		response.write formatnumber(capitalconsideration,0)
		else
		response.write formatnumber(totalconsideration,0)
		end if
		
		%></td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext" align=center>&nbsp;</td>
    <td  bgcolor="#dddddd" valign="top" class="plaintext">&nbsp;</td>
  </tr>

 <tr>
<td class=plaintext colspan=8>
Total <%=tradingcode%> Listed: <%=formatnumber(listed,0)%><br>
Total <%=tradingcode%> Unlisted: <%=formatnumber(unlisted,0)%><br>
Current <%=tradingcode%> Issued Capital: <%=formatnumber(unlisted+listed,0)%>
<% totalconsideration = 0%>
<hr noshade color="#808080" width="700" size="1">
</td></tr>

</table></div>


	</div>
	
<p>&nbsp;</p>
<%
	end if
	%>
<!--#INCLUDE FILE="footer.asp"-->
</body>

</html>