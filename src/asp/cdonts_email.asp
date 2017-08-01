<!--#INCLUDE FILE="include/cdo_constants.asp"--><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <meta name="generator" content="PSPad editor, www.pspad.com">
  <title></title>
  </head>
  <body>
<%

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' SendMail: Subroutine to send an email using CDO mail object
' Parameters:
'  from_email = From email address
'  to_email = Email will be sent to this address. Use ';' to separate multiple recipients.
'  cc_email = Email will be CC'd to this address. Use ';' to separate multiple recipients.
'  bcc_email = Email will be BCC'd to this address. Use ';' to separate multiple recipients.
'  replyto  = Return address.
'  subject = Subject line
'  body = Text body of email.
'  attach_filename = 1. If attach_filename is empty this must be a full path to an existing file (e.g. c:\temp\temp.txt). 
'                    2. If attach_filename is not empty this is the file name attach_filename is attached as.
'  attach_textfile = Body of text file attachment. Leave empty if attach_filename is an existing file.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
        
        Response.Write fileName
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

' SendEmail "trading@nsxa.com.au","paul.hulskamp@nsxa.com.au", "", "", "Test Email - Subject", "Test Email - Body", "", ""

SendMail "trading@nsxa.com.au","paul@nsxa.com.au", "a@nsxa.com.au;b@nsxa.com.au;c@nsxa.com.au;", "", "", "Test Email - Subject", "Test Email - Body", "ATTACH.TXT", "ATTACHED FILE." & vbCrLf & "Next Line."

%>
  </body>
</html>
