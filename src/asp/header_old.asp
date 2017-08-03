<!--#INCLUDE FILE="stock_ticker.asp"--><%
Response.CodePage = 65001

' check domain and set domain analytics code properly
sitedomain =  trim(Request.ServerVariables("SERVER_NAME") & " ")
'googleaccount = "UA-9560336-2" ' nsxa.com.au
googleaccount = "UA-76513446-2" ' nsxa.com.au
googledomain = "nsxa.com.au"
if instr(sitedomain,"nsx.com.au") > 0 then
	'googleaccount = "UA-9560336-1"
	googleaccount = "UA-76513446-1"
	googledomain = "nsx.com.au"
end if
'response.write sitedomain

' set base url
If UCase(Session("PASSWORDACCESS")) = "YES" Then
	Response.AddHeader "X-SignIn", Session.SessionID
Else
	Response.AddHeader "X-SignIn", "0"
End If

Dim SiteRootURL
Dim ssl
If Request.ServerVariables("HTTPS") = "on" Then ' And Application("SSL") = "1" Then 
	'SiteRootURL = Application("nsx_SSLSiteRootURL")
	SiteRootURL = "https://www." & googledomain 
	ssl = "https://"
Else
	SiteRootURL = Application("nsx_SiteRootURL")
	'SiteRootURL = "http://www." & googledomain 
	ssl = "http://"
End If
session("googledomain") = googledomain

%>
<!DOCTYPE html>
<html>
<head>
<base href="<%= SiteRootURL %>" target="_self">

<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta content="width=device-width,initial-scale=1" name="viewport">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<% If alow_robots <> "yes" Then 
%><meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
<% End If
   If Len(meta_description) > 0 Then
%><meta name="description" content="<%=meta_description%>">
<% End If 
   If Len(meta_keywords) > 0 Then
%><meta name="keywords" content="<%=meta_keywords%>">
<% End If %>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="apple-touch-icon" href="/apple-touch-icon.png" type="image/png">

<link rel="alternate" type="application/rss+xml" title="NSX Company Announcements" href="/ftp/rss/nsx_rss_announcements.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Exchange News" href="/ftp/rss/nsx_rss_news.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Floats" href="/ftp/rss/nsx_rss_floats.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Official List" href="/ftp/rss/nsx_rss_officiallist.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Weekly Diary" href="/ftp/rss/nsx_rss_diary.xml">
<link rel="alternate" type="application/rss+xml" title="NSX Prices Table" href="/ftp/rss/nsx_rss_prices.xml">

<title><%= page_title %></title>
<%
' Replaced with allstyles.css
'<link rel="stylesheet" href="/css/style.css" type="text/css" media="all">
'<link rel="stylesheet" href="/css/li-scroller.css" type="text/css" media="all">
'<link rel="stylesheet" href="/css/smoothness/jquery-ui-1.8.17.custom.css" type="text/css" media="all">
'<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.17/themes/base/jquery-ui.css" type="text/css" media="all">
'<link rel="stylesheet" href="/css/jquery.jscrollpane.css" type="text/css" media="all">
'<!-- Anything Slider -->
'<link rel="stylesheet" href="/css/anythingslider.css" type="text/css" media="all">
%>
<!-- <link rel="stylesheet" href="/css/allstyles.min.css" type="text/css" media="all"> -->
<link rel="stylesheet" href="/css/bootstrap.min.css">
 <!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
   <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
 <![endif]-->
<script type="text/javascript" src="/js/jquery-1.9.1.js"></script>
<!-- <script type="text/javascript" src="js/jquery.min.js"></script> -->
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/new_style_jan_2017.css" type="text/css" media="all">
<%
' removed google scripts to speed up access in china.
'<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.17/themes/base/jquery-ui.css" type="text/css" media="all">
%>
<link rel="stylesheet" href="/css/smoothness/jquery-ui-1.8.17.custom.css" type="text/css" media="all">

<%
' Additional CSS Includes
For Each cssInclude In objCssIncludes
%><link rel="stylesheet" href="<%=CStr(objCssIncludes(cssInclude))%>" type="text/css" media="all">
<%
Next
%>

