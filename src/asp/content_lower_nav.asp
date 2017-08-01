<%
menu = Request.QueryString("menu")
page = Request.QueryString("page")
asp_page = Request.ServerVariables("SCRIPT_NAME")
nsxcode = Request.QueryString("nsxcode")
tradingcode = Request.QueryString("tradingcode")

'Response.write(menu + ", ")
'Response.write(page)

'asp_page_split = Split(asp_page,"/")
'Response.Write(asp_page)

if len(menu) = 0 then menu = session("menu")
if len(page) = 0 then page = session("page")

'Return true if page (p) is the currently selected page
Function IsActive(p)
	IsActive = false
	If p = page or p = asp_page Then 
		IsActive = true
	End If
End Function

Function IsActiveLink(scriptName)
  IsActiveLink = " "
  If Trim(LCase(scriptName)) = Trim(LCase(Request.ServerVariables("SCRIPT_NAME"))) Then 
    IsActiveLink = " class=""active"" "
  End If
End Function


' Top and lower sections of side nav
sidenav_top = "<div class=""row""><div class=""col-sm-12 leftnav""><div class=""subpage-subnav content-page-subnav"">"
sidenav_lower = "</div></div></div>"
    
sub_nav = false
If menu = "brokers_new" or menu = "brokers_existing" or menu = "companies" or menu = "advisers" or menu = "regulation" or menu = "exchange" or menu = "governance" or menu = "investor-relations" or menu = "media-centre" then sub_nav = true End If
If page = "company_details" or asp_page ="/security_summary_new1.asp" or nsxcode <> "" or tradingcode <> "" or page="brokers" or menu="brokers" or page = "governance" or page = "investor-relations" or page = "media-centre" then sub_nav = true End If

If sub_nav = true Then
%>
<div class="subnav-cont content-page-cont">
<div class="container">
<%
End If

If menu = "about" or menu = "governance" or menu = "investor-relations" or menu = "media-centre" Then
%>
<%  Response.Write(sidenav_top) %>
<ul class="side-bar-menu">

    <% If menu = "about" and page = "our-business" Then %>

    <% End If %>

    <% If menu = "governance" OR page = "governance" Then %>
        <li><a <% If IsActive("board-of-directors") Then Response.Write("class=""active"" ")        %> href="/about/governance/board-of-directors/">Board of directors</a></li>
        <li><a <% If IsActive("executive-team") Then Response.Write("class=""active"" ")            %> href="/about/governance/executive-team/">Executive Team</a></li>
        <li><a <% If IsActive("constitution-and-policies") Then Response.Write("class=""active"" ") %> href="/about/governance/constitution-and-policies/">Constitution &amp; Policies</a></li>
    <% End If %>

    <% If menu = "investor-relations" OR page = "investor-relations" Then %>
        <li><a <% If IsActive("financial-reporting") Then Response.Write("class=""active"" ")               %> href="/about/investor-relations/financial-reporting/">Financial Reporting</a></li>
        <li><a <% If IsActive("market-announcements") Then Response.Write("class=""active"" ")         %> href="/about/investor-relations/market-announcements/">Market Announcements</a></li>
    <% End If %>
    
    <% If menu = "media-centre" OR page = "media-centre" Then %>
        <li><a <% If IsActive("press-release") Then Response.Write("class=""active"" ")             %> href="/about/media-centre/press-release/">Press Release</a></li>
        <li><a <% If IsActive("thought-leadership") Then Response.Write("class=""active"" ")        %> href="/about/media-centre/thought-leadership/">Thought Leadership</a></li>
        <!--<li><a <% If IsActive("talk-box") Then Response.Write("class=""active"" ")  %> href="/about/media-centre/talk-box/">Talk Box</a></li>-->
        <!--<li><a <% If IsActive("listing-ceremonies") Then Response.Write("class=""active"" ")        %> href="/about/media-centre/listing-ceremonies/">Listing Ceremonies</a></li>-->
    <% End If %>

