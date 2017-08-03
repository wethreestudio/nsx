<!--#INCLUDE FILE="include_all.asp"-->
<%
board=ucase(trim(request("region")))
alow_robots = "no"

objCssIncludes.Add "tablesortercss", "css/table_sort_blue.css"

%>

<!--#INCLUDE FILE="header.asp"-->

<div class="container_cont">
<div class="editarea">

<h1>Nominated Adviser List by Security Represented</h1>
<p>
Below is a list of Nominated Advisers and a list of securities attached to those advisers. Under the rules all Issuers are required to have a Nominated Adviser.
</p>
<p><b>Other Options</b>: <a href="adviser_list.asp">Alphabetical Adviser List</a>| <a href="adviser_list_print.asp?region=<%=board%>">Printable Contact Sheet</a>
</p>


  <div class="table-responsive"><table width="100%" cellspacing="0" cellpadding="0" >
<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1





Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_ReaderConnectionString")
'SQL = "SELECT agadvisers,nsxcode,agname,agdelisteddate FROM coDetails "
'SQL = SQL & " WHERE " 
'SQL = SQL & " ORDER BY agadvisers ASC"


SQL = "SELECT DISTINCT coDetails.nsxcode, coDetails.coName, coDetails.agAdvisers, coIssues.IssueStatus "
SQL = SQL & " FROM coDetails INNER JOIN coIssues ON coDetails.nsxcode = coIssues.nsxcode"
SQL = SQL & " WHERE (((coIssues.IssueStatus)='active'))"
SQL = SQL & " ORDER BY coDetails.agAdvisers"


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
    
                <a href="/adviser_list_by_security.asp?region=<%=board%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="/adviser_list_by_security.asp?region=<%=board%>&currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="/adviser_list_by_security.asp?region=<%=board%>&currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="/adviser_list_by_security.asp?region=<%=board%>&currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%> </td>
  </tr>

  <tr>
    <td width="100%" class="plaintext">&nbsp;</td>
  </tr>
  </table></div>

  
  
  
  
  
<div class="table-responsive"><table id="myTable" class="tablesorter1" width="99%"> 
<tbody>
<%  if WEOF then %>
  <tr>
    <td width="100%" class="plaintext">There are no advisers available.</td>
  </tr>
<% else
	prevadviser=""
	lap = 1
      	  for jj = st to fh
      	  
      	  adviser = adjtextarea(trim(alldata(2,jj) & " "))
      	  nsxcode=alldata(0,jj)
      	  agname = adjtextarea(trim(alldata(1,jj)))
      	  status=alldata(3,jj)
      	  
      	 cl = array("#EEEEEE","#FFFFFF")
	

	if prevadviser<>adviser then 
%>
	<tr bgcolor="#808080" >
       <td class="whitelinks"><img border="0" src="/images/nsxdiag.gif" width="22" height="11" align="right">&nbsp;<img name="LK<%=adid%>" border="0" src="images/v2/LPOINT1.jpg" width="15" height="7" align="middle"></a>
      <b><%=adviser%></b>&nbsp 
	</td></tr>
<% 
prevadviser = adviser
 lap = (-lap)+1
end if ' adviser test%>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"  colspan=2>
       <td class="plaintext"><%="(" & nsxcode & ") " & agname %></b>&nbsp</td></tr>
 <%
lap = (-lap)+1
 NEXT
END IF ' if ther are records

%>

</td>
</tr>


 </tbody> 
</table></div>
</div>

</div>
<!--#INCLUDE FILE="footer.asp"-->