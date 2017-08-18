
<!DOCTYPE html>
<html>
<head>
<base href="http://staging.nsx.com.au" target="_self">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Official site of the National Stock Exchange of Australia, the market of choice for growth style Australian and International companies.">
<meta name="keywords" content="NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW">

<link rel="shortcut icon" href="/favicon-32x32.png" type="image/x-icon">
<link rel="apple-touch-icon" href="/apple-touch-icon.png" type="image/png">
<link rel="alternate" type="application/rss+xml" title="NSX Company Announcements" href="/ftp/rss/nsx_rss_announcements.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Exchange News" href="/ftp/rss/nsx_rss_news.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Floats" href="/ftp/rss/nsx_rss_floats.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Official List" href="/ftp/rss/nsx_rss_officiallist.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Weekly Diary" href="/ftp/rss/nsx_rss_diary.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Prices Table" href="/ftp/rss/nsx_rss_prices.xml">
<title>NSX - National Stock Exchange of Australia</title>

<!-- <link rel="stylesheet" href="/css/allstyles.min.css" type="text/css" media="all"> -->
<!--<link rel="stylesheet" type="text/css" href="https://cloud.typography.com/6874356/6131572/css/fonts.css" />-->

<link href="/css/fonts.css" rel="stylesheet" type="text/css" media="all">
<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">
<link href="/css/font-awesome.min.css" rel="stylesheet">

 <!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
   <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
 <![endif]-->
<!--<script type="text/javascript" src="/js/jquery-1.9.1.js"></script>-->
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/jquery-migrate-3.0.0.min.js"></script>
<!-- <script type="text/javascript" src="js/jquery.min.js"></script> -->
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/new_style_jan_2017.css" type="text/css" media="all">

<link rel="stylesheet" href="/css/smoothness/jquery-ui-1.8.17.custom.css" type="text/css" media="all">

<!--<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>-->
<script type="text/javascript" src="/js/alljavascript.js"></script>
<script type="text/javascript" src="/js/header.js.asp"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	$('.noAutoComplete').attr('autocomplete', 'off');

});
</script>
<script type="text/javascript" src="/js/default.js"></script>
<script type="text/javascript" src="/js/jquery.autocomplete.js"></script>

 <!--
<script type="text/javascript">
 var _gaq = _gaq || [];
 var pluginUrl = '//www.google-analytics.com/plugins/ga/inpage_linkid.js';
 _gaq.push(['_require', 'inpage_linkid', pluginUrl]);	  
 _gaq.push(['_setAccount', 'UA-76513446-1']);
 _gaq.push(['_setDomainName', 'nsx.com.au']);
 _gaq.push(['_trackPageview']);

 (function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
 })();
</script>
-->

<script>
$(document).ready(function() {
    $("#topnavul").mouseover(function () {
        if($("#topnav").hasClass("blue-back"))
        {
        
        }
        else {
            $("#topnav").toggleClass("blue-back");
        }
    }).mouseout(function() {
        $("#topnav").removeClass("blue-back")
    });
    $("#topsearch").mouseover(function () {
        $("#topsearch").addClass("visible-search")
        $("input.topsearch-btn").val("\uf00d")
        $("#topnavul").addClass("hidden")
    }).mouseout(function() {
        $("#topsearch").removeClass("visible-search")
        $("input.topsearch-btn").val("\uf002")
        $("#topnavul").removeClass("hidden")
    });
    $(".navbar-toggle").click(function (e) {
        if($(".navbar-toggle").hasClass("menu-open")){
            $(".navbar-toggle").removeClass("menu-open")}
        else {$(".navbar-toggle").addClass("menu-open");}
        if($("#topnav").hasClass("blue-back")){}
        else {$("#topnav").toggleClass("blue-back");}
    })
});
</script>
</head>
<body>

 

