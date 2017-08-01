<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "User Registration"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<h1>User Registration</h1>
<% 
    for each x in Request.Form 
        Response.Write("<br>" & x & " = " & Request.Form(x)) 
    next 
%>

  <div align="center">
<table width="90%" cellspacing="1" border="0">
  <tbody><tr>
    <td width="500" valign="top" class="highlightbox">
      <p><font>This is a free service.&nbsp; Registration is 
		required to access email and sms alert services.&nbsp; Please read the 
		disclaimer below.</font></p>
    </td>
  </tr>
</tbody></table>
</div>

<form action="user_registration_new.asp" method="post">
  <div align="center">
	<table border="0" width="450" cellspacing="1" bgcolor="#FFFFFF" cellpadding="0">
    <center>
    	<tr>
			<td align="right">First Name:</td>
			<td><input type="text" name="fname" size="15" style="border: 1 solid #6D7BA0 ;background-color:#EEEEEE" value="<%=session("fname")%>">*</td>
		</tr>
		<tr>
			<td align="right">Last Name:</td>
			<td style="line-height: 100%" class="plaintext">
			<input type="text" name="lname" size="15" style="border: 1 solid #6D7BA0;background-color:#EEEEEE" value="<%=session("lname")%>"> 
			*</td>
		</tr>
		<tr>
			<td align="right" >Email:</td>
			<td><input type="text" name="email" size="30" style="border: 1 solid #6D7BA0;background-color:#EEEEEE" maxlength="100" value="<%=session("email")%>">*</td>
		</tr>
		<tr>
			<td align="right" >Mobile Phone</td>
			<td><input type="text" name="mobile" size="20" style="border: 1 solid #6D7BA0;background-color:#EEEEEE" maxlength="20" value="<%=session("mobile")%>">*</td>
		</tr>
		<tr>
			<td align="right" >Username:</td>
			<td>
			<input type="text" name="username" size="20" style="border: 1 solid #6D7BA0;background-color:#EEEEEE" maxlength="100" value="<%=session("username")%>"> 
			*</td>
		</tr>
		<tr>
			<td align="right" >Password:</td>
			<td >
			<input type="password" name="PASSWORD" size="20" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"> 
			*</td>
		</tr>
		<tr>
			<td align="right">Confirm Password:</td>
			<td>
			<input type="password" name="CONFIRMPASSWORD" size="20" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"> 
			*</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" valign="top" align="right" class="texthint" colspan="2">
			<p align="left">* Please supply all details to complete your 
			registration.<br>
			* For the SMS services only Australian and New Zealand mobile phones are supported 
			at this time.&nbsp; Please <a href="contacts.asp">contact us</a> and 
			register your interest in receiving alerts to an overseas mobile 
			phone.</td>
		</tr>
	</table></div>

  <div align="center"><p>
	<input type="submit" value="Register" style="color: #6D7BA0; background-color: #FFFFFF; font-family: arial; font-size: 10pt; font-weight: bold"></p>
  </div>
</form>






</div>
<!--#INCLUDE FILE="footer.asp"-->