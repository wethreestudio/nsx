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
<meta name="keywords" content="small, medium, company, companies, companys, australia, Australia, Newcastle, 
enterprises, high technology, stock, exchange, stock exchange, Australian, NSX, nsx">
<link rel=stylesheet href="newsx2.css" type="text/css">



<meta name="Microsoft Border" content="none">
<link rel="shortcut icon" href="favicon.ico" ></head>

<body >
<!--#INCLUDE FILE="header.asp"-->
<div align="center">
<div class="table-responsive"><table border="0" width="100%" cellpadding="0" style="border-collapse: collapse" >
  <tr>
    <td valign="top" rowspan="4" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"-->
 
    
    </td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF"  height="30" valign="bottom">
    <h1><b>&nbsp;&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;WOLLONGONG ADVISER LIST</font></b></h1>
    </td>
  </tr>
  <tr>
    <td class="textheader" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    <div align="left">
    <div class="table-responsive"><table align=left border="0" width="100%" cellpadding="0" style="border-collapse: collapse" align="left">
<tr>
<td class="plaintext">


<div align="center">


<div class="table-responsive"><table width="80%" cellspacing="0" cellpadding="0" style="border: 1px dotted #808080">
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<!--#INCLUDE FILE="include/sql_functions.asp"-->
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

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_ReaderConnectionString")   
SQL = "SELECT adid,adName FROM advisers "
SQL = SQL & srch 
SQL = SQL & " ORDER BY adSort"


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
   





  <tr>
    <td width="100%" class="plaintext"><b>Page:&nbsp;</b><%if currentpage > 1 then %>
    
                <a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="advisers_wollongong.asp?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="advisers_wollongong.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="advisers_wollongong.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%> </td>
  </tr>

  <tr>
    <td width="100%" class="plaintext">When contacting advisers please include 
    sufficient detail about the entity to list
    and also allow sufficient time for a considered response to your request.
    </td>
  </tr>
<%  if WEOF then %>
	
  <tr>
    <td width="100%" class="plaintext">There are no advisers available.</td>
  </tr>
<% else
		lap=0
      	  for jj = st to fh
      	  
      	  adid = alldata(0,jj)
      	  adname = adjtextarea(trim(alldata(1,jj)))
      	  if lap = 0 then
      	  	cl = "#EEEEEE"
      	  	lap = 1
      	  else
      	  	cl = "#FFFFFF"
      	  	lap = 0
      	  end if 
      	  	
      	  	
      	  
      	  
%>
 <tr>
    <td width="100%" class="plaintext" bgcolor=<%=cl%>>&nbsp;<img name="LK<%=adid%>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" align="middle"></a>
      <b><%=adname%></b>&nbsp;&nbsp; <a href="adviser_profile.asp?id=<%=adid%>" onmouseover="spec('LK<%=adid%>','imgmnon')" onmouseout="spec('LK<%=adid%>','imgmnoff')"><img border="0" alt="Click for full profile of <%=adname%>"  src="images/v2/icons/Profile.gif" align="middle"></a></td>
  </tr>
<% NEXT
	end if
	%>

<tr>
<td class=plaintext>
<p><b>Page:&nbsp;</b><%if currentpage > 1 then %>
    
                <a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
<font face="Arial">&lt;&lt;</font></a><a href="advisers_wollongong.asp?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="advisers_wollongong.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="advisers_wollongong.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
<font face="Arial">&gt;&gt;</font></a>
      <%end if%> 

</td></tr>

  
</table></div>

<p>&nbsp;</div>

    </td>
    
  </tr>
  
  </table></div>
    </td>
</tr>     
   
      </table></div>
    </div>
    </div>
    </td>
    
  </tr>
</table></div>
<!--#INCLUDE FILE="footer.asp"-->
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p>&nbsp;&nbsp; </p>

</body>

</html>