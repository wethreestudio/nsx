<!--#INCLUDE FILE="include_all.asp"-->
<%

page_title = "Subscribe to NSX Newsletters"
'meta_description = "The National Stock Exchange of Australia - Operates a Stock Exchange in Australia focussing on small to medium and high technology companies. NSX is Australia's second official stock exchange."
'meta_keywords = "NSX, equties, company floats, IPO, investing, brokers, listed companines, stock exchange, Newcastle NSW"
' alow_robots = "no"
'objJsIncludes.Add "validate_js", "js/jquery.validate.js"
objJsIncludes.Add "newsletter_js", "/js/newsletter.js"
objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

Email = Request.Form("useremail")
Dim action
action = Request.Form("action")
If Len(action) < 1 Then
  If Request.Form("issubscribe") = "1" Then action = "subscribe"
  If Request.Form("isunsubscribe") = "1" Then action = "unsubscribe" 
End If
If Len(Email) < 1 Then
  Email = Request.Form("uuseremail")
End If


IPOs = "0"
Newsletter = "0"
i=1
subcount = request.form("subs").count
If subcount > 0 Then
  Do While i <= subcount
    subs = request.form("subs")(i)
    If subs = "ipos" Then IPOs = "1"
    If subs = "newsletter" Then Newsletter = "1"
    i = i + 1
  Loop
Else
  subcount = request.form("usubs").count
  If subcount > 0 Then
    Do While i <= subcount
      subs = request.form("usubs")(i)
      If subs = "ipos" Then IPOs = "1"
      If subs = "newsletter" Then Newsletter = "1"
      i = i + 1
    Loop
  End If
End If  



' Subscribe
If action = "subscribe" Then
  If isEmailValid(Email) And (IPOs = "1" Or Newsletter = "1") Then
    SQL = "SELECT regid FROM UserReg WHERE email='" & SafeSqlParameter(Email) & "'"
    
    UsreRegRows = GetRows(SQL)
    UsreRegRowsCount = 0
    If VarType(UsreRegRows) <> 0 Then 
      UsreRegRowsCount = UBound(UsreRegRows,2)+1
    End If   

    Set ConnPasswords = GetWriterConn()    
    If UsreRegRowsCount > 0 Then
      If Newsletter = "1" Then
        SQL = "UPDATE UserReg SET enewsletter=1 WHERE email='" & SafeSqlParameter(Email) & "'"
        ConnPasswords.Execute SQL
      End If
      If IPOs = "1" Then 
        SQL = "UPDATE UserReg SET iponewsletter=1 WHERE email='" & SafeSqlParameter(Email) & "'"
        ConnPasswords.Execute SQL 
      End If
    Else 
      SQL = "INSERT INTO UserReg (email, enewsletter, iponewsletter) VALUES ('" & SafeSqlParameter(Email) & "', " & SafeSqlParameter(Newsletter) & ", " & SafeSqlParameter(IPOs) & " )"
      ConnPasswords.Execute SQL 
    End If
    
    ' setCookie('subscribeOpp','closed',1365); 

    DBDisconnect()
    Response.Redirect("newsletter.asp?issubscribe=1") 
  End If
End If
  
' Unsubscribe
If action = "unsubscribe" Then
 '' Response.Write Email & "," & IPOs & "," & Newsletter
  If isEmailValid(Email) And (IPOs = "1" Or Newsletter = "1") Then
    SQL = "SELECT regid FROM UserReg WHERE email='" & SafeSqlParameter(Email) & "'"
    UsreRegRows = GetRows(SQL)
    UsreRegRowsCount = 0
    If VarType(UsreRegRows) <> 0 Then 
      UsreRegRowsCount = UBound(UsreRegRows,2)+1
    End If
    Set ConnPasswords = GetWriterConn()   
    If UsreRegRowsCount > 0 Then
      If Newsletter = "1" Then
        SQL = "UPDATE UserReg SET enewsletter=0 WHERE email='" & SafeSqlParameter(Email) & "'"
        ConnPasswords.Execute SQL
      End If
      If IPOs = "1" Then 
        SQL = "UPDATE UserReg SET iponewsletter=0 WHERE email='" & SafeSqlParameter(Email) & "'"
        ConnPasswords.Execute SQL 
      End If
    End If
    DBDisconnect()
    Response.Redirect("newsletter.asp?isunsubscribe=1#unsubscribe") 
  Else 
    DBDisconnect()
    Response.Redirect("newsletter.asp#unsubscribe")   
  End If
End If
%>
<!--#INCLUDE FILE="header.asp"-->


<div class="container_cont editarea">
<h1>Newsletter - NSX CALLS</h1>
<%
If Request.Querystring("issubscribe") = "1" Then
  Response.Cookies("subscribeOpp") = "closed" 
  Response.Cookies("subscribeOpp").Expires = Date() + 720
