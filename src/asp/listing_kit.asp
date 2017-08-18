<%
page = Request.QueryString("page")
menu = Request.QueryString("menu")
sent = Request.QueryString("sent")

If menu = "listing" And Session("ListingKitRequested") <> "YES" Then
%>
<div id="request-kit-holder">
    <button id="request-btn" class="btn btn-default request-kit" href="javascript:void(0);" onclick="_gaq.push(['_trackEvent', 'ListingKit', 'PopupClick', '<%=menu%>'])">Request Listing Kit</button>
    <div class="clear"></div>
</div>
<%
End If
%>