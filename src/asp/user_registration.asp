<!--#INCLUDE FILE="include_all.asp"-->

<%
page_title = "User Registration"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="hero-banner subpage">
		<div class="hero-banner-img"></div>
		<div class="container hero-banner-cont">
				<div class="container hero-banner-content-holder subpage">
						<div class="col-sm-12 hero-banner-left comp-info">
								<h1>Registration</h1>
						</div>
				</div>
		</div>
</div>

<div class="container subpage">
		<div class="row">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
						<div class="subpage-center">
	<div class="editarea">
	<h1>myNSX Registration</h1>
	
	<% If Len(Session("PASSWORDACCESSDESC")) > 0 Then %>
	<div style="border:1px solid #ff0000;padding:8px; color:#ff0000; font-weight:bold; margin:8px;">
	<%= Session("PASSWORDACCESSDESC") %>
	</div>
	<% End If %>
	
	<p>
		This is a free service.&nbsp; Registration is 
		required to access email and sms alert services.&nbsp; Please read the 
		disclaimer below.
	</p>

			<form method="POST" action="<%= Application("nsx_SiteRootURL") %>/user_save_registration.asp" name="FrontPage_Form1">
				<div class="form-group">
					<label for="exampleInputEmail1">Username</label>
					<input type="text" name="username" maxlength="100" value="<%=Server.HTMLEncode(session("username"))%>" class="form-control">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">First Name</label>
					<input type="text" name="fname" value="<%=Server.HTMLEncode(session("fname"))%>" class="form-control">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Last Name</label>
					<input type="text" name="lname" value="<%=Server.HTMLEncode(session("lname"))%>" class="form-control">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Email</label>
					<input type="text" name="email" maxlength="255" value="<%=Server.HTMLEncode(session("email"))%>" class="form-control">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Mobile Phone</label>
					<input type="text" name="mobile" maxlength="20" value="<%=Server.HTMLEncode(session("mobile"))%>" aria-describedby="phone" class="form-control">
		  			<span id="phone" class="help-block"><small>For the SMS services only Australian and New Zealand mobile phones are supported 
					at this time. Please <a href="/about/contact_us">contact us</a> and 
					register your interest in receiving alerts to an overseas mobile 
					phone.</small></span>
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Password</label>
					<input type="password" name="password" value="<%=Server.HTMLEncode(session("password"))%>" class="form-control">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Confirm Password</label>
					<input type="password" name="confirmpassword" value="<%=Server.HTMLEncode(session("confirmpassword"))%>" class="form-control">
				</div>
				<p align="left">All details are required to complete your registration.</p>
				<button type="submit" class="btn btn-primary btn-lg request-kit popup">Register</button>
			</form>
			<p><br /><small><strong>Disclaimer and rights</strong><br />NSX accepts no responsibility if many messages are generated on your 
			phone or email services. This service is made available as a 
			curtsey only. NSX reserves the right to remove the service at any 
			time or to suspend or disable the alerts service. If you no longer 
			require this service please log on and delete your portfolio or your SMS/Email 
			selections. To avoid spam, NSX reserves the right to disable SMS 
			or email alerts on a user account if NSX believes this account has 
			incorrect details. NSX reserves the right to suspend or delete a 
			user account at any time. NSX reserves the right to charge for 
			services in the future. If NSX charges for services in the future, 
			users will be able to sign up for subscription based content. 
			Services that become chargeable will be removed from the free section of 
			the site.</small></p>

</div>
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->