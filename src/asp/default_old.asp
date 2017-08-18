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
<div class="cc">
<div id="wrapper"><!--wrapper start-->
	<div id="left_pannel" class="fltleft"><!--left_pannel start-->
    	<div class="banner"><!--banner start-->

<!-- BEGIN AnythingSlider -->
<ul id="slider" style="padding:0px;margin:0px;overflow:hidden;">
<% 
'set holiday banners XMAS & New Year

dte = date ()
startdte = cdate("18-Dec-2015")
enddte = cdate("31-Dec-2015")
startdte_ny = cdate("1-Jan-2016")
enddte_ny = cdate("10-Jan-2016")
holidays = ""
hol_img = ""
holiday_flag = false
if  dte >= startdte and dte <= enddte then 
	holidays = "Christmas"
	hol_img = "nsx_xmas2015.jpg"
	holiday_flag = true
end if
if  dte >= startdte_ny and dte <= enddte_ny then 
	holidays = "New Year"
	hol_img = "nsx_newyear.png"
	holiday_flag = true
end if
'response.write "<!-- " & dte & " holiday" & " " & startdte & " " & enddte & " " & startdte_ny & " " & enddte_ny & " " & holiday_flag & " -->"
if holiday_flag then	
%>
<li><a id="holidays" href="/companies_pre_listed/why_list"><img width="640" height="308" src="/img/<%=hol_img%>" alt="<%=holidays%>" title="<%=holidays%>"></a></li>
<%
End If
%>		

<% if date >= cdate("30-nov-2016") then %>	
<li><a id="L1" href="/summary/VGX"><img width="640" height="308" src="/img/VGX_img.gif" title="view VGX Limited" alt="VGX"></a></li>		
<!--<li><a href="/companies_pre_listed/cpl_why_nsx" ><img width="641" height="308" src="/img/Slider_3_1.jpg" alt="Why List"></a></li>-->
<%end if%>	
	<%
	if len(holidays) = 0 then	
	%>
			<!-- li><a id="L4" href="http://hotcopper.com.au/discussions/nsx---by---stock/" target="_blank"><img width="640" height="308" src="/img/hotcopper.png" alt="HotCopper Forum"></a></li -->
	<%
	end if
	%>
	<li><a id="L5" href="/summary/ASS"><img width="640" height="308" src="/img/ASS_img.gif" title="view Asset Resolution Limited" alt="ASS"></a></li>
	<li><a id="L2" href="/summary/AHH"><img width="640" height="308" src="/img/AHH_img.jpg" title="view Al Hamra Hotels and Resorts" alt="AHH"></a></li>
	<li><a id="L3" href="/summary/AGT"><img width="640" height="308" src="/img/AGT_img.jpg" title="view AGT" alt="AGT"></a></li>
	<li><a id="L6" href="/companies_pre_listed/migrate_from_asx"><img width="640" height="308" src="/img/banners/fasttrack_banner_308.png" title="view NSX Fast Track" alt="Fast Track"></a></li>	
