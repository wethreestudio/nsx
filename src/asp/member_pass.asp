<%
STATUS = "CHKLOGIN"

%>
<!--#INCLUDE FILE="member_check.asp"-->
<%
' <!--#INCLUDE FILE="member_check.asp"-->
' redirect to various types of users.
' check for the exchange source.
exchid=request("exchid")
returnurl=request("returnurl")

' Make sure if we're using SSL if it's available
if Application("SSL") = "1" and len(trim(returnurl)) > 0 then 
	returnurl = replace(LCase(trim(returnurl)), "http://", "https://", 1, 1)
end if

if len(exchid)=0 then
	session("exchdid")="NSX"
else
	session("exchid")=exchid
end if


'response.write Session("merchid") & vbcrlf

if Application("SSL") = "1" then 
	t = Right(returnurl, Len(returnurl) - Len(Application("nsx_SSLSiteRootURL")))
else
	t = Right(returnurl, Len(returnurl) - Len(Application("nsx_SiteRootURL")))
end if

If Instr(t, "?") > 0 Then
  t = Left(t, Instr(t, "?")-1)
End If

If Instr(t, "#") > 0 Then
  t = Left(t, Instr(t, "#")-1)
End If

'response.write t & vbcrlf
'response.end

If t="/" Or t="/default.asp" Or t="" Then
  select case Session("merchid")
  	case -1
  	' listed companies / company secretaries
  		response.redirect "company_default.asp"
  	case -2
  		' advisers change to adviser_default when ready
  		' current special case of companies
  		response.redirect "company_default.asp"
  	case -3
  	' brokers
  		response.redirect "broker_default.asp"
  	case -4
  	' facilitators
  		response.redirect "facilitator_default.asp"
  	case -5
  	' users (general public)
  		response.redirect "user_default.asp"
  	case -0
  	' staff access
		If Session("admin") = True Then
  			response.redirect "admin/adminmenu.asp"
		Else
			response.redirect "default.asp"
		End If
  	case else
  		response.redirect "default.asp"
  end select
Else
  select case Session("merchid")
  	case -1
  	' listed companies / company secretaries
  		response.redirect "company_default.asp"
  	case -2
  		' advisers change to adviser_default when ready
  		' current special case of companies
  		response.redirect "company_default.asp"
  	case -3
  	' brokers
  		response.redirect "broker_default.asp"
  	case -4
  	' facilitators
  		response.redirect "facilitator_default.asp"
  	case -5
  	' users (general public)
  		response.redirect "user_default.asp"
  	case else
  		response.redirect returnurl
  end select
  
End If

 

%>