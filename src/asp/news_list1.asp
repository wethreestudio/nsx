<!--#INCLUDE FILE="include_all.asp"-->
<%
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function

page_title = "Press Release"
' meta_description = ""
alow_robots = "yes"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

If Len(Request.ServerVariables("HTTP_X_ORIGINAL_URL")) > 0 Then
	self_url = Request.ServerVariables("HTTP_X_ORIGINAL_URL")
	x = Split(self_url,"?")
	self_url = x(0) 
Else
	self_url = "news_list1.asp"
End If

page = Request.QueryString("page")
menu = Request.QueryString("menu")

objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
hero_banner_class = ""
If menu = "about" Then
    hero_banner_class = "about-page"
End If

%>
<!--#INCLUDE FILE="header.asp"-->

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img"><img src="images/banners/iStock-626304804.jpg" />  </div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Press Release</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<!--#INCLUDE FILE="content_lower_nav.asp"-->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<div class="prop min600px"></div>
<div>
<%
  RenderContent page, "editarea" 
%>
</div>

<div >
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    <div align="center">
<table width="100%" cellspacing="0" cellpadding="5">


<%
errmsg=""
currentpage = trim(request("currentpage"))

if currentpage = "" then
	currentpage = "1"
else 
	'if Not valid_integer(currentpage) Then
	if Not isnumeric(currentpage) Then
		currentpage = "1"
		else
		currentpage = cdbl(currentpage)
	End if

end if

Set ConnPasswords = GetReaderConn() ' Server.CreateObject("ADODB.Connection")
Set CmdDD = Server.CreateObject("ADODB.Recordset")
 
SQL = "SELECT id,newsdate,newstitle,newsprecise FROM news ORDER BY NewsDate DESC,id DESC"
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
    <td width="100%" class="plaintext" colspan="2" align="right">
    <div style="padding-bottom:8px">
    <%if currentpage > 1 then %>
                <a href="<%=self_url%>?nsxcode=<%=nsxcodes%>&currentpage=<%=currentpage-1%>">
	<font face="Arial">&lt;&lt;</font></a><a href="<%=self_url%>?currentpage=<%=currentpage-1%>"> Previous <%=maxpagesize%></a> | 
            <%end if%>
            
            <%
      for ii = 1 to maxpages
            	if ii = currentpage then 
      		response.write "<strong>" & ii & "</strong> | "
      	else
      %>
      <a href="<%=self_url%>?currentpage=<%=ii%>" ><%=ii%></a> | 

      <%
      	end if
      next
      
      
    
      %>
      <%if maxpages > CurrentPage then %>
              
             <a href="<%=self_url%>?currentpage=<%=currentpage+1%>">Next <%=maxpagesize%> 
	<font face="Arial">&gt;&gt;</font></a>
      <%end if%>
    </div>  
</td>
  </tr>
</table>
</div>
	<div align="center">
<table class="tablesorter" style="width:100%">
  <thead>
  <tr>
    <th align="left" width="150">Date</th>
    <th align="left">Article</th>
  </tr>
  </thead>
  <tbody>
<%  if WEOF then %>
	
  <tr>
    <td colspan="2" align="center">There are no news articles available.</td>
  </tr>
<% else
	
      	  for jj = st to fh
      	  
      	  id = alldata(0,jj)
      	  newsdate = alldata(1,jj) 
      	  newstitle = alldata(2,jj)
      	  newsprecise = alldata(3,jj)
      	  
c = " class=""odd"""
If jj Mod 2 = 0 Then c = ""				
    %>
  <tr<%=c%>>
       <td><%=formatdatetime(newsdate,1)%></td>
    <td><b><%=adjtextarea(NewsTitle)%></b><br>
    <%=Replace(getSnippet(stripTags(NewsPrecise),60),"&", "&amp;") %>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="<%="news_view.asp?ID=" & ID%>"><i>More ...</i></a>
    </td>
  </tr>
<% NEXT
	end if
	%>
  </tbody>
</table>
<p>&nbsp;</div>
</td>
</tr>
</table>
</div>
</div>
<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->