<%
'<script src="https://www.google.com/jsapi" type="text/javascript"></script>
'<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
'<script type="text/javascript" src="/js/jquery-ui-1.8.17.custom.min.js"></script>
'<script type="text/javascript" src="/js/jquery.cycle.all.js"></script>
'<script type="text/javascript" src="/js/hoverIntent.js"></script>
'<script type="text/javascript" src="/js/custom.js"></script>
'<script type="text/javascript" src="/js/jquery.li-scroller.1.0.js"></script>
'<script type="text/javascript" src="/js/jquery.tipTip.minified.js"></script>
'<script type="text/javascript" src="/js/functions.js"></script>
'<script type="text/javascript" src="/js/jquery.labelify.js"></script>
'<script type="text/javascript" src="/js/jquery.corner.js"></script>
'<script type="text/javascript" src="/js/chart_encode.js"></script>
'<script type="text/javascript" src="/js/jquery.jcarousellite.pauseOnHover.min.js"></script>
'<script type="text/javascript" src="/js/jquery.mousewheel.js"></script>
'<script type="text/javascript" src="/js/jquery.jscrollpane.min.js"></script>
<!-- Anything Slider --> 
'<script type="text/javascript" src="/js/jquery.anythingslider.js"></script> 
%>
<%
' removed google scripts to speed up access in china.
'<script src="https://www.google.com/jsapi" type="text/javascript"></script>
'<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
%>
<!--<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>-->
<script type="text/javascript" src="/js/alljavascript.js"></script>
<script type="text/javascript" src="/js/header.js.asp"></script> 
<script type="text/javascript" src="js/jquery.validate.js"></script> 

<script type="text/javascript">
$(document).ready(function () {
	$('.noAutoComplete').attr('autocomplete', 'off');
<%
If Session("PopupMsg") <> "" Then
%>	
	alert('<%= Server.HTMLEncode(Session("PopupMsg")) %>');
<%
  Session("PopupMsg") = ""
End If
%>
});
</script>
<%
' Additional JS Includes
For Each jsInclude In objJsIncludes
%><script type="text/javascript" src="<%=CStr(objJsIncludes(jsInclude))%>"></script>
<%
Next
%>

<% If ie > 0 Then %>
<!--[if IE] -->
<style type="text/css">
/*    .user_nav ul li a { 
	zoom: 1;
	filter: progid:DXImageTransform.Microsoft.DropShadow(OffX=1, OffY=1, Color=#FFFFFF);
} 
.nav_area_shadow {
	zoom: 1;
	filter: progid:DXImageTransform.Microsoft.DropShadow(OffX=1, OffY=1, Color=#000000);    
}
.chartNav ul li a {
	zoom: 1;
	filter: progid:DXImageTransform.Microsoft.DropShadow(OffX=1, OffY=1, Color=#FFFFFF);    
}
.tiptip_content{
	zoom: 1;
	filter: progid:DXImageTransform.Microsoft.DropShadow(OffX=0, OffY=0, Color=#000000);    
}
.nav_area ul li:hover{
	zoom: 1;
	filter: progid:DXImageTransform.Microsoft.DropShadow(OffX=1, OffY=1, Color=#FFFFFF);
} */   
</style>
<% End If %>
<% If ie6 > 0 Then %>
<!--[if IE 6] -->
<style type="text/css">
    body { /*behavior: url("csshover3.htc");*/ } 
    .graph_area{padding:8px 0 px;}
    .user_nav ul li.nav2 a{left:0px;}
    .user_nav ul li.nav3 {width:90px;}
    .user_nav ul li.nav3 a{width:90px;padding-left:7px;}
    .rightBox span{font-size:9px;}
</style>
<% End If 
If ie7 > 0 Then %>
<!--[if IE 7] -->
<style type="text/css">
	.graph_area{padding:8px 0 px;}
    .rightBox span{font-size:9px;}
    .language_area ul li.nobr2 a{padding:7px 7px 6px 7px;}
</style>
<% End If 
If ie8 > 0 Then %>
<!--[if IE 8] -->
<style type="text/css">
    .rightBox span{font-size:9px;}
</style>
<% End If %>
 <!--
<script type="text/javascript">
 var _gaq = _gaq || [];
 var pluginUrl = '//www.google-analytics.com/plugins/ga/inpage_linkid.js';
 _gaq.push(['_require', 'inpage_linkid', pluginUrl]);	  
 _gaq.push(['_setAccount', '<%=googleaccount%>']);
 _gaq.push(['_setDomainName', '<%=googledomain%>']);
 _gaq.push(['_trackPageview']);

 (function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
 })();
</script>
-->
</head>
<body>

