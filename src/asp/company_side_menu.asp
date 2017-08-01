<%

  
 'Response.Write Request.ServerVariables("SCRIPT_NAME")
 
Function IsActiveLink (scriptName)
  IsActiveLink = " "
  If Trim(LCase(scriptName)) = Trim(LCase(Request.ServerVariables("SCRIPT_NAME"))) Then 
    IsActiveLink = " class=""active"" "
  End If
End Function

comments=trim(session("comments") & " ")
if len(comments)=0 then comments=trim(session("nsxcode") & " ")
nsxcodes=replace(comments,";",",")

portfolio_class = IsActiveLink("/user_portfolio_view1.asp")
If Len(Trim(portfolio_class)) <= 0 Then 
  portfolio_class = IsActiveLink("/user_portfolio_edit1.asp")
End If

%>
<div id="side-bar-left">                                                    
  <ul id="side-bar-menu">
    <li><a<%=IsActiveLink("/company_default.asp") %>href="/company_default.asp">Company Home</a></li>
	<li><a<%=IsActiveLink("/partner_list.asp") %>href="/partner_list.asp">Partner Services</a></li>
    <li><a<%=IsActiveLink("/company_annupnsx3.asp") %>href="/company_annupnsx3.asp">Lodge Announcement</a></li>
    <li><a<%=IsActiveLink("/lodgement_status.asp") %>href="/lodgement_status.asp?nsxcode=<%=nsxcodes%>">Lodgement Status</a></li>
    <li><a<%=IsActiveLink("/company_trades.asp") %>href="/company_trades.asp?nsxcodes=<%=nsxcodes%>">Trades</a></li>
    <li><a<%=portfolio_class %>href="/user_portfolio_view1.asp">Portfolio &amp; Alerts</a></li>
    <li><a<%=IsActiveLink("/company_market_summaries.asp") %>href="/company_market_summaries.asp">Market Summary Alerts</a></li>
    <li><a<%=IsActiveLink("/company_edit_your_details1.asp") %>href="/company_edit_your_details1.asp">Edit Your Details</a></li>
    <li><a<%=IsActiveLink("/company_view_details.asp") %>href="/company_view_details.asp">View Co Details</a></li>
    <li><a<%=IsActiveLink("/company_edit_co_details.asp") %>href="/company_edit_co_details.asp">Edit Co Details</a></li>
    <li><a<%=IsActiveLink("/rules_listing.asp") %>href="/rules_listing.asp">Listing Rules</a></li>
    <li><a<%=IsActiveLink("/rules_practicenotes.asp") %>href="/rules_practicenotes.asp">Practice Notes</a></li>
    <li><a<%=IsActiveLink("/company_forms.asp") %>href="/company_forms.asp">Forms</a></li>
    <li><a<%=IsActiveLink("/company_help.asp") %>href="/company_help.asp">Help</a></li>
  </ul>
</div>
