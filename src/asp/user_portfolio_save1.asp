<%@ LANGUAGE="VBSCRIPT" %>

<% Response.Buffer = "True" %>
<% ID = session("subid") 

MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if


%>

<% CHECKFOR = "CSX" %>
<!--#INCLUDE FILE="member_check.asp"-->
<!--#INCLUDE FILE="include/sql_functions.asp"-->
<% 




portfolioname=trim(request("portfolioname") & " ")
if len(portfolioname="") then portfolioname="default"
username = session("username")


Set ConnPasswords = Server.CreateObject("ADODB.Connection")
  
ConnPasswords.Open Application("nsx_WriterConnectionString") 

' delete existing records to start afresh

Response.Write username & "<br>"
Response.Write portfolioname & "<br>"

Response.End

SQL = "DELETE FROM nsx_portfolio WHERE (username='" & SafeSqlParameter(username) & "') AND (portfolioname='" & SafeSqlParameter(portfolioname) & "' OR portfolioname IS NULL)"


ConnPasswords.Execute SQL


' add new records

' for each variableName in Request.Form : response.write(variableName & ": " & Request.Form(variableName) & "<br/>") : next : response.end


For ii = 0 To 19
  tradingcode = ucase(trim(request.form("tradingcode" & ii) & " "))
  if len(tradingcode)<>0 then 
  	tradingcode = replace(tradingcode,",","")
  	tradingcode = replace(tradingcode," ","")
  	tradingcode = replace(tradingcode,"-","")
  	tradingcode = replace(tradingcode,"+","")
  	tradingcode = replace(tradingcode,"_","")
  	tradingcode = replace(tradingcode,"%","")
  	tradingcode = replace(tradingcode,"@","")
  end if
  
  pholding = trim(request.form("pholding" & ii) & " ")
  if len(pholding )<>0 then 
  	pholding = replace(pholding ,",","")
  	pholding = replace(pholding ," ","")
  end if
  if isnumeric(pholding) then
  	pholding = pholding
  	else
  	pholding = 0
  end if
  
  pprice = trim(request.form("pprice" & ii) & " ")
  if len(pprice )<>0 then 
  	pprice = replace(pprice ,",","")
  	pprice = replace(pprice ," ","")
  end if
  if isnumeric(pprice) then
  	pprice= ccur(pprice)
  	else
  	pprice= 0
  end if
  
  smstrade= trim(request.form("smstrade" & ii) & " ")
  if smstrade= "true" then 
  	smstrade= "1"
  	else
  	smstrade= "0"
  end if
  
  emailtrade= trim(request.form("emailtrade" & ii) & " ")
  if emailtrade= "true" then 
  	emailtrade= "1"
  	else
  	emailtrade= "0"
  end if
  
  smsnews = trim(request.form("smsnews" & ii) & " ")
  if smsnews = "true" then 
  	smsnews = "1"
  	else
  	smsnews = "0"
  end if
  
  emailnews = trim(request.form("emailnews" & ii) & " ")
  if emailnews = "true" then 
  	emailnews = "1"
  	else
  	emailnews = "0"
  end if
  
  smspricechange = trim(request.form("smspricechange" & ii) & " ")
  if smspricechange = "true" then 
  	smspricechange = "1"
  	else
  	smspricechange = "0"
  end if
  
  
  emailpricechange = trim(request.form("emailpricechange" & ii) & " ")
  if emailpricechange= "true" then 
  	emailpricechange= "1"
  	else
  	emailpricechange= "0"
  end if
  
  
  ' only put in records with a tradingcode.
  If len(tradingcode)<>0 Then
    SQL = "INSERT INTO nsx_portfolio "
    SQL = SQL & "(username,tradingcode,pholding,pprice,smstrade,emailtrade,smsnews,emailnews,recorddatestamp,recordchangeuser,mobile,email,smspricechange,emailpricechange) VALUES ("
    SQL = SQL & "'" & SafeSqlParameter(username) & "',"
    SQL = SQL & "'" & SafeSqlParameter(tradingcode) & "',"
    SQL = SQL & SafeSqlParameter(pholding) & ","
    SQL = SQL & SafeSqlParameter(pprice) & ","
    SQL = SQL & SafeSqlParameter(smstrade) & ","
    SQL = SQL & SafeSqlParameter(emailtrade) & ","
    SQL = SQL & SafeSqlParameter(smsnews) & ","
    SQL = SQL & SafeSqlParameter(emailnews) & ","
    SQL = SQL & "'" & SafeSqlDate(Now()) & "',"
    SQL = SQL & "'" & SafeSqlParameter(username) & "',"
    SQL = SQL & "'" & SafeSqlParameter(session("mobile")) & "',"
    SQL = SQL & "'" & SafeSqlParameter(session("email")) & "',"
    SQL = SQL & SafeSqlParameter(smspricechange) & ","
    SQL = SQL & SafeSqlParameter(emailpricechange) & ""
    SQL = SQL & ")"
    'response.write SQL
    'response.end
    ConnPasswords.Execute SQL
  End If

Next


ConnPasswords.Close
Set ConnPasswords = Nothing


Response.Redirect "user_portfolio_view1.asp?portfolioname=" & portfolioname %>