<%
  mode = MarketMode
  mode = trim(lcase(mode))
  img = "market_amber.png"
  sessionmode = ""
  If mode = "open" Then
    img = "market_green.png"
    sessionmode = "Normal (NML)"
  ElseIf mode = "halt" Then 
    img = "market_amber.png"
    sessionmode="Enquiry Only (ENQ)"
  ElseIf mode = "aha" Then 
    img = "market_amber.png"
    sessionmode="After Hours Adjust (AHA)"
	ElseIf mode = "preopen" Then
    img = "market_amber.png" 
    sessionmode="Pre-Open (PRE)"
	ElseIf mode = "enquiry" Then 
    img = "market_amber.png"
    sessionmode="Enquiry Only (ENQ)"
	Else
	If Hour(Now()) > 17 Then
    img = "market_red.png"
    sessionmode="Shutdown - Maintenance"
	Else
    img = "market_amber.png"
    sessionmode="Enquiry Only (ENQ)"
	End If
  End If 
	' if sat or sun then market closed indicator
	dow = weekday(date)
	if dow = 7 or dow = 1 then 
		img = "market_red.png"
		sessionmode="Closed"
	end if
%> 

<div id="tiptipcontent" style="display:none"> <!-- market status on hover tip -->
  <div style="height:170px;padding:5px;font-size:12px;line-height:14px;" >
  Market Status: <%=sessionmode%><br><br>
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

<div class="container-fluid">	
    <nav class="navbar navbar-default topnav" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a class="toplogo" href="/"><img src="images/logo2.png"/></a>
            </div>

            <!-- market status --><!--
            <div class="header-toplinks">
                <div class="marketstatus">                  	
                        <a href="/investors/trading_hours_and_calendar"><img src="/img/<%=img%>" alt="" style="padding-right:4px;top:-7px;"></a><%=systemTime%>
                </div>
                <div class="language_area">
                    <ul>
                        <li class="nobr1 active"><a href="javascript:void(0)">English</a>--span></span--</li>
                        <li class="nobr2"><a href="javascript:void(0)"><img src="/img/chtext.png" width="28" height="17" alt=""></a></li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
            -->
            <!-- /market status -->

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right topsearch topsearch-form">
                    <li>
                        <form class="navbar-form topsearch-form" role="search">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <button class="btn btn-default topsearch-btn" type="submit"><i class="topsearch-icon"></i></button>
                                </div>
                                <input type="text" class="form-control topsearch-input" id="#searchbox" placeholder="" name="q">
                            </div>
                        </form>
                    </li>
                 </ul>
             </div>
        </div>
    </nav>
</div>

