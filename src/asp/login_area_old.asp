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
                        
 <ul class="login-account-holder">
	<li class="nav1 snHover">
    	<a href="javascript:void(0)">Member Login</a><!--span></span-->
    	<div class="login_area" id="login_area">
        	<form id="loginform" name="loginform" action="<%= SiteRootURL %>/member_pass.asp" method="post" class="noAutoComplete">
            	<div class="conLogin">
                	<input name="username" id="username" type="text" class="logintxtbox noAutoComplete" value="" title="username*">
                  <input name="fakepassword" id="fakepassword" type="text" class="logintxtbox noAutoComplete" value="Password" title="password*">
                  <input name="password" id="password" type="password" class="logintxtbox noAutoComplete" style="display:none" value="" title="password*"> 
                  <!--input name="password" id="password" type="password" class="logintxtbox noAutoComplete" value="" title="password*" -->
                  <input name="STATUS" id="STATUS" type="hidden" value="CHKLOGIN">
                  <input name="returnurl" id="returnurl" type="hidden" value="">
                  <div class="login_area_bottom">
                  	<input style="display:none;" name="persist" id="persist" type="checkbox" value="yes" class="checkBox">
                     <span><label for="persist" style="display:none;">Keep me logged in</label> <a href="<%= Application("nsx_SSLSiteRootURL") %>/member_forgot.asp">Forgotten Password?</a></span>
                     <input name="login" type="submit" class="login" value="login">
                  </div>
                </div>
            </form>
        </div>
    </li>
    
    <li class="nav2 soHover">
    	<a href="javascript:void(0)">Create Account</a><!--span></span-->
    	<div class="acount_area">
        	<form id="registeruser" name="registeruser" action="<%= SiteRootURL %>/user_save_registration.asp" method="post" class="noAutoComplete">
            	<div class="account_create">
                	<input id = "rusername" name="username" type="text" class="logintxtbox noAutoComplete" value="" title="username*">
                	<input id = "rfname" name="fname" type="text" class="logintxtbox noAutoComplete" value="" title="first name*">
                	<input id = "rlname" name="lname" type="text" class="logintxtbox noAutoComplete" value="" title="last name*">
                  <input id = "remail" name="email" type="text" class="logintxtbox noAutoComplete" value="" title="e-mail*">
                  <input id = "rmobile" name="mobile" type="text" class="logintxtbox noAutoComplete" value="" title="mobile*">
                  <input name="fakepassword1" id="fakepassword1" type="text" class="logintxtbox noAutoComplete" value="Password" title="password*">
                  <input name="password" id="password1" type="password" class="logintxtbox noAutoComplete" style="display:none" value="" title="password*">
                  <input name="fakepassword2" id="fakepassword2" type="text" class="logintxtbox noAutoComplete" value="Password" title="confirm password*">
                  <input name="confirmpassword" id="password2" type="password" class="logintxtbox noAutoComplete" style="display:none" value="" title="confirm password*">                                          
                    <div class="error_info" style="display:none;">
                    	<h2>Passwords do not match</h2>
                        <div class="error_box">
                        	<h3>The SignUp attempt has failed!</h3>
                            Please, check the highlighted fields <br>and try again
                        </div>
                    </div>
                    <div class="acount_bottom" style="width:100%;">
                        <div class="clearfix"></div>
                        <input name="register_btn" type="submit" class="acount_btn" value="create">
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </form>
        </div>
    </li>
   
    <!-- li class="nav3 spHover">
	<a href="/kb">Knowledgebase</a><a href="javascript:void(0)"> Newsletter.</a>
    	<div class="news_area">
			<div class="news_link">
				<a href="/kb">Need more help: View the latest Knowledgebase articles</a>
			</div>
        <!--	<form name="newsletterform" id="newsletterform" action="<%= SiteRootURL %>/newsletter.asp" method="post" class="noAutoComplete">
            	<div class="newsletter_join">
                	<input name="useremail" id="useremail1" type="text" class="logintxtbox noAutoComplete" value="" title="e-mail*"><br />
                	<input type="radio" id="action_add" name="action" value="subscribe" checked="checked"> <label for="action_add">Subscribe</label>&nbsp;
                	<input type="radio" id="action_remove" name="action" value="unsubscribe"> <label for="action_remove">Unsubscribe</label>
                	<div>
                    <input type="checkbox" name="subs" id="ipos" value="ipos" checked="checked" style="vertical-align:middle"/>&nbsp;<label for="ipos">Upcoming IPOs</label><br />
                    <input type="checkbox" name="subs" id="newsletter" value="newsletter" checked="checked" style="vertical-align:middle"/>&nbsp;<label for="newsletter">Newsletter</label>
                	</div>
                  <div class="news_link">
                      <div class="clearfix" style="height:10px;"></div>
                      <input name="subscribe_btn" type="submit" class="input_subscribe" value="">
                      <div class="clearfix"></div>
                 	</div>
                </div>
            </form> >
        </div>	
    </li -->
	
</ul>
<div class="clearfix"></div>
                        
<% Else %> 
                        
<div class="user_navLogin">
    <ul>
        <li class="nav_first">
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
                                    	 <a href="/<%=user_url%>"><b>Account:</b>&nbsp;<%=Session("FULL_NAME")%></a>
                                         <span>&nbsp;</span>
                                    	<div class="msgNo" style="display:none;">2</div>
                                    </li>
                                    
                                    <li><a href="/<%=user_url%>"><%=user_url_text%></a></li>
                                    <li class="nav_logout"><a href="/member_end1.asp">LogOut</a></li>
                                </ul>
                            </div>
                            <div class="clearfix"></div>

<% End If %>