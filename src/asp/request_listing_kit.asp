<%
spammsg = ""
if len(session("spammsg")) > 0 then response.end
UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If UserIPAddress = "" Then
	UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
End If


Dim MyJMail2
Dim HTML

Dim fname
Dim lname
Dim email
Dim phone
Dim company
Dim website

fname = Request.form("name")
lname = Request.form("last-name")
email = Request.form("email")
phone = Request.form("phone")
company = trim(Request.form("company") & " " )
website = Request.form("website")
returnurl = Request.form("ret")
honeypot = Request.form("fax") ' Hidden field that should match system date/time 
cname = fname & " " & lname
company2 = ucase(company)

'If Len(Trim(returnurl)) < Len("http://www.nsx.com.au")  Then
'	spammsg = spammsg & " Treat this message as potential SPAM. returnurl1."
'End If

If instr(returnurl,"(") > 0 or  instr(returnurl,"-1") > 0 or  instr(returnurl,"[1]") > 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. returnurl2."
End If

If instr(company2,"(") > 0 or  instr(company2,"-1") > 0 or  instr(company2,"[1]") > 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. company1."
End If


If instr(website,"email.tst") > 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. website1."
End If

'If instr(returnurl,"nsxa.com.au") = 0 Then
'	spammsg = spammsg & " Treat this message as potential SPAM. returnurl3."
'End If

If instr(returnurl,"http") = 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. returnurl4."
End If

goodemail = true
If instr(email,"@") = 0 or instr(email,".") = 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. bademail."
	goodemail = false
End If

goodcompany = true
If instr(company,"APPLE") > 0 or instr(company,"MICROSOFT") > 0 or instr(company,"AT&T") > 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. badcompany."
	goodcompany = false
	'response.end
End If
If instr(company2,"APPLE") > 0 or  instr(company2,"MICROSOFT") > 0 or  instr(company2,"ACUTENIX") > 0 or  instr(company2,"Acutenix") > 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. badcompany2."
	goodcompany = false
	'response.end
End If

goodfrom = true

If instr(cname,"_") > 0 or instr(cname,")") > 0 or  instr(cname,"@") > 0 or  instr(cname,".") > 0  or  instr(cname,"=") > 0 or instr(cname,"&") > 0 or  instr(cname,"%") > 0 or  instr(cname,"//") > 0 or  instr(cname,">") > 0 Then
	spammsg =  spammsg &  " Treat this message as potential SPAM. badname."
End If
goodphone = true
If instr(phone,"&") > 0 or  instr(phone,"@") > 0 or  instr(phone,"%") > 0  or  instr(phone,"=") > 0  or  instr(phone,")") > 0  Then
	spammsg =  spammsg & " Treat this message as potential SPAM. badphone."
End If

If UserIPAddress = "209.11.218.6" or UserIPAddress = "83.22.61.195" or UserIPAddress = "93.170.186.133" or UserIPAddress ="195.154.181" or UserIPAddress = "91.207.9.234" or UserIPAddress = "91.207.9.214" or UserIPAddress = "189.58.125.94" or UserIPAddress = "178.121.129.92" or UserIPAddress = "213.238.175.29" or UserIPAddress = "188.143.233.245" Then
	spammsg =   spammsg & " IP address " & UserIPAddress & " attempting spam" 
	'Response.End
End If


'If Not IsDate(honeypot) Then
'	spammsg = "Treat this message as potential SPAM."
'Else  ' this code is illogical need a more robust test. had one valid user send an email with 1 hour's difference
'	diff = DateDiff("n",CDate(honeypot),Now())
'	If diff > 5 Then ' Larger than five minutes ago
'		spammsg = "Hidden date field is not correct. Possible SPAM"
'	End If
'End If

'If Len(spammsg) > 0 Then Response.End

username = Trim(fname & " " & lname)
' fill in the website field
website = trim(website & " ")
if len(website) = 0 and len(email)<> 0 then
	at = instr(email,"@")
	if at <> 0 then	
		web = mid(email,at+1,len(email))
		website = "http://www." & web
	end if
end if ' website construct
If instr(website,"email.tst") > 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. website2."
End If
	
session("spammsg")=""

HTML = "<!DOCTYPE HTML PUBLIC""-//IETF//DTD HTML//EN"">"
HTML = HTML & "<html>"
HTML = HTML & "<head>" 
HTML = HTML & "<title>NSX Listing Kit Requested</title>"
HTML = HTML & "</head>"
HTML = HTML & "<body bgcolor=""FFFFFF"" >"
HTML = HTML & "<h1>NSX Listing Kit Requested</h1>"
HTML = HTML & "<p><font size =""2"" face=""Arial"" color=navy>"
HTML = HTML & "<b>From: </b> " & username & "  [<a href=mailto:" & email & ">" & email & "</a>]"
HTML = HTML & "<br><b>Phone:</b> " & phone 
HTML = HTML & "<br><b>Company:</b> " & company 
HTML = HTML & "<br><b>Website:</b> " & website
HTML = HTML & "<br><b>NSX Referring Page:</b> <a href=""" & returnurl & """>" & returnurl & "</a>"
HTML = HTML & "<br>IP Address:  " & Request.ServerVariables("remote_addr") 
If Len(spammsg) > 0 Then
HTML = HTML & "<br><b>WARNING</b> " & spammsg & " (honeypot=" & honeypot & ") <br>returnurl=" & returnurl
'HTML = HTML & "<br>IP Address:  " & Request.ServerVariables("remote_addr") 
HTML = HTML & "<br>Referrer:  " & Request.ServerVariables("HTTP_REFERER") 
HTML = HTML & "<br>All raw data:  " & Request.ServerVariables("ALL_RAW") 
session("spammsg")=spammsg
End If
HTML = HTML & "</body>"
HTML = HTML & "</html>"

Set MyJMail2 = Server.CreateObject("JMail.SMTPMail")
MyJMail2.ServerAddress = Application("SMTP_Server") & ":" & Application("SMTP_Port")
MyJMail2.Sender= "listingkit@nsxa.com.au" 'useremail ' Doesn't allow sending from non nsxa.com.au address
MyJMail2.SenderName = username  
If Len(spammsg) > 0 Then 
	MyJMail2.AddRecipient "techsupport@nsx.com.au" 
Else
	MyJMail2.AddRecipient "listingkit@nsx.com.au"  ' distribution group
	'MyJMail2.AddRecipientBCC "forms@nsxa.com.au"
	'MyJMail2.AddRecipientBCC "techsupport@nsxa.com.au" 
End If
MyJMail2.Subject="Listing Kit Request - NSX Website"
MyJMail2.ContentType="text/html"
MyJMail2.Priority = 1 'High importance!
MyJMail2.Body=HTML
if len(email) <> 0 then MyJMail2.Execute
Set MyJMail2=nothing
Set HTML = nothing

' Session("ListingKitRequested") = "YES"
' Session("PopupMsg") = "NSX staff will contact you to discuss your listing requirements."
Response.redirect "/listingkit_success.asp?ret=" & Server.URLEncode(returnurl)
%>
