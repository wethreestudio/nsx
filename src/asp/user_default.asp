<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "USR" %>
<!--#INCLUDE FILE="member_check.asp"-->
<%
page_title = "myNSX User Services"
alow_robots = "no"
%>

<!--#INCLUDE FILE="header.asp"-->

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "user_side_menu.asp"
%>


<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">

  <div class="editarea">
    <h1>myNSX User Services</h1>
    <p>Welcome <%=Session("fname")%> to the myNSX User Services Page.</p>
    <p>The services area allows you to:</p> 
    <ul>
      <li><a href="/user_portfolio_edit.asp?portfolioname=default">manage</a> a portfolio of up to 20 securities;</li>
      <li>enter holding and purchase price details to track the value of your portfolio;</li>
      <li><a href="/company_research_public.asp">research</a> more information about NSX listed companies;</td></li>
      <li>get SMS or Email alerts for trades in securities in your portfolio;</li>
      <li>get SMS or Email alerts for news on securities in your portfolio</li>
      <li>get SMS or Email end of day market alerts;</li>
      <li>get SMS or Email end of day Index alerts.</li>
      <li>change your contact details and password;</li>
      <li>logout from your session.</li>
    </ul>
    <p>In order to use the SMS or Email services you must have a valid mobile number and email address.</p>
    <p>To start please create a <a href="/user_portfolio_edit.asp?portfolioname=default">watchlist portfolio</a> or go to your <a href="/user_portfolio_view.asp">existing portfolio</a>.</p>
  </div>

</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>


<!--#INCLUDE FILE="footer.asp"-->

