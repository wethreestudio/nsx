﻿<!--#INCLUDE FILE="stock_ticker.asp"--><%
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
			$("#topnavul li.dropdown").mouseover(function() {
				$("#topnav").addClass("blue-back");
			}).mouseout(function() {
				$("#topnav").removeClass("blue-back")
			});
		});
		</script>
	</head>
	<body class="nsx-lp">
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
					<a class="toplogo" href="/" target="_blank">
						<svg viewBox="0 0 1272 165" xmlns="http://www.w3.org/2000/svg" id="nsx-logo">
							<title>National stock Exchange of Australia logo</title>
							<g transform="translate(703 255)">
								<g transform="translate(-703 -255)" class="nsx-logo-grey">
									<path d="M 93.57 116.71L 123.33 154.8C 125.79 157.8 132.4 164.8 140.28 164.8L 180.19 164.8L 118.1 85.32L 93.57 116.71Z"/>
									<path d="M 89 48.09L 59.24 10C 56.78 7 50.17 0 42.29 0L 2.38001 0L 64.47 79.48L 89 48.09Z"/>
									<path d="M 42.29 107.87L 42.29 56.93L 0 2.79998L 0 162L 42.29 107.87Z"/>
									<path d="M 140.27 56.93L 140.27 107.87L 182.56 162L 182.56 2.79998L 140.27 56.93Z"/>
								</g>
								<g transform="translate(-700.62 -255)" class="nsx-logo-blue">
									<path d="M 39.91 164.8C 47.79 164.8 54.4 157.8 56.91 154.8L 177.8 0L 137.89 0C 130.01 0 123.4 7 120.89 10L 120.03 11.1L 0 164.8L 39.91 164.8Z"/>
									<path d="M 258.7 11.03L 258.7 56.96L 223.82 11.03L 215.33 11.03L 215.33 74.56L 225.2 74.56L 225.2 28.83L 259.99 74.56L 268.57 74.56L 268.57 11.03L 258.7 11.03Z"/>
									<path d="M 303.27 24.2C 297.65 24.2 292.4 25.05 284.53 27.2L 283.12 27.59L 284.83 35.97L 286.42 35.58C 291.596 34.1799 296.92 33.3978 302.28 33.25C 308.93 33.25 311.28 34.72 311.49 43.55C 307.68 43.48 304.74 43.48 299.49 43.48C 285.64 43.48 278.61 48.94 278.61 59.7C 278.61 70.14 284.47 75.43 296.02 75.43C 301.754 75.499 307.294 73.3493 311.48 69.43L 311.48 74.49L 321.25 74.49L 321.25 45.27C 321.28 32.26 318.27 24.2 303.27 24.2ZM 311.51 51.5L 311.51 59.68C 308.61 63.24 303.97 67.28 297.83 67.28C 291.16 67.28 287.91 64.62 287.91 59.14C 287.91 54.36 289.91 51.6 300.21 51.6C 302.65 51.6 304.82 51.6 306.95 51.55L 311.51 51.5Z"/>
									<path d="M 360.05 64.77L 358.5 65.01C 356.226 65.416 353.919 65.6069 351.61 65.58C 346.61 65.58 344.46 64.58 344.46 58.33L 344.46 33.9L 359.02 33.9L 359.02 25.12L 344.44 25.12L 344.44 13.01L 334.77 13.01L 334.77 25.09L 327.54 25.09L 327.54 33.9L 334.77 33.9L 334.77 58.57C 334.77 69.86 339.35 74.89 349.61 74.89C 353.136 74.7907 356.628 74.1672 359.97 73.04L 361.28 72.64L 360.05 64.77Z"/>
									<path d="M 373.03 18.62C 374.1 18.5711 375.132 18.2099 375.998 17.5809C 376.865 16.952 377.528 16.083 377.907 15.0812C 378.285 14.0794 378.361 12.9887 378.126 11.944C 377.892 10.8992 377.356 9.94617 376.585 9.20256C 375.815 8.45895 374.843 7.95737 373.791 7.75979C 372.738 7.56222 371.651 7.67731 370.663 8.09085C 369.676 8.50438 368.831 9.19823 368.233 10.0867C 367.635 10.9751 367.311 12.0192 367.3 13.09C 367.279 13.839 367.415 14.5842 367.698 15.278C 367.981 15.9718 368.406 16.5989 368.945 17.1192C 369.484 17.6396 370.126 18.0419 370.829 18.3003C 371.533 18.5587 372.282 18.6676 373.03 18.62Z"/>
									<path d="M 377.87 25.09L 368.1 25.09L 368.1 74.57L 377.87 74.57L 377.87 25.09Z"/>
									<path d="M 411.5 24.2C 396.59 24.2 386.96 34.42 386.96 50.2C 386.96 65.53 396.55 75.43 411.4 75.43C 426.25 75.43 436.04 65.52 436.04 50.2C 436.04 34.41 426.44 24.2 411.5 24.2ZM 411.4 66.58C 402.15 66.58 396.63 60.43 396.63 50.12C 396.63 39.44 402.19 33.12 411.5 33.12C 420.81 33.12 426.5 39.49 426.5 50.12C 426.44 60.43 420.83 66.58 411.44 66.58L 411.4 66.58Z"/>
									<path d="M 471.35 24.3C 465.261 24.2819 459.389 26.556 454.9 30.67L 454.9 25.09L 445.13 25.09L 445.13 74.57L 454.9 74.57L 454.9 41.96C 459.34 36.47 464.61 33.57 470.17 33.57C 476.64 33.57 478.5 36.26 478.5 45.57L 478.5 74.57L 488.27 74.57L 488.27 44.08C 488.27 30.58 482.89 24.3 471.35 24.3Z"/>
									<path d="M 521.44 24.2C 515.82 24.2 510.57 25.05 502.7 27.2L 501.29 27.59L 503 35.97L 504.59 35.58C 509.764 34.1874 515.084 33.412 520.44 33.27C 527.09 33.27 529.44 34.74 529.65 43.57C 525.84 43.5 522.9 43.5 517.65 43.5C 503.8 43.5 496.77 48.96 496.77 59.72C 496.77 70.16 502.63 75.45 514.18 75.45C 519.914 75.519 525.454 73.3693 529.64 69.45L 529.64 74.51L 539.44 74.51L 539.44 45.27C 539.44 32.26 536.44 24.2 521.44 24.2ZM 529.68 51.5L 529.68 59.68C 526.78 63.24 522.14 67.28 516 67.28C 509.33 67.28 506.08 64.62 506.08 59.14C 506.08 54.36 508.08 51.6 518.38 51.6C 520.82 51.6 522.99 51.6 525.12 51.55L 529.68 51.5Z"/>
									<path d="M 561.24 6.56999L 551.47 6.56999L 551.47 74.56L 561.24 74.56L 561.24 6.56999Z"/>
									<path d="M 621.12 37.74L 620.85 37.65C 608.24 33.48 605.26 32.27 605.26 26.45C 605.26 22.94 608.81 19.2 615.38 19.2C 621.957 19.1955 628.458 20.6075 634.44 23.34L 635.92 24L 639.25 15.66L 637.89 15.04C 630.845 11.8134 623.199 10.1097 615.45 10.04C 603.32 10.04 595.17 16.88 595.17 27.04C 595.17 39.8 604.17 42.65 614.68 45.96C 628.61 50.33 630.68 52.6 630.68 58.13C 630.68 64.69 624.58 66.07 619.47 66.07C 612.61 66.07 604.37 63.39 597.47 58.89L 596.04 57.96L 591.82 65.8L 592.9 66.61C 600.744 72.2368 610.127 75.319 619.78 75.44C 632.72 75.44 640.78 68.44 640.78 57.24C 640.81 46.42 633.9 42.04 621.12 37.74Z"/>
									<path d="M 676.22 64.77L 674.68 65.01C 672.41 65.4154 670.106 65.6062 667.8 65.58C 662.8 65.58 660.65 64.58 660.65 58.33L 660.65 33.9L 675.21 33.9L 675.21 25.12L 660.64 25.12L 660.64 13.01L 650.97 13.01L 650.97 25.09L 643.74 25.09L 643.74 33.9L 650.97 33.9L 650.97 58.57C 650.97 69.86 655.55 74.89 665.81 74.89C 669.336 74.7903 672.827 74.1668 676.17 73.04L 677.48 72.64L 676.22 64.77Z"/>
									<path d="M 704.94 24.2C 690.03 24.2 680.4 34.42 680.4 50.2C 680.4 65.53 689.99 75.43 704.84 75.43C 719.69 75.43 729.44 65.55 729.44 50.22C 729.44 34.41 719.85 24.2 704.94 24.2ZM 704.84 66.58C 695.59 66.58 690.07 60.43 690.07 50.12C 690.07 39.44 695.63 33.12 704.94 33.12C 714.25 33.12 719.94 39.49 719.94 50.12C 719.91 60.43 714.28 66.58 704.84 66.58Z"/>
									<path d="M 776.1 60.07L 774.69 61.18C 769.69 65.12 765.53 66.59 759.42 66.59C 750.67 66.59 745.42 60.48 745.42 50.23C 745.42 39.59 750.93 32.98 759.8 32.98C 764.474 33.0005 769.069 34.1863 773.17 36.43L 774.59 37.26L 778.38 29.99L 777.19 29.21C 771.95 25.9237 765.885 24.19 759.7 24.21C 745.15 24.21 735.75 34.43 735.75 50.21C 735.75 65.54 744.75 75.44 758.61 75.44C 767.36 75.44 772.96 73.44 779.25 67.93L 780.25 67.07L 776.1 60.07Z"/>
									<path d="M 823.86 74.56L 805.66 52.34L 797.85 59.9L 797.85 74.56L 788.08 74.56L 788.08 6.56999L 797.85 6.56999L 797.85 46.84L 820.51 25.09L 833.65 25.09L 812.76 45.31L 836.13 74.56L 823.86 74.56Z"/>
									<path d="M 869.84 65.09L 869.84 47.24L 898.56 47.24L 898.56 37.76L 869.84 37.76L 869.84 20.5L 902.62 20.5L 902.62 11.03L 859.98 11.03L 859.98 74.56L 903.51 74.56L 903.51 65.09L 869.84 65.09Z"/>
									<path d="M 939.26 49.63L 957.26 25.09L 945.84 25.09L 934.64 40.2C 934.02 40.93 933.35 41.75 932.64 42.7C 931.97 41.76 931.31 40.95 930.73 40.28L 919.47 25.09L 908.06 25.09L 926.06 49.63L 907.67 74.57L 918.88 74.57L 930.69 59.06C 931.31 58.33 931.98 57.51 932.69 56.56C 933.37 57.5 934.03 58.31 934.61 59L 946.44 74.57L 957.65 74.57L 939.26 49.63Z"/>
									<path d="M 999.98 60.07L 998.57 61.18C 993.57 65.12 989.41 66.59 983.3 66.59C 974.55 66.59 969.3 60.48 969.3 50.23C 969.3 39.59 974.81 32.98 983.68 32.98C 988.354 33.0005 992.949 34.1863 997.05 36.43L 998.47 37.26L 1002.26 29.99L 1001.07 29.21C 995.83 25.9237 989.765 24.19 983.58 24.21C 969.03 24.21 959.63 34.43 959.63 50.21C 959.63 65.54 968.63 75.44 982.49 75.44C 991.24 75.44 996.84 73.44 1003.13 67.93L 1004.13 67.07L 999.98 60.07Z"/>
									<path d="M 1038.27 24.2C 1031.95 24.2326 1025.87 26.6588 1021.27 30.99L 1021.27 6.56999L 1011.6 6.56999L 1011.6 74.57L 1021.27 74.57L 1021.27 42.45C 1025.89 36.75 1031.02 33.86 1036.54 33.86C 1043.01 33.86 1044.88 36.57 1044.88 45.96L 1044.88 74.56L 1054.65 74.56L 1054.65 44.08C 1054.59 30.33 1049.55 24.2 1038.27 24.2Z"/>
									<path d="M 1087.31 24.2C 1081.69 24.2 1076.44 25.05 1068.57 27.2L 1067.16 27.59L 1068.87 35.97L 1070.45 35.58C 1075.63 34.1799 1080.95 33.3978 1086.31 33.25C 1092.96 33.25 1095.31 34.72 1095.52 43.55C 1091.71 43.48 1088.77 43.48 1083.52 43.48C 1069.67 43.48 1062.64 48.94 1062.64 59.7C 1062.64 70.14 1068.5 75.43 1080.05 75.43C 1085.79 75.5016 1091.33 73.3517 1095.52 69.43L 1095.52 74.49L 1105.29 74.49L 1105.29 45.27C 1105.31 32.26 1102.3 24.2 1087.31 24.2ZM 1095.55 51.5L 1095.55 59.68C 1092.65 63.24 1088.01 67.28 1081.87 67.28C 1075.19 67.28 1071.95 64.62 1071.95 59.14C 1071.95 54.36 1073.95 51.6 1084.25 51.6C 1086.69 51.6 1088.86 51.6 1090.99 51.55L 1095.55 51.5Z"/>
									<path d="M 1143.07 24.3C 1136.98 24.2819 1131.11 26.556 1126.62 30.67L 1126.62 25.09L 1116.85 25.09L 1116.85 74.57L 1126.62 74.57L 1126.62 41.96C 1131.06 36.47 1136.33 33.57 1141.89 33.57C 1148.36 33.57 1150.23 36.26 1150.23 45.57L 1150.23 74.57L 1160 74.57L 1160 44.08C 1159.99 30.58 1154.62 24.3 1143.07 24.3Z"/>
									<path d="M 1205.8 25.09L 1205.8 30C 1201.06 26.3285 1195.25 24.2935 1189.25 24.2C 1172.49 24.2 1168.97 37.98 1168.97 49.53C 1168.97 70.83 1185.18 72.53 1190.14 72.53C 1197.32 72.53 1201.8 70.4 1205.8 66.81C 1205.66 76.4 1201.56 80.88 1192.91 80.88C 1186.96 80.9188 1181.09 79.5154 1175.8 76.79L 1174.27 76.01L 1171.15 83.8L 1172.31 84.48C 1178.78 88.1917 1186.14 90.0819 1193.6 89.95C 1207.76 89.95 1215.6 81.55 1215.6 66.3L 1215.6 25.09L 1205.8 25.09ZM 1192.12 64.01C 1187.12 64.01 1178.63 62.13 1178.63 49.53C 1178.63 34.69 1185.76 32.98 1191.13 32.98C 1196.32 32.98 1201.13 35.51 1205.8 40.72L 1205.8 56.19C 1201.66 61.02 1197.87 64 1192.11 64L 1192.12 64.01Z"/>
									<path d="M 1247.29 24.2C 1232.48 24.2 1223.64 33.93 1223.64 50.2C 1223.64 66.2 1232.11 75.43 1246.89 75.43C 1255.36 75.43 1261.79 73.05 1267.74 67.7L 1268.74 66.82L 1264.42 59.94L 1263.05 61.06C 1258.64 64.9193 1252.97 67.0135 1247.11 66.94C 1241.28 66.94 1234.29 64.49 1233.24 53.14L 1268.88 53.14L 1269.06 51.78C 1269.22 50.6139 1269.29 49.437 1269.27 48.26C 1268.85 32.76 1261.05 24.2 1247.29 24.2ZM 1233.53 44.8C 1235.18 34.92 1241.89 32.8 1247.39 32.8C 1254.86 32.8 1259.11 36.8 1260.04 44.8L 1233.53 44.8Z"/>
									<path d="M 235.22 106.97C 220.31 106.97 210.68 117.19 210.68 132.97C 210.68 148.3 220.27 158.2 235.12 158.2C 249.97 158.2 259.76 148.3 259.76 132.97C 259.76 117.19 250.13 106.97 235.22 106.97ZM 235.12 149.35C 225.87 149.35 220.35 143.2 220.35 132.89C 220.35 122.21 225.91 115.89 235.22 115.89C 244.53 115.89 250.22 122.26 250.22 132.89C 250.19 143.2 244.55 149.35 235.12 149.35Z"/>
									<path d="M 287.82 96.74C 290.52 96.74 292.82 96.84 294.82 97.03L 296.35 97.18L 297.29 89.18L 295.92 88.87C 292.938 88.2701 289.901 87.9919 286.86 88.04C 275.93 88.04 270.86 93.41 270.86 104.95L 270.86 107.9L 264.23 107.9L 264.23 116.68L 270.86 116.68L 270.86 157.38L 280.63 157.38L 280.63 116.68L 295.68 116.68L 295.68 107.9L 280.58 107.9L 280.58 105.01C 280.58 98.9 282.44 96.74 287.82 96.74Z"/>
									<path d="M 353.82 93.8L 342.74 93.8L 315.35 157.34L 326.09 157.34L 332.92 141.4L 363.54 141.4L 370.44 157.34L 381.07 157.34L 353.82 93.8ZM 336.82 132.02L 347.22 107.9C 347.59 106.9 347.93 106.04 348.22 105.21C 348.53 106.05 348.88 106.97 349.22 107.97L 359.57 132.03L 336.82 132.02Z"/>
									<path d="M 418.67 107.9L 418.67 140.3C 414.56 145.71 408.93 149.06 403.9 149.06C 397.31 149.06 394.97 145.84 394.97 136.76L 394.97 107.9L 385.3 107.9L 385.3 138.18C 385.3 151.88 390.58 158.26 401.92 158.26C 407.77 158.26 413.51 155.99 418.67 151.66L 418.67 157.36L 428.44 157.36L 428.44 107.9L 418.67 107.9Z"/>
									<path d="M 458.75 127.45L 457.89 127.17C 451.03 124.95 448.25 123.93 448.25 120.82C 448.25 116.39 452.35 115.46 455.79 115.46C 459.69 115.46 465.07 116.75 470.54 119.01L 472.06 119.63L 474.88 111.79L 473.58 111.19C 468.052 108.526 462.024 107.06 455.89 106.89C 445.3 106.89 438.97 112.18 438.97 121.03C 438.97 129.88 445.37 132.6 454.43 135.5L 454.72 135.59C 464.49 138.65 466.8 139.59 466.8 144.01C 466.8 147.7 463.96 149.57 458.37 149.57C 452.406 149.618 446.63 147.484 442.13 143.57L 440.74 142.43L 436.22 149.76L 437.22 150.63C 443.224 155.502 450.708 158.183 458.44 158.23C 469.36 158.23 476.15 152.74 476.15 143.89C 476.17 134.21 470.59 131.33 458.75 127.45Z"/>
									<path d="M 512.91 147.54L 511.36 147.78C 509.087 148.19 506.78 148.384 504.47 148.36C 499.47 148.36 497.32 147.36 497.32 141.11L 497.32 116.64L 511.88 116.64L 511.88 107.9L 497.34 107.9L 497.34 95.78L 487.67 95.78L 487.67 107.9L 480.44 107.9L 480.44 116.68L 487.67 116.68L 487.67 141.35C 487.67 152.64 492.25 157.67 502.51 157.67C 506.036 157.57 509.527 156.947 512.87 155.82L 514.18 155.42L 512.91 147.54Z"/>
									<path d="M 551.12 107.28C 549.092 107.048 547.051 106.944 545.01 106.97C 542.53 107 540.088 107.58 537.859 108.667C 535.63 109.755 533.67 111.324 532.12 113.26L 532.12 107.9L 522.35 107.9L 522.35 157.38L 532.12 157.38L 532.12 127.99C 534.46 120.73 538.96 116.74 544.81 116.74C 546.46 116.74 548.01 116.74 550.32 116.93L 551.89 117.06L 552.62 107.44L 551.12 107.28Z"/>
									<path d="M 579.27 106.97C 573.65 106.97 568.4 107.82 560.53 109.97L 559.12 110.36L 560.83 118.74L 562.42 118.35C 567.596 116.95 572.92 116.168 578.28 116.02C 584.93 116.02 587.28 117.49 587.49 126.32C 583.68 126.25 580.74 126.25 575.49 126.25C 561.64 126.25 554.61 131.71 554.61 142.47C 554.61 152.91 560.47 158.2 572.02 158.2C 577.754 158.269 583.293 156.119 587.48 152.2L 587.48 157.26L 597.25 157.26L 597.25 128.04C 597.27 115.03 594.26 106.97 579.27 106.97ZM 587.51 134.27L 587.51 142.45C 584.61 146.01 579.97 150.05 573.83 150.05C 567.16 150.05 563.91 147.39 563.91 141.91C 563.91 137.13 565.91 134.37 576.21 134.37C 578.65 134.37 580.82 134.37 582.95 134.32L 587.51 134.27Z"/>
									<path d="M 618.69 89.34L 608.92 89.34L 608.92 157.33L 618.69 157.33L 618.69 89.34Z"/>
									<path d="M 635.72 101.39C 636.79 101.343 637.823 100.983 638.691 100.356C 639.559 99.7278 640.224 98.8593 640.604 97.8576C 640.984 96.8559 641.061 95.7649 640.828 94.7195C 640.594 93.674 640.059 92.72 639.289 91.9754C 638.519 91.2308 637.547 90.7283 636.494 90.53C 635.442 90.3317 634.354 90.4463 633.365 90.8596C 632.377 91.2729 631.532 91.9668 630.934 92.8555C 630.335 93.7443 630.011 94.7888 630 95.86C 629.979 96.6082 630.114 97.3525 630.397 98.0455C 630.68 98.7386 631.103 99.3651 631.642 99.8854C 632.18 100.406 632.82 100.808 633.522 101.067C 634.225 101.326 634.973 101.436 635.72 101.39Z"/>
									<path d="M 640.56 107.86L 630.79 107.86L 630.79 157.34L 640.56 157.34L 640.56 107.86Z"/>
									<path d="M 674.61 106.97C 668.99 106.97 663.74 107.82 655.87 109.97L 654.46 110.36L 656.17 118.74L 657.75 118.35C 662.926 116.95 668.25 116.168 673.61 116.02C 680.26 116.02 682.61 117.49 682.82 126.32C 679.01 126.25 676.07 126.25 670.82 126.25C 656.97 126.25 649.94 131.71 649.94 142.47C 649.94 152.91 655.8 158.2 667.35 158.2C 673.088 158.272 678.631 156.122 682.82 152.2L 682.82 157.26L 692.59 157.26L 692.59 128.04C 692.62 115.03 689.6 106.97 674.61 106.97ZM 682.85 134.27L 682.85 142.45C 679.95 146.01 675.31 150.05 669.17 150.05C 662.49 150.05 659.25 147.39 659.25 141.91C 659.25 137.13 661.25 134.37 671.55 134.37C 673.99 134.37 676.16 134.37 678.29 134.32L 682.85 134.27Z"/>
								</g>
							</g>
						</svg>
					</a>
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#nsx-primary-nav" aria-expanded="false">
						<i class="fa fa-align-right fa-lg" aria-hidden="true"></i>
						<span class="sr-only">Toggle navigation</span>
					</button>
				</div>
				<div class="collapse navbar-collapse" id="nsx-primary-nav">
					<ul class="nav navbar-nav" id="topnavul">
						<li class="<% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
							<a href="#statement">声明</a>
						</li>
						<li class="<% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
							<a href="#listing">上市须知</a>
						</li>
						<li class="<% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
							<a href="#trading">交易须知</a>
						</li>
						<li class="<% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
							<a href="#suitability">新兴市场企业上市的合宜条件与规则</a>
						</li>
						<li class="<% If IsActive("companies_pre_listed") or IsActive("companies_listed") or IsActive("listing") Then Response.Write("active") End If %>">
							<a href="#contact">联系NSX</a>
						</li>
					</ul>
				</div><!-- /nav .navbar-collapse -->
			</div>
		</nav>