</ul>
<% Response.Write(sidenav_lower) %>
<%
End If

subpage = Request.QueryString("nsxcode")
If subpage <> "" or tradingcode <> "" Then
    If subpage = "" then subpage = tradingcode End If
%>
<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("/security_summary_new1.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/<%=subpage%>/">Overview</a></li>
    <li><a <% If IsActive("/security_details.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/details/<%=subpage%>/">Details</a></li>
    <li><a <% If IsActive("/prices_eom.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/prices-monthly/<%=subpage%>/">Month End Prices</a></li>
    <li><a <% If IsActive("/prices_daily.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/prices/<%=subpage%>/">Daily Prices</a></li>
    <li><a <% If IsActive("/search_for_company_announcements.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/announcements/<%=subpage%>/">Announcements</a></li>
	<li><a <% If IsActive("/prices_trades.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/trades/<%=subpage%>/">Trades</a></li>
    <li><a <% If IsActive("/security_capital.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/capital/<%=subpage%>/">Capital</a></li>
    <li><a <% If IsActive("/security_dividends.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/dividends/<%=subpage%>/">Dividends</a></li>
    <li><a <% If IsActive("/fun_statements.asp") Then Response.Write("class=""active"" ") %> href="/marketdata/company-directory/financials/<%=subpage%>/" >Financials</a></li>  
</ul>
<% Response.Write(sidenav_lower) %>
<%
End If

If menu = "brokers_new" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
    <li><a <% If IsActive("why_nsx") Then Response.Write("class=""active"" ") %>href="<%=menu%>/why_nsx">Why NSX?</a></li>
    <li><a <% If IsActive("application_process") Then Response.Write("class=""active"" ") %>href="<%=menu%>/application_process">Application Process</a></li>
    <li class="sub-item"><a <% If IsActive("overview") Then Response.Write("class=""active"" ") %>href="<%=menu%>/overview">Accessing Overview</a></li>
    <li class="sub-item"><a <% If IsActive("nsx_nets") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_nets">Accessing NSX NETS</a></li>
    <li class="sub-item"><a <% If IsActive("third_party_software") Then Response.Write("class=""active"" ") %>href="<%=menu%>/third_party_software">Third Party Software</a></li>
    <li><a <% If IsActive("trading_and_settlement_process") Then Response.Write("class=""active"" ") %>href="<%=menu%>/trading_and_settlement_process">Settlement Process</a></li>
    <li><a <% If IsActive("rules_and_notes") Then Response.Write("class=""active"" ") %>href="<%=menu%>/rules_and_notes">Rules &amp; Notes</a></li>
    <li><a <% If IsActive("fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/fees">Fees</a></li>
    <li><a <% If IsActive("brochure_and_application_kit") Then Response.Write("class=""active"" ") %>href="<%=menu%>/brochure_and_application_kit">Broker Application Kit</a></li>
    <li><a <% If IsActive("nsx_broker_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_broker_logo">NSX Broker Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>

<%
End If

If menu = "brokers_existing" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
    <li><a <% If IsActive("broker-aids") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_aids">Broker Benefits</a></li>
    <li><a <% If IsActive("data-providers") Then Response.Write("class=""active"" ") %>href="<%=menu%>/data_providers">Data Providers</a></li>
    <li><a <% If IsActive("broker-supervision") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_supervision">Broker Supervision</a></li>
    <li><a <% If IsActive("broker-list") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_list">Broker List</a></li>
    <li><a <% If IsActive("rules-and-notes") Then Response.Write("class=""active"" ") %>href="<%=menu%>/rules_and_notes">Rules &amp; Notes</a></li>
    <li><a <% If IsActive("broker-fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_fees">Fees</a></li>
    <li><a <% If IsActive("broker-forms") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_forms/">Broker Forms</a></li>
    <!-- li><a <% If IsActive("broker_admin_login") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_admin_login">Broker Admin Login</a></li -->
    <li><a <% If IsActive("nsx_broker_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_broker_logo">NSX Broker Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>

<%
End If

If page = "companies" or menu="companies" Then

If menu = "regulation" Then menu = "companies" End If
%>
<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("listing-rules") Then Response.Write("class=""active"" ") %>href="/regulation/<%=menu%>/listing-rules/">Listing Rules &amp; Practice Notes</a></li>
    <li><a <% If IsActive("company-forms") Then Response.Write("class=""active"" ") %>href="/regulation/<%=menu%>/company-forms/">Company Forms</a></li>
    <li><a <% If IsActive("company-fees") Then Response.Write("class=""active"" ") %>href="/regulation/<%=menu%>/company-fees/">Fees</a></li>
    <li><a <% If IsActive("waivers") Then Response.Write("class=""active"" ") %>href="/regulation/<%=menu%>/waivers/">Waivers</a></li>
    <li><a <% If IsActive("reporting-calendar") Then Response.Write("class=""active"" ") %>href="/regulation/<%=menu%>/reporting-calendar/">Reporting Calendar</a></li>
    
</ul>
<% Response.Write(sidenav_lower) %>
<%
End If

If page="advisers" or menu="advisers" Then
%>
<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("adviser-forms") Then Response.Write("class=""active"" ") %>href="/regulation/advisers/adviser-forms/">Adviser Forms</a></li>
    <li><a <% If IsActive("adviser-fees") Then Response.Write("class=""active"" ") %>href="/regulation/advisers/adviser-fees/">Fees</a></li>
</ul>
<% Response.Write(sidenav_lower) %>
<%
End If

If page="exchange" or menu="exchange" Then
%>
<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
	<li><a <% If IsActive("trading-codes") Then Response.Write("class=""active"" ") %>href="/regulation/exchange/trading-codes/">Trading Codes</a></li>
    <li><a <% If IsActive("trading-hours-and-calendar") Then Response.Write("class=""active"" ") %>href="/regulation/exchange/trading-hours-and-calendar/">Trading Hours &amp; Calendar</a></li>
    <li><a <% If IsActive("settlement") Then Response.Write("class=""active"" ") %>href="/regulation/exchange/settlement/">Settlement</a></li>
    <li><a <% If IsActive("market-supervision") Then Response.Write("class=""active"" ") %>href="/regulation/exchange/market-supervision/">Market Supervision</a></li>
    <li><a <% If IsActive("connectivity") Then Response.Write("class=""active"" ") %>href="/regulation/exchange/connectivity/">Connectivity</a></li>
    <li><a <% If IsActive("complaints") Then Response.Write("class=""active"" ") %>href="/regulation/exchange/complaints/">Complaints</a></li>
</ul>
<% Response.Write(sidenav_lower) %>
<%
End If


If page="brokers" or menu="brokers" Then
%>
<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("business-rules") Then Response.Write("class=""active"" ") %>href="/regulation/brokers/business-rules/">Business Rules &amp; Practice Notes</a></li>
    <li><a <% If IsActive("broker-forms") Then Response.Write("class=""active"" ") %>href="/regulation/brokers/broker-forms/">Forms</a></li>
    <li><a <% If IsActive("broker-fees") Then Response.Write("class=""active"" ") %>href="/regulation/brokers/broker-fees/">Fees</a></li>
    <li><a <% If IsActive("market-access") Then Response.Write("class=""active"" ") %>href="/regulation/brokers/market-access/">Market Access</a></li>
    <li><a <% If IsActive("broker-supervision") Then Response.Write("class=""active"" ") %>href="/regulation/brokers/broker-supervision/">Broker Supervision</a></li>
    
</ul>
<% Response.Write(sidenav_lower) %>
<%
End If

If sub_nav = true Then
%>
</div><!-- /row -->
</div><!-- /container -->
</div><!-- /subnav cont -->
<%
End If
%>