<li><a id="L6" href="/documents/pdfs/NSX_brochure_Succession_Planning_with_an_NSX_Listing.pdf"><img width="640" height="308" src="/img/banners/succession_banner_308.png" title="view NSX Succession" alt="Succesion"></a></li>	


	<li><a id="request-btn-banner" href="#" onclick="_gaq.push(['_trackEvent', 'ListingKit', 'PopupClick', 'Landing Page Banner']);return false;" title="request a listing kit" alt="listing kit"><img width="641" height="308" src="/img/Slider_3_1.jpg" alt="Why List"></a></li>
			<!-- li><a id="L1" href="/kb"><img width="640" height="308" src="/img/blog_hero_pic2.jpg" title="view Knowledgebase" alt="NSX Knowledgebase"></a></li -->
      		
      	</ul>
      	<!-- END AnythingSlider -->

        </div><!--banner end-->
        
        <div class="tab_block"><!--tab_block start-->
          <div class="tab_nav"><!--tab_nav start-->
            <div class="nav_block1 active fltleft">
                <ul class="tabs2">
                    <li><a id="become_link" class="current" href="javascript:void(0)" onclick="changet2('become')">BECOME AN NSX</a></li>
                    <li><a id="about_link" href="javascript:void(0)" onclick="changet2('about')">ABOUT NSX</a></li>
                    <li><a id="why_link" href="javascript:void(0)" onclick="changet2('why')">WHY NSX</a></li>
                </ul>
            </div>
        
            <div class="nav_block2 fltleft">
                <ul class="tabs3">
                    <li><a id="gainers_link" href="javascript:void(0)" onclick="changet3('gainers')">ADVANCES</a></li>
                    <li><a id="fallers_link" href="javascript:void(0)" onclick="changet3('fallers')">DECLINES</a></li>
                    <li><a id="volume_link" href="javascript:void(0)" onclick="changet3('volume')">VOLUME</a></li>
                    <li><a id="value_link" href="javascript:void(0)" onclick="changet3('value')">VALUE</a></li>
                </ul>
            </div>  
          </div><!--tab_nav start-->
            <div class="holder">
            <div class="tab_content tb1"><!--tab_content start-->
            	<div class="tab_cont_left become_tab"><!--tab_cont_left start-->
            		<h2 class=".tk-adelle">Become an NSX</h2>
                    <div class="icon_block"><!--icon_block start-->
                    	<div class="icon_box fltleft">
                    		<div class="icon1"><a href="/companies_pre_listed/why_list"></a></div>
                            <span class="icon_text">Listed Company</span>
                            <div class="clear"></div>
                    	</div>
                        
                        <div class="icon_box fltleft">
                    		<div class="icon2"><a href="/brokers_new/why_nsx"></a></div>
                            <span class="icon_text">Broker</span>
                            <div class="clear"></div>
                    	</div>
                        
                        <div class="icon_box fltleft">
                    		<div class="icon3"><a href="/investors/find_a_broker"></a></div>
                            <span class="icon_text">Investor</span>
                            <div class="clear"></div>
                    	</div>
                        
                        <div class="icon_box fltleft">
                    		<div class="icon4"><a href="/advisers_new/an_why_nsx"></a></div>
                            <span class="icon_text">Adviser</span>
                            <div class="clear"></div>
                    	</div>
                        <div class="clear"></div>
                    </div><!--icon_block end-->
					
<div style="clear:both;height:20px"></div>
<div id="Listing-Kit-placeholder">
     	 <button id="request-btn" class="btn btn-default request-kit left" onclick="_gaq.push(['_trackEvent', 'ListingKit', 'PopupClick', 'Landing Page']);">Request a Listing Kit</button>
         <p>We would love to hear about your proposed listing.  Please contact us by requesting a listing kit.</p>
    </div>					
					
					
					
                </div><!--tab_cont_left end-->
                
                <div class="tab_cont_left about_tab" style="display:none"><!--tab_cont_left start-->
            		<h2 class=".tk-adelle">About NSX</h2>
<%
 RenderContent "lefttab_about_nsx", "editarea1"
%>
                </div><!--tab_cont_left end-->
                
                <div class="tab_cont_left why_tab" style="display:none"><!--tab_cont_left start-->
            		<h2 class=".tk-adelle">Why NSX</h2>
<%
 RenderContent "lefttab_why_nsx", "editarea1"
