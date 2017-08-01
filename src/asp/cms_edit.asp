<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Edit Content"
alow_robots = "no"
'objJsIncludes.Add "ckeditor", "js/ckeditor.js"
'objJsIncludes.Add "ckeditorconfig", "js/ckeditorconfig.js"

%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<%
  RenderContent "test", "editarea" 
%>
<hr>
<%
  RenderContent "test2", "editarea" 
%>
</div>
<!--#INCLUDE FILE="footer.asp"-->