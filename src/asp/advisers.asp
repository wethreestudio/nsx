<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
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
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Advisers</h1>
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
            <h1>Compliance is no joke, we take it really seriously</h1>
        </div>
        <div class="col-sm-6"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis ultricies ipsum. Ut id eleifend arcu, vel ultricies ante. Phasellus dapibus tempus risus sit amet varius. In congue aliquet odio et pellentesque. Aliquam erat volutpat. Nunc dictum lacus pellentesque tincidunt egestas. Nullam consectetur diam at elit tristique sagittis. Donec mattis, erat eleifend euismod blandit, nulla massa auctor odio, et rutrum ex lacus ut lacus. Praesent lobortis et lorem at tristique. Donec nec tincidunt augue. Nam mollis in dui vitae efficitur. Fusce tristique fringilla ipsum, eget venenatis erat ullamcorper non. Praesent rutrum arcu sagittis pharetra malesuada.</p></div>
        <div class="col-sm-6"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis ultricies ipsum. Ut id eleifend arcu, vel ultricies ante. Phasellus dapibus tempus risus sit amet varius. In congue aliquet odio et pellentesque. Aliquam erat volutpat. Nunc dictum lacus pellentesque tincidunt egestas. Nullam consectetur diam at elit tristique sagittis. Donec mattis, erat eleifend euismod blandit, nulla massa auctor odio, et rutrum ex lacus ut lacus. Praesent lobortis et lorem at tristique. Donec nec tincidunt augue. Nam mollis in dui vitae efficitur. Fusce tristique fringilla ipsum, eget venenatis erat ullamcorper non. Praesent rutrum arcu sagittis pharetra malesuada.</p></div>
    </div>

    <div class="row">
        <div class="col-sm-6">
            <h2>Market Data</h2>
            <div>Stats Plugin</div>
        </div>
        <div class="col-sm-6"><div class="grey-back-listing"><h2>Interested in listing?</h2></div></div>
    </div>

</div>
<!--#INCLUDE FILE="footer.asp"-->