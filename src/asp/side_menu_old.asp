
<%
menu = Request.QueryString("menu")
page = Request.QueryString("page")
nsxcode = Request.QueryString("nsxcode")
tradingcode = Request.QueryString("tradingcode")

if len(menu) = 0 then menu = session("menu")
if len(page) = 0 then page = session("page")

'Response.write(menu + ",")
'Response.write(page)

' Return true if page (p) is the currently selected page
Function IsActive(p)
	IsActive = false
	If p = page Then 
		IsActive = true
	End If
    If p = menu Then 
		IsActive = true
	End If
End Function

Function IsActiveLink(scriptName)
    IsActiveLink = false
    If scriptName = menu Then 
        IsActiveLink = true
    End If
End Function
  
' Top and lower sections of side nav
sidenav_top = "<div class=""row""><div class=""col-sm-12 leftnav""><div class=""subpage-subnav"">"
sidenav_lower = "</div></div></div>"
     
' Top and lower sections of breadcrumb html
breadcrumb_top = "<div class=""row subnav-holder""><div class=""col-sm-8 breadcrumb-nav""><ol class=""breadcrumb"">"
breadcrumb_lower = "</ol></div></div>"

If menu = "about" Then
    'menu_class = "content-subpage"
End If

Function CleanUpPageName(page)
    pageName = Replace(page,"_"," ")
    pageName = Replace(pageName,"-"," ")
    Response.write(pageName)
End Function
%>

<div class="subnav-cont <%= menu_class %>">
<div class="container">


<%
If menu = "about" or menu = "governance" or menu = "investor-relations" or menu = "media-centre" Then

thispage = page
thispage = Replace(page,"_"," ")
thispage = Replace(thispage,"-"," ")
%>

    <% Response.Write(sidenav_top) %>

    <ul class="side-bar-menu">
        <li><a <% If IsActive("our-business") Then Response.Write("class=""active"" ")            %> href="/about/our-business/">Our Business</a></li>
        <li><a <% If IsActive("governance") Then Response.Write("class=""active"" ")              %> href="/about/governance/">Governance</a></li>
        <li><a <% If IsActive("investor-relations") Then Response.Write("class=""active"" ")      %> href="/about/investor-relations/">Investor Relations</a></li>
        <li><a <% If IsActive("media-centre") Then Response.Write("class=""active"" ")            %> href="/about/media-centre/">Media Centre</a></li>
        <li><a <% If IsActive("contact_us") Then Response.Write("class=""active"" ")              %> href="/about/contact_us/">Contact Us</a></li>
    </ul>

    <% Response.Write(sidenav_lower) %>

    <% Response.Write(breadcrumb_top) %>
        <li><a href="/default.asp">home</a></li>
        <li><a href="/about/">About</a></li>
    <% If menu = "about" and page <> "about" Then %>  
        <li><a href="/about/<%=page%>/"><%=thispage %></a></li>
    <% End If %>

    
    <% If menu = "governance" or menu = "investor-relations" or menu = "media-centre" Then 
        menu = Replace(menu,"-"," ")
    %>
        <li><a href="/about/<%=menu%>/"><%=menu %></a></li>
        <li><a href="/about/<%=page%>/"><%=thispage %></a></li>
    <% End If %>

    <% Response.Write(breadcrumb_lower) %>

<%
End If



If menu = "services" Then
%>

<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("lvm_hosting_service") Then Response.Write("class=""active"" ") %>href="<%=menu%>/lvm_hosting_service">LVM Hosting Service</a></li>
    <li><a <% If IsActive("exchange_hosting_service") Then Response.Write("class=""active"" ") %>href="<%=menu%>/exchange_hosting_service">Exchange Hosting Service</a></li>
    <li><a <% If IsActive("marketing") Then Response.Write("class=""active"" ") %>href="<%=menu%>/marketing">Marketing</a></li>
</ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
  <li><a href="/default.asp">home</a></li>
  <li><a href="#">Services</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If


