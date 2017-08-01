<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="header.asp"-->
<%
board=ucase(trim(request("region")))
%>
    	<div class="container_cont">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="3" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td  class="textheader" bgcolor="#FFFFFF" >
    <h1><b>&nbsp;<font color="#FFFFFF">&nbsp;&nbsp;&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;</font></font><font face="Arial">NOMINATED 
    ADVISER&nbsp;LIST</font></b></h1>
    </td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">

	Other Options:
	<a href="adviser_list_print.asp?region=<%=board%>">Printable Contact Sheet</a> 
	| <a href="adviser_list_by_security.asp">Adviser List by Security</a>
<div align="center">
  <table width="100%" cellspacing="0" cellpadding="0" >
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


if len(board)<>0 then srch = srch & " AND (addisplayboard LIKE '%" & SafeSqlParameter(board) & "%') "

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT adid,adName,listeddate FROM advisers "
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
maxpagesize = 50
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
   





  <tr>
    <td width="100%" class="plaintext"><b>Page:&nbsp;</b><%if currentpage > 1 then %>
    
                <a href="adviser_list.asp?region=<%=board%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="adviser_list.asp?region=<%=board%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="adviser_list.asp?region=<%=board%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="adviser_list.asp?region=<%=board%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%> </td>
  </tr>

  <tr>
    <td width="100%" class="plaintext">Under the rules all Issuers are required 
	to appoint and maintain at all times a Nominated Adviser.&nbsp; When contacting advisers please include 
    sufficient detail about the entity to list
    and also allow sufficient time for a considered response to your request. 
	The number of registered Nominated Advisers is <%=rc+1%>.
    </td>
  </tr>
  </table>

  <table width="100%" cellspacing="0" cellpadding="5" style="border-bottom:1px solid #808080; ">
 
<%  if WEOF then %>
	
  <tr>
    <td width="100%" class="plaintext">There are no advisers available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  adid = alldata(0,jj)
      	  adname = adjtextarea(trim(alldata(1,jj)))
      	  listeddate=alldata(2,jj)
      	  listedyear = ""
      	  memberyears = ""
      	  if isdate(listeddate) then
      	  	listedyear=year(listeddate)
      	  	memberyears = year(date) - listedyear
      	  end if
      	 cl = array("#EEEEEE","#FFFFFF")
	
	
	stat = "even" 
    SELECT CASE abs(jj) mod 2 
        CASE 1: stat = "odd" 
    END SELECT 
    'Response.write jj & " is " & stat 

				
   if stat="even" then %>
   
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"  colspan=2>
  <% end if ' even/odd cells %>
       <td class="plaintext" width=360><img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right">&nbsp;<img name="LK<%=adid%>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" align="middle"></a>
      <b><%=adname%></b>&nbsp;&nbsp; <a href="adviser_profile.asp?id=<%=adid%>&region=<%=board%>" onmouseover="spec('LK<%=adid%>','imgmnon')" onmouseout="spec('LK<%=adid%>','imgmnoff')"><img border="0" alt="Click for full profile of <%=adname%>"  src="images/v2/icons/Profile.gif" align="middle"></a> 
		<br><font size=1>member since: <%=listedyear%></font></td>
 <%
 	if stat="odd" then 
 		response.write "</tr>"
 		lap = (-lap)+1
 	end if
 NEXT
	if stat="even" then response.write "</tr>"
	end if
	%>
<tr>
<td class="plaintext"> 
<p>
<b>Page:&nbsp;</b><%if currentpage > 1 then %>
    
                <a href="adviser_list.asp?region=<%=board%>&currentpage=<%=currentpage-1%>">
<font face="Arial">&lt;&lt;</font></a><a href="adviser_list.asp?region=<%=board%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="adviser_list.asp?region=<%=board%>&currentpage=<%=ii%>" ><%=ii%></a> | 
      <%
      	end if
      next
     
      %>
      <%if maxpages > CurrentPage then %>
             <a href="adviser_list.asp?region=<%=board%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
<font face="Arial">&gt;&gt;</font></a>
      <%end if%></p>
</td>
</tr>


  
</table>
</div>



&nbsp;
    </td>
    
  </tr>
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->