
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

<div class="subnav-cont <%= menu_class %> " style="border:none;background:none;">
<div class="container">


<%
If menu = "about" or menu = "governance" or menu = "investor-relations" or menu = "media-centre" Then

thispage = page
thispage = Replace(page,"_"," ")
thispage = Replace(thispage,"-"," ")
%>

    <% Response.Write(breadcrumb_top) %>
        <li><a href="/default.asp">home</a></li>
        <li><a href="/about/our-business/">About</a></li>
    <% If menu = "about" and page <> "about" Then %>  
        <li><a href="/about/<%=page%>/"><%=thispage %></a></li>
    <% End If %>

    
    <% If menu = "governance" or menu = "media-centre" Then 
        menulink = menu
        menu = Replace(menu,"-"," ")
        
    %>
        <li><a href="/about/<%=menulink%>/"><%=menu %></a></li>
        <li><a href="/about/<%=page%>/"><%=thispage %></a></li>
    <% End If %>

    <% Response.Write(breadcrumb_lower) %>

<%
End If

If menu = "investor-relations"  Then

thispage = page
thispage = Replace(page,"_"," ")
thispage = Replace(thispage,"-"," ")
%>

    <% Response.Write(breadcrumb_top) %>
        <li><a href="/default.asp">home</a></li>
        <li><a href="/about/our-business/">About</a></li>
        <li><a href="/about/investor-relations/">investor relations</a></li>   
        <li><a href="/about/investor-relations/<%=page%>/"><%=thispage %></a></li>

    <% Response.Write(breadcrumb_lower) %>

<%
End If





If menu = "services" Then
%>


<% Response.Write(breadcrumb_top) %>
  <li><a href="/default.asp">home</a></li>
  <li><a href="#">Services</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If


If menu = "marketdata" or nsxcode <> "" or tradingcode <> "" Then
%>

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
%>


<%
If menu = "investing" or menu = "investors" Then
%>

<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/investing/">Investing</a></li>

<% If page = "investing" Then 
    
   Else
    investors_page = Replace(page,"_"," ")
    investors_page = Replace(page,"-"," ")
%>
    <li><a href="/investing/<%=page%>/"><%=investors_page%></a></li>
<% End If %>

<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "brokers_new" Then
%>

<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/brokers_new/why_nsx">For Brokers</a></li>
    <li><a href="/brokers_new/why_nsx">Become a Broker</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "brokers_existing" Then
%>


<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/brokers_new/why_nsx">For Brokers</a></li>
    <li><a href="/brokers_existing/broker_aids">Existing Brokers</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "advisers_new" Then
%>


<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/advisers_new/an_why_nsx">For Advisers</a></li>
    <li><a href="/advisers_new/an_why_nsx">Become an Adviser</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "advisers_existing" Then
%>


<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/advisers_new/an_why_nsx">For Advisers</a></li>
    <li><a href="/advisers_existing/ae_why_nsx">Existing Advisers</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "companies_listed" Then
%>


<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/companies_pre_listed/why-list-with-us">For Companies</a></li>
    <li><a href="/companies_listed/listing_rules_and_notes">Listed Companies</a></li>
<% Response.Write(breadcrumb_lower) %>

<%
End If
If menu = "listing" Then
%>


<% Response.Write(breadcrumb_top) 
    listing_page = Replace(page,"_"," ")
    listing_page = Replace(listing_page,"-"," ")
%>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/listing/listing/">Listing</a></li>
    <% If page="listing" Then %>

    <% Else %>
        <li><a href="/listing/<%=page%>/"><%=listing_page%></a></li>
    <% End If %>

<% Response.Write(breadcrumb_lower) %>

<%
End If

If menu = "regulation" Then
%>


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

If menu = "companies"  Then
%>

<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/regulation/">Regulation</a></li>
    <li><a href="/regulation/companies/rules-and-notes/">Companies</a></li>
<% If page <> "" Then 
    %>
    
    <li><a href="/regulation/companies/<%=page%>/"><%=CleanUpPageName(page)%></a></li>
<% End If %>
<% Response.Write(breadcrumb_lower) %>

<%
End If



If menu = "brokers"  Then
%>

<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/regulation/">Regulation</a></li>
    <li><a href="/regulation/brokers/rules-and-notes/">Brokers</a></li>
<% If page <> "" Then 
    %>
    
    <li><a href="/regulation/<%=menu%>/<%=page%>/"><%=CleanUpPageName(page)%></a></li>
<% End If %>
<% Response.Write(breadcrumb_lower) %>

<%
End If


If menu =  "exchange" Then
%>

<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/regulation/">Regulation</a></li>
    <li><a href="/regulation/exchange/trading-codes/">Exchange</a></li>
<% If page <> "" Then 
    %>
    
    <li><a href="/regulation/<%=menu%>/<%=page%>/"><%=CleanUpPageName(page)%></a></li>
<% End If %>
<% Response.Write(breadcrumb_lower) %>

<%
End If


If menu = "advisers"  Then
%>

<% Response.Write(breadcrumb_top) %>
    <li><a href="/default.asp">home</a></li>
    <li><a href="/regulation/">Regulation</a></li>
    <li><a href="/regulation/advisers/adviser-forms/">Advisers</a></li>
<% If page <> "" Then 
    %>
    
    <li><a href="/regulation/<%=menu%>/<%=page%>/"><%=CleanUpPageName(page)%></a></li>
<% End If %>
<% Response.Write(breadcrumb_lower) %>

<%
End If




%>
</div><!-- /row --> 
</div><!-- /container -->
</div><!-- /subnav cont -->