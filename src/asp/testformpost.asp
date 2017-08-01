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


Set tradingcode = objUpload("tradingcode")
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
Set nsxcode = objUpload("nsxcode")
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

newfile = nsxcode.Value & newday & oldext



ispricesensitive = "0"
If annPriceSensitive.Value = "yes" Then ispricesensitive = "1"

docopy = "0"
If anncopy.Value = "yes" Then docopy = "1"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 1. Save File
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
objUpload("f1").SaveAs uplpath & newfile

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Insert Database Record
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
sql = "INSERT INTO coAnn (nsxcode,annTitle,annPrecise,annSubmitter,annPhone,annEmail,annFile,annUsername,annFileSize,tradingcode,annPriceSensitive,annupload,anncopy,anncopycodes)"
sql = sql & " VALUES (" 
sql = sql & "'" & Replace(nsxcode.Value, "'","''") & "',"
sql = sql & "'" & Replace(anntitle.Value, "'","''") & "',"
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
Set conn = GetWriterConn()
conn.Execute sql 
DBDisconnect()

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 3. Send Email
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
crr = vbCRLF
msg = "This is an RNS announcement receipt notification" & crr & crr
msg = msg & "NSXCODE: " & nsxcode.Value & crr
msg = msg & "Title: " & anntitle.Value & crr & crr
msg = msg & "Price Sensitive? " & annPriceSensitive.Value & crr
msg = msg & "Description: " & description.Value & crr
msg = msg & "Submitter: " & person.Value & crr
msg = msg & "Phone: " & phone.Value & crr
msg = msg & "Email: mailto:" & Trim(LCase(email.Value)) & crr
msg = msg & "FileName: " & Application("nsx_SiteRootURL") & "/" & newsdir3 &  newfile & crr
msg = msg & "FileSize: " & filesize & " bytes" & crr
msg = msg & "Date/Time: " & Now & crr
Set cdoConfig = CreateObject("CDO.Configuration") 
With cdoConfig.Fields 
  .Item(cdoSendUsingMethod) = cdoSendUsingPort
  .Item(cdoSMTPServer) = Application("SMTP_Server")
  .Item(cdoSMTPServerPort) = CInt(Application("SMTP_Port"))
  .Item(cdoSMTPConnectionTimeout) = 10
  .Item(cdoSMTPAuthenticate) = cdoBasic
''  .Item(cdoSendUserName) = "username"
''  .Item(cdoSendPassword) = "password"     
  .update 
End With 
Set cdoMessage = CreateObject("CDO.Message") 
With cdoMessage 
  Set .Configuration = cdoConfig 
  .From = "rns@nsxa.com.au"
  .ReplyTo = "mail@nsxa.com.au"
  .To = "trading@nsxa.com.au"
  .Subject = nsxcode.Value & " announcement has arrived"
  .TextBody = msg
  .Send 
End With 
Set cdoMessage = Nothing 
Set cdoConfig = Nothing

If Err.Number <> 0 Then
   On Error Goto 0 
   RecordWebError "company_announcement_upload.asp", Err
   errors "A system error has occured. NSX Staff have been notified with full details of the error." 
End If
On Error Goto 0 ' Reset error handling.

If StrLen(returnurl.Value) > 0 Then
  Response.Status = "301 Moved Permanently"
  Response.AddHeader "Location", returnurl.Value & "?errors=" & errors
  Response.End()
Else
  Response.Write "Upload has been successful." 
End If


'Response.Write "nsxcode=" & nsxcode.Value & "<br>"
'Response.Write "tradingcode=" & tradingcode.Value & "<br>"
'Response.Write "category=" & category.Value & "<br>"
'Response.Write "person=" & person.Value & "<br>"
'Response.Write "anntitle=" & anntitle.Value & "<br>"
'Response.Write "description=" & description.Value & "<br>"
'Response.Write "annPriceSensitive=" & annPriceSensitive.Value & "<br>"
'Response.Write "annCopy=" & annCopy.Value & "<br>"
'Response.Write "phone=" & phone.Value & "<br>"
'Response.Write "email=" & email.Value & "<br>"
'Response.Write "newsdir=" & newsdir & "<br>"
'Response.Write "newsdir2=" & newsdir2 & "<br>"
'Response.Write "newsdir3=" & newsdir3 & "<br>"
'Response.Write "tm=" & tm & "<br>"
'Response.Write "uplpath=" & uplpath & "<br>"
'Response.Write "newfile=" & newfile & "<br>"
'Response.Write "oldext=" & oldext & "<br>"
'Response.Write "newday=" & newday & "<br>"
'Response.Write "SaveAs=" & newsdir2 & newfile & "<br>"
'Response.Write "filesize=" & filesize & "<br>"


%>


