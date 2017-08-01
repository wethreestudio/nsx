<%@ LANGUAGE="VBSCRIPT" %>
<% Response.Buffer = "True" %>
<% ID = Request("ID") %>

<% CHECKFOR = "USR" %>
<!--#INCLUDE FILE="member_check.asp"-->

<% 
username = Session("username")
Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
 
ConnPasswords.Open Application("nsx_WriterConnectionString")
SQL = "SELECT usubscribers.* FROM usubscribers WHERE (username = '" & username & "')"
CmdEditUser.Open SQL, ConnPasswords, 1, 3
%>
<!---------- USERS ------------------------------------------->
<% 

smseod = Request.Form("smseod")
if smseod ="" THEN
CmdEditUser.Fields("smseod") = False
Else
CmdEditUser.Fields("smseod") = True
END IF

emaileod = Request.Form("emaileod")
if emaileod="" THEN
CmdEditUser.Fields("emaileod") = False
Else
CmdEditUser.Fields("emaileod") = True
END IF

smsindices = Request.Form("smsindices")
if smsindices="" THEN
CmdEditUser.Fields("smsindices") = False
Else
CmdEditUser.Fields("smsindices") = True
END IF

emailindices= Request.Form("emailindices")
if emailindices="" THEN
CmdEditUser.Fields("emailindices") = False
Else
CmdEditUser.Fields("emailindices") = True
END IF


%>

<!----------------------------------------------------->
<%
CmdEditUser.Fields("RecordDateStamp") = Now()
CmdEditUser.Fields("RecordChangeUser") = Session("USERNAME")
%>
<!----------------------------------------------------->
<%
CmdEditUser.Update
CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing

If Len(Request.Form("returnurl")) > 0 Then 
  Response.Redirect Request.Form("returnurl")
  Response.End
Else
  Response.Redirect "user_market_summaries.asp"
  Response.End
End If
%>