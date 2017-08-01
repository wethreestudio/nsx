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
 
                        
<% Else %> 
                        
<div class="user_navLogin_top">
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
            <li class="nav_logout"><a href="/member_end1.asp">Logout</a></li>
        </ul>
    </div>
<div class="clearfix"></div>

<% End If %>