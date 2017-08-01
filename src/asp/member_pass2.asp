<!--#INCLUDE FILE="member_check.asp"-->
<%
' redirect to various types of users.
' check for the exchange source.
exchid=request("exchid")
if len(exchid)=0 then
	session("exchdid")="NSX"
	else
	session("exchid")=exchid
end if
select case Session("merchid")
	case -1
	' listed companies / company secretaries
		'response.redirect "company_default.asp"
%>
	<script>
	window.open('company_default.asp','_blank','resizeable=yes,menubar=1,toolbar=yes,location=no,directories=no,status=no,copyhistory=no') 
	</script>
<%		
		
	case -2
		' advisers change to adviser_default when ready
		' current special case of companies
		'response.redirect "company_default.asp"
		%>
	<script>
	window.open('company_default.asp','_blank','resizeable=yes,menubar=1,toolbar=no,location=no,directories=no,status=no,copyhistory=no') 
	</script>
<%	
	case -3
	' brokers
		response.redirect "broker_default.asp"
	case -4
	' facilitators
		response.redirect "facilitator_default.asp"
	case -5
	' users (general public)
		response.redirect "user_default.asp"
	case 0
	' staff access
		response.redirect "admin/adminmenu.asp"
	case else
		response.redirect "default.asp"
end select 
%>