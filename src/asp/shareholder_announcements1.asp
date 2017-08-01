<!--#INCLUDE FILE="include_all.asp"-->
<%
'------------------------------------------
' Adjust textarea box formatting
'str: the string to be adjusted
Function AdjTextArea(str)
	AdjTextArea = trim(Replace(str & " ", vbCrLf, "<BR>"))
	AdjTextArea = trim(Replace(AdjTextArea & " ", "''", "'"))

End Function

page_title = "Market Annoucements"
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

%>
<!--#INCLUDE FILE="header.asp"-->

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Announcements</h1>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<!--#INCLUDE FILE="content_lower_nav.asp"-->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<%
  'RenderContent page, "editarea" 
%>
</div>

<div style="clear:both;"></div>
<div class="row">

<table class="table">
<tr>
    <td>
    <a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=W">
    Lodged in the last week</a></td></tr>
    <tr><td><a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=M">
    Lodged in the last month</a></td></tr>
    <tr><td><a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=M3">
    Lodged in the last 3 months</a></td></tr>
    <tr><td><a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=D&amp;period=M6">
    Lodged in the last 6 Months</a></td></tr>

<%
for ii = year(date) to 2005 step -1
%>
<tr><td>
<a target="_blank" href="http://www.asx.com.au/asx/statistics/announcements.do?by=asxCode&amp;asxCode=nsx&amp;timeframe=Y&amp;year=<%=ii%>">
Lodged during <%=ii%></a>
</td></tr>
<%next%>
</tr>
</table>
</div>
</div>
<div style="clear:both;"></div>
</div>
</div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->