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
%>
<!--#INCLUDE FILE="header.asp"-->

<div class="hero-banner">
    <div class="hero-banner-img"><img src="images/pexelsphoto211929.jpg" /></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder">
            <div class="col-sm-12 hero-banner-left">
                <h1>Competition:<br/>The New Playbook</h1>
                <a href="/companies_pre_listed/ways_to_list/" class="hero-blue-link">List with us</a>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<div class="clearfix"></div>
<div class="container content_sec">
    <div class="row feature-blocks-row"><!-- start news -->
        <%
        SQL = "SELECT TOP 6 id,newsdate,newstitle,newsprecise,recorddatestamp FROM news ORDER BY NewsDate DESC,id DESC"
        NewsRows = GetRows(SQL)
        NewsRowsCount = 0
        If VarType(NewsRows) <> 0 Then NewsRowsCount = UBound(NewsRows,2)
        For i = 0 To  NewsRowsCount
          newsDate = CDate(NewsRows(1,i))
          newsTime = WeekdayName(weekday(newsDate),True) & ", " & Day(newsDate) & " " & monthAbbreviation(Month(newsDate)) & " " & Year(newsDate)
        %>
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=<%=NewsRows(0,i)%>">
                    <img src="images/home_news/pic_<%=i%>.jpg" />
                    <div class="feature-block-bar">
                        <% '<div class="feature-date"> =newsTime </div> %>
                        <div class="feature-title"><%=left(stripTags(NewsRows(2,i)),80)%></div>
                    </div>
                </a>
            </div>
        </div>
        <%
        Next
        %>     
    </div>     
</div><!-- /news blocks -->
<div class="clearfix"></div>

<div class="content-blue-back"><!-- center content -->
    <div class="container lower-blocks">
             <div class="row">
                 <div class="col-sm-7">
                     <div class="row market-data-cont">
                         <h2>Market Data</h2>
                         <div class="market-data">

                             <div class="value_tab"><!--tab_cont_right start-->
                                <div class="">
                                    <div class="list_area">
                        	            <div class="list_title">
                            	            <span class="box1">Description</span>
                                            <!--<span class="box2">&nbsp;</span>-->
                                            <span class="box3">Volume</span>
                                            <span class="box4">Last</span>
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
                         <a href="/marketdata/prices/"><h4>All Market data</h4></a>
                     </div><!-- /row -->
                     <!-- data graph -->
                     <div class="row">

                         <div class="data-graph"><!-- market data -->
                             <div id="show_index" class="blk_lft fltleft" style="">
                                 <h2>NSX All Equities Index</h2>
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
                         </div><!-- /end market data -->
                     </div>
                 </div>

                 <div class="col-sm-5 sec_one">
                     <div class="row">
                         <div class="market-announcements">
                             <h2>Market Announcements</h2>
                             <ul>
                                 <%
                                SQL = "SELECT TOP 4 coAnn.tradingcode, coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard "
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
                             <div class="disclaimer">&nbsp;</div>
                             <a href="/marketdata/market_list/"><h4>All announcements</h4></a>
                    </div>
                         <div class="right_side_bar_one">
                             <img src="images/feature1.jpg" />
                             <div class="why_list">
                                 <h3>Become an Advisor</h3>
                                 <a href="/advisers_new/an_why_nsx" class="solid-blue-link-button">Find out how</a>
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="clearfix"></div>
             </div><!-- /end top 4 boxes -->
             <div class="clearfix"></div>

             <div class="row">
                 <div class="end-section">
                     <div class="col-sm-3"><h3>MARKET CAPITALISATION</h3><span class="large-text">$4.6b</span></div>
                     <div class="col-sm-3"><h3>NSX BROKERS</h3><span class="large-text">23</span></div>
                     <div class="col-sm-3"><h3>MARKET UPTIME</h3><span class="large-text">100%</span></div>
                     <div class="col-sm-3"><h3>AVERAGE RAISING</h3><span class="large-text">$8.3m</span></div>
                     <div class="clearfix"></div>
                 </div>
                 <div class="clearfix"></div>
             </div>
             <div class="clearfix"></div>

         </div>
     </div><!-- /center content -->
<div class="clearfix"></div>

<!--#INCLUDE FILE="footer.asp"-->