<nav class="navbar navbar-default second_navbar" role="navigation">
     <div class="container">
         <div class="navbar-header">
             <a class="top-mobile-logo" href="/"><img src="images/mobile_logo.png" /></a>
             <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
                 <span class="sr-only">Toggle navigation</span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
             </button>
         </div>
         <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
             <ul class="nav navbar-nav">
                 <li class="dropdown">
                     <a href="#">LOGIN</a>
                     <ul class="dropdown-menu">
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">LOGIN</li>
                                 <div id="lin" class="user_nav fltright"></div>
                             </ul>
                         </li>
                     </ul>
                 </li>
                 <li class="dropdown active">
                    <a href="#">INVESTING</a>
                     <ul class="dropdown-menu">
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">INVESTING</li>
                                 <li><a class="active" href="investors/find_a_broker">Find a Broker</a></li>
                                 <li><a href="investors/company_search">Company Search &amp; Information</a></li>
                                 <li><a href="investors/new_floats_ipos_and_issues">New Floats, IPOs &amp; Issues</a></li>
                                 <li><a href="investors/recent_issues">Recent Floats</a></li>
                                 <li><a href="investors/inv_why_nsx">Why NSX</a></li>
                                 <li><a href="investors/how_do_i_trade">How do I trade</a></li>
                                 <li><a href="investors/tradingcodes">Trading Codes &amp; Identifiers</a></li>
                                 <li><a href="investors/security_types_listed_on_nsx">Security Types Listed on NSX</a></li>
                                 <li><a href="investors/trading_hours_and_calendar">Trading Hours &amp; Calendar</a></li>
                                 <li><a href="investors/trading_and_settlement_process">Settlement Process</a></li>
                                 <!--li><a href="investors/mobile_apps_and_widgets">Mobile Apps &amp; Widgets</a></li-->
                             </ul>
                         </li>
                     </ul>
                 </li>
                 <li class="dropdown">
                     <a href="#" class="dropdown-toggle" aria-expanded="false">LISTING</a>
                     <ul class="dropdown-menu">
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">PRE LISTED COMPANIES</li>
                                 <li><a class="active" href="companies_pre_listed/why_list">Why List?</a></li>
                                 <li><a href="companies_pre_listed/cpl_why_nsx">Why NSX?</a></li>
                                 <!--li><a href="companies_pre_listed/nsx_press_service">NSX PRESS Service</a></li-->
                                 <li><a href="companies_pre_listed/ways_to_list">Ways to List</a></li>
                                 <!-- li><a href="companies_pre_listed/asx_vs_nsx">ASX vs NSX</a></li -->
                                 <li><a href="companies_pre_listed/migrate_from_asx">Migrate From ASX</a></li>
                                 <li><a href="companies_pre_listed/trading_options_standard">Trading Models</a></li>
                                 <li><a href="companies_pre_listed/case_studies">Case Studies</a></li>
                                 <li><a href="companies_pre_listed/listing_process">Listing Process</a></li>
                                 <li><a href="companies_pre_listed/listing_rules">Rules &amp; Notes</a></li>
                                 <!--li><a href="companies_pre_listed/sponsoring_broker_list">Sponsoring Broker List</a></li -->
                                 <li><a href="companies_pre_listed/comp_fees">Fees</a></li>
                                 <li><a href="companies_pre_listed/comppl_faq">FAQ</a></li>
                                 <li><a href="companies_pre_listed/brochures">Brochures</a></li>
                             </ul>
                         </li>
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">LISTED COMPANIES</li>
                                 <li><a href="companies_listed/listing_rules_and_notes">Partner services</a></li>
                                 <li><a class="active" href="companies_listed/listing_rules_and_notes">Listing Rules &amp; Notes</a></li>
                                 <li><a href="companies_listed/about_nominated_advisors">About Nominated Advisers</a></li>
                                 <li><a href="companies_listed/waivers">Waivers</a></li>
                                 <li><a href="companies_listed/comp_fees">Fees</a></li>
                                 <li><a href="companies_listed/company_forms">Company Forms</a></li>
                                 <li><a href="companies_listed/company_calendar">Company Calendar</a></li>
                                 <li><a href="companies_listed/nsx-listed_logo">NSX-Listed Logo</a></li>
                             </ul>
                         </li>
                     </ul>
                 </li>
                 <li class="dropdown">
                     <a href="#" class="dropdown-toggle" aria-expanded="false">TRADING</a>
                     <ul class="dropdown-menu">
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">PRE LISTED COMPANIES</li>
                                 <li><a class="active" href="companies_pre_listed/why_list">Why List?</a></li>
                                 <li><a href="companies_pre_listed/cpl_why_nsx">Why NSX?</a></li>
                                 <li><a href="companies_pre_listed/ways_to_list">Ways to List</a></li>
                                 <li><a href="companies_pre_listed/migrate_from_asx">Migrate From ASX</a></li>
                                 <li><a href="companies_pre_listed/trading_options_standard">Trading Models</a></li>
                                 <li><a href="companies_pre_listed/case_studies">Case Studies</a></li>
                                 <li><a href="companies_pre_listed/listing_process">Listing Process</a></li>
                                 <li><a href="companies_pre_listed/listing_rules">Rules &amp; Notes</a></li>
                                 <li><a href="companies_pre_listed/comp_fees">Fees</a></li>
                                 <li><a href="companies_pre_listed/comppl_faq">FAQ</a></li>
                             </ul>
                         </li>
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">LISTED COMPANIES</li>
                                 <li><a href="companies_listed/listing_rules_and_notes">Partner services</a></li>
                                 <li><a class="active" href="companies_listed/listing_rules_and_notes">Listing Rules &amp; Notes</a></li>
                                 <li><a href="companies_listed/about_nominated_advisors">About Nominated Advisers</a></li>
                                 <li><a href="companies_listed/waivers">Waivers</a></li>
                                 <li><a href="companies_listed/comp_fees">Fees</a></li>
                                 <li><a href="companies_listed/company_forms">Company Forms</a></li>
                                 <li><a href="companies_listed/company_calendar">Company Calendar</a></li>
                                 <li><a href="companies_listed/nsx-listed_logo">NSX-Listed Logo</a></li>
                             </ul>
                         </li>
                     </ul>
                 </li>
                 <li class="dropdown ">
                     <a href="#">DATA</a>
                     <ul class="dropdown-menu">
                         <li>
                             <ul class="nav-popup-menu">
                                 <li class="nav-popup-heading">DATA</li>
                                 <li><a class="active" href="companies_pre_listed/why_list">Why List?</a></li>
                                 <li><a href="companies_pre_listed/cpl_why_nsx">Why NSX?</a></li>
                                 <li><a href="companies_pre_listed/ways_to_list">Ways to List</a></li>
                             </ul>
                         </li>
                     </ul>
                 </li>
             </ul>
         </div><!-- /.navbar-collapse -->
     </div>
 </nav>


