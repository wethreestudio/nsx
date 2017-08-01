<%
MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("PASSWORDACCESS") = "No" 
	Session("PASSWORDACCESSDESC") = "Logon Expired. Please logon on."
else
	Session.Abandon
end if
returnurl = session("returnurl")
if len(returnurl) = 0 then
	returnurl = request("returnurl")
end if
if len(returnurl) = 0 then
	returnurl = request("returnurl")
end if
if len(merchid)=0 then
	if len(returnurl)> 0 then 
		response.redirect returnurl
		else
		response.redirect "login.asp"
	end if
else

select case merchid
	case -1
	' listed companies / company secretaries
		if len(returnurl)> 0 then response.redirect returnurl
	case -2
		' advisers change to adviser_default when ready
		' current special case of companies
		if len(returnurl)> 0 then response.redirect returnurl
	case -3
	' brokers
		if len(returnurl)> 0 then response.redirect returnurl
	case -4
	' facilitators
		if len(returnurl)> 0 then response.redirect returnurl
	case -5
	' users (general public)
		if len(returnurl)> 0 then response.redirect returnurl
	case 0
	' staff access
		response.redirect "admin/adminmenu.asp"
	case else
		response.redirect "login.asp"
end select 

end if
response.redirect "login.asp"
		


%>