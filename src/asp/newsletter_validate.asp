<%
Function InsertAp(str)
If str <> "" Then
      If Instr(str,"'")<>0 Then
         InsertAp = Replace(str,"'","''")
      Else
         InsertAp = str
      End If
   End If
End Function
%>
<%

DIM errorMSG
action=request.form("action")
Session("action")=action
Session("email")=Request.form("enews")
email=Request.form("enews")
' check if valid email
	IF instr(email,"@")= 0  or instr(email,".")= 0 THEN
		errorMSG = "Please supply a valid Email address e.g. you@fromsomewhere.com - you typed: " & email
		Session("errmsg")=errormsg
		response.redirect "newsletter.asp"
	END IF
' if OK then proceed
	
	Set ConnPasswords = Server.CreateObject("ADODB.Connection")
	Set CmdDD = Server.CreateObject("ADODB.Recordset")
	ConnPasswords.Open Application("nsx_WriterConnectionString")   
		SQL = "SELECT email,enewsletter,interest from userreg WHERE (email='" & email & "')"
		CmdDD.cachesize=100
		CmdDD.Open SQL, ConnPasswords,1,3
'response.write SQL
	select case action
		case "add"
			if CmdDD.EOF then
				' add a new one in
				CmdDD.AddNew
			end if
			' update an old one (including newly created)
			CmdDD("email")=email
			CmdDD("enewsletter")=1
			CmdDD("interest")=1
			CmdDD.Update
			

		case "remove"
				if CmdDD.EOF then
					' doesn't exist just exit
					Session("errmsg") = "Email address does not exist in database. Please check."
				else
					' update an existing one
					'CmdDD("enewsletter")=False
					'CmdDD.Update
					CmdDD.Delete
				end if
	
	end select


	CmdDD.close
	set CmdDD = nothing
	connPasswords.close
	set connPasswords=nothing
	
	if len(Session("errmsg"))>0 then response.redirect "newsletter.asp"


%>
		
		
