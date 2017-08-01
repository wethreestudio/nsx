<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Connectivity"
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
    <div class="hero-banner-img"><img src="images/banners/iStock-171259563.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Connectivity</h1>
               
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<%
Server.Execute "content_lower_nav.asp"
%>

<div class="container subpage maincontent" >
  

    <div class="row">
        <div class="col-sm-12">

            <%
                RenderContent page, "editarea" 
            %>
				</div>
      </div>
	</div>          

<div class="content-blue-back"><!-- center content -->
    <div class="container lower-blocks">
    <div class="row ">
        <div class="col-sm-4" style="padding-top:20px;">
        
        
        
        
        	
<div class="feature-block-content" style="height:260px">
	<a href="http://www.iress.com/au/solutions/">                     
		<img src="images/home_news/iStock-525975242_800.jpg" alt="">
		<div class="feature-block-bar">
			<div class="feature-title">IRESS</div>
		</div>
	</a>
</div>        	
        	
        	
        	
        </div>
        <div class="col-sm-8">
            <div class="market-announcements" style="min-height:260px;">
                <h2>Connect with IRESS</h2>
				<p>As a strategic partner, IRESS Order Management Systems will give you an additional avenue of liquidity. For more information, visit <a href="http://www.iress.com/au/solutions/">IRESS</a></p>
                
            </div>
        </div>
    </div>
    <div class="clearfix" style="height:30px;"></div>
				 
    

    </div>
</div>
<!--#INCLUDE FILE="footer.asp"-->