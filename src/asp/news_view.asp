<!--#INCLUDE FILE="include_all.asp"--><%
on error resume next
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function
page_title = "News Item"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

id = request("id")
Set regEx = New RegExp 
regEx.Pattern = "^\d+$" 
isPageValid = regEx.Test(id) 
If Not isPageValid Then
  Response.Redirect "/errorpages/404.html"
  response.end
End If

Set ConnPasswords = GetReaderConn() 
Set rs = Server.CreateObject("ADODB.Recordset")
SQL = "SELECT * FROM news WHERE (id=" & CLng(id) & ")"
rs.Open SQL, ConnPasswords ,1,3
If Not rs.EOF Then
  page_title = rs("NewsTitle")
  meta_description = getSnippet(stripTags(rs("NewsPrecise")),100)
Else 
  Response.Write "ERROR"
  Response.End
End If 

%>
<!--#INCLUDE FILE="header.asp"-->

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Press Release</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
<div class="editarea">

<%

If rs.EOF Then 
  %>
<h1><span>News</span><a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_news.xml"><img class="rss" alt="" src="img/rss.jpg"></a></h1>
<p style="padding:15px">No Article Available.</p>
<% 
Else
%>
<h1><span><%=adjtextarea(rs("NewsTitle") & " ") %></span><a href="<%= Application("nsx_SiteRootURL") %>/ftp/rss/nsx_rss_news.xml"><img class="rss" alt="" src="img/rss.jpg"></a></h1>
<p><%=formatdatetime(rs("newsDate"),1)%></p>
<div>
  <%=adjtextarea(rs("NewsText") & " " )%>
</div>
        
<%
If Trim(rs("NewsAuthor") & " ") <> "" Then
%>
<p><b>Author:</b> <%=adjtextarea(rs("NewsAuthor") & " ")%></p>
<%
End If
If Trim(rs("newssource") & " ") <> "" Then
%>
<p><b>Source:</b> <%=adjtextarea(rs("newssource") & " ")%></p>
<% 
End If
If Trim(rs("newsurl") & " ") <> "" Then
%>
<p><b>&nbsp;</b> <%=adjtextarea(rs("NewsURL") & " ")%></p>
<% 
End If
End If
%>
</div>
</div>
</div>
</div>
</div>
<%
rs.Close
Set rs = Nothing

%>

<!--#INCLUDE FILE="footer.asp"-->
