<% 
Function IsActiveLink (scriptName)
  IsActiveLink = " "
  If Trim(LCase(scriptName)) = Trim(LCase(Request.ServerVariables("SCRIPT_NAME"))) Then 
    IsActiveLink = " class=""active"" "
  End If
End Function
%>
<div id="side-bar-left">                                                    
  <ul id="side-bar-menu">
<%
portfolio_class = IsActiveLink("/user_portfolio_view.asp")
If Len(Trim(portfolio_class)) <= 0 Then 
  portfolio_class = IsActiveLink("/user_portfolio_edit.asp")
End If
%>
    <li><a<%=IsActiveLink("/user_default.asp") %>href="/user_default.asp">Member Home</a></li>
    <li><a<%=IsActiveLink("/user_edit_your_details.asp") %>href="/user_edit_your_details.asp">Edit Your Details</a></li>
    <li><a<%=IsActiveLink("/user_market_summaries.asp") %>href="/user_market_summaries.asp">Market Summary Alerts</a></li>
    <li><a<%=portfolio_class %>href="/user_portfolio_view.asp">Portfolio &amp; Alerts</a></li>
    <!-- li><a<%=IsActiveLink("/user_portfolio_edit.asp") %>href="/user_portfolio_edit.asp">Edit Portfolio</a></li -->
    <!-- li><a<%=IsActiveLink("/company_research_public.asp") %>href="/company_research_public.asp">Company Details</a></li -->
    <!-- li><a<%=IsActiveLink("/prices_alpha.asp") %>href="/prices_alpha.asp">Prices</a></li -->
    <!-- li><a<%=IsActiveLink("/announcements_list.asp") %>href="/announcements_list.asp">News</a></li -->
    <!-- li><a<%=IsActiveLink("/broker_list.asp") %>href="/broker_list.asp">Find a Broker</a></li -->
  </ul>
</div>
