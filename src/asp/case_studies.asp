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
menu = Request.QueryString("menu")
'Response.Write("menu=[ " + menu + " ]")
'Response.Write("page=[ " + page + " ]")

hero_banner_class = ""
If menu = "about" Then
    hero_banner_class = "about-page"
End If

Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  'Response.Redirect "/"
   'Response.Write("pageNOTVALID=" + page + "]")
End If
    'Response.Write("pageVALID=" + page + "]")

Function CleanUpPageName(page)
    pageName = Replace(page,"_"," ")
    Response.write(pageName)
End Function
%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<!--TODO "hero_banner.asp"-->

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img">
        <% If page="why_list" Then %>
            <img src="images/listing_hero_banner_1.jpg" />
        <% ElseIf menu = "about" Then %>
            <img src="images/about_banner_1.jpg" />
        <% ElseIf menu = "why_nsx" Then %>
            <img src="images/brokers_banner_1.jpg" />
        <% End if %>
    </div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <% If menu="companies_pre_listed" Then %>
                    <h1>Listing</h1>
                <% ElseIf menu = "companies_listed" Then %>
                    <h1>Listing</h1>
                <% ElseIf menu = "about" Then %>
                    <div class="about-top-story">OUR STORY</div>
                    <h1>A startup since 1937 - National Stock Exchange of Australia</h1>
                <% ElseIf menu = "investors" Then %>
                    <h1>Investing</h1>
                <% Else %>
                    <h1><%=CleanUpPageName(page)%></h1>
                <% End if %>

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

    <% If page="why_list" then %>
        
        <div class="row">
            <div class="col-sm-12">
                <h1>List here, it's much better than the competition</h1>
            </div>
            <div class="col-sm-6"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis ultricies ipsum. Ut id eleifend arcu, vel ultricies ante. Phasellus dapibus tempus risus sit amet varius. In congue aliquet odio et pellentesque. Aliquam erat volutpat. Nunc dictum lacus pellentesque tincidunt egestas. Nullam consectetur diam at elit tristique sagittis. Donec mattis, erat eleifend euismod blandit, nulla massa auctor odio, et rutrum ex lacus ut lacus. Praesent lobortis et lorem at tristique. Donec nec tincidunt augue. Nam mollis in dui vitae efficitur. Fusce tristique fringilla ipsum, eget venenatis erat ullamcorper non. Praesent rutrum arcu sagittis pharetra malesuada.</p></div>
            <div class="col-sm-6"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis ultricies ipsum. Ut id eleifend arcu, vel ultricies ante. Phasellus dapibus tempus risus sit amet varius. In congue aliquet odio et pellentesque. Aliquam erat volutpat. Nunc dictum lacus pellentesque tincidunt egestas. Nullam consectetur diam at elit tristique sagittis. Donec mattis, erat eleifend euismod blandit, nulla massa auctor odio, et rutrum ex lacus ut lacus. Praesent lobortis et lorem at tristique. Donec nec tincidunt augue. Nam mollis in dui vitae efficitur. Fusce tristique fringilla ipsum, eget venenatis erat ullamcorper non. Praesent rutrum arcu sagittis pharetra malesuada.</p></div>
        </div>

        <div class="row green-section">
            <div class="col-sm-8">
                <div class="subpage-center">
                    <div class="prop min600px"></div>
                      <%
                      RenderContent page, "editarea" 
                    %>
                </div>
            </div>
            <div class="col-sm-4"><div class="stat-section green"><h3>Key NSX Stat</h3><span class="large-text">71</span></div></div>
        </div>

        <div class="row">
            <div class="col-sm-12"><h2>Advisor List</h2></div>
        </div>

        <div class="row">
            <div class="col-sm-6"><h2>More infomation on why we rock</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis ultricies ipsum. Ut id eleifend arcu, vel ultricies ante. Phasellus dapibus tempus risus sit amet varius. In congue aliquet odio et pellentesque. Aliquam erat volutpat. Nunc dictum lacus pellentesque tincidunt egestas. Nullam consectetur diam at elit tristique sagittis. Donec mattis, erat eleifend euismod blandit, nulla massa auctor odio, et rutrum ex lacus ut lacus. Praesent lobortis et lorem at tristique. Donec nec tincidunt augue. Nam mollis in dui vitae efficitur. Fusce tristique fringilla ipsum, eget venenatis erat ullamcorper non. Praesent rutrum arcu sagittis pharetra malesuada.</p></div>
            <div class="col-sm-6"><div class="grey-back"><h2>Interested in listing?</h2></div></div>
        </div>

        <div class="row">
            <div class="col-sm-6">
                <h2>Market Data</h2>
                <div>Stats Plugin</div>
            </div>
            <div class="col-sm-6"><h2>Another point on why the nsx</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis ultricies ipsum. Ut id eleifend arcu, vel ultricies ante. Phasellus dapibus tempus risus sit amet varius. In congue aliquet odio et pellentesque. Aliquam erat volutpat. Nunc dictum lacus pellentesque tincidunt egestas. Nullam consectetur diam at elit tristique sagittis. Donec mattis, erat eleifend euismod blandit, nulla massa auctor odio, et rutrum ex lacus ut lacus. Praesent lobortis et lorem at tristique. Donec nec tincidunt augue. Nam mollis in dui vitae efficitur. Fusce tristique fringilla ipsum, eget venenatis erat ullamcorper non. Praesent rutrum arcu sagittis pharetra malesuada.</p>
            </div>
        </div>

    <%  else %>

        <div class="row">
            <div class="col-sm-12">
                <div class="subpage-center">
                    <div class="prop min600px"></div>
                    <%
                      RenderContent page, "editarea" 
                    %>
                </div>
            </div>
        <div style="clear:both;"></div>
        </div>

    <% End If %>
  
</div>
<!--#INCLUDE FILE="footer.asp"-->