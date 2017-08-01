<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="include/recaptcha.asp"-->
<%
Function DispErrs(errmsg)
errmsg = errmsg & " "
if len(trim(errmsg))>0 then 
%>
<style>

</style>

<div style="border:1px solid red; color:red; font-weight:bold; padding:15px;">
<%=errmsg%>
</div>
<%
end if
End Function

page_title = "User Options"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img">
    </div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Password Request</h1>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">

<div class="editarea">

<%
ErrorMessage = ""

If Len(Request.QueryString("success")) = 0 Then
	If request.servervariables("REQUEST_METHOD") = "POST" Then
		memberid = Request.Form("memberid")
		' validate form
		If len(memberid)=0 Then
			ErrorMessage = "Please enter your NSX username or the email address you registered with."
		Else
			' find userid and email address.
			Set ConnPasswords = Server.CreateObject("ADODB.Connection")
			Set CmdDD = Server.CreateObject("ADODB.Recordset")
			ConnPasswords.Open Application("nsx_ReaderConnectionString")   
			SQL = "SELECT TOP 5 * FROM subscribers WHERE username='" & SafeSqlParameter(memberid) & "' OR email='" & SafeSqlParameter(memberid) & "'"
			'response.write SQL
			CmdDD.Open SQL, ConnPasswords
			if CmdDD.EOF then 
				ErrorMessage = "Username or email address is not valid."
			Else
				email=trim(CmdDD("email"))
				hintq=trim(CmdDD("password"))
				uname=CmdDD("username")
				If len(trim(email))=0 Or isnull(email) Then 
					ErrorMessage = "No Email address supplied.  Please contact support@nsxa.com.au"
				Else
					If (server_response <> "" Or newCaptcha) And newCaptcha = False Then
						ErrorMessage = "Incorrect security code. Please try again."
					Else
						HR="<hr color=gray>" 
						BR = "<BR>"
						LT=""
						LT = LT & "<font face=arial size=1 color=black><b>Your NSX Password(s) are:</b>" & BR
						While Not CmdDD.EOF
							hintq=trim(CmdDD("password"))
							uname=CmdDD("username")
							LT = LT & HR
							LT = LT & "<b>Username:</b> " & uname &  BR 
							'LT = LT & "<br>"
							LT = LT & "<b>Password:</b> " & hintq &  BR
							LT = LT & HR
							CmdDD.MoveNext 
						Wend 
						LT = LT & "<br>Please come back and visit us soon! " & Application("nsx_SiteRootURL") & "<br></font>"
						Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
						MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
						MyJMail2.Sender= "support@nsxa.com.au"
						MyJMail2.ReplyTo= "support@nsxa.com.au"
						MyJMail2.AddRecipient email
						MyJMail2.AddRecipientBCC "scott.evans@nsxa.com.au"
						MyJMail2.AddRecipientBCC "paul.hulskamp@nsxa.com.au"
						MyJMail2.Subject="Your NSX Password:" 
						MyJMail2.Priority = 1 'High importance!
						MyJMail2.Body=LT
						MyJMail2.ContentType="text/html"
						MyJMail2.Execute
						set MyJMail2=nothing
						set LT = nothing
						CmdDD.Close
						Set CmdDD = Nothing
						ConnPasswords.Close
						Set ConnPasswords = Nothing
						Response.Redirect "member_forgot.asp?success=1"
					End If
				End If

			End If
			CmdDD.Close
			Set CmdDD = Nothing
			ConnPasswords.Close
			Set ConnPasswords = Nothing
		End If
	End If
	%>
	<h1>Forgot Password</h1>
	<p>Please complete the fields below to retrieve your password for you. The password will be sent to your nominated email address.<br>
	    <%disperrs(ErrorMessage)%>
	</p>
	<form method="POST" action="member_forgot.asp" class="form-horizontal form1 password-reminder">

        <div class="form-group">
            <label class="col-sm-2 control-label"><b>Username or email:</b></label>
            <div class="col-sm-6 col-md-10 col-lg-6 col-xs-12">
                <input type="text" name="memberid" size="" class="form-control TextBox standard-input" value="<%=Server.HTMLEncode(Request("memberid"))%>">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label"><b>Security Code:</b></label>
            <div class="col-sm-6 col-md-10 col-lg-6 col-xs-12">
                <%=recaptcha_challenge_writer()%>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <input type="submit" value="Email It" name="B1" class="btn nsx-blue request-kit popup left">
            </div>
        </div>

	</form>
	<%
Else
%>
<h1>Password Sent</h1>
<p>Your NSX password has been sent to your nominated email address.</p>
<%
End If
%>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->