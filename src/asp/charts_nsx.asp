<%@ LANGUAGE="VBSCRIPT" %>
<%

Response.Redirect "/summary/" & ucase(request("tradingcode"))
Resposne.End

%>