%>
                </div><!--tab_cont_left end-->
            </div><!--tab_content end--> 
            <div class="tab_content tb2"><!--tab_content start-->  
                	<div id="show_index" class="blk_lft fltleft" style="display:none">
                    	<h2 class=".tk-adelle">NSX Index</h2>
                        <div class="field">
                        	<form action="" method="post">
                            <div>
                            	<select class="field_box" id="indexselection">
                                  <option selected="selected" value="NSXAEI">NSX All Equities Index</option>
                                  <option value="NSXAGR">NSX All Agriculture Index</option>
                                  <option value="NSXCOM">NSX All Community Index</option>
                                  <option value="NSXFIN">NSX All Finance Index</option>
                                  <option value="NSXINV">NSX All Investment Index</option>
                                  <option value="NSXPPY">NSX All Property Index</option>
                                  <option value="NSXRES">NSX All Resources Index</option>
                                  <option value="NSXTEC">NSX All Technology Index</option>
                                  <option value="SIMAEI">SIMVSE All Equities Index</option>
                                </select>  
                                <div class="rightBox fltright" id="index_values">
                           	<input type="text" value="-" class="inputtxtbox3" id="index_last">
                            <span><span id="index_change">-</span><img alt="" src="img/arrow_none.jpg" height="20" width="9" id="index_change_img"></span>
                            </div>                          
                                <div class="clear"></div>
                            </div>
                            </form>
                        </div>
                        <div class="graph"><a class="index_graph_a" href="javascript:void(0)"><img class="index_graph" src="images/transparent_1x1.png" width="286" height="107" alt="" /></a></div>
                    </div>            
            
             
                <div class="tab_cont_right gainers_tab" style="display:none"><!--tab_cont_right start-->
                    <div class="blk_rht fltleft">
                    	<h2 class=".tk-adelle">Advances</h2>
                        <div class="list_area">
                        	<div class="list_title">
                            	<span class="box1">Security</span>
                                <span class="box2">Change</span>
                                <span class="box3">Bid</span>
                                <span class="box4">Offer</span>
                                <div class="clear"></div>
                            </div>
                            
                            <div class="items">
                              <div class="item" style="font-size:9px;width:100%;text-align:center;padding-top:20px;padding-bottom:20px;">No records</div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div><!--tab_cont_right end-->
                
                <div class="tab_cont_right fallers_tab" style="display:none"><!--tab_cont_right start-->
                    <div class="blk_rht fltleft">
                    	<h2 class=".tk-adelle">Declines</h2>
                        <div class="list_area">
                        	<div class="list_title">
                            	<span class="box1">Security</span>
                                <span class="box2">Change</span>
                                <span class="box3">Bid</span>
                                <span class="box4">Offer</span>
                                <div class="clear"></div>
                            </div>
                            
                            <div class="items">
                              <div class="item" style="font-size:9px;width:100%;text-align:center;padding-top:20px;padding-bottom:20px;">No records</div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div><!--tab_cont_right end-->
                
                <div class="tab_cont_right volume_tab" style="display:none"><!--tab_cont_right start-->
                    <div class="blk_rht fltleft">
                    	<h2 class=".tk-adelle">Volume</h2>
                        <div class="list_area">
                        	<div class="list_title">
                            	<span class="box1">Security</span>
                                <span class="box2">Last</span>
                                <span class="box3">&nbsp;</span>
                                <span class="box4">No.</span>
                                <div class="clear"></div>
                            </div>
                            
                            <div class="items">
                              <div class="item" style="font-size:9px;width:100%;text-align:center;padding-top:20px;padding-bottom:20px;">No records</div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div><!--tab_cont_right end-->
                
                <div class="tab_cont_right value_tab" style="display:none"><!--tab_cont_right start-->
                    <div class="blk_rht fltleft">
                    	<h2 class=".tk-adelle">Value</h2>
                        <div class="list_area">
                        	<div class="list_title">
                            	<span class="box1">Security</span>
                                <span class="box2">Last</span>
                                <span class="box3">&nbsp;</span>
                                <span class="box4">$</span>
                                <div class="clear"></div>
                            </div>
                            
                            <div class="items">
                              <div class="item" style="font-size:9px;width:100%;text-align:center;padding-top:20px;padding-bottom:20px;">No records</div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div><!--tab_cont_right end-->
            </div><!--tab_content end-->
            </div>
            </div><!--tab_block end-->
        
		


	
		
		
    </div><!--left_pannel end-->
    
    <div id="right_pannel" class="fltright"><!--right_pannel start-->
    	<div class="broker_search">
        	<form id="marketsearch" name="marketsearch" action="search.asp" method="get">
            <div>
              <input type="text" id="searchbox" name="q" class="broker_field" value="" title="company code or name" />
                <input id="searchgo" type="submit" class="broker_bttn" value="" onclick="$('#marketsearch').submit()" />
                <input name="id" type="hidden" id="id"/>
                <input name="t" type="hidden" id="t"/>                
                <div class="clear"></div>
                <span class="broker"><a href="/investors/find_a_broker">Find a Broker</a> | 
				<a href="/advisers_existing/adviser_list">Find an Adviser</a> | 
				<a href="/marketdata/official_list">Official List</a>
				</span>
            </div>
            </form>
        </div>
		<div align="center" valign="center" id="almanac-placeholder"><br />
	<a href="/documents/pdfs/NSX_Brochure_Why_List_on_NSX.pdf"><img src="/images/nsx_brochure_why_list_drop.png" width="120"  height="180" border="0" valign="middle" align="left" alt="" hspace="0" vspace="0" /></a>
		<br /><br/><a href="/documents/pdfs/NSX_Brochure_Why_List_on_NSX.pdf"><h1>Why List on NSX?<br></h1></a><a href="/documents/pdfs/NSX_Brochure_Why_List_on_NSX_chinese.pdf">Chinese Version 中国版</a><br /><br /><p>&nbsp;</p><br /><br /><p>&nbsp;</p><br /><br /><br /><br /><br /><br /> <br />
		 </div>	
        <div <!--class="sign_up"-->
       <!--	<h2 class=".tk-adelle">Sign up!</h2>
            <p>Hear the latest important news<br /> and IPO information as it happens.</p>
        	<form method="post" action="/newsletter.asp" id="newsletterform1" name="newsletterform1">
