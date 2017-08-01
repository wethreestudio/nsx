<!--#INCLUDE FILE="include_all.asp"-->
<% 
ID = session("subid") 
CHECKFOR = "CSX" 

MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if
%>
<!--#INCLUDE FILE="member_check.asp"-->
<%
page_title = "NSX - National Stock Exchange of Australia"
meta_description = "Official site of the National Stock Exchange of Australia, the market of choice for SME and growth style Australian and International companies."
meta_keywords = "NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW"
alow_robots = "no"
'objJsIncludes.Add "validate_js", "js/jquery.validate.js"

%>

<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript">
$(document).ready(function () {
  $.validator.addMethod('password', function(value, element, param) {
    var reg = /^[^%\s]{6,}$/;
    var reg2 = /[a-zA-Z]/;
    var reg3 = /[0-9]/;
    return this.optional(element) || (reg.test(value) && reg2.test(value) && reg3.test(value));
  });

  
  $("#theForm").validate({ 
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },         
    rules: {
      password: { required: true, password: true },
      cpassword: { required: true, password: true, equalTo: "#password" },
      fname: {
        required: true,
        minlength: 1,
        maxlength: 50
      },
      lname: {
        required: true,
        minlength: 1,
        maxlength: 50
      },
      organisation: {
        required: true,
        minlength: 1,
        maxlength: 100
      },            
      email: { required: true, email: true },
    },
    messages: {
      password: {
        required: "Password is required",
        password: "Must be at least 6 characters long and contain one digit (0-9) and one letter (a-z)"
      },
      cpassword: {
        required: "Confirm password is required",
        password: "Must be at least 6 characters long and contain one digit (0-9) and one letter (a-z)",
        equalTo: "Must match password"
      },   
      fname: "Please enter your first name",
      lname: "Please enter your last name",
      organisation: "Please enter your organisation",
      email: {
        required: "Email address is required",
        email: "Email address must be in a valid format"
      },               
    },
    errorElement: "div"
  });        
});
</script>






<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "company_side_menu.asp"
%>


<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">
	
	<div class="editarea">
		<h1>Edit Your Details</h1>
      <p>
        Use the form below to report update your details.
      </p>

<%
If Len(Request.QueryString("errors")) > 0 Then
%>
<div class="errors">    
  <b>Errors:</b>
  <ul>
  <% 
    errors = split(Request.QueryString("errors"),";")
    Response.Write "<li>" & ImpolodeCollection(errors, "</li><li>") & "</li>"
  %>
  </ul>    
</div>
<br>
<%
ElseIf Len(Request.QueryString("success")) > 0 Then
%>
<div class="success">    
  Your account details have been updated.     
</div>
<br>
<%
End If



Set conn = GetReaderConn()
sql = "SELECT uSubscribers.* FROM uSubscribers WHERE (subid = " & SafeSqlParameter(ID) & ")"
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><p>User record not found?</p><%
Else
%>



<div class="stylized myform">
<form method="POST" id="theForm" action="company_save_your_details.asp">


  <a name="create_form_error"></a>
  <div id="create_form_error">
  </div>

 
  
  <label class="stylized_label" for="category">Title
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <select name="salutation" id="salutation" class="stylized_input" style="width:130px;">
    	<option value="" <% If rs("salutation") = "" Then Response.Write "selected=""selected""" %>></option>
    	<option value="Mr" <% If LCase(rs("salutation")) = "mr" Then Response.Write "selected=""selected""" %>>Mr.</option>
    	<option value="Mrs" <% If LCase(rs("salutation")) = "mrs" Then Response.Write "selected=""selected""" %>>Mrs.</option>
    	<option value="Miss" <% If LCase(rs("salutation")) = "miss" Then Response.Write "selected=""selected""" %>>Miss</option>
    	<option value="Ms" <% If LCase(rs("salutation")) = "ms" Then Response.Write "selected=""selected""" %>>Ms.</option>
    	<option value="Dr" <% If LCase(rs("salutation")) = "dr" Then Response.Write "selected=""selected""" %>>Dr.</option>
      <option value="Prof" <% If LCase(rs("salutation")) = "prof" Then Response.Write "selected=""selected""" %>>Prof.</option>
      <option value="Rev" <% If LCase(rs("salutation")) = "rev" Then Response.Write "selected=""selected""" %>>Rev.</option>
    </select>
  </div>
  
  <label class="stylized_label" for="category"><span class="required">*</span>First Name
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("fname")%>" maxlength="50" alt="First Name" id="fname" name="fname" class="stylized_input">
  </div>  
  
  
  <label class="stylized_label" for="title"><span class="required">*</span>Last Name
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("lname")%>" maxlength="50" alt="Last Name" id="lname" name="lname" class="stylized_input">
  </div>
  
 
  <label class="stylized_label" for="description"><span class="required">*</span>Organisation
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("organisation")%>" maxlength="100" alt="Organisation" id="organisation" name="organisation" class="stylized_input">
  </div>
  
  
  <label class="stylized_label" for="description">Position
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("position")%>" maxlength="100" alt="Position" id="position" name="position" class="stylized_input">
  </div> 
  
  <label class="stylized_label" for="description">Occupation
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("occupation")%>" maxlength="100" alt="Occupation" id="occupation" name="occupation" class="stylized_input">
  </div>      

  <label class="stylized_label" for="description">Address
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <textarea rows="4" name="address" id="address" cols="48"><%=rs("address")%></textarea>
  </div> 
  

  <label class="stylized_label" for="description">Suburb
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("suburb")%>" maxlength="50" alt="Suburb" id="suburb" name="suburb" class="stylized_input">
  </div>  
  
  <label class="stylized_label" for="description">City
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("city")%>" maxlength="50" alt="City" id="city" name="city" class="stylized_input">
  </div>  
  
  <label class="stylized_label" for="description">State
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("state")%>" maxlength="50" alt="State" id="state" name="state" class="stylized_input">
  </div>
  
  
  <label class="stylized_label" for="description">ZIP/Postcode
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("zip")%>" maxlength="20" alt="ZIP/Postcode" id="zip" name="zip" class="stylized_input">
  </div>
      
  
  <label class="stylized_label" for="description">Phone
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("phone")%>" maxlength="50" alt="Phone" id="phone" name="phone" class="stylized_input">
  </div>
  
  <label class="stylized_label" for="description">Fax
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("fax")%>" maxlength="50" alt="Fax" id="fax" name="fax" class="stylized_input">
  </div>
  
  <label class="stylized_label" for="description"><span class="required">*</span>Email
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("email")%>" maxlength="255" alt="Email" id="email" name="email" class="stylized_input">
  </div>  
  
  <label class="stylized_label" for="description">Mobile
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="text" value="<%=rs("mobile")%>" maxlength="50" alt="Mobile" id="mobile" name="mobile" class="stylized_input">
  </div>    
  
  <label class="stylized_label" for="description">Username
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <%=rs("username")%>
  </div>  
  
  <label class="stylized_label" for="description"><span class="required">*</span>Password
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
    <input type="password" value="<%=rs("password")%>" maxlength="50" alt="Password" id="password" name="password" class="stylized_input">
  </div>
            
  <label class="stylized_label" for="description"><span class="required">*</span>Confirm Password
  <span class="small">Same as above</span>
  </label>
  <div class="input_container">
    <input type="password" value="" maxlength="50" alt="Password" id="cpassword" name="cpassword" class="stylized_input">
  </div>
  
  <input type="submit" value="Update" class="stylized_button">
  <div class="spacer"></div>

	
</form>


</div>
<%
End If
%>
	

    

</div>
</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--#INCLUDE FILE="footer.asp"-->
