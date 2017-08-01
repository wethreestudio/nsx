<%

Const cdoSendUsingMethod = "http://schemas.microsoft.com/cdo/configuration/sendusing"
Const cdoSendUsingPort = 2
Const cdoSMTPServer = "http://schemas.microsoft.com/cdo/configuration/smtpserver"
Const cdoSMTPServerPort = "http://schemas.microsoft.com/cdo/configuration/smtpserverport"
Const cdoSMTPConnectionTimeout = "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout"
Const cdoSMTPAuthenticate = "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"
Const cdoBasic = 1
Const cdoSendUserName = "http://schemas.microsoft.com/cdo/configuration/sendusername"
Const cdoSendPassword = "http://schemas.microsoft.com/cdo/configuration/sendpassword"

Response.ContentType = "text/plain"

Sub SendMail(from_email, to_email, cc_email, bcc_email, replyto, subject, body, attach_filename, attach_textfile)
    Dim deleteFile
    deleteFile = ""
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
    ' Attach flename, teleml
    With cdoMessage 
      Set .Configuration = cdoConfig 
      .From = from_email
      .To = to_email
      .Cc = cc_email
      .Bcc = bcc_email      
      .ReplyTo = replyto
      .Subject = subject
      .TextBody = body
       
    End With 
    If Len(attach_filename) > 0 Then
      If Len(attach_textfile) > 0 Then
        Dim objFSO
        Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
        
        'Open the text file
        Dim objTextStream
        Dim fileName
        fileName = Server.MapPath("/ftp/" & attach_filename)
        
        ' Response.Write fileName
        i = 0
        While objFSO.FileExists(fileName)
          i = i+1
          fileName = Server.MapPath("/ftp/" & i & "-" & attach_filename)
        Wend
        deleteFile = fileName
        Set objTextStream = objFSO.CreateTextFile(fileName, True)
        
        'Display the contents of the text file
        objTextStream.WriteLine attach_textfile
        
        'Close the file and clean up
        objTextStream.Close
        Set objTextStream = Nothing
        Set objFSO = Nothing
        cdoMessage.AddAttachment (fileName)
      Else
        Dim fs
        Set fs=Server.CreateObject("Scripting.FileSystemObject")
        If fs.FileExists(attach_filename) = True Then
          cdoMessage.AddAttachment (attach_filename)
        Else
          Response.Write("SendMail - Attachment file '" & attach_filename & "'' does not exist.")
        End If
        Set fs = Nothing 
      End If
    End If
    
    cdoMessage.Send
    Set cdoMessage = Nothing 
    Set cdoConfig = Nothing
    
    If Len(deleteFile) > 0 Then
      Dim dfs
      Set dfs=Server.CreateObject("Scripting.FileSystemObject")
      If dfs.FileExists(deleteFile) Then
        dfs.DeleteFile(deleteFile)
      End If
      Set dfs = Nothing
    End If
End Sub


toEmail = "paul.hulskamp@gmail.com"
SendMail toEmail,"trading@nsxa.com.au", "", "", "", "TEST", "Test email", "", ""
Response.Write "Finished sending test email to: " & toEmail
%>
