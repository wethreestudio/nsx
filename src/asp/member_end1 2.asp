<%

' The member_end.php script will clean up ALL cookies. 
' Some of the httponly cookies can't be removed by classic ASP
Sub Redirect1(url)
	response.redirect "default.asp"
End Sub

MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session.Contents.RemoveAll()
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Logon Expired. Please logon on."
else
	Session.Abandon
end if



if len(merchid)=0 then
	Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
else

select case merchid
	case -1
	' listed companies / company secretaries
		Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
	case -2
		' advisers change to adviser_default when ready
		' current special case of companies
		Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
	case -3
	' brokers
		Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
	case -4
	' facilitators
		Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
	case -5
	' users (general public)
		Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
	case 0
	' staff access
		Redirect1(Application("nsx_SiteRootURL") & "/admin/adminmenu.asp")
	case else
		Redirect1(Application("nsx_SiteRootURL") & "/default.asp")
end select 

end if



%>