<%
MerchID = Session("MerchID")
strLocation = "/"
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Logon Expired. Please logon on."
else
	Session.Abandon
    For Each strKey In Request.Cookies 
		Response.Cookies(strKey) = ""
    Next 	
	
	
end if
if len(merchid)=0 then
	strLocation = Application("nsx_SiteRootURL") & "/default.asp"
else

select case merchid
	case -1
	' listed companies / company secretaries
		strLocation = Application("nsx_SiteRootURL") & "/default.asp"
	case -2
		' advisers change to adviser_default when ready
		' current special case of companies
		strLocation = Application("nsx_SiteRootURL") & "/default.asp"
	case -3
	' brokers
		strLocation = Application("nsx_SiteRootURL") & "/default.asp"
	case -4
	' facilitators
		strLocation = Application("nsx_SiteRootURL") & "/default.asp"
	case -5
	' users (general public)
		strLocation = Application("nsx_SiteRootURL") & "/default.asp"
	case 0
	' staff access
		strLocation = Application("nsx_SiteRootURL") & "/admin/adminmenu.asp"
	case else
		strLocation = Application("nsx_SiteRootURL") & "/default.asp"
end select 

end if



%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <title>Sign Out</title>
  <script type="text/javascript">
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
    	var cookie = cookies[i];
    	var eqPos = cookie.indexOf("=");
    	var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
    	document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
    location.replace('<%=strLocation%>');
  </script>
  </head>
  <body>

  </body>
</html>