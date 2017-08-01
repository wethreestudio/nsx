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

menu2 = Request.QueryString("menu")
if len(menu2) = 0 then menu2 = session("menu")

' Return true if page (p) is the currently selected page
Function IsActive(p)
	IsActive = false
	If p = menu2 Then
		IsActive = true
	End If
End Function

' not used
Function GetActivePage(name)
    'Response.Write(name)
    css_class = ""
    strReturnURL = Request.ServerVariables("SCRIPT_NAME")
    'Response.Write(strReturnURL)
    If name = strReturnURL Then
        css_class = "active"
    End If
    'Response.Write(css_class)
End Function

'Response.Write(Request.ServerVariables("SCRIPT_NAME"))
'page = Request.QueryString("page")
'menu = Request.QueryString("menu")
'Response.Write(", menu=[" + menu + "]")
'Response.Write("page=[" + page + "]")

%>
<!DOCTYPE html>
<html>
<head>
<base href="<%= SiteRootURL %>" target="_self">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
<script type="text/javascript" src="/js/jquery.validate.js"></script>
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
    <div style="height:170px;padding:5px;font-size:12px;line-height:14px;">
    Market Status: <%=sessionmode%><br><br>
        <table class="market_status">   
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
        </table>
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
                 <li class="dropdown <% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
                     <a href="/companies_pre_listed/why-list-with-us/" class="dropdown-toggle" aria-expanded="false">LISTING</a>
                     <div class="dropdown-holder">
                         <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><a href="/companies_pre_listed/why-list-with-us/">Why List with Us</a></li>
                                    <li><a href="/companies_pre_listed/ways_to_list/">How to List</a></li>
                                    <li><a href="/companies_pre_listed/listing_process/">Getting Started</a></li>
                                    <li><a href="/companies_pre_listed/trading_options_standard/">Trading Models</a></li>
                                    <li><a href="/companies_pre_listed/case-studies/">Case Studies</a></li>
                                </ul>
                            </li>
                         </ul>
                    </div>
                </li>
                <li class="dropdown <% If IsActive("investing") Then Response.Write("active") End If %> ">
                    <a href="/investing/">INVESTING</a>
                    <div class="dropdown-holder">
                        <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><a href="/investors/upcoming-listings/">Upcoming Listings</a></li>
                                    <li><a href="/investors/recent-issues/">Recent Listings</a></li>
                                    <li><a href="/investors/indices/">Indices</a></li>
                                    <li><a href="/investors/broker-directory/">Broker Directory</a></li>
                                    <li><a href="/investors/security_types_listed_on_nsx/">Security Types</a></li>
                                    <li><a href="/investors/case_studies/">Case Studies</a></li>
                                </ul>
                             </li>
                         </ul>
                    </div>
                 </li>
                <li class="dropdown <% If IsActive("marketdata") Then Response.Write("active") End If %>">
                    <a href="/marketdata/">MARKET DATA</a>
                    <div class="dropdown-holder">
                        <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><a href="/marketdata/company-directory/">Directory</a></li>
                                    <li><a href="/marketdata/market_summary/">Market Summary</a></li>
                                    <li><a href="/marketdata/prices/">Prices</a></li>
                                    <li><a href="/marketdata/market_list/">Announcements</a></li>
                                    <li><a href="/marketdata/statistics/">Statistics</a></li>
                                    <li><a href="/marketdata/weekly_event_reports/">Daily Diary</a></li>
                                    <li><a href="/marketdata/delisted-suspended/">Delisted & Suspended</a></li>
                                </ul>
                             </li>
                         </ul>
                     </div>
                 </li>
                <li class="dropdown <% If IsActive("brokers_new") or IsActive("regulation") or IsActive("companies") or IsActive("brokers") or IsActive("advisers") or IsActive("exchange") Then Response.Write("active") %> <% If Trim(Request.QueryString("page")) = "regulation" Then Response.Write("active") End If %>">
                    <a href="/regulation/" class="dropdown-toggle" aria-expanded="false">REGULATION</a>
                    <div class="dropdown-holder">
                        <ul class="dropdown-menu">
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Companies</span></li>
                                    <li><a href="/regulation/companies/">Companies</a></li>
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
                                    <li><a href="/regulation/brokers/broker_forms/">Forms</a></li>
                                    <li><a href="/regulation/brokers/overview/">Accessing NSX</a></li>
                                    <li><a href="/regulation/brokers/broker_supervision/">Broker Supervision</a></li>
                                    <li><a href="/regulation/brokers/be_fees/">Fees</a></li>
                                 </ul>
                            </li>
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Advisers</span></li>
                                    <li><a href="/regulation/advisers/adv_fees/">Fees</a></li>
                                    <li><a href="/regulation/adviser_forms">Adviser Forms</a></li>
                                </ul>
                            </li>
                            <li>
                                <ul class="nav-popup-menu">
                                    <li><span>Exchange</span></li>
                                    <li><a href="/regulation/exchange/tradingcodes/">Trading Codes &amp; Identifiers</a></li>
                                    <li><a href="/regulation/exchange/trading_hours_and_calendar/">Trading Hours &amp; Calendar</a></li>
                                    <li><a href="/regulation/exchange/trading_and_settlement_process/">Settlement</a></li>
                                    <li><a href="/regulation/exchange/market_supervision/">Market Supervision</a></li>
                                    <li><a href="/regulation/exchange/third_party_software/">Connectivity</a></li>
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