If menu = "marketdata" or nsxcode <> "" or tradingcode <> "" Then
%>
    <% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
        <li><a <% If IsActive("directory") Then Response.Write("class=""active"" ") %>href="<%=menu%>/directory/">Directory</a></li>
        <li><a <% If IsActive("market_summary") Then Response.Write("class=""active"" ") %>href="<%=menu%>/market_summary/">Market Summary</a></li>
        <li><a <% If IsActive("prices") Then Response.Write("class=""active"" ") %>href="<%=menu%>/prices/">Prices</a></li>
        <li><a <% If IsActive("announcements") Then Response.Write("class=""active"" ") %>href="<%=menu%>/announcements/">Announcements</a></li>
        <li><a <% If IsActive("statistics") Then Response.Write("class=""active"" ") %>href="<%=menu%>/statistics/">Statistics</a></li>
        <li><a <% If IsActive("daily-diary") Then Response.Write("class=""active"" ") %>href="<%=menu%>/daily-diary/">Daily Diary</a></li>
        <li><a <% If IsActive("delisted-suspended") Then Response.Write("class=""active"" ") %>href="<%=menu%>/delisted-suspended/">Delisted & Suspended</a></li>   
    </ul>
    <% Response.Write(sidenav_lower) %>
    <% Response.Write(breadcrumb_top) %>
        <li><a href="/default.asp">home</a></li>
        <li><a href="/marketdata/">Market Data</a></li>

    <%
    If page = "directory" Then
    %> 
        <li><a href="/marketdata/directory/">directory</a></li>
        <%
        nsxcode = Request.QueryString("nsxcode")
        tradingcode = Request.QueryString("tradingcode")
        subpage = Request.QueryString("subpage")

        If nsxcode = "" then nsxcode = tradingcode End If
        If nsxcode <> "" or tradingcode <> "" Then %>
            <li><a href="/marketdata/directory/<%=subpage%>/"><%=subpage %></a></li>
        <%
        End If

        If subpage <> "" and nsxcode <> "" Then %>
            <li><a href="/marketdata/directory/<%=subpage%>/<%=nsxcode%>/"><%=nsxcode %></a></li>
        <%
        End If
    ElseIf page = "marketdata" Then

    Else
        If page <> "" Then   
            'Response.Write("here")
            
            thispage = page
            thispage = Replace(page,"_"," ")
            thispage = Replace(thispage,"-"," ")
            'Response.Write(thispage)
            If thispage = "market list" then thispage = "announcements"
            If thispage = "delisted suspended" then thispage = "delisted & suspended"
    %>
            <li><a href="/marketdata/<%=page%>/"><%=thispage%></a></li>
    <%
        End If
    End If
    %>

    <% Response.Write(breadcrumb_lower) %>
<%
End If 'end marketdata

If menu = "investing" or menu = "investors" Then
%>

<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("upcoming-listings") Then Response.Write("class=""active"" ") %>href="/investors/upcoming-listings/">Upcoming Listings</a></li>
    <li><a <% If IsActive("recent-Listings") Then Response.Write("class=""active"" ") %>href="/investors/recent-listings/">Recent Listings</a></li>
    <li><a <% If IsActive("indices") Then Response.Write("class=""active"" ") %>href="/investors/indices/">indices</a></li>
    <li><a <% If IsActive("broker-directory") Then Response.Write("class=""active"" ") %>href="/investors/broker-directory/">Broker Directory</a></li>
    <li><a <% If IsActive("security-types") Then Response.Write("class=""active"" ") %>href="/investors/security-types">Security Types</a></li>
    <!--<li><a <% If IsActive("case-studies") Then Response.Write("class=""active"" ") %>href="/investors/case-studies/">Case Studies</a></li>-->
</ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/investors/find_a_broker">Investors</a></li>

<% If page = "investing" Then 
    
   Else
    investors_page = Replace(page,"_"," ")
    investors_page = Replace(page,"-"," ")
%>
    <li><a href="/investors/<%=page%>/"><%=investors_page%></a></li>
<% End If %>

