<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Companies Pre-listed"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<!--#INCLUDE FILE="include/cms.asp"-->

<%
Server.Execute "listing_kit.asp"
%>

<div class="container_cont">  


<div class="content_right2">
<%
  RenderContent "companies_pre_listed", "editarea" 
%>
</div>

<div style="width:100%;clear:both;height:1px;"></div>  
  
</div>
<!--#INCLUDE FILE="footer.asp"-->