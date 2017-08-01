<!--#INCLUDE FILE="include/sql_functions.asp"-->
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
<link rel="stylesheet" href="admin/admin.css" type="text/css">
<STYLE TYPE="text/css">
     P.breakhere {page-break-before: always}
</STYLE >



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body bgcolor=white >

<div align="center">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td  class="textheader" bgcolor="#FFFFFF" >
    <h1><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;</font></font><font face="Arial" color="#000000">NSX 
	FACILITATOR&nbsp;CONTACT SHEET </font></b></h1>
	
		<p><a href="<%= Application("nsx_SiteRootURL") %>">www.nsxa.com.au</a><br>
		<font size="2"><%=formatdatetime(date,1)%></font></p>
	
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
&nbsp;<div align="center">

<!--#INCLUDE FILE="admin/merchtools.asp"-->

<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1




state = trim(request.querystring("state") & " ")
suburb = trim(request.querystring("suburb") & " ")
srch = " WHERE (adstatus = 1) "
if state <> "" then srch = srch & " AND  (adstate='" & SafeSqlParameter(state) & "')"
if suburb <> "" then srch = srch & " AND  (adsuburb='" & SafeSqlParameter(suburb) & "')"

board=ucase(trim(request("board")))
if len(board)<>0 then srch = srch & " AND (addisplayboard LIKE '" & SafeSqlParameter(board) & "') "

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT adid,adName,Address,POBOX,AdEmail,Websites,Logo,Strapline,Phone,Fax FROM shfden "




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
maxpagesize = 30
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
   


  <table width="100%" cellspacing="1" cellpadding="5" style="border-bottom:1px solid #808080; ">
 
<%  if WEOF then %>
	
  <tr>
    <td width="100%" class="plaintext" colspan=2>There are no records available.</td>
  </tr>
<% else
		lap = 0
      	  for jj = 0 to rc step 2
      	  
      	  jj1 = jj
      	  jj2 = jj1 + 1
      	  if jj2 > rc then jj2 = rc
      	  adid1 = alldata(0,jj1)
      	  adid2 = alldata(0,jj2)
      	  adname1 = adjtextarea(trim(alldata(1,jj1)))
      	  adname2 = adjtextarea(trim(alldata(1,jj2)))
      	  
      	  address1 = adjtextarea(trim(alldata(2,jj1)))
      	  address2 = adjtextarea(trim(alldata(2,jj2)))
      	  
      	  pobox1 = adjtextarea(trim(alldata(3,jj1)))
      	  pobox2 = adjtextarea(trim(alldata(3,jj2)))
      	  
      	  email1 = adjtextarea(trim(alldata(4,jj1)))
      	  email2 = adjtextarea(trim(alldata(4,jj2)))

		  web1 = adjtextarea(trim(alldata(5,jj1)))
      	  web2 = adjtextarea(trim(alldata(5,jj2)))
      	  
      	  logo1 = adjtextarea(trim(alldata(6,jj1)))
      	  logo2 = adjtextarea(trim(alldata(6,jj2)))


      	  strap1 = adjtextarea(trim(alldata(7,jj1)))
      	  strap2 = adjtextarea(trim(alldata(7,jj2)))


      	  phone1 = adjtextarea(trim(alldata(8,jj1)))
      	  phone2 = adjtextarea(trim(alldata(8,jj2)))

      	  fax1 = adjtextarea(trim(alldata(9,jj1)))
      	  fax2 = adjtextarea(trim(alldata(9,jj2)))

				
    %>
  <tr bgcolor=gray>
       <td width="50%" class="plaintextw" ><b><%=adname1%></b></td>
      <td width="50%" class="plaintextw" ><b><%=adname2%></b></td>
      
  </tr>
  <tr >
  <td class=plaintext valign="top">
  <%=address1%><br>
  phone: <%=phone1%><br>
  fax: <%=fax1%><br>
  email: <%=email1%><br>
  web:   <%=web1%><br>
  </td>
  <td class=plaintext valign="top">
    <%=address2%><br>
  phone: <%=phone2%><br>
  fax: <%=fax2%><br>
  email: <%=email2%><br>
  web:   <%=web2%><br>  </td>
  </tr>
  <%
  ' put in page break for print out
  lap = lap + 2
  if lap >= 14 and (jj+1) <= rc then
  	lap = 0
  	response.write "</table><p class=breakhere>&nbsp;</p>"

  	%>
  	
  	  <table width="100%" cellspacing="1" cellpadding="5" style="border-bottom:1px solid #808080; ">
  	
  	<%
  	
  end if

 NEXT
	end if
	%>


  
</table>
</div>



&nbsp;
    </td>
    
  </tr>
  </table>
</div>

<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>
</body>

</html>