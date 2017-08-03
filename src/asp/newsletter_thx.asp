<!--#INCLUDE FILE="include_all.asp"-->
<!-- #INCLUDE file="admin/merchtools.asp" -->
<!-- #INCLUDE file="newsletter_validate.asp" -->
<%
action=request.form("action")

page_title = "NSX - National Stock Exchange of Australia"
'meta_description = "The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies. NSX is Australia's second official stock exchange."
'meta_keywords = "NSX, equties, company floats, IPO, investing, brokers, listed companines, stock exchange, Newcastle NSW"
' alow_robots = "no"
objJsIncludes.Add "default_js", "/js/default.js"
objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"
%>
<!--#INCLUDE FILE="header.asp"-->
    	<div class="container_cont">
    	
<h1>NSX Newsletter</h1>    	
    	
    	
<div class="table-responsive"><table border="0" width="100%" cellspacing="0" cellpadding="0">

  <tr>
    <td width="100%" class="textheader" bgcolor="#FFFFFF" height="30">
	
		THANK
      YOU
	</td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    

	<p><%
if action="add" then %>

We greatly appreciate that you took the time to join our <i>eNewsletter - NSX Calls</i>.
  </p>Spam Mail Filter Settings</h2>

	<p>
If you filter out SPAM email you may not receive NSX Newsletters. This is because NSX places your email address in the BCC field
in order to preserve your privacy.
</p>
	<p>To receive email from us you will need to either:</p>
	<ol>
		<li>Turn filtering off</li>
		<li><b>or</b> explicitly allow email coming from announcements@nsxa.com.au in your filter settings.</font></li>
	</ol>
	<p align="left">
<%else%>
 We are sorry to see you go! We hope that you have enjoyed reading our <i>eNewsletter - NSX Calls</i>.
<%end if%>





</p>






<p align="left">&nbsp;&nbsp;&nbsp;</p>



    </td>
  </tr>
  <tr>
    <td width="600" class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    
<p>&nbsp;
    </td>
  </tr>
</table></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->