<div id="tiptipcontent" style="display:none"> <!-- market status on hover tip -->
    <div style="height:170px;padding:5px;font-size:12px;line-height:14px;">
    Market Status: Enquiry Only (ENQ)<br><br>
        <div class="table-responsive"><table class="market_status">   
            <tbody>   
            <tr>   
              <th align="left">Market Phase   
              </th>   
              <th align="left">Time   
              </th>   
            </tr>   
            <tr><td> 
                <img src="/img/market_amber.png" width="9" height="9" alt="Start of Day Enquiry(enq)">Start of Day Enquiry(enq)</td><td>02:30 - 03:00</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_amber.png" width="9" height="9" alt="Pre-Open(pre)">Pre-Open(pre)</td><td>03:00 - 10:00</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_green.png" width="9" height="9" alt="Normal(nml)">Normal(nml)</td><td>10:00 - 16:00</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_amber.png" width="9" height="9" alt="Pre-Open prior to Closing(cls)">Pre-Open prior to Closing(cls)</td><td>16:00 - 16:04</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_amber.png" width="9" height="9" alt="Closing Single Price Auction(nml)">Closing Single Price Auction(nml)</td><td>16:04 - 16:05</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_amber.png" width="9" height="9" alt="Closing(cls)">Closing(cls)</td><td>16:05 - 16:10</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_amber.png" width="9" height="9" alt="After Hours Adjust(aha)">After Hours Adjust(aha)</td><td>16:10 - 16:15</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_amber.png" width="9" height="9" alt="End of Day Enquiry (enq)">End of Day Enquiry (enq)</td><td>16:15 - 23:00</td>   
            </tr>   
            <tr>   
              <td nowrap> 
                <img src="/img/market_red.png" width="9" height="9" alt="Shutdown">Shutdown</td>   <td>23:00 - 02:30</td>   
            </tr>   
            </tbody>
        </table></div>
    </div>
</div> <!-- /market status on hover tip -->


