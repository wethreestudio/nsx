<!--#INCLUDE FILE="include_all.asp"-->
<%

Response.Redirect "/about/nsx_news"
Response.End

'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function

page_title = "NSX News"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">


<h1><span>NSX News</span><a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_news.xml"><img class="rss" alt="" src="img/rss.jpg"></a></h1>



<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    <div align="center">
<table width="100%" cellspacing="0" cellpadding="5">


<%
errmsg=""
currentpage = trim(request("currentpage"))
if len(currentpage)=0 then currentpage=1
currentpage=cint(currentpage)
if currentpage<1 then currentpage=1


Set ConnPasswords = GetReaderConn() ' Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
SQL = "SELECT id,newsdate,newstitle,newsprecise  FROM news ORDER BY NewsDate DESC"
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

'CmdDD.Close
'Set CmdDD = Nothing

'ConnPasswords.Close
'Set ConnPasswords = Nothing

rowcount = 0
maxpagesize = 30
maxpages = round(.5 + (rc / maxpagesize),0)
st = (currentpage * maxpagesize ) - maxpagesize
fh = st + maxpagesize - 1
if fh > rc then fh = rc

%>
   





  <tr>
    <td width="100%" class="plaintext" colspan="2" align="right"><%if currentpage > 1 then %>
                <a href="announcements_status.asp?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="news_list.asp?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<b>" & ii & "</b> | "
      	else
      %>
      <a href="news_list.asp?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="news_list.asp?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>
</td>
  </tr>
</table>
</div>
	<div align="center">
<table width="100%" cellspacing="0" cellpadding="5" style="border-bottom:1px solid #666666; ">
  <tr>
    <td width="10%" class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>DATE</b></font></td>
    <td width="90%" class="plaintext" bgcolor="#666666"><font color="#FFFFFF"><b>ARTICLE</b></font></td>
  </tr>
<%  if WEOF then %>
	
  <tr>
    <td width="20%" class="plaintext">&nbsp;</td>
    <td width="80%" height="20" class="plaintext">There are no news articles available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  newsdate = alldata(1,jj) 
      	  newstitle = alldata(2,jj)
      	  newsprecise = alldata(3,jj)
      	  
     cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
				
    %>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
       <td width="20%" class="plaintext" valign="top" ><%=formatdatetime(newsdate,1)%></td>
    <td width="80%" height="20" class="plaintext" ><b><%=adjtextarea(NewsTitle)%></b><br>
    <%=adjtextarea(left(NewsPrecise,150)) %>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href=<%="news_view.asp?ID=" & ID%>><i>More ...</i></a>
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
<!--#INCLUDE FILE="footer.asp"-->