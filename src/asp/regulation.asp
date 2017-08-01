<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Regulation"
' meta_description = ""
' alow_robots = "no"

objJsIncludes.Add "lightbox", "/js/jquery.lightbox.js"
objJsIncludes.Add "cms_page", "/js/cms_page.js"

' testtesttest
' W:\staging.nsxa.com.au\css\jquery.lightbox-0.5.css
' Now in allstyles.css - objCssIncludes.Add "lightbox", "/css/jquery.lightbox-0.5.css"     

page = Request.QueryString("page")
menu_regu = Request.QueryString("menu")

hero_banner_class = ""
If menu_regu = "about" Then
    hero_banner_class = "about-page"
End If

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

<!--TODO OWNINCLUDE FILE="hero_banner.asp"-->

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img"><img src="images/banners/iStock-161861470.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Regulation</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <%
                RenderContent page, "editarea" 
            %>

          

        </div>
    </div>
</div>
<!--#INCLUDE FILE="footer.asp"-->