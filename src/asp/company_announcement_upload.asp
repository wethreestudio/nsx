<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "UPL"%>
<!--#INCLUDE FILE="member_check.asp"-->
<%
Dim objUpload
Dim tradingcode
Dim category
Dim person
Dim title
Dim description
Dim annPriceSensitive
Dim ispricesensitive
Dim annCopy
Dim docopy
Dim phone
Dim email
Dim tm
Dim newday
Dim newsdir
Dim newsdir2
Dim newsdir3
Dim uplpath
Dim oldext
Dim filesize
Dim nsxcode
Dim coname
Dim acn
Dim display
Dim username
Dim anncopycodes
Dim returnurl
Dim errors

On Error Resume Next

errors = ""

Set objUpload = New clsUpload


Set tradingcode = objUpload("tc")
Set category = objUpload("category")
Set person = objUpload("person")
Set anntitle = objUpload("title")
Set description = objUpload("description")
Set annPriceSensitive = objUpload("annPriceSensitive")
Set annCopy = objUpload("annCopy")
Set phone = objUpload("phone")
Set email = objUpload("email")
Set username = objUpload("username")
filesize = objUpload("f1").Length

Set coname = objUpload("coname")
Set acn = objUpload("acn")
Set display = objUpload("display")
Set username = objUpload("username")
'Set nsxcode = objUpload("nsxcode")
Set anncopycodes = objUpload("anncopycodes")
Set returnurl = objUpload("returnurl")

tm = Now()+daylightsaving
dy = day(tm)
if dy < 10 then dy = "0" & dy
my = month(tm)
if my < 10 then my = "0" & my
hr = hour(tm)
if hr < 10 then hr = "0" & hr
mn = minute(tm)
if mn < 10 then mn = "0" & mn
sc = second(tm)
if sc < 10 then sc = "0" & sc

newday=Dy&My&year(tm)&hr&mn&sc
newsdir = "ftp\news"
newsdir2 = "ftp/news/"
newsdir3 = "ftp/news/"
uplpath = Server.MapPath(newsdir) & "\" 

oldext = ".pdf"

newfile = tradingcode.Value & newday & oldext



ispricesensitive = "0"
If Ucase(annPriceSensitive.Value) = "YES" Then ispricesensitive = "1"

docopy = "0"
If UCase(anncopy.Value) = "YES" Then docopy = "1"



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 1. Save File
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
objUpload("f1").SaveAs uplpath & newfile

'Dim fs,f
'Dim file_size
'Set fs=Server.CreateObject("Scripting.FileSystemObject")
'Set f=fs.GetFile(uplpath & newfile)
'file_size = f.Size
'set f=nothing
'set fs=nothing

'If file_size > 10485760 Then
'	Response.Write "File size exceeds 10MB. Please reduce your file size."
'	Response.End
'End If

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Get NSX Code from tradingcode
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set conn = GetWriterConn()
nsxcode = ""
sql = "SELECT nsxcode FROM coIssues WHERE tradingcode='" & Replace(tradingcode.Value, "'","''") & "'"
Set rs = conn.Execute(sql)
If Not rs.EOF Then
	nsxcode = rs("nsxcode")
End If

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Validate Data
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
If Trim(nsxcode) = "" Then
	errors = "Company code cannot be empty;" & errors
End If 
If Len(Trim(category.Value)) < 1 Then
	errors = "Category cannot be empty;" & errors
End If
If Len(Trim(anntitle.Value)) < 1 Then
	errors = "Title cannot be empty;" & errors
End If
If Len(Trim(description.Value)) < 1 Then
	errors = "Description cannot be empty;" & errors
End If
If Len(Trim(ispricesensitive)) < 1 Then
	errors = "Price sensitive cannot be empty;" & errors
End If
If Len(Trim(docopy)) < 1 Then
	errors = "Copy to underlying cannot be empty;" & errors
End If
If Len(Trim(person.Value)) < 1 Then
	errors = "Contact person cannot be empty;" & errors
End If
If Len(Trim(phone.Value)) < 1 Then
	errors = "Contact phone number cannot be empty;" & errors
End If
If Len(Trim(email.Value)) < 1 Then
	errors = "Contact phone number cannot be empty;" & errors
End If
If filesize < 1 Then
	errors = "Announcement file cannot be empty;" & errors
End If
If filesize >= 10485760 Then
	errors = "File size exceeds 10MB;" & errors
End If


