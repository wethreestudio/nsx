<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Company Search"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  'Response.Redirect "/"
End If
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
                <h1>Company Search</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<div class="prop min600px"></div>
<%
 '' RenderContent page, "editarea" 
%>

<div class="editarea">
<%
PrintSearchBox "NSX Company Search", "company", "350", "Enter company name or code", ""
%>
<hr>
<h2>By Sector</h2>
<ul>
<li><a href="prices_alpha.asp?nsxcode=&amp;board=ncrp&amp;region=">Industrial</a></li>
<li><a href="prices_alpha.asp?nsxcode=&amp;board=nprp&amp;region=">Property</a></li>
<li><a href="prices_alpha.asp?nsxcode=&amp;board=ndbt&amp;region=">Debt</a></li>
<li><a href="prices_alpha.asp?nsxcode=&amp;board=nmin">Mining &amp; Energy</a></li>
<li><a href="prices_alpha.asp?nsxcode=&amp;board=nrst">Restricted</a></li>
</ul>

<h2>Certficated Securities</h2>
<ul>
<li><a href="prices_alpha.asp?nsxcode=&amp;currentpage=1&amp;board=comm&amp;region=">Community Banks</a></li>
<li><a href="prices_alpha.asp?nsxcode=&amp;currentpage=1&amp;board=main&amp;region=">Industrial</a></li>
<li><a href="prices_alpha.asp?nsxcode=&amp;currentpage=1&amp;board=prop&amp;region=">Property</a></li>
</ul>

 <hr>
<h2>Complete NSX list</h2>
<p><a href="/prices_alpha.asp?nsxcode=&amp;currentpage=1&amp;region=">View complete list here <br>
</a></p>

<hr>
<h2>Suspended and delisted</h2>
<p>View companies that have been suspended <a href="/marketdata/suspended">here</a>.</p>
<p>View companies that have been delisted <a href="/marketdata/delisted">here</a>.</p></div>

</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->