%>
  <div style="padding-top:15px;padding-bottom:15px;width:100%;">
    <div style="border:1px solid #6B9128;">
      <div style="padding:8px;padding-top:15px;padding-bottom:15px;">
      <p><img src="/img/tick.png" alt="OK">&nbsp;Your subscribe request has been processed successfully.</p>
      </div> 
    </div>
  </div>
<%
Else
%>    	
  <p>
  Complete the form below to signup to our IPO releases and monthly newsletters.
  </p>
  <div class="stylized myform" style="padding-top:20px;padding-bottom:20px;">
  <form id="newsletter_form" name="newsletter_form" action="newsletter.asp" method="post">
  <input type="hidden" id="issubscribe" name="issubscribe" value="1">
  <a name="newsletter_form_error"></a>
  <div id="newsletter_form_error">
  </div>
  <label for="useremail" class="stylized_label"><span class="required">*</span>Your Email
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
  <input class="stylized_input" type="text" name="useremail" id="useremail" alt="Your email address" maxlength="255" value="<%= Server.HTMLEncode(Email) %>" />
  </div>
  <span class="stylized_label"><span class="required">*</span>Subscribe to
  <span class="small">&nbsp;</span>
  </span>
  <div class="input_container">
  <input type="checkbox" name="subs" id="sipos" value="ipos" <%
If IPOs = "1" Then
  Response.Write "checked=""checked"""
End If 
  %>/><label for="sipos">Upcoming IPOs</label><br />
  <input type="checkbox" name="subs" id="snewsletter" value="newsletter" <%
If Newsletter = "1" Then
  Response.Write "checked=""checked"""
End If 
  %>/><label for="snewsletter">Newsletter</label>
  </div>
  <input class="stylized_button" type="submit" value="Subscribe">
  <div class="spacer"></div>
  </form>
  </div>
<%
End If
%>



<h2>About our Newsletter</h2>
<p><b>NSX</b> CALLS, eNewsletter, is FREE and contains a wealth of information concerning upcoming events, service updates or other topics of general interest.</p>
<p>You may remove yourself from the eNewsletter list by returning to this page, clicking unsubscribe and typing in the same e-mail address that you subscribed with.</p>
<p>Please feel free to read earlier editions of our eNewsletter - <a href="/about/nsx_news">NSX CALLS<br></a></p>


<h2>SPAM Mail Filter Settings</h2>
<p>If you filter out SPAM email you may not receive <b>NSX</b> Calls. This is because <b>NSX</b> Calls places your email address in the BCC field in order to preserve your privacy.</p>
<p>To receive email from us you will need to either:</p>
<ol>
	<li>Turn filtering <b>off</b>, or</li>
	<li>Explicitly allow email coming from announcement@nsxa.com.au in your filter settings.</li>
</ol>


<h2>Stay up to date by using RSS instead.</h2>
<p>NSX provides a lot of information via
<a href="whatis_rss.asp">RSS</a>. Whenever we make a change to that 
information the feed is updated. To find out more about RSS
<a href="whatis_rss.asp">click here</a>.</p>


<a name="unsubscribe">
<h2>Unsubscribe</h2>
<%
If Request.QueryString("isunsubscribe") = "1" Then
%>
  <div style="padding-top:15px;padding-bottom:15px;width:100%;">
    <div style="border:1px solid #6B9128;">
      <div style="padding:8px;padding-top:15px;padding-bottom:15px;">
        <p><img src="/img/tick.png" alt="OK">&nbsp;Your unsubscribe request has been processed successfully.</p>
      </div> 
    </div>
  </div>
<%
Else
%>
  <p>
  Complete the form below to unsubscribe from NSX newsletters or announcements.
  </p>

  <div class="stylized myform" style="padding-top:20px;padding-bottom:20px;">
    <form id="unnewsletter_form" name="unnewsletter_form" action="newsletter.asp" method="post">
    
    <input type="hidden" id="isunsubscribe" name="isunsubscribe" value="1">
    <a name="unnewsletter_form_error"></a>
    <div id="unnewsletter_form_error">
    </div>
    
    <label for="useremail" class="stylized_label"><span class="required">*</span>Your Email
    <span class="small">&nbsp;</span>
    </label>
    <div class="input_container">
    <input class="stylized_input" type="text" name="uuseremail" id="useremail" alt="Your email address" maxlength="255" value="" />
    </div>
    
    <span class="stylized_label"><span class="required">*</span>Unsubscribe from
    <span class="small">&nbsp;</span>
    </span>
    <div class="input_container">
    <input type="checkbox" name="usubs" id="unipos" value="ipos" /><label for="unipos">Upcoming IPOs</label><br />
    <input type="checkbox" name="usubs" id="unnewsletter" value="newsletter" /><label for="unnewsletter">Newsletter</label>
    </div>
  
    <input class="stylized_button" type="submit" value="Unsubscribe">
    <div class="spacer"></div>
    </form>
  </div>
<%
End If
%>



</div>
<!--#INCLUDE FILE="footer.asp"-->
