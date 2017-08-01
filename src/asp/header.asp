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
page = Request.QueryString("page")
menu = Request.QueryString("menu")
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
		<link rel="shortcut icon" href="/favicon-32x32.png" type="image/x-icon">
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
		'<script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
		'<link rel="stylesheet" href="/css/allstyles.min.css" type="text/css" media="all">
		'<script type="text/javascript" src="/js/jquery-migrate-3.0.0XXX.min.js"></script>
		'<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
		'<script type="text/javascript" src="js/jquery.min.js"></script>
		%>
		<!--<link rel="stylesheet" type="text/css" href="https://cloud.typography.com/6874356/6131572/css/fonts.css" />-->
		<link href="/css/fonts.css" rel="stylesheet" type="text/css" media="all">
		<link href="/css/font-awesome.min.css" rel="stylesheet">
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="bootstrap-3.3.7/js/carousel.js"></script>
		<link rel="stylesheet" href="/css/main.css" type="text/css" media="all">
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
			
		String.prototype.toTitleCase = function(){
			var smallWords = /^(a|an|and|as|at|but|by|en|for|if|in|nor|of|on|or|per|the|to|vs?\.?|via)$/i;
			return this.replace(/[A-Za-z0-9\u00C0-\u00FF]+[^\s-]*/g, function(match, index, title){
				if (index > 0 && index + match.length !== title.length &&
					match.search(smallWords) > -1 && title.charAt(index - 2) !== ":" &&
					(title.charAt(index + match.length) !== '-' || title.charAt(index - 1) === '-') &&
					title.charAt(index - 1).search(/[^\s-]/) < 0) {
					return match.toLowerCase();
				}
				if (match.substr(1).search(/[A-Z]|\../) > -1) {
					return match;
				}
				return match.charAt(0).toUpperCase() + match.substr(1);
			});
		};
		</script>
		<%
		' Additional JS Includes
		For Each jsInclude In objJsIncludes
		%><script type="text/javascript" src="<%=CStr(objJsIncludes(jsInclude))%>"></script>
		<%
		Next
		%>
		
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
		<script>
		$(document).ready(function() {
			$("#topnavul").mouseover(function() {
				$("#topnav").addClass("blue-back");
			}).mouseout(function() {
				$("#topnav").removeClass("blue-back")
			});
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
		<nav class="navbar navbar-default topnav" role="navigation" id="topnav">
			<div class="container">
				
				<!-- nav -->
				<div class="navbar-header">
					<a class="toplogo" href="/"><img src="images/lg_2.png" class="vanilla-logo"/><img src="images/logo2_white.png" class="reverse-logo"/></a>
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#nsx-primary-nav" aria-expanded="false">
						<span class="sr-only">Toggle navigation</span>
					</button>
				</div>
				<div class="collapse navbar-collapse" id="nsx-primary-nav">
					<ul class="nav navbar-nav" id="topnavul">
						<li class="dropdown <% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
							<span><a href="/listing/">LISTING</a><button data-toggle="collapse" data-target="#nsx-primary-nav-listing" aria-expanded="false"><span class="sr-only">Toggle Listing menu</span></button></span>
							<div class="dropdown-holder collapse" id="nsx-primary-nav-listing">
								<ul>
									<li><a href="/listing/why-list-with-us/">Why List with Us</a></li>
									<li><a href="/listing/how-to-list/">How to List</a></li>
									<li><a href="/listing/getting-started/">Getting Started</a></li>
									<li><a href="/listing/nominated-adviser/">Nominated Adviser</a></li>
									<li><a href="/listing/trading-models/">Trading Models</a></li>
								</ul>
							</div>
						</li>
						<li class="dropdown <% If IsActive("investors") Then Response.Write("active") End If %> ">
							<span><a href="/investing/">INVESTING</a><button data-toggle="collapse" data-target="#nsx-primary-nav-investing" aria-expanded="false"><span class="sr-only">Toggle Investing menu</span></button></span>
							<div class="dropdown-holder collapse" id="nsx-primary-nav-investing">
								<ul>
									<li><a href="/investing/upcoming-listings/">Upcoming Listings</a></li>
									<li><a href="/investing/recent-listings/">Recent Listings</a></li>
									<li><a href="/investing/indices/">Indices</a></li>
									<li><a href="/investing/broker-directory/">Broker Directory</a></li>
									<li><a href="/investing/security-types/">Security Types</a></li>
								</ul>
							</div>
						</li>
						<li class="dropdown <% If IsActive("marketdata") Then Response.Write("active") End If %>">
							<span><a href="/marketdata/">MARKET DATA</a><button data-toggle="collapse" data-target="#nsx-primary-nav-marketdata" aria-expanded="false"><span class="sr-only">Toggle Market Data menu</span></button></span>
							<div class="dropdown-holder collapse" id="nsx-primary-nav-marketdata">
								<ul>
									<li><a href="/marketdata/directory/">Directory</a></li>
									<li><a href="/marketdata/market-summary/">Market Summary</a></li>
									<li><a href="/marketdata/prices/">Prices</a></li>
									<li><a href="/marketdata/announcements/">Announcements</a></li>
									<li><a href="/marketdata/statistics/">Statistics</a></li>
									<li><a href="/marketdata/daily-diary/">Daily Diary</a></li>
									<li><a href="/marketdata/delisted-suspended/">Delisted &amp; Suspended</a></li>
								</ul>
							</div>
						</li>
						<li class="dropdown <% If IsActive("brokers_new") or IsActive("regulation") or IsActive("companies") or IsActive("brokers") or IsActive("advisers") or IsActive("exchange") Then Response.Write("active") %> <% If Trim(Request.QueryString("page")) = "regulation" Then Response.Write("active") End If %>">
							<span><a href="/regulation/" class="dropdown-toggle" aria-expanded="false">REGULATION</a><button data-toggle="collapse" data-target="#nsx-primary-nav-regulation" aria-expanded="false"><span class="sr-only">Toggle Regulation menu</span></button></span>
							<div class="dropdown-holder collapse" id="nsx-primary-nav-regulation">
								<ul class="row">
									<li class="col-xs-12 col-sm-6 col-md-3">
										<a href="/regulation/companies/listing-rules/">Companies</a>
										<ul class="nav-popup-menu">
											<li><a href="/regulation/companies/listing-rules/">Listing Rules &amp; Practice Notes</a></li>
											<li><a href="/regulation/companies/company-forms/">Forms</a></li>
											<li><a href="/regulation/companies/company-fees/">Fees</a></li>
											<li><a href="/regulation/companies/waivers/">Waivers</a></li>
											<li><a href="/regulation/companies/reporting-calendar/">Reporting Calendar</a></li>
										</ul>
									</li>
									<li class="col-xs-12 col-sm-6 col-md-3">
										<a href="/regulation/brokers/business-rules/">Brokers</a>
										<ul class="nav-popup-menu">
											<li><a href="/regulation/brokers/business-rules/">Business Rules &amp; Practice Notes</a></li>
											<li><a href="/regulation/brokers/broker-forms/">Forms</a></li>
											<li><a href="/regulation/brokers/broker-fees/">Fees</a></li>
											<li><a href="/regulation/brokers/market-access/">Market Access</a></li>
											<li><a href="/regulation/brokers/broker-supervision/">Broker Supervision</a></li>
										</ul>
									</li>
									<li class="col-xs-12 col-sm-6 col-md-3">
										<a href="/regulation/advisers/adviser-forms/">Advisers</a>
										<ul class="nav-popup-menu">
											<li><a href="/regulation/advisers/adviser-forms/">Forms</a></li>
											<li><a href="/regulation/advisers/adviser-fees/">Fees</a></li>
										</ul>
									</li>
									<li class="col-xs-12 col-sm-6 col-md-3">
										<a href="/regulation/exchange/trading-codes/">Exchange</a>
										<ul class="nav-popup-menu">
											<li><a href="/regulation/exchange/trading-codes/">Trading Codes</a></li>
											<li><a href="/regulation/exchange/trading-hours-and-calendar/">Trading Hours &amp; Calendar</a></li>
											<li><a href="/regulation/exchange/settlement/">Settlement</a></li>
											<li><a href="/regulation/exchange/market-supervision/">Market Supervision</a></li>
											<li><a href="/regulation/exchange/connectivity/">Connectivity</a></li>
											<li><a href="/regulation/exchange/complaints/">Complaints</a></li>
										</ul>
									</li>
								</ul>
							</div>
						</li>
						
						<% If LCase(Session("PASSWORDACCESS")) <> "yes" Then %>
						<li class="dropdown">
							<span><a class="login">LOGIN</a><button data-toggle="collapse" data-target="#nsx-primary-nav-login" aria-expanded="false"><span class="sr-only">Toggle Login menu</span></button></span>
							<div class="dropdown-holder collapse" id="nsx-primary-nav-login">
								<div class="row">
									<div id="lin" class="login-form col-xs-12 col-sm-6 col-md-4"></div>
								</div>
							</div>
						</li>
						<% End If %>
					</ul>
					<!-- #include virtual | file ="login_status.asp" -->

					<div class="navbar-form topsearch" id="topsearch">
						<button class="topsearch-toggle" data-toggle="collapse" data-target="#nsx-primary-nav-search" aria-expanded="false">&#xf002;</button>
						<div class="topsearch-form collapse" id="nsx-primary-nav-search">
							<form class="navbar-form topsearch-form" role="search" id="marketsearch" name="marketsearch" action="search.asp" method="get">
								<input type="text" id="searchbox" name="q" class="topsearch-input" value="" title="Company code or name" autocomplete="off">
								<input id="searchgo" type="submit" class="broker_bttn topsearch-btn" value="&#xf002;" onclick="$('#marketsearch').submit()">
								<input name="id" type="hidden" id="id">
								<input name="t" type="hidden" id="t">
							</form>
						</div>
					</div>
				</div><!-- /nav .navbar-collapse -->
			</div>
		</nav>