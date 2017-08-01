<!--#INCLUDE FILE="include_all.asp"-->
<%

Function GetGuid() 
    Set TypeLib = CreateObject("Scriptlet.TypeLib") 
    GetGuid = Left(CStr(TypeLib.Guid), 38) 
    Set TypeLib = Nothing 
End Function  

Session("feedbackkey") = GetGuid()

' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If


'objJsIncludes.Add "validate_js", "js/jquery.validate.js"

%>
<!--#INCLUDE FILE="header.asp"-->

<!--div class="container_cont">

<div id="wrap" -->
<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "side_menu.asp"
%>

<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
  <div style="float:left;width:750px;">
  
  
<h1>Company Search &amp; Information</h1>
<h2>Search by NSX Code</h2>
<p>(Enter code box)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Go (box) (<a href="http://www.asx.com.au/research/company-research.htm">like ASX site</a>)</p>
<p>Find a Code:&nbsp; (popup name to code search)</p>
<h2>Detailed Search</h2>
<p>Search by:</p>
<ul>
    <li>Code&nbsp; (box)&nbsp; <a href="http://www.asx.com.au/asx/research/companyInfo.do">(like ASX detailed search site)</a></li>
    <li>Company Name</li>
    <li>Sector</li>
</ul>
<h2>Complete NSX list</h2>
<p><a href="/market_officiallist.asp">View complete list here <br />
</a></p>
<h2>Suspended and delisted</h2>
<p>View companies that have been suspended <a href="/marketdata/suspended">here</a>.</p>
<p>View companies that have been delisted <a href="/marketdata/delisted">here</a>.</p>  
  
  
  <%
    RenderContent page,"editarea" 
  %>
  </div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->