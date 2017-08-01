<%@ LANGUAGE="VBSCRIPT" %>
<% Response.Buffer = "True" %>
<!--#INCLUDE FILE="company_check_exchid_v2.asp"-->
<!--#INCLUDE FILE="member_check_v2.asp"-->
<!--#INCLUDE FILE="include/sql_functions.asp"-->

<% 
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
  
ConnPasswords.Open Application("nsx_WriterConnectionString") 
SQL = "SELECT usubscribers.* FROM usubscribers WHERE (username = '" & session("username") & "')"
CmdEditUser.Open SQL, ConnPasswords, 1, 3

SALUTATION = Request.Form("salutation")
if SALUTATION="" THEN
CmdEditUser.Fields("salutation") = NULL
Else
CmdEditUser.Fields("salutation") = SALUTATION
END IF

FNAME = Request.Form("fname")
if FNAME="" THEN
CmdEditUser.Fields("fname") = NULL
Else
CmdEditUser.Fields("fname") = FNAME
END IF

 
LNAME = Request.Form("lname")
if LNAME="" THEN
CmdEditUser.Fields("lname") = NULL
Else
CmdEditUser.Fields("lname") = LNAME
END IF

ORG = Request.Form("organisation")
if ORG="" THEN
CmdEditUser.Fields("organisation") = NULL
Else
CmdEditUser.Fields("organisation") = ORG
END IF

 
POSITION = Request.Form("position")
if POSITION="" THEN
CmdEditUser.Fields("position") = NULL
Else
CmdEditUser.Fields("position") = POSITION
END IF

 
OCC = Request.Form("occupation")
if OCC="" THEN
CmdEditUser.Fields("occupation") = NULL
Else
CmdEditUser.Fields("occupation") = OCC
END IF

ADDRESS = Request.Form("address")
if ADDRESS="" THEN
CmdEditUser.Fields("address") = NULL
Else
CmdEditUser.Fields("address") = ADDRESS
END IF

 
SUBURB = Request.Form("suburb")
if FNAME="" THEN
CmdEditUser.Fields("suburb") = NULL
Else
CmdEditUser.Fields("suburb") = SUBURB
END IF


CITY = Request.Form("city")
if CITY="" THEN
CmdEditUser.Fields("city") = NULL
Else
CmdEditUser.Fields("city") = UCASE(CITY)
END IF

 
STATE = Request.Form("state")
if STATE="" THEN
CmdEditUser.Fields("state") = NULL
Else
CmdEditUser.Fields("state") = UCASE(STATE)
END IF

COUNTRY = Request.Form("country")
if COUNTRY="" THEN
CmdEditUser.Fields("country") = NULL
Else
CmdEditUser.Fields("country") = UCASE(COUNTRY)
session("country")=country
END IF

ZIP = Request.Form("zip")
if ZIP="" THEN
CmdEditUser.Fields("zip") = NULL
Else
CmdEditUser.Fields("zip") = ZIP
END IF

PHONE = Request.Form("phone")
if PHONE="" THEN
CmdEditUser.Fields("phone") = NULL
Else
CmdEditUser.Fields("phone") = PHONE
session("phone")=phone
END IF

 
FAX = Request.Form("fax")
if FAX="" THEN
CmdEditUser.Fields("fax") = NULL
Else
CmdEditUser.Fields("fax") = FAX
session("fax")=fax
END IF

MOBILE = Request.Form("mobile")
if MOBILE="" THEN
CmdEditUser.Fields("mobile") = NULL
Else
mobile=replace(mobile," ","")
mobile=replace(mobile,"+","")
mobile=replace(mobile,"-","")
mobile=replace(mobile,"@","")
mobile=replace(mobile,"%","")
mobile=replace(mobile,"_","")
CmdEditUser.Fields("mobile") = MOBILE
session("mobile")=mobile
END IF

 
EMAIL = Request.Form("email")
if EMAIL="" THEN
CmdEditUser.Fields("email") = NULL
Else
CmdEditUser.Fields("email") = EMAIL
session("email")=email
END IF

PASSWORD = Request.Form("password")
if PASSWORD="" THEN
CmdEditUser.Fields("PASSWORD") = NULL
Else
CmdEditUser.Fields("password") = PASSWORD
END IF

CmdEditUser.Fields("RecordDateStamp") = Now()
CmdEditUser.Fields("RecordChangeUser") = Session("USERNAME")

CmdEditUser.Update
CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing

' update the portfolio database to have mobile and email.  makes things easier this way.

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
  
ConnPasswords.Open Application("nsx_ReaderConnectionString") 
SQL = "UPDATE nsx_portfolio SET "
SQL = SQL & "email = '" & SafeSqlParameter(email) & "',"
SQL = SQL & "mobile = '" & SafeSqlParameter(mobile) & "'"
SQL = SQL & " WHERE username='" & SafeSqlParameter(session("username")) & "'"
ConnPasswords.Execute SQL
ConnPasswords.Close
Set ConnPasswords = Nothing

Response.Redirect "company_edit_your_details_v2.asp?id=" & id %>