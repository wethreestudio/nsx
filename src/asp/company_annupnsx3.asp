<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "CSX"%>
<!--#INCLUDE FILE="member_check.asp"-->
<%
page_title = "NSX - National Stock Exchange of Australia"
meta_description = "Official site of the National Stock Exchange of Australia, the market of choice for SME and growth style Australian and International companies."
meta_keywords = "NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW"
alow_robots = "no"
'objJsIncludes.Add "validate_js", "js/jquery.validate.js"
anncopycodes = ""
%>

<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript">
$(document).ready(function () {
  $.validator.addMethod('filesize', function(value, element, param) {
      // param = size (en bytes) 
      // element = element to validate (<input>)
      // value = value of the element (file name)
      //return this.optional(element) || element.files[0].size <= param;
      
      
      var fileInput = $("#f1")[0];
      
      alert (fileInput.files[0].fileSize);
      alert(param);
      
      return false;// this.optional(element) || fileInput.files[0].fileSize <= param; 
  });



  $("#theForm").validate({ 
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },         
    rules: {
      tc: "required",
      category: "required",
      title: {
        required: true,
        minlength: 4,
        maxlength: 54
      },
      description: "required",
      person: "required",
      phone: "required",
      email: { required: true, email: true }
      //, f1: { required: true, accept: "pdf"  }
      , f1: { required: true, accept: "pdf" } //, filesize: 10485760  }  
    },
    messages: {
      tc: "Please select an announcement code",
      category: "Please select an announcement category",
      title: {
        required: "Please enter an announcement title",
        minlength: "Title must be at least 4 characters long",
        maxlength: "Title must be less than 54 characters long"
      },
      description: "Short description is required",
      person: "Contact name is required",
      phone: "Phone number is required",
      email: {
        required: "Email address is required",
        email: "Email address must be in a valid format"
      }
      , f1: "File must be PDF, less than 10MB"                 
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
		<h1>Lodge an Announcement</h1>
      <p>
        Use the form below to report a Company Announcement to the NSX. All fields marked are mandatory.  If the form fails to submit correctly press the back button and  correct any details and then resubmit the announcement.
      </p>
      <p>     
        Please note: 10 megabyte file upload limit.  Please reduce file size to fit under this limit.  Adobe PDF files only can be accepted.
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
  Announcement has been uploaded successfully.     
</div>
<br>
<%
Else
%>



<div class="stylized myform">
<!-- form method="POST" action="company_resupload3.asp" name="theForm" id="theForm" enctype="multipart/form-data" -->
<form method="POST" action="company_announcement_upload.asp" name="theForm" id="theForm" enctype="multipart/form-data">


  <a name="create_form_error"></a>
  <div id="create_form_error">
  </div>

  <span class="stylized_label"><span class="required">*</span>Available Securities:
  <span class="small">&nbsp;</span>
  </span>
  <div class="input_container">
<%
' need to modify form to allow advisers with multiple codes.
nsxcode = ""
if session("ADV") > 0 then
	nsxcode = ucase(trim(session("comments") & " "))
end if
if nsxcode = "" then
	' get a single company
	nsxcode = ucase(session("nsxcode"))
else
	' keep multiple companies
	nsxcode = nsxcode
end if

nc = split(nsxcode,";")
srch = "AND (ci.nsxcode IN ('" & ImpolodeCollection(nc, "','") & "'))" 
sql = "SELECT cd.nsxcode, cd.coname, cd.agacn, ci.tradingcode, ci.issuedescription FROM coIssues ci JOIN coDetails cd ON cd.nsxcode = ci.nsxcode "
sql = sql & " WHERE  ((ci.Issuestatus ='Active') OR (ci.Issuestatus ='Suspended') OR (ci.Issuestatus ='IPO')) " & srch
sql = sql & " ORDER BY ci.tradingcode"
'Response.Write sql
Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
    %>
    <%=Session("nsxcode")%>
    <input type="hidden" name="tc" id="tc" value="<%=Session("nsxcode")%>">
    <%  
Else
    %>
	  <select size="1" name="tc" id="tc" class="stylized_input">
		<option value="">Select</option>
    <%  
    While Not rs.EOF
      tradingcode = rs("tradingcode")
      coname = rs("coname")
      agacn = rs("agacn")
      issuedesc = rs("issuedescription")
	  anncopycodes = anncopycodes & "," & tradingcode
      response.write "<option value=""" & tradingcode & """>" & tradingcode & left(" - " & issuedesc,50) & "</option>"
      rs.MoveNext 
    Wend 
	If Len(anncopycodes) > 0 Then anncopycodes = Right(anncopycodes, Len(anncopycodes)-1)
    %>
	  </select>
    <% 
End If


%> 
  </div>
  
  
  <label class="stylized_label" for="category"><span class="required">*</span>Category
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
  <%
  NSXAnnouncemntCategorySelect "category", "category", "stylized_input" 
  %>
  </div>
  
  
  
  
  <label class="stylized_label" for="title"><span class="required">*</span>Title of Announcement
  <span class="small">54 Characters Max</span>
  </label>
  <div class="input_container">
  <input type="text" value="" maxlength="54" alt="Title" id="title" name="title" class="stylized_input">
  </div>
  
 
  <label class="stylized_label" for="description"><span class="required">*</span>Short Description 
  <span class="small">Precise</span>
  </label>
  <div class="input_container">
  <textarea rows="4" name="description" id="description" cols="48"></textarea>
  </div>
    

  
  <label class="stylized_label" for="annPriceSensitive"><span class="required">*</span>Price Sensitive
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
      <input name="annPriceSensitive" id="annPriceSensitive_yes" value="Yes" type="radio"><label for="annPriceSensitive_yes">Yes</label>&nbsp;
      <input name="annPriceSensitive" id="annPriceSensitive_no" value="No" checked="checked" type="radio"><label for="annPriceSensitive_no">No</label>
  </div>
  
  <label class="stylized_label" for="annCopy"><span class="required">*</span>Copy to Underlying
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
      <input name="anncopy" id="anncopy_yes" value="Yes" type="radio"><label for="anncopy_yes">Yes</label>&nbsp;
      <input name="annCopy" id="anncopy_no" value="No" checked="checked" type="radio"><label for="anncopy_no">No</label><br>
  </div>
  
  
  <label class="stylized_label" for="person"><span class="required">*</span>Contact Person:
  <span class="small">For Announcement</span>
  </label>
  <div class="input_container">
  <input type="text" value="<%=Session("Full_Name")%>" name="person" id="person" class="stylized_input"> 
  </div>
  
  <label class="stylized_label" for="phone"><span class="required">*</span>Direct Phone:
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
  <input type="text" value="<%=Session("phone")%>" name="phone" id="phone" class="stylized_input"> 
  </div>  
  
  <label class="stylized_label" for="email"><span class="required">*</span>Email Address:
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
  <input type="text" value="<%=Session("email")%>" name="email" id="email" class="stylized_input"> 
  </div>  
  
 
  
  
  
  <label class="stylized_label" for="f1"><span class="required">*</span>File
  <span class="small">&nbsp;</span>
  </label>
  <div class="input_container">
  <input type=file name="f1" id="f1" class="stylized_input"> 
  </div>
  
  
  <input type="submit" value="Upload" class="stylized_button">
  <div class="spacer"></div>
  <input type="hidden" name="coname" value="<%=coname%>">
  <input type="hidden" name="acn" value="<%=acn%>">
  <input type="hidden" name="display" value="1">
  <input type="hidden" name="username" value="<%=Session("username")%>">
  <input type="hidden" name="nsxcode" value="<%=nsxcode%>">
	<input type="hidden" name="anncopycodes" value="<%=anncopycodes%>">
	<input type="hidden" name="returnurl" value="company_annupnsx3.asp">
	
</form>


</div>
<%
End If
%>
	




		<p><b>Copy to underlying</b>: When selected a duplicate record 
		will be added for all securities attached to the root of the 
		security. For example; if releasing an announcement for 
		options of ABCOA then all securities will receive a duplicate 
		record of the announcement e.g. ABC, ABCA, ABCB, ABCOA, ABCOB etc when 
		the copy to underlying is set to &quot;Yes&quot;. This saves on having to 
		lodge the same announcement multiple times.</p>
		<p><b>Upload: </b>If the upload is successful you will see an acknowledgement receipt 
		page and receive a email acknowledgement. Otherwise you will see a 
		red error message requesting you to take corrective action. If you 
		do not get the receipt messages then the upload was not successful. 
		Please note that the file size limit is 10 megabytes and that only Adobe 
		acrobat PDF files can be accepted.</p>
		<p><b>What happens next: </b>Once NSX was reviewed the announcement and released it, you 
		will get an email stating that NSX has released the announcement.</p>
		<p>If you do not receive the above notifications then it is likely an 
		announcement ahs not been submitted. Please check the NSX website 
		and if the announcement has not appeared then resubmit the document.</p>
		<p><b>Maximum File size: </b>Files must not be larger than 10 megabytes. 
		If it is the announcement will be rejected. Files larger than 
		10megabytes are usually scanned documents. Look at reducing the 
		resolution settings on your scanner or create a PDF file from the 
		original document, then only scan and insert the pages that have to be 
		scanned. For example signature pages.</p>
    

</div>
</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>
<!--#INCLUDE FILE="footer.asp"-->
