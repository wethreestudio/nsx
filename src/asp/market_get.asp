<%
' redirect to various types of data.
nsxcode = trim(ucase(request("nsxcode")) & " ")
marketdata = ucase(request("marketdata"))
if nsxcode = "" then 
	Session("errmsg") = "Please enter a valid code"
	response.redirect "default.asp"
end if 
select case marketdata
	case "PRICES"
		response.redirect "prices_alpha.asp?nsxcode=" & nsxcode
	case "DAILYPRICES"
		response.redirect "prices_daily.asp?tradingcode=" & nsxcode
	case "MONTHLYPRICES"
		response.redirect "prices_monthly.asp?tradingcode=" & nsxcode
	case "JUNEPRICES"
		response.redirect "prices_eom.asp?mth=6&tradingcode=" & nsxcode
	case "DECEMBERPRICES"
		response.redirect "prices_eom.asp?mth=12&tradingcode=" & nsxcode
	case "TRADES"
		response.redirect "prices_trades.asp?tradingcode=" & nsxcode
	case "CAPITAL"
		response.redirect "security_capital.asp?nsxcode=" & nsxcode
	case "DIVIDENDS"
		response.redirect "security_dividends.asp?nsxcode=" & nsxcode
	case "ANNOUNCEMENTS"
		response.redirect "/marketdata/search_by_company?nsxcode=" & nsxcode
	case "CHART"
		response.redirect "charts_nsx.asp?tradingcode=" & nsxcode
	case "AIRESEARCH"
		response.redirect "company_research_ai.asp?tradingcode=" & nsxcode
	case "COMPANYDETAILS"
		response.redirect "company_details.asp?nsxcode=" & nsxcode
	case "SECURITYDETAILS"
		response.redirect "security_details.asp?nsxcode=" & nsxcode
	case else
		response.redirect "/marketdata/search_by_company?nsxcode=" & nsxcode
end select 
%>