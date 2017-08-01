<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Market Data"
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
    <div class="hero-banner-img"><img src="images/banners/iStock-613550610.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Data</h1>
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
        <div class="col-sm-6" style="padding-top:20px;">
        
        
        
        
        	
<div class="feature-block-content" style="height:350px">
	<a href="/regulation/exchange/connectivity/">                     
		<img src="images/home_news/iStock-619662792_800.jpg" alt="">
		<div class="feature-block-bar">
			<div class="feature-title">Tech &amp; Data:<br/>
Connecting to NSX</div>
		</div>
	</a>
</div>        	
        	
        	
        	
        </div>
        <div class="col-sm-6">
            <div class="market-announcements">
                <h2>Market Announcements</h2>
                <ul style="height: 216px !important;">
                 <%
                SQL = "SELECT TOP 3 coAnn.tradingcode, coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard "
                SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
                SQL = SQL & " WHERE annRelease IS NOT NULL AND coAnn.displayboard<>'SIMV' AND coAnn.annDisplay=1 AND coAnn.annPriceSensitive=1"
                SQL = SQL & " ORDER BY coAnn.annUpload DESC"
                'Response.Write "<BR><BR>" & SQL & "<BR><BR>"
                NewsRows = GetRows(SQL)
                NewsRowsCount = 0
                If VarType(NewsRows) <> 0 Then NewsRowsCount = UBound(NewsRows,2)

                For i = 0 To  NewsRowsCount
                  nsxCode = NewsRows(0,i)
                  priceSensitive = NewsRows(9,i)
                  newsDate = CDate(NewsRows(4,i))
                  newsTime = Day(newsDate) & " " & monthAbbreviation(Month(newsDate)) & " " & Year(newsDate)
                %>
            
                <li><div class="market-top-line"><span class="date"><%=newsTime%></span><span class="sub-title"><%=nsxCode%></span></div><div class="title"><a href="/ftp/news/<%=NewsRows(3,i)%>"><%=Replace(NewsRows(2,i),"&", "&amp;")%></a></div>
                    <div class="clearfix"></div>
                </li>
            
                <%
                Next
                %>  
                </ul>
                <div class="clearfix"></div>
                <h4><a href="/marketdata/announcements/">All announcements</a></h4>
            </div>
        </div>
    </div>
    <div class="clearfix" style="height:10px;"></div>
				 
    

    </div>
</div>
<!--#INCLUDE FILE="footer.asp"-->