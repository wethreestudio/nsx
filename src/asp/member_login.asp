<%
If Session("PASSWORDACCESS") = "Yes" Then
	Response.Redirect "/default.asp"
	Response.End
End If

if Request.ServerVariables("HTTPS") = "off" And Application("SSL") = "1" then 
	srvname = Request.ServerVariables("SERVER_NAME") 
	scrname = Request.ServerVariables("SCRIPT_NAME") 
	response.redirect("https://" & srvname & scrname)
	Response.End	
end if 

%><!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="include/recaptcha.asp"-->
<%
Function DispErrs(errmsg)
errmsg = errmsg & " "
if len(trim(errmsg))>0 then 
%>
<div style="border:1px solid red; color:red; font-weight:bold; padding:15px;">
<%=errmsg%>
</div>
<%
end if
End Function

ErrorMessage = ""
If Not IsEmpty(Session("PASSWORDACCESSDESC")) Then
	ErrorMessage = Session("PASSWORDACCESSDESC")
End If

UserName = ""
If Not IsEmpty(Session("LAST_USERNAME")) Then
	UserName = Session("LAST_USERNAME")
End If

page_title = "Member Login"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">
	<h1>Member Sign-in</h1>
	<p>Enter your details below to sign into your NSX account.<br>
	<%disperrs(ErrorMessage)%>
	</p>
	<form method="POST" action="/member_check.asp">
		<input type="hidden" name="capform" value="1">
		<input type="hidden" name="STATUS" value="CHKLOGIN">
		<table class="form1">
			<tr>
				<td nowrap="nowrap"><b>NSX Username:</b></td>
				<td><input type="text" id="USERNAME" name="USERNAME" size="50" class="TextBox" value="<%= UserName %>"></td>
			</tr>
			<tr>
				<td nowrap="nowrap"><b>Password:</b></td>
				<td><input type="PASSWORD" name="PASSWORD" size="50" class="TextBox" value=""></td>
			</tr>			
			<tr>
				<td nowrap="nowrap"><b>Security Code:</b></td>
				<td><%=recaptcha_challenge_writer()%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" value="Sign-in" id="B1">&nbsp;<a href="/member_forgot.asp">Forgot your username or password?</a>
				</td>
			</tr>
		</table>
	</form>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