<!-- old nav -->
    <!--
	<div class="header_wrap">
    	<div class="header_container">
        	<div class="headerTop">
            	<div class="logo fltleft"><a href="/"><img src="/img/logo2.png" width="208" height="84" alt="NSX"></a></div>
                <div class="headerRight fltright">
                	<div class="headerRight_nav fltright">
                    	<div class="today fltleft marketstatus">                  	
                        <a href="/investors/trading_hours_and_calendar"><img src="/img/<%=img%>" alt="" style="padding-right:4px;top:-7px;"></a><%=systemTime%>
                      </div>
                        <div class="language_area fltleft">
                            <ul>
                                <li class="nobr1 active"><a href="javascript:void(0)">English</a></li>
                                <li class="nobr2"><a href="javascript:void(0)"><img src="/img/chtext.png" width="28" height="17" alt=""></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>

						<div id="lin" class="user_nav fltright">
						
						</div>

                        <div class="clearfix"></div>
                    </div>
                    <div class="clearfix"></div>
                    
                    
                     <div class="nav fltright">
                     	<div class="nav_icon"><a href="/"><img src="/img/home_btn.png" width="40" height="31" alt=""></a></div>
                        <div class="nav_area">
                          <ul>
                            <li class="smHover nobr3 firstli">
                              <a href="/companies_pre_listed/why_list" class="nav_area_shadow">For Companies</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/companies_pre_listed/why_list">Pre-Listed Companies</a></li>
                                    <li><a href="/companies_listed/listing_rules_and_notes">Listed Companies</a></li>
                                  </ul>
                                </div>                              
                              </div>
                            </li>                                
                            <li class="smHover">
                              <a href="/brokers_new/why_nsx" class="nav_area_shadow">For Brokers</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/brokers_new/why_nsx" class="links_plain" style="width:134px">Become a Broker</a></li>
                                    <li><a href="/brokers_existing/broker_aids" class="links_plain" style="width:134px">Existing Brokers</a></li>                       
                                  </ul>
                                </div>                                
                              </div>
                            </li>                                 
                            <li class="smHover">
                              <a href="/advisers_new/an_why_nsx" class="nav_area_shadow">For Advisers</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/advisers_new/an_why_nsx" class="links_plain" style="width:134px">Become an Adviser</a></li>
                                    <li><a href="/advisers_existing/ae_why_nsx" class="links_plain" style="width:134px">Existing Advisers</a></li>  
                                  </ul>
                                </div>
                              </div>
                            </li>                            
                            <li><a href="/investors/find_a_broker" class="nav_area_shadow">For Investors</a></li>  
                            <li><a href="/marketdata/company_search" class="nav_area_shadow">Market Data</a></li>
                            
                            <li><a href="about/about_nsx" class="nav_area_shadow">About</a></li>
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">Quick links</a>
                              <div class="submenu submenu_single" style="left:-80px;">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/investors/new_floats_ipos_and_issues" class="links_plain" style="width:124px">New Floats</a></li>
                                    <li><a href="/investors/find_a_broker" class="links_plain" style="width:124px">Find a Broker</a></li>
                                    <li><a href="/marketdata/company_search" class="links_plain" style="width:124px">Company Search</a></li>
                                    <li><a href="/marketdata/search_by_company" class="links_plain" style="width:124px">Announcements</a></li>
                                    <li><a href="/marketdata/market_summary" class="links_plain" style="width:124px">Market Summary</a></li>
                                    <li><a href="/prices_alpha.asp?nsxcode=&amp;region=" class="links_plain" style="width:124px">Price Data</a></li>
                                    <li><a href="/marketdata/prices" class="links_plain" style="width:124px">Indices</a></li>
                                    <li><a href="/about/nsx_news" class="links_plain" style="width:124px">NSX News</a></li>
                                    <li><a href="/about/contact_us" class="links_plain" style="width:124px">Contact Us</a></li>
									<li><a href="https://www.<%=googledomain%>/makepayment.asp" class="links_plain" style="width:124px">Make Payment</a></li>
                                  </ul>
                                </div>
                              </div>
                            </li>
                        </ul>
                        </div>
                     </div>                    
                    
                    <% If False Then %>
                     <div class="nav fltright">
                     	<div class="nav_icon"><a href="/"><img src="img/home_btn.png" alt=""></a></div>
                        <div class="nav_area">
                          <ul>
                            <li class="smHover nobr3 firstli">
                              <a href="javascript:void(0)" class="nav_area_shadow">Investors</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/inv_how_to_trade.asp">How to trade</a></li>
                                    <li><a href="/market_officiallist.asp">Listed Companies</a></li>
                                    <li><a href="/settlement.asp">Settlement of trades</a></li>
                                    <li><a href="/broker_list.asp">Find a broker</a></li>
                                    <li><a href="/fidelity_fund.asp">Compensation</a></li>
                                  </ul>
                                </div>                              
                              </div>
                            </li>                                
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">Research</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/market_officiallist.asp" class="links_plain" style="width:134px">Official List</a></li>
                                    <li><a href="/prices_alpha.asp" class="links_plain" style="width:134px">Share Prices</a></li>
                                    <li><a href="/marketdata/search_by_company" class="links_plain" style="width:134px">Announcements</a></li>
                                    <li><a href="/float_list.asp" class="links_plain" style="width:134px">Floats, IPOs &amp; Issues</a></li>
                                    <li><a href="/company_research.asp" class="links_plain" style="width:134px">Company Details</a>
                                    <hr></li>
                                    <li><a href="/weekly_diary.asp" class="links_plain" style="width:134px">Diary</a></li>
                                    <li><a href="/indices.asp" class="links_plain" style="width:134px">Index</a></li>
                                    <li><a href="/market_statistics.asp" class="links_plain" style="width:134px">Statistics</a>
                                    <hr></li>
                                    <li><a href="/market_delisted.asp" class="links_plain" style="width:134px">Delisted Securities</a></li>
                                    <li><a href="/market_suspended.asp" class="links_plain" style="width:134px">Suspended Securities</a></li>                                   
                                  </ul>
                                </div>                                
                              </div>
                            </li>                                 
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">Statistics</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/market_statistics.asp" class="links_plain" style="width:134px">Market Statistics</a>
                                    <li><a href="/indices.asp" class="links_plain" style="width:134px">Index</a></li>
                                    <li><a href="/weekly_diary.asp" class="links_plain" style="width:134px">Diary</a></li>
                                  </ul>
                                </div>
                              </div>
                            </li>                            
                            <li><a href="javascript:void(0)" class="nav_area_shadow">Education</a></li>
                            <li class="smHover">
                            	<a href="javascript:void(0)" class="nav_area_shadow">Listing</a>
                            	<div class="submenu submenu_single">
                                	<div class="submenuBox fltleft">
                                        <ul>
                                          <li><a href="/why_list.asp">Why List </a></li>
                                          <li><a href="/listing_factsheets.asp">Fact Sheets</a></li>
                                          <li><a href="/how_to_list.asp">How to list</a></li>
                                          <li><a href="/listing_fees.asp">Listing Fees</a></li>
                                          <li><a href="/chess.asp">CHESS registration</a>
                                          <hr></li>
                                          <li><a href="/rules_listing.asp">Listing Rules</a></li>
                                          <li><a href="/rules_practicenotes.asp">Practice Notes </a></li>
                                          <li><a href="/rules_waivers.asp">Waivers </a>
                                          <hr></li>
                                          <li><a href="/about_sponsoring_brokers.asp">About Sponsoring Brokers</a></li>
                                          <li><a href="/about_nominated_advisers.asp">About Nominated Advisers</a></li>
                                          <li><a href="/about_facilitators.asp">About Facilitators</a>
                                          <hr></li>
                                          <li><a href="/company_forms.asp">Forms</a></li> 
                                        </ul>
                                    </div>
                                </div>
                            </li>                                
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">Brokers</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/why_become_a_broker.asp">Why become a broker</a></li>
                                    <li><a href="/broker_apply.asp">How to apply</a></li>
                                    <li><a href="/broker_list.asp">Broker list</a>
                                    <hr></li>
                                    <li><a href="/how_to_trade.asp">How to trade</a></li> 
                                    <li><a href="/broker_chess.asp">How to clear &amp; settle</a></li>
                                    <li><a href="/rules_business.asp">Business Rules</a></li>
                                    <li><a href="/slf.asp">Surplus liquid funds</a></li>
                                    <li><a href="/broker_supervision.asp">Broker supervision</a>
                                    <hr></li>
                                    <li><a href="/market_data.asp">Market data</a>
                                    <hr></li>
                                    <li><a href="/broker_fees.asp">Fees</a></li>
                                    <li><a href="/broker_forms.asp">Forms</a></li>                                  
                                  </ul>
                                </div>
                              </div>
                            </li>
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">Advisers</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/whatisa_NominatedAdviser.asp">What is a Nominated Adviser</a></li>
                                    <li><a href="/adviser_apply.asp">How to apply</a></li>
                                    <li><a href="/adviser_list.asp">Adviser List</a></li>
                                    <li><a href="/adviser_fees.asp">Adviser Fees</a></li>
                                    <li><a href="/adviser_forms.asp">Adviser Forms</a>                             
                                  </ul>
                                </div>
                              </div>
                            </li>                            
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">Facilitators</a>
                              <div class="submenu submenu_single">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/whatisa_facilitator.asp">What is a Facilitator</a></li>
                                    <li><a href="/facilitator_apply.asp">How to apply</a></li>
                                    <li><a href="/facilitator_list.asp">Facilitator List</a></li>
                                    <li><a href="/facilitator_fees.asp">Faciltator Fees</a></li>
                                    <li><a href="/facilitator_forms.asp">Faciltator Forms</a></li>                                 
                                  </ul>
                                </div>
                              </div>
                            </li> 
                            <li class="smHover">
                              <a href="javascript:void(0)" class="nav_area_shadow">About NSX</a>
                              <div class="submenu submenu_single" style="left:-105px;">
                                <div class="submenuBox fltleft">
                                  <ul>
                                    <li><a href="/shareholder_default.asp">Shareholders</a><hr></li>
                                    <li><a href="<%= ssl %>www.nsx.com.au">National Exchange</a></li>
                                    <li><a href="<%= ssl %>www.bsx.com.au" target="_blank">BSX Exchange</a></li>
                                    <li><a href="<%= ssl %>www.simvse.com.au" target="_blank">SIM Venture Exchange</a><hr></li>
                                    <li><a href="/about_nsx.asp">About Us</a></li>
                                    <li><a href="/news_list.asp">News</a></li>
                                    <li><a href="/news_view.asp?ID=13">ASIC &amp; NSX</a></li>
                                    <li><a href="/feedback.asp">Feedback</a></li>
                                    <li><a href="/complaints.asp">Complaints</a></li>
                                    <li><a href="/about/contact_us">Contact Us</a></li>                                
                                  </ul>
                                </div>
                              </div>
                            </li> 
                        </ul>
                        </div>
                     </div>
                     <%
                     End If
                     %>
                     <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="stock_ticker" style="overflow:hidden">
              <% PrintStockTicker %>            
            </div>
        </div>
    </div> -->
    <!-- /old nav -->
  
    <% If False Then %>
    <div class="subNav">
    	<ul>
          <li class="nobr3"><a href="/float_list.asp">New Floats</a></li>
          <li><a href="/broker_list.asp">Find a Broker</a></li>
          <li><a href="/market_officiallist.asp">Detailed Search</a></li>
          <li><a href="/marketdata/search_by_company">Announcements</a></li>
          <li><a href="/prices_alpha.asp">Market Summary</a></li>
          <li><a href="/prices_alpha.asp?board=ncrp">Price Data</a></li>
          <li><a href="/prices_index.asp">Indices</a></li>
          <li><a href="/whatis_rss.asp">RSS Feeds</a></li>
          <li><a href="/news_list.asp">NSX News</a></li>
          <li><a href="/about/contact_us">Contact Us</a></li>
        </ul>
        <div class="clearfix"></div>
    </div> 
    <% End If %>
    
    <!--<div class="container_wrapper">--><!-- old container_wrapper-->     	