<nav class="navbar navbar-default topnav" role="navigation" id="topnav">
    <div class="container">
        
        <!-- nav -->
        <div class="navbar-header">
            <a class="toplogo" href="/"><img src="images/lg_2.png" class="vanilla-logo"/><img src="images/logo2_white.png" class="reverse-logo"/></a>

            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="topnavul">
                 <li class="dropdown ">
                     <a href="/companies_pre_listed/why-list-with-us/" class="dropdown-toggle" aria-expanded="false">LISTING</a>
                     <div class="dropdown-holder">
                         <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><a href="/companies_pre_listed/why-list-with-us/">Why List with Us</a></li>
                                    <li><a href="/companies_pre_listed/how-to-list/">How to List</a></li>
                                    <li><a href="/companies_pre_listed/getting-started/">Getting Started</a></li>
                                    <li><a href="/companies_pre_listed/trading-models/">Trading Models</a></li>
                                    <li><a href="/companies_pre_listed/case-studies/">Case Studies</a></li>
                                </ul>
                            </li>
                         </ul>
                    </div>
                </li>
                <li class="dropdown  ">
                    <a href="/investing/">INVESTING</a>
                    <div class="dropdown-holder">
                        <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><a href="/investors/upcoming-listings/">Upcoming Listings</a></li>
                                    <li><a href="/investors/recent-issues/">Recent Listings</a></li>
                                    <li><a href="/investors/indices/">Indices</a></li>
                                    <li><a href="/investors/broker-directory/">Broker Directory</a></li>
                                    <li><a href="/investors/security-types/">Security Types</a></li>
                                    <li><a href="/investors/case-studies/">Case Studies</a></li>
                                </ul>
                             </li>
                         </ul>
                    </div>
                 </li>
                <li class="dropdown ">
                    <a href="/marketdata/">MARKET DATA</a>
                    <div class="dropdown-holder">
                        <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><a href="/marketdata/directory/">Directory</a></li>
                                    <li><a href="/marketdata/market_summary/">Market Summary</a></li>
                                    <li><a href="/marketdata/prices/">Prices</a></li>
                                    <li><a href="/marketdata/announcements/">Announcements</a></li>
                                    <li><a href="/marketdata/statistics/">Statistics</a></li>
                                    <li><a href="/marketdata/daily-diary/">Daily Diary</a></li>
                                    <li><a href="/marketdata/delisted-suspended/">Delisted & Suspended</a></li>
                                </ul>
                             </li>
                         </ul>
                     </div>
                 </li>
                <li class="dropdown ">
                    <a href="/regulation/" class="dropdown-toggle" aria-expanded="false">REGULATION</a>
                    <div class="dropdown-holder">
                        <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Companies</span></li>
                                    <li><a href="/regulation/companies/listing_rules/">Listing Rules & Practice Notes</a></li>
                                    <li><a href="/regulation/companies/company_forms/">Forms</a></li>
                                    <li><a href="/regulation/companies/comp_fees/">Fees</a></li>
                                    <li><a href="/regulation/companies/waivers/">Waivers</a></li>
                                    <li><a href="/regulation/companies/company_calendar/">Reporting Calendar</a></li>
                                 </ul>
                            </li>
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Brokers</span></li>
                                    <li><a href="/regulation/brokers/rules_and_notes/">Business Rules &amp; Practice Notes</a></li>
                                    <li><a href="/regulation/brokers/broker_forms/">Broker Forms</a></li>
                                    <li><a href="/regulation/brokers/overview/">Accessing NSX</a></li>
                                    <li><a href="/regulation/brokers/broker_supervision/">Broker Supervision</a></li>
                                    <li><a href="/regulation/brokers/be_fees/">Fees</a></li>
                                 </ul>
                            </li>
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Advisers</span></li>
                                    <li><a href="/regulation/advisers/adv_fees/">Fees</a></li>
                                    <li><a href="/regulation/advisers/adviser_forms/">Adviser Forms</a></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Exchange</span></li>
                                    <li><a href="/regulation/exchange/trading-codes-and-Identifiers/">Trading Codes &amp; Identifiers</a></li>
                                    <li><a href="/regulation/exchange/trading_hours_and_calendar/">Trading Hours &amp; Calendar</a></li>
                                    <li><a href="/regulation/exchange/trading_and_settlement_process/">Settlement</a></li>
                                    <li><a href="/regulation/exchange/market_supervision/">Market Supervision</a></li>
                                    <li><a href="/regulation/exchange/connectivity/">Connectivity</a></li>
                                    <li><a href="/regulation/exchange/complaints/">Complaints</a></li>
                                 </ul>
                            </li>
                        </ul>
                     </div>
                 </li>
                 
                 <li class="dropdown">
                     <span class="login">LOGIN</span>
                     <div class="dropdown-holder">
                     <ul class="dropdown-menu">
                         <li>
                             <ul class="nav-popup-menu">
                                 <div id="lin" class="user_nav fltright"></div>
                                 <div class="clearfix"></div>
                             </ul>
                             <div class="clearfix"></div>
                         </li>
                         <div class="clearfix"></div>
                     </ul>
                         <div class="clearfix"></div>
                     </div>
                 </li>
            </ul>

            <div class="topsearch topsearch-form" id="topsearch">
                <form class="navbar-form topsearch-form" role="search" id="marketsearch" name="marketsearch" action="search.asp" method="get">
                    <div class="">
                        <input type="text" id="searchbox" name="q" class="broker_field ac_input" value="" title="Company code or name" autocomplete="off">
                        <input id="searchgo" type="submit" class="broker_bttn topsearch-btn" value="&#xf002;" onclick="$('#marketsearch').submit()">
                        <input name="id" type="hidden" id="id">
                        <input name="t" type="hidden" id="t">
                    </div>
                </form>
            </div>

        </div><!-- /nav .navbar-collapse -->
   
    </div>
</nav>

<!--<div class="container_wrapper">--><!-- old container_wrapper-->     	

