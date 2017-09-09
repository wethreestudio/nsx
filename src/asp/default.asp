<!--#INCLUDE FILE="mobile_redirect.asp"-->
<!--#INCLUDE FILE="include_all.asp"--><%
Response.CodePage = 65001
page_title = "NSX - National Stock Exchange of Australia"
meta_description = "Official site of the National Stock Exchange of Australia, the market of choice for growth style Australian and International companies."
meta_keywords = "NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW"
' alow_robots = "no"
objJsIncludes.Add "default_js", "/js/default.js"
objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
' objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

menu ="home"
page ="home"
%>
<!--#INCLUDE FILE="header.asp"-->

<div class="hero-banner home-page">
    <div class="hero-banner-img"><img src="images/banners/pexels-photo-211929_new.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder">
            <div class="col-sm-12 hero-banner-left">
				<h1>Competition:<br> The New Playbook</h1>
                <!--<a href="/listing/how-to-list/" class="hero-blue-link">List with us</a>-->
                <a id="request-btn" href="javascript:void(0);" class="btn btn-default" onclick="_gaq.push(['_trackEvent', 'ListingKit', 'PopupClick', '<%=menu%>'])" data-toggle="modal" data-target="#Listing-PopUp">List with us</a>
                
                
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<div class="clearfix"></div>
<div class="container content_sec">
    <div class="row feature-blocks-row"><!-- start news -->

        <%
            RenderContent page, "editarea" 
        %>

        <%
        'SQL = "SELECT TOP 6 id,newsdate,newstitle,newsprecise,recorddatestamp FROM news ORDER BY NewsDate DESC,id DESC"
        'NewsRows = GetRows(SQL)
        'NewsRowsCount = 0
        'If VarType(NewsRows) <> 0 Then NewsRowsCount = UBound(NewsRows,2)
        'For i = 0 To  NewsRowsCount
        '  newsDate = CDate(NewsRows(1,i))
        '  newsTime = WeekdayName(weekday(newsDate),True) & ", " & Day(newsDate) & " " & monthAbbreviation(Month(newsDate)) & " " & Year(newsDate)
        
        ' <div class="col-sm-4">
        '     <div class="feature-block-content">
        '         <a href="news_view.asp?id=%=NewsRows(0,i)%">
        '             <img src="images/home_news/pic_%=i%.jpg" />
        '             <div class="feature-block-bar">
        '                 % '<div class="feature-date"> =newsTime </div> %
        '                 <div class="feature-title"><%=left(stripTags(NewsRows(2,i)),80)% </div>
        '             </div>
        '         </a>
        '     </div>
        ' </div>
        
        'Next
        %>

    </div>     
</div><!-- /news blocks -->
<div class="clearfix"></div>

<div class="content-blue-back"><!-- center content -->
    <div class="container lower-blocks">
        <div class="row">
                
            <div class="col-sm-8 col-xs-12">
                <div class="market-data-cont">
                     <h2>MARKET DATA</h2>
                     <div class="market-data">

                         <div class="value_tab"><!--tab_cont_right start-->
                            <div class="">
                                <div class="list_area">
                	                <div class="list_title">
                    	                <span class="box1">Code</span>
                                        <span class="box2">Volume</span>
                                        <span class="box3">Last</span>
                                        <span class="box4">Market Cap($m)</span>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="items">
                                        <div class="item" style="font-size:9px;width:100%;text-align:center;padding-top:20px;padding-bottom:20px;">No records</div>
                                    </div>
                                </div>
                            </div>
                        
                            <div class="clearfix"></div>
                        </div><!--tab_cont_right end-->
					    <div class="disclaimer">This market data is the latest traded information.</div>
                     </div><!-- /market data -->
                     <h4><a href="/marketdata/prices/">All Market data</a></h4>
                 </div>
            </div><!-- /col -->
                     
            <div class="col-sm-4 col-xs-12">
					 <div class="market-announcements">
					     <h2>MARKET ANNOUNCEMENTS</h2>
                         <div class="market-announcements-inner">
					     <ul>
						     <%
						    SQL = "SELECT TOP 5 coAnn.tradingcode, coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard "
						    SQL = SQL & " FROM coIssues INNER JOIN coAnn ON coIssues.tradingcode = coAnn.tradingcode "
						    SQL = SQL & " WHERE annRelease IS NOT NULL AND coAnn.displayboard<>'SIMV' AND coAnn.annDisplay=1 AND coAnn.annPriceSensitive=1"
						    SQL = SQL & " ORDER BY coAnn.annUpload DESC"

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
					    <div class="disclaimer">&nbsp;</div>
                        </div>
                        <h4><a href="/marketdata/announcements/">All announcements</a></h4>
					</div>
            </div>
                     
        </div><!-- end first row -->         
                     
        <div class="row">
            <div class="col-sm-8 col-xs-12">
                <!-- data graph -->
                <div class="data-graph"><!-- market data -->
                    <div id="show_index" class="blk_lft fltleft" style="">
                    <h2>NSX ALL EQUITIES INDEX</h2>
                    <div class="field">
                        <form action="" method="post">
                            <div>
                                <div class="rightBox fltright" id="index_values">
                                    <!--<input type="text" value="-" class="inputtxtbox3" id="index_last">-->
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                     </div>
                     <div class="graph"><a class="index_graph_a" href="javascript:void(0)"><img class="index_graph" src="images/transparent_1x1.png" width="286" height="107" alt="" /></a></div>
                    </div>
                </div>
		    </div><!-- /end market data -->
        
            <div class="col-sm-4 col-xs-12">
        	    <div class="right_side_bar_one">
                   <!--<a href="/about/media-centre/talk-box/">
                    <img src="images/content-images-544/Talk_Box.jpg"/>
                    
                    
					</a>-->
               
               <div>
				
				
					<div style="display: block; position: relative;"><div style="padding-top: 56.25%;"><video data-video-id="5443222036001" 
					data-account="756700387001" 
					data-player="rkx47VcWbZ" 
					data-embed="default" 
					data-application-id 
					class="video-js" 
					controls 
					style="width: 100%; height: 100%; position: absolute; top: 0px; bottom: 0px; right: 0px; left: 0px; border:none"></video>
					<script src="//players.brightcove.net/756700387001/rkx47VcWbZ_default/index.min.js"></script></div></div>	
					
					
				</div>
				<div class="right_side_bar_one_inner">
					<h5 style="color:#ffffff;">Talk Box – Episode 1</h5>
					<h3 style="color:#ffffff;">EAST 72 Limited NSX: E72</h3>
              <p style="color:#ffffff;line-height: 17px" class="small">Andrew Brown, Executive Director at East 72 shares insights into the strategy of E72 and explains what is unique about their model.</p>
			</div>
                </div>
		    </div>
        </div>
                     
        <div class="clearfix"></div>
        <!--#INCLUDE FILE="nsx_key_stats.asp"-->
        <div class="clearfix"></div>
        </div>
    </div><!-- /end top 4 boxes -->
<div class="clearfix"></div>
<!--#INCLUDE FILE="footer.asp"-->