<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Waivers"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">
<h1>Waivers</h1>
<table border="0" width="100%" cellspacing="0" cellpadding="0">

  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    
    
    &nbsp; Sort By: <a href="rules_waivers.asp?sort=approval">Date Approved</a> |
    			<a href="rules_waivers.asp?sort=issuer">Issuer</a>
	<div align="center">
		<table border="0" width="100%" cellpadding="2" style="border-collapse: collapse" >
<!--#INCLUDE FILE="admin/merchtools.asp"-->

<%

errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1

sortorder = ucase(trim(request("sort") & " "))
sortorder2= sortorder
select case sortorder
	case "APPROVAL"
		sortorder = "dateapproved DESC"
	case "ISSUER"
		sortorder = "RequestedForIssuer,dateapproved DESC"
	case else
		sortorder = "dateapproved DESC"
end select


Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 

ConnPasswords.Open Application("nsx_ReaderConnectionString")
SQL = "SELECT wid,dateapproved,ruledescshort,RequestedForSecurities,SectionNumber,RuleNumber,RequestedForIssuer FROM waivers WHERE displayboard<>'SIMV' ORDER BY " & sortorder 
'Response.write SQL
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
maxpagesize = 20
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
   




  <tr>
    <td width="100%" class="plaintext" colspan="2" align="right"><%if currentpage > 1 then %>
                <a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="rules_waivers.asp?currentpage=<%=currentpage-1%>&sort=<%=sortorder2%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="rules_waivers.asp?currentpage=<%=ii%>&sort=<%=sortorder2%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="rules_waivers.asp?currentpage=<%=currentpage+1%>&sort=<%=sortorder2%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>
</td>
  </tr>

</table>
	</div>
	
	<div align="center">
<table style="border-left-width: 1px; border-right-width: 1px; border-top-width: 1px; border-bottom: 1px solid #666666" width="100%" cellspacing="0" cellpadding="5">
  <tr>
    <td width="10%" class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>DATE APPROVED</b></font></td>
    <td width="90%" class="plaintext" bgcolor="#666666">
	<img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right"><font color="#FFFFFF"><b>WAIVER REQUESTED</b></font></td>
  </tr>
<%  if WEOF then %>
	
  <tr>
    <td width="20%" class="plaintext">&nbsp;</td>
    <td width="80%" class="plaintext">There are no waivers to 
    display.</td>
  </tr>
<% else
		lap=0
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  dateapproved = alldata(1,jj) 
      	  ruledescshort = replace(alldata(2,jj) & " ","<p>","")
		  ruledescshort = replace(ruledescshort & " ","</p>","")
      	  RequestedForSecurities = alldata(3,jj)
      	  SectionNumber = alldata(4,jj)
      	  RuleNumber = alldata(5,jj)
      	  Issuer = alldata(6,jj)
      	  
      	 	cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
      	  
%>
 <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
    <td width="15%" class="plaintext" align="right" valign="top"><%
    
    if len(trim(dateapproved & " "))=0 then
    	response.write dateapproved & " " & id
    	else
    	response.write  day(dateapproved) & "-" & monthname(month(dateapproved),3) & "-" & year(dateapproved)
    	end if
    	
    	%></td>
    <td width="85%" class="plaintext" >Rule: <%=SectionNumber & " " & RuleNumber%><br><b><%=left(adjtextarea(ruledescshort),200)%></b><br>
    Issuer: <%=adjtextarea(left(issuer,150)) %> Securities: <%=adjtextarea(left(RequestedForSecurities,150)) %>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href=<%="rules_waiversview.asp?ID=" & ID%>><i>More ...</i></a>
    </td>
  </tr>
<% NEXT
	end if
	%>



  
</table>
    
    
    <p>&nbsp;</div>
    
    
    </td>
  </tr>
</table>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->