<div class="hero-banner">
    <div class="hero-banner-img"><img src="images/banners/pexelsphoto211929.jpg" /></div>
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
        
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=253">
                    <img src="images/home_news/pic_0.jpg" />
                    <div class="feature-block-bar">
                        
                        <div class="feature-title">Two new listings join the Nati</div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=258">
                    <img src="images/home_news/pic_1.jpg" />
                    <div class="feature-block-bar">
                        
                        <div class="feature-title">Why Agri Companies Choose NSX</div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=257">
                    <img src="images/home_news/pic_2.jpg" />
                    <div class="feature-block-bar">
                        
                        <div class="feature-title">NSX, the New Home for Resource</div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=256">
                    <img src="images/home_news/pic_3.jpg" />
                    <div class="feature-block-bar">
                        
                        <div class="feature-title">Tech Savy</div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=255">
                    <img src="images/home_news/pic_4.jpg" />
                    <div class="feature-block-bar">
                        
                        <div class="feature-title">The New NSX</div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div class="feature-block-content">
                <a href="news_view.asp?id=254">
                    <img src="images/home_news/pic_5.jpg" />
                    <div class="feature-block-bar">
                        
                        <div class="feature-title">Celebrating Women Series</div>
                    </div>
                </a>
            </div>
        </div>
             
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
                            	            <span class="box1">Security</span>
                                            <span class="box2">Last</span>
                                            <span class="box3">&nbsp;</span>
                                            <span class="box4">$</span>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="items">
                                            <div class="item" style="font-size:9px;width:100%;text-align:center;padding-top:20px;padding-bottom:20px;">No records</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div><!--tab_cont_right end-->

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
                                 
                                
                                <li><div class="market-top-line"><span class="date">6 Apr 2017</span><span class="sub-title">JBL</span></div><div class="title"><a href="/ftp/news/021732953.PDF">JBL announces $4.108 million placement</a></div>
                                    <div class="clearfix"></div>
                                </li>
                               
                                
                                
                                <li><div class="market-top-line"><span class="date">5 Apr 2017</span><span class="sub-title">AGT</span></div><div class="title"><a href="/ftp/news/021732950.PDF">Listing on FSE</a></div>
                                    <div class="clearfix"></div>
                                </li>
                               
                                
                                
                                <li><div class="market-top-line"><span class="date">4 Apr 2017</span><span class="sub-title">E72</span></div><div class="title"><a href="/ftp/news/021732942.PDF">Quarterly Report to 31 March 2017</a></div>
                                    <div class="clearfix"></div>
                                </li>
                               
                                
                                
                                <li><div class="market-top-line"><span class="date">4 Apr 2017</span><span class="sub-title">ECL</span></div><div class="title"><a href="/ftp/news/021732941.PDF">Share Consolidation</a></div>
                                    <div class="clearfix"></div>
                                </li>
                               
                                  

                            </ul>
                             <div class="clearfix"></div>
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

<!-- begin footer.asp -->

</div><!-- /end container -->

<footer class="footer">
     <div class="subfooter-back">
         <div class="container subfooter-cont">
             <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                    <h3>NSX MARKET</h3>
                     <ul class="sub-footer-links">
                         <li><a href="/companies_pre_listed/why-list-with-us/">Why List with Us</a></li>
                         <li><a href="/companies_pre_listed/listing_process/">Getting Started</a></li>
                         <li><a href="/investors/upcoming-listings/">Upcoming Listings</a></li>
                         <li><a href="/investors/recent_issues/">Recent Listings</a></li>
                         <li><a href="/marketdata/market_summary/">Market Summary</a></li>
                     </ul>
                     <div class="clearfix"></div>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-6 col-xs-12 footer-col2">
					<h3><a href="/about/our-business/">ABOUT NSX</a></h3>
                    <ul class="sub-footer-links">
                        <li><a href="/about/our-business/">Our Business</a></li>
                        <li><a href="/about/governance/">Governance</a></li>
                        <li class="sub-links">
                            <ul>
                                <li><a href="/about/board-of-directors/">Board of Directors</a></li>
                                <li><a href="/about/executive-team/">Executive Team</a></li>
                                <li><a href="/about/governance/">Constitution &amp; Policies</a></li>
                            </ul>
                        </li>
                        <li><a href="/about/investor-relations/">Investor Relations</a></li>
                        <li class="sub-links">
                            <ul>
                                <li><a href="/about/nsx_reports/">Financial Reporting</a></li>
                                <li><a href="/about/nsx_announcements/">Market Annoucements</a></li>
                            </ul>
                        </li>
                        <li><a href="/about/media-centre/">Media Centre</a></li>
                        <li class="sub-links">
                            <ul>
                                <li><a href="/about/press_release/">Press Release</a></li>
                                <li><a href="/about/thought_leadership/">Thought Leadership</a></li>
                                <li><a href="/about/Celebrating-Women-Series/">Celebrating Women Series</a></li>
                                <li><a href="/about/listing-ceremonies/">Listing Ceremonies</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="container lower-footer">
        <div class="row">
            <div class="footer-bottom-cont">
                <div class="col-sm-8 footer-left">
                    <span>&copy; Copyright 2017 </span><span>National Stock Exchange of Australia</span> <span class="spacer">ABN 11 000 902 063</span>
                </div>
                <div class="col-sm-3 footer-right">
                    <a href="/privacy.asp">Privacy</a> <a target="_blank" href="/tc.asp">Legal</a>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</footer>

<script type="text/javascript">
$(document).ready(function () {
    $("#request-btn").click(function(){ $('div#Listing-PopUp').animate({opacity: 'toggle'}, 'slow');});
    $('#ret').val(encodeURI(document.URL));
    $("#listingkitform").validate({ 
	 errorPlacement: function(error, element) {
      error.insertBefore($(element).parent());
    },       
    rules: {
      name: "required",
      email: { required: true, email: true } 
    },
    messages: {
	  name: {
		required: "Your name is required",
	  },
      email: {
        required: "Your email address is required",
        email: "Email address seems to be incorrect"
      }               
    },
    errorElement: "div",
	errorClass:"listingformerror"
  });     
});
</script>
<script type="text/javascript">
$(document).ready(function () {
	$("#request-btn-banner").click(function(){ $('div#Listing-PopUp').animate({opacity: 'toggle'}, 'slow');});
	$('#ret').val(encodeURI(document.URL));
    $("#listingkitform").validate({ 
	 errorPlacement: function(error, element) {
      error.insertBefore($(element).parent());
    },       
    rules: {
      name: "required",
      email: { required: true, email: true } 
    },
    messages: {
	  name: {
		required: "Your name is required",
	  },
      email: {
        required: "Your email address is required",
        email: "Email address seems to be incorrect"
      }               
    },
    errorElement: "div",
	errorClass:"listingformerror"
  });
});
</script>

<div id="Listing-PopUp" class="nsx-sprite;" style="display:none;">
    <form id="listingkitform" action="/request_listing_kit.asp" method="post" novalidate>

    <div class="col-lg-8 col-md-10 col-sm-10 col-xs-12 popup-holder" style="margin: 0 auto;float: none">
        <a id="close" class="nsx-sprite" onclick="$('#Listing-PopUp').fadeOut();" href="javascript:void(0)"><i class="fa fa-times-circle" aria-hidden="true"></i></a>
        <div id="Listing-PopUp-body">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 popup-left">
                <h2>Listing is easier than you think. The market of choice for innovative and growth companies!</h2>
                <p>Many companies are seeking a listing exchange that is customer focused, flexible, responsive, innovative, helpful and offers real value for money.</p>
                <ul id="Pop-up-list">
        	        <li>Simple Rules</li>
                    <li>Tailored listing criteria</li>
                    <li>Low costs</li>
                    <li>Help offered at every step</li>
                </ul>
                <p>or call <strong>02 8378 6400</strong></p>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 popup-right">
                
                <h2>Sign up for a listing pack</h2>
		        <input type="hidden" value="2/05/2017 1:20:07 PM" name="fax" id="fax">
                <input type="hidden" name="ret" id="ret" value="http://localhost/companies_pre_listed/why_list/">
                
		        <div class="fieldset">
        	        <div class="row">
            	        <div class="">
                            <label class="required name" for="name">FULL NAME</label>
                            <input id="name" name="name" class="valid" type="text" placeholder="">
                        </div>
                    </div>
                    <div class="row">
                        <div for="email" generated="true" class="listingformerror" style="display: none;">Email address seems to be incorrect</div><div class="">
                            <label class="required mail" for="email">EMAIL</label>
                            <input id="email" name="email" type="text" placeholder="" class="valid">
                        </div>
                    </div>
                    <div class="row">
                        <div class="">
                            <label class="required phone" for="phone">PHONE</label>
                            <input id="phone" name="phone" type="text" placeholder="" class="valid">
                        </div>
                    </div>
                    <div class="row">
                        <div class="">
                            <label class="company" for="company">COMPANY</label>
                            <input id="company" name="company" type="text" placeholder="" class="valid">
                        </div>
                    </div>
        	        <button id="get-list" type="submit" class="btn btn-default request-kit">Get your listing Kit</button>
                    <div class="clearfix"></div>
		        </div>
                
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    </form>
</div>
	
</body>
</html>