-->
<!--<div id="signup_options" style="padding-bottom:15px;font-size: 12px;">    -->
<div id="signup_options" >
 <!--   <input type="checkbox" id="ipos1" name="subs" value="ipos" checked="checked"><label style="padding-left:8px;padding-right:10px; cursor: default;" for="ipos1">Upcoming IPOs</label>
    <input type="checkbox" id="newsletter1" name="subs" value="newsletter" checked="checked"><label style="padding-left:8px; cursor: default;" for="newsletter1">News</label>
-->
	</div>
      	  
            <div>
      <!--      	<input id="enews" name="useremail" type="text" class="sign_field" value="" title="your email address" />
                <input name="go" type="submit" class="go_bttn" value="" />
				-->
           <div class="clear"></div> 
            </div>
            <!--</form>
        --></div>      
        <div class="latest_news_top"></div>
        <div class="latest_news"><!--latest_news start-->
          
        	<div class="news_nav">
            	<ul class="tabs">					
                	<li><a  class="current" id="news_link" href="javascript:changet1('news')">NSX News</a></li>
					<li><a id="ann_link" href="javascript:changet1('ann')">Announcements</a></li>
					<!-- li><a id="blog_link" href="javascript:changet1('blog')">More Info</a></li -->
                </ul>
            </div>
            <div class="news_scroll">
                <div id="news_pane" class="news_content panes" >
                    <h2 class=".tk-adelle">NSX News</h2>            
<%
SQL = "SELECT TOP 8 id,newsdate,newstitle,newsprecise,recorddatestamp FROM news ORDER BY NewsDate DESC,id DESC"
NewsRows = GetRows(SQL)
NewsRowsCount = 0
If VarType(NewsRows) <> 0 Then NewsRowsCount = UBound(NewsRows,2)
For i = 0 To  NewsRowsCount
  newsDate = CDate(NewsRows(1,i))
  newsTime = Day(newsDate) & " " & monthAbbreviation(Month(newsDate)) & " " & Year(newsDate)
%>     


                    <!-- div class="date"><%=newsTime%></div -->
                    <p ><b><%=newsTime%>: </b><a href="news_view.asp?id=<%=NewsRows(0,i)%>" class="blue" style="text-decoration:none"><%=left(stripTags(NewsRows(2,i)),30)%></a></p>
                    <!-- p>-</p -->
                    <p><%=Replace(getSnippet(stripTags(NewsRows(3,i)),40),"&", "&amp;")%> &nbsp;...</p>
                    <!-- br /><br /-->
<%
Next
%>            
                </div> 
			
                <div id="ann_pane" class="news_content panes" style="display:none;">
                    <h2 class=".tk-adelle">MARKET Announcements</h2>
					<h4>Price Sensitive only</h4>
<%
SQL = "SELECT TOP 8 coAnn.tradingcode, coAnn.annid,annPrecise,annFile,annRelease,annTitle,annFileSize,annUpload,coIssues.IssueDescription, annPriceSensitive, coissues.displayboard "
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
<!-- div class="date"><%=newsTime%></div -->
<div class="mktann">
<p ><%
If priceSensitive Then
%><span style="color:#ff0000;float:left; display:inline;">*</span>&nbsp;<%
End If 
%><b><%=newsTime%>: </b><a href="/ftp/news/<%=NewsRows(3,i)%>" class="blue"  style="text-decoration:none"><b><%=nsxCode%></b> - <%=Replace(NewsRows(2,i),"&", "&amp;")%></a></p>      

      <div class="clearfix"></div>
</div><%
Next
%> 
<br /><br />                   
                    
                </div>
				<div id="blog_pane" class="news_content panes" style="display:none;">
                    <!-- h2 class=".tk-adelle">Knowledge Base Articles</h2 -->  
<%
'session("rsstr")="http://www.nsx.com.au/kb/feed"
'			session("rssdesc")=false
'				session("rssmaxx")=8
'			session("rssdate")=true
'			session("rsstitle")=true
'          server.execute "nsxrssreader.asp"
%>
                </div> 
            </div>
        </div><!--latest_news end-->
        
    </div><!--right_pannel end-->
    <div class="clear"></div>
</div><!--wrapper end-->
</div>
<div style="height:30px; clear:both; margin-bottom:10px;background-color:#fff"></div>
<!--#INCLUDE FILE="footer.asp"-->