<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "brokers_new" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
        <li><a <% If IsActive("why_nsx") Then Response.Write("class=""active"" ") %>href="<%=menu%>/why_nsx/">Why NSX?</a></li>
        <li><a <% If IsActive("application_process") Then Response.Write("class=""active"" ") %>href="<%=menu%>/application_process/">Application Process</a></li>
        <li class="sub-item"><a <% If IsActive("overview") Then Response.Write("class=""active"" ") %>href="<%=menu%>/overview/">Accessing Overview</a></li>
        <li class="sub-item"><a <% If IsActive("nsx_nets") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_nets/">Accessing NSX NETS</a></li>
        <li class="sub-item"><a <% If IsActive("connectivity") Then Response.Write("class=""active"" ") %>href="<%=menu%>/connectivity/">Connectivity</a></li>
        <li><a <% If IsActive("trading_and_settlement_process") Then Response.Write("class=""active"" ") %>href="<%=menu%>/trading_and_settlement_process/">Settlement Process</a></li>
        <li><a <% If IsActive("rules_and_notes") Then Response.Write("class=""active"" ") %>href="<%=menu%>/rules_and_notes/">Rules &amp; Notes</a></li>
        <li><a <% If IsActive("broker_fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_fees">Fees</a></li>
        <li><a <% If IsActive("brochure_and_application_kit") Then Response.Write("class=""active"" ") %>href="<%=menu%>/brochure_and_application_kit/">Broker Application Kit</a></li>
        <li><a <% If IsActive("nsx_broker_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_broker_logo/">NSX Broker Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/brokers_new/why_nsx">For Brokers</a></li>
    <li><a href="/brokers_new/why_nsx">Become a Broker</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "brokers_existing" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
    <li><a <% If IsActive("broker_aids") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_aids">Broker Benefits</a></li>
    <li><a <% If IsActive("data_providers") Then Response.Write("class=""active"" ") %>href="<%=menu%>/data_providers">Data Providers</a></li>
    <li><a <% If IsActive("broker_supervision") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_supervision">Broker Supervision</a></li>
    <li><a <% If IsActive("broker_list") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_list">Broker List</a></li>
    <li><a <% If IsActive("rules_and_notes") Then Response.Write("class=""active"" ") %>href="<%=menu%>/rules_and_notes">Rules &amp; Notes</a></li>
    <li><a <% If IsActive("broker_fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_fees">Fees</a></li>
    <li><a <% If IsActive("broker_forms") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_forms">Broker Forms</a></li>
    <!-- li><a <% If IsActive("broker_admin_login") Then Response.Write("class=""active"" ") %>href="<%=menu%>/broker_admin_login">Broker Admin Login</a></li -->
    <li><a <% If IsActive("nsx_broker_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_broker_logo">NSX Broker Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/brokers_new/why_nsx">For Brokers</a></li>
    <li><a href="/brokers_existing/broker_aids">Existing Brokers</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "advisers_new" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
    <li><a <% If IsActive("an_why_nsx") Then Response.Write("class=""active"" ") %>href="<%=menu%>/an_why_nsx">Why NSX?</a></li>
    <li><a <% If IsActive("what_is_an_adviser") Then Response.Write("class=""active"" ") %>href="<%=menu%>/what_is_an_adviser">What is an Adviser</a></li>
    <li><a <% If IsActive("adv_application_process") Then Response.Write("class=""active"" ") %>href="<%=menu%>/adv_application_process">Application Process</a></li>
    <li><a <% If IsActive("advisor_fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/advisor_fees">Fees</a></li>
    <li><a <% If IsActive("ad_brochure_and_application_kit") Then Response.Write("class=""active"" ") %>href="<%=menu%>/ad_brochure_and_application_kit">Adviser Application Kit</a></li>
    <li><a <% If IsActive("nsx_adviser_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_adviser_logo">NSX Adviser Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/advisers_new/an_why_nsx">For Advisers</a></li>
    <li><a href="/advisers_new/an_why_nsx">Become an Adviser</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "advisers_existing" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
    <li><a <% If IsActive("ae_why_nsx") Then Response.Write("class=""active"" ") %>href="<%=menu%>/ae_why_nsx">Why NSX?</a></li>
    <li><a <% If IsActive("adviser_list") Then Response.Write("class=""active"" ") %>href="<%=menu%>/adviser_list">Adviser List</a></li>
    <li><a <% If IsActive("adviser_forms") Then Response.Write("class=""active"" ") %>href="<%=menu%>/adviser_forms">Adviser Forms</a></li>
    <li><a <% If IsActive("advisor_fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/advisor_fees">Fees</a></li>
    <li><a <% If IsActive("nsx_adviser_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx_adviser_logo">NSX Adviser Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/advisers_new/an_why_nsx">For Advisers</a></li>
    <li><a href="/advisers_existing/ae_why_nsx">Existing Advisers</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "companies_listed" Then
%>

<% Response.Write(sidenav_top) %>
    <ul class="side-bar-menu">
        <li><a <% If IsActive("partners") Then Response.Write("class=""active"" ") %>href="<%=menu%>/partners/">Partner Services</a></li>
        <li><a <% If IsActive("listing_rules") Then Response.Write("class=""active"" ") %>href="<%=menu%>/listing_rules/">Listing Rules &amp; Practice Notes</a></li>
        <li><a <% If IsActive("about-nominated-advisors") Then Response.Write("class=""active"" ") %>href="<%=menu%>/about-nominated-advisors/">About Nominated Advisers</a></li>
        <li><a <% If IsActive("waivers") Then Response.Write("class=""active"" ") %>href="<%=menu%>/waivers">Waivers</a></li>
        <li><a <% If IsActive("company_fees") Then Response.Write("class=""active"" ") %>href="<%=menu%>/company_fees/">Fees</a></li>
        <li><a <% If IsActive("forms") Then Response.Write("class=""active"" ") %>href="<%=menu%>/forms/">Forms</a></li>
        <li><a <% If IsActive("company_calendar") Then Response.Write("class=""active"" ") %>href="<%=menu%>/company_calendar/">Company Calendar</a></li>
        <li><a <% If IsActive("nsx-listed_logo") Then Response.Write("class=""active"" ") %>href="<%=menu%>/nsx-listed_logo/">NSX-Listed Logo</a></li>
    </ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/companies_pre_listed/why-list-with-us">For Companies</a></li>
    <li><a href="/companies_listed/listing_rules_and_notes">Listed Companies</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "companies_pre_listed" Then
%>

<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("why-list-with-us") Then Response.Write("class=""active"" ") %>href="<%=menu%>/why-list-with-us/">Why list with us</a></li>
    <li><a <% If IsActive("how-to-list") Then Response.Write("class=""active"" ") %>href="<%=menu%>/how-to-list/">How to List</a></li>
    <li><a <% If IsActive("getting-started") Then Response.Write("class=""active"" ") %>href="<%=menu%>/getting-started/">Getting Started</a></li>
    <li><a <% If IsActive("trading-models") Then Response.Write("class=""active"" ") %>href="<%=menu%>/trading-models/">Trading Models</a></li>
    <!--<li><a <% If IsActive("case-studies") Then Response.Write("class=""active"" ") %>href="<%=menu%>/case-studies/">Case Studies</a></li>-->
</ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) 
    listing_page = Replace(page,"_"," ")
    listing_page = Replace(listing_page,"-"," ")
%>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/companies_pre_listed/listing/">Listing</a></li>
    <% If page="listing" Then %>

    <% Else %>
        <li><a href="/companies_pre_listed/<%=page%>/"><%=listing_page%></a></li>
    <% End If %>

<% Response.Write(breadcrumb_lower) %>

<%
End If

If menu = "regulation" Then
%>

<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActive("companies") Then Response.Write("class=""active"" ") %> href="/regulation/companies/listing-rules-and-practice-notes/">Companies</a></li>
    <li><a <% If IsActive("brokers") Then Response.Write("class=""active"" ")   %> href="/regulation/brokers/rules_and_notes/">Brokers</a></li>
    <li><a <% If IsActive("advisers") Then Response.Write("class=""active"" ")  %> href="/regulation/advisers/advisor_fees/">Advisers</a></li>
    <li><a <% If IsActive("exchange") Then Response.Write("class=""active"" ")  %> href="/regulation/exchange/trading-codes-and-Identifiers/">Exchange</a></li>
</ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/regulation/">Regulation</a></li>

<% 
    If page="regulation" Then %>

    <% Else If page <> "" Then 
        thispage = Replace(page,"_"," ")
        thispage = Replace(thispage,"-"," ")
    %>
        <li><a href="/regulation/<%=page%>/"><%=thispage%></a></li>
    <% End If 
    
%>
    
<% End If %>
<% Response.Write(breadcrumb_lower) %>

<%
End If

If menu = "companies" or menu = "brokers" or menu = "advisers" or menu = "exchange" Then
%>

<% Response.Write(sidenav_top) %>
<ul class="side-bar-menu">
    <li><a <% If IsActiveLink("companies") Then Response.Write("class=""active"" ") %> href="/regulation/companies/">Companies</a></li>
    <li><a <% If IsActiveLink("brokers") Then Response.Write("class=""active"" ")   %> href="/regulation/brokers/">Brokers</a></li>
    <li><a <% If IsActiveLink("advisers") Then Response.Write("class=""active"" ")  %> href="/regulation/advisers/">Advisers</a></li>
    <li><a <% If IsActiveLink("exchange") Then Response.Write("class=""active"" ")  %> href="/regulation/exchange/">Exchange</a></li>
</ul>
<% Response.Write(sidenav_lower) %>
<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/regulation/">Regulation</a></li>
<% If page <> "" Then 
    %>
    <li><a href="/regulation/<%=menu%>/"><%=menu%></a></li>
    <li><a href="/regulation/<%=menu%>/<%=page%>/"><%=CleanUpPageName(page)%></a></li>
<% End If %>
<% Response.Write(breadcrumb_lower) %>

<%
End If


%>
</div><!-- /row --> 
</div><!-- /container -->
</div><!-- /subnav cont -->