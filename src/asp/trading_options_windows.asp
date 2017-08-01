<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Trading Options - Trading Windows"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<!--#INCLUDE FILE="include/cms.asp"-->

 
<div class="container_cont">  
<%
Server.Execute "side_menu.asp"
%>

<div class="content_right2">
<%
  RenderContent "trading_options_windows","editarea" 
%>
</div>

<div style="width:100%;clear:both;height:1px;"></div>  
  
</div>
<!--#INCLUDE FILE="footer.asp"-->