If Len(errors) = 0 Then
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 3. Insert Database Record
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
sql = "INSERT INTO coAnn (nsxcode,annTitle,annPrecise,annSubmitter,annPhone,annEmail,annFile,annUsername,annFileSize,tradingcode,annPriceSensitive,annupload,anncopy,anncopycodes)"
sql = sql & " VALUES (" 
sql = sql & "'" & Replace(nsxcode, "'","''") & "',"
sql = sql & "'" & Replace(category.Value & " - " & anntitle.Value, "'","''") & "',"
sql = sql & "'" & Replace(description.Value, "'","''") & "',"
sql = sql & "'" & Replace(person.Value, "'","''") & "',"
sql = sql & "'" & Replace(phone.Value, "'","''") & "',"
sql = sql & "'" & Replace(Trim(LCase(email.Value)), "'","''") & "',"
sql = sql & "'" & Replace(newfile, "'","''") & "',"
sql = sql & "'" & Replace(username.Value, "'","''") & "',"
sql = sql & Replace(filesize, "'","''") & ","
sql = sql & "'" & Replace(tradingcode.Value, "'","''") & "',"
sql = sql & Replace(ispricesensitive, "'","''") & ","
sql = sql & "GETDATE(),"
sql = sql & Replace(docopy, "'","''") & ","
sql = sql & "'" & Replace(anncopycodes.Value, "'","''") & "'"
sql = sql & ")"

'Response.Write sql : Response.End


conn.Execute sql 
DBDisconnect()

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 4. Send Email
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If UserIPAddress = "" Then UserIPAddress = Request.ServerVariables("REMOTE_ADDR")

crr = vbCRLF
ps = "Yes"
If ispricesensitive <> "1" Then ps = "No"
msg = "This is an RNS announcement receipt notification" & crr & crr
msg = msg & "NSXCODE: " & tradingcode.Value & crr
msg = msg & "Title: " & category.Value & " - " & anntitle.Value & crr & crr
msg = msg & "Price Sensitive? " & ps & crr
msg = msg & "Copy to Underlying: " & anncopy.Value & crr
msg = msg & "Description: " & description.Value & crr
msg = msg & "Submitter: " & person.Value & crr
msg = msg & "Phone: " & phone.Value & crr
msg = msg & "Email: mailto:" & Trim(LCase(email.Value)) & crr
msg = msg & "FileName: http://www.nsx.com.au/" & newsdir3 &  newfile & crr
msg = msg & "FileSize: " & filesize & " bytes" & crr
msg = msg & "Date/Time: " & Now & crr
msg = msg & "IP: " & UserIPAddress & crr
msg = msg & "Username: " & Session("username") & crr
msg = msg & "Path Info: " & Request.ServerVariables("PATH_INFO") & crr

Set cdoConfig = CreateObject("CDO.Configuration") 
With cdoConfig.Fields 
  .Item(cdoSendUsingMethod) = cdoSendUsingPort
  .Item(cdoSMTPServer) = Application("SMTP_Server")
  .Item(cdoSMTPServerPort) = CInt(Application("SMTP_Port"))
  .Item(cdoSMTPConnectionTimeout) = 10
  .Item(cdoSMTPAuthenticate) = cdoBasic   
  .update 
End With 
Set cdoMessage = CreateObject("CDO.Message") 
With cdoMessage 
  Set .Configuration = cdoConfig 
  .From = "rns@nsxa.com.au"
  .ReplyTo = "mail@nsx.com.au"
  .To = "trading@nsx.com.au; " & email.Value
  .Subject = tradingcode.Value & " announcement has arrived"
  .TextBody = msg
  .Send 
End With 
Set cdoMessage = Nothing 
Set cdoConfig = Nothing
End If

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 5. Redirect
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
If Len(returnurl.Value) > 0 Then
  If Len(errors) = 0 Then
    Response.Status = "301 Moved Permanently"
    Response.AddHeader "Location", returnurl.Value & "?success=1"    
  Else
    Response.Status = "301 Moved Permanently"
    Response.AddHeader "Location", returnurl.Value & "?errors=" & errors
  End If
  Response.End()
Else
  Response.Write "Announcement has been uploaded successfully." 
End If


If Err.Number <> 0 Then
   On Error Goto 0 
   RecordWebError "company_announcement_upload.asp", Err
   errors "A system error has occured. NSX Staff have been notified with full details of the error." 
End If
On Error Goto 0 ' Reset error handling.


Response.Write "nsxcode=" & nsxcode.Value & "<br>"
Response.Write "tradingcode=" & tradingcode.Value & "<br>"
Response.Write "category=" & category.Value & "<br>"
Response.Write "person=" & person.Value & "<br>"
Response.Write "anntitle=" & anntitle.Value & "<br>"
Response.Write "description=" & description.Value & "<br>"
Response.Write "annPriceSensitive=" & annPriceSensitive.Value & "<br>"
Response.Write "annCopy=" & annCopy.Value & "<br>"
Response.Write "phone=" & phone.Value & "<br>"
Response.Write "email=" & email.Value & "<br>"
Response.Write "newsdir=" & newsdir & "<br>"
Response.Write "newsdir2=" & newsdir2 & "<br>"
Response.Write "newsdir3=" & newsdir3 & "<br>"
Response.Write "tm=" & tm & "<br>"
Response.Write "uplpath=" & uplpath & "<br>"
Response.Write "newfile=" & newfile & "<br>"
Response.Write "oldext=" & oldext & "<br>"
Response.Write "newday=" & newday & "<br>"
Response.Write "SaveAs=" & newsdir2 & newfile & "<br>"
Response.Write "filesize=" & filesize & "<br>"


%>


