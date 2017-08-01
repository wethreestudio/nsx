<%
' check for the exchange source.
' use as an include file

exchid = trim(session("exchid") & " ")
if len(exchid)=0 then exchid = trim(request("exchid") & " ")
if len(exchid)=0 then exchid = "NSX"

select case exchid
	case "NSX"
		session("exchid")="NSX"
		exchshort="NSX"
		exchname="National Stock Exchange of Australia"
		exchlong = "NSXA"
	case "SIMV"
		exchname="SIM Venture Securities Exchange"
		exchshort="SIM"
		exchlong = "SIMVSE"
	case "SPSE"
		session("exchname")="South Pacific Stock Exchange"
		exchshort="SPS"
		exchlong = "SPSE"
	case "POMX"
		exchname="Port Moresby Stock Exchange"
		exchshort="POM"
		exchlong = "POMSoX"
	case else
		exchid="NSX"
		exchshort="NSX"
		exchname="National Stock Exchange of Australia"
		exchlong = "NSXA"
end select

' check that still loggged on
ID = session("subid") 

CHECKFOR = "CSX" 

MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	if len(session("returnurl"))=0 then 
		response.redirect "login.asp"
		else
		response.redirect session("returnurl")
	end if
end if
%>
