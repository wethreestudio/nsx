<%

Response.ContentType = "text/plain"
    Set MyJMail4 = Server.CreateObject("JMail.SMTPMail")
    MyJMail4.ServerAddress = Application("SMTP_Server")
    MyJMail4.Sender= "admin@nsxa.com.au"
    MyJMail4.ReplyTo = "admin@nsxa.com.au"
    MyJMail4.Subject= "TEST Email 22"
    MyJMail4.Priority = 1 'High importance!
    MyJMail4.Body= "Test Message"

	
	MyJMail4.AddRecipient "paul.hulskamp@nsxa.com.au"
	'MyJMail4.AddRecipient "paul.hulskamp@gmail.com"
	MyJMail4.Silent = True
    MyJMail4.Logging = True
    

	MyJMail4.Execute
	 nsxlog =  MyJMail4.Log
    set MyJMail4=nothing

    response.write nsxlog

%>
