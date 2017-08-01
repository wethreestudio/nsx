<%
' set the exchange parameter required for sending messages
exchid = trim(request("exchid") & " ")
if len(exchid) = 0 then exchid = "SIMV"
%>
	
<!--#INCLUDE FILE="head.asp"--><html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Member Services Login</title>
<%select case exchid
	case "NSX"
	%>
	<link rel=stylesheet href="newsx2.css" type="text/css">
<% case "SIMV"%>
	<!--#file = "include/common/stylesheets.asp" -->
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% case else %>
	<link rel=stylesheet href="<%= Application("nsx_SiteRootURL") %>/newsx2.css" type="text/css">
<% end select%>
</head>

<body >
<div align="center" bgcolor=white>
<% if len(exchid)<>0 then server.execute "company_header_v2_" & exchid & ".asp"%>
<div bgcolor=white> <!-- input form -->
<table align=center bgcolor=white width=797>
<tr><td align=center><p>&nbsp;</p>
<table align=center bgcolor=white cellpadding="4" style="border:1px solid #666666; border-collapse: collapse; padding-left:4px; padding-right:4px; padding-top:1px; padding-bottom:1px" width="200px" id="table37" cellspacing="0">
	<tr>
		<td class="plaintext" bgcolor="#959CA0">
		<b><font color="#FFFFFF">Member Services</font></b></td>
		<td class="plaintext" bgcolor="#959CA0" align="right">
			&nbsp;</td>
	</tr>
	<tr>
		<td class="plaintext" colspan="2">
		<%
		if Session("PASSWORDACCESS") = "No" then
					response.write "<font color=red><b>"
					response.write Session("PASSWORDACCESSDESC") 
					response.write "</b></font>"
					Session("PASSWORDACCESSDESC")  = Null
		end if
		%>
		
<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="VBScript" Type="text/vbscript"><!--
function FrontPage_Form1_onsubmit()
  Set theForm = document.FrontPage_Form1

  If (theForm.username.value = "") Then
    MsgBox "Please enter a value for the ""Username"" field.", 0, "Validation Error"
    theForm.username.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If

  If (theForm.password.value = "") Then
    MsgBox "Please enter a value for the ""Password"" field.", 0, "Validation Error"
    theForm.password.focus()
    FrontPage_Form1_onsubmit = False
    Exit Function
  End If
  FrontPage_Form1_onsubmit = True 
End Function
--></script><!--webbot BOT="GeneratedScript" endspan --><form method="POST" name="FrontPage_Form1" action="<%= Application("nsx_SiteRootURL") %>/member_pass_v2.asp" style="margin-top: 0; margin-bottom: 0">

	Username<br>
	<!--webbot bot="Validation" s-display-name="Username" b-value-required="TRUE" --><input value="" type="text" name="username" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" class="plaintext" onFocus="if(this.value=='username')this.value='';" onBlur="if(this.value=='')this.value='username';"><br>
	Password:<br>
  	<!--webbot bot="Validation" s-display-name="Password" b-value-required="TRUE" --><input value="" type="password" name="password" size="20" style="border: 1px solid #000080; ; background-color:#EEEEEE" class="plaintext" onFocus="if(this.value=='password')this.value='';" onBlur="if(this.value=='')this.value='password';">
  	<br>
  	<input type="submit" value="Login" name="Submit"><br>
	<font size="1"><a href="member_forgot_v2.asp" >Forgot your password?</a></font>
	<input type="hidden" name="STATUS" value="CHKLOGIN">
	<input type="hidden" name="PASSWORDACCESSDESC" value="<%=session("PASSWORDAACCESSDESC")%>">
	<input type="hidden" name="EXCHID" value="<%=exchid%>">
	<input type="hidden" name="RETURNURL" value="<%
	' for SPSE this should just be login.asp or whatever handles invalid logins
	select case exchid
		case "SIMV"
				response.write "http://www.simvse.com.au/login.php"
		case "NSX"
				response.write "http://www.nsx.com.au/login.asp"
		case "SPSE"
				response.write "http://www.spse.com.fj/login.asp"
		case "POMX"
				response.write "http://www.pomsox.com.pg/login.asp"
		end select
		%>"></form>
		</td>
	</tr>
	</table>
<p>&nbsp;</p></td></tr></table>
<% if len(exchid)<>0 then server.execute "company_footer_v2_" & exchid & ".asp"%>
</div>
</div>
</body>

</html>
