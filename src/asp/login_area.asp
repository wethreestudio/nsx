<% 
If Application("SSL") = "1" Then 
	'SiteRootURL = Application("nsx_SSLSiteRootURL")
	SiteRootUrl = "https://" & Request.ServerVariables("SERVER_NAME")
	ssl = "https://"
Else
	'SiteRootURL = Application("nsx_SiteRootURL")
	SiteRootUrl = "http://" & Request.ServerVariables("SERVER_NAME")
	ssl = "http://"
End If

If LCase(Session("PASSWORDACCESS")) <> "yes" Then %>                         
												
<div class="row login-dropdown">
	<div class="login-form col-xs-12 col-sm-6 col-md-4 col-md-offset-8" id="login_area">
		<h4>Member Login</h4>
		<form id="loginform" name="loginform" action="<%= SiteRootURL %>/member_pass.asp" method="post" class="noAutoComplete" autocomplete="off" _lpchecked="1">
			<input name="STATUS" id="STATUS" type="hidden" value="CHKLOGIN">
			<input name="returnurl" id="returnurl" type="hidden" value="">
			<div class="form-group">
				<input name="username" id="username" type="text" class="form-control" value="" placeholder="User name" autocomplete="off">
			</div>
			<div class="form-group">
				<input name="fakepassword" id="fakepassword" type="text" class="form-control" placeholder="Password" autocomplete="off">
				<input name="password" id="password" type="password" class="form-control" placeholder="Password" style="display:none">
			</div>
			<div class="login_area_bottom">
				<div class="checkbox">
					<label for="persist" style="display:none;">
						<input name="persist" id="persist" type="checkbox" value="yes" class="checkBox"> Keep me logged in
					</label>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
				<p>
					<a href="<%= Application("nsx_SSLSiteRootURL") %>/member_forgot.asp">Forgot Password?</a><br />
					Don't have an account? <a href="user_save_registration.asp">Register</a>
				</p>
			</div>
		</form>
	</div>
</div>
									
<% Else %> 
												
<ul class="sub-nav sub-nav-right">
	<li>
<%
	' Link account of logged in user to the correct page
	Dim user_url
	Dim user_url_text
	select case Session("merchid")
		case -1
		' listed companies / company secretaries
			user_url = "company_default.asp"
			user_url_text = "Admin"
		case -2
			' advisers change to adviser_default when ready
			' current special case of companies
			user_url = "company_default.asp"
			user_url_text = "Admin"
		case -3
		' brokers
			user_url = "broker_default.asp"
			user_url_text = "Admin"
		case -4
		' facilitators
			user_url = "facilitator_default.asp"
			user_url_text = "Admin"
		case -5
		' users (general public)
			user_url = "user_default.asp"
			user_url_text = "myNSX"
		case 0
		' staff access
			user_url = "admin/adminmenu.asp"
			user_url_text = "Staff"
		case else
			user_url = "default.asp"
			user_url_text = "Home"
	end select
%>
		<a href="/<%=user_url%>">User:&nbsp;<strong><%=Session("FULL_NAME")%></strong><span class="msgNo" style="display: none;">2</span></a>
	</li>
	<li>
		<a href="/<%=user_url%>"><%=user_url_text%></a>
	</li>
	<li>
		<a href="/member_end1.asp">Logout</a>
	</li>
</ul>

<% End If %>