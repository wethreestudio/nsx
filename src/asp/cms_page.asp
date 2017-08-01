<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"

objJsIncludes.Add "lightbox", "/js/jquery.lightbox.js"
objJsIncludes.Add "cms_page", "/js/cms_page.js"

' 
' W:\staging.nsxa.com.au\css\jquery.lightbox-0.5.css
' Now in allstyles.css - objCssIncludes.Add "lightbox", "/css/jquery.lightbox-0.5.css"     

page = Request.QueryString("page")
menu = Request.QueryString("menu")
'Response.Write("menu=[ " + menu + " ]")
'Response.Write("page=[ " + page + " ]")

'HTTP_X_ORIGINAL_URL 
'fileName = Request.ServerVariables("HTTP_X_ORIGINAL_URL")
'Response.Write(fileName)

Dim sScriptLocation, sScriptName, iScriptLength, iLastSlash
sScriptLocation = Request.ServerVariables("HTTP_X_ORIGINAL_URL")
iScriptLength   = Len(sScriptLocation)
iLastSlash      = InStrRev(sScriptLocation, "/",iScriptLength-1)
sScriptName     = Right(sScriptLocation, iScriptLength - iLastSlash)
sScriptName = Replace(sScriptName,"-"," ")
sScriptName = Replace(sScriptName,"/","")
sScriptName = Replace(sScriptName,"_"," ")
'response.write("[" & sScriptName & "]")
page_title = sScriptName

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
    pageName = Replace(pageName,"-"," ")
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
       
        <% If page="why-list-with-us" Then %>
            <img src="images/banners/pexelsphoto47426.jpg" />
            
        <% ElseIf menu = "why_nsx" Then %>
            <img src="images/banners/brokers_banner_1.jpg" />
            
        <% ElseIf page = "find_a_broker" Then %>
            <img src="images/banners/iStock-155396151.jpg" />
            
        <% ElseIf page = "how-to-list" Then %>
            <img src="images/banners/iStock-503224436.jpg" />
            
        <% ElseIf page = "listing_process" Then %>
            <img src="images/banners/iStock-503224436.jpg" />
            
        <% ElseIf page = "getting-started" Then %>
            <img src="images/banners/iStock-515375318.jpg" />
              
        <% ElseIf page = "trading-models" Then %>
            <img src="images/banners/iStock-504112194.jpg" />
                                  
         <% ElseIf page = "listing" Then %>
            <img src="images/banners/iStock-506511434.jpg" />  
            
         <% ElseIf page = "upcoming-listings" Then %>
            <img src="images/banners/iStock-673667648.jpg" />
	 
		<% ElseIf page = "recent-listings" Then %>
            <img src="images/banners/iStock-476090471.jpg" />
            
         <% ElseIf page = "governance" Then %>
            <img src="images/banners/iStock-115887078.jpg" />       
             
         <% ElseIf page = "broker-directory" Then %>
            <img src="images/banners/iStock-184352977.jpg" />
                     
          <% ElseIf page = "security-types" Then %>
            <img src="images/banners/iStock-178530072.jpg" />  
                
         <% ElseIf page = "our-business" Then %>
            <img src="images/banners/iStock-524908206.jpg" />         
                 
      	<% ElseIf page = "tech-savvy" Then %>
            <img src="images/banners/iStock-667502094.jpg" /> 
            
         <% ElseIf page = "investor-relations" Then %>
            <img src="images/banners/iStock-460211705.jpg" /> 
            
		<% ElseIf page = "why-agri-companies-choose-NSX" Then %>
            <img src="images/banners/iStock-510222832.jpg" />
            
         <% ElseIf page = "nominated-adviser" Then %>
            <img src="images/banners/iStock-497386040.jpg" />     
            
         <% ElseIf page = "market-access" Then %>
            <img src="images/banners/iStock-511198842.jpg" />    
            
          <% ElseIf page = "talk-box" Then %>
            <img src="images/banners/iStock-510562415.jpg" />
            
         <% ElseIf page = "the-new-NSX" Then %>
            <img src="images/banners/iStock-467100356.jpg" />       
            
         <% ElseIf page = "media-centre" Then %>
            <img src="images/banners/iStock-506041568.jpg" />  
            
          <% ElseIf page = "NSX,-the-new-home-for-resoures" Then %>
            <img src="images/banners/iStock-467635312.jpg" />         
      
        <% ElseIf menu = "regulation" and page = "companies" Then %>
            <img src="images/banners/iStock-161861470.jpg" />
            
        <% ElseIf menu = "companies" and page = "listing_rules" Then %>
            <img src="images/banners/iStock-161861470.jpg" />
            
        <% ElseIf menu = "brokers" and page = "rules_and_notes" Then %>
            <img src="images/banners/iStock-161861470.jpg" />
            
        <% ElseIf menu = "regulation" and page = "brokers" Then %>
            <img src="images/banners/iStock-161861470.jpg" />
            
        <% ElseIf menu = "regulation" and page = "advisers" Then %>
            <img src="images/banners/iStock-161861470.jpg" />
            
        <% ElseIf menu = "regulation" and page = "exchange" Then %>
            <img src="images/banners/iStock-161861470.jpg" />
            
        <% ElseIf menu = "about" and page = "about_nsx" Then %>
            <img src="images/banners/Ann_worked.jpg" />
            
            
            
        <% End if %>
    </div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <% If menu = "about" Then %>
                   <!-- <div class="about-top-story">OUR STORY</div>
                    <h1>A startup since 1937 - National Stock Exchange of Australia</h1>-->
                    <h1><%=CleanUpPageName(page)%></h1>
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

<div class="container subpage main-content">

    <% If page="why-list-with-us" then %>
        
       
                <div class="subpage-center">
                    <div class="prop min600px"></div>
                      <%
                      RenderContent page, "editarea" 
                    %>
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