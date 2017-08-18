<!--#INCLUDE FILE="include_all.asp"-->
<%

Function GetGuid() 
    Set TypeLib = CreateObject("Scriptlet.TypeLib") 
    GetGuid = Left(CStr(TypeLib.Guid), 38) 
    Set TypeLib = Nothing 
End Function  

Session("feedbackkey") = GetGuid()

page_title = "Complaints"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  'Response.Redirect "/"
End If

'objJsIncludes.Add "validate_js", "js/jquery.validate.js"

%>
<!--#INCLUDE FILE="header.asp"-->
<script src="js/additional-methods.js" type="text/javascript"></script>

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Complaints</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<!--#INCLUDE FILE="content_lower_nav.asp"-->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">

<%
  RenderContent page, "editarea" 
%>




<!--
<script type="text/javascript">
// added by sfe 
jQuery.validator.addMethod("phonenumbers", function(value, element) {
	return this.optional(element) || /^[0-9\-.+()\s]+$/i.test(value);
}, "Valid phone number please only please");

$(document).ready(function () {
  /*
    Events
  */
  if($("#subject").val() == 'Other'){
    $('#other_desc').show('fast', function() {
      $('#other_desc input').focus();
    });
  }
      
  $("#subject").change(function () {
    var sel = $("#subject").val();
    if(sel == 'Other'){
      $('#other_desc').show('fast', function() {
        $('#other_desc input').focus();
      });
    } else {
      $('#other_desc').hide('fast');
    }
  });

  /*
      Validation 
  */
  $("#contact_form").validate({ 
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },         
    rules: {
      subject: "required",
      subjectother: {
        required: true,
        minlength: 4,
        maxlength: 100
      },
      comments: {
        required: true,
        minlength: 10,
        maxlength: 400
      },
	  contactname: {
        required: true,
        minlength: 5,
        maxlength: 30,
		letterswithbasicpunc: true
      },
	  usertel: {
        required: false,
		phonenumbers: true,
        minlength: 8,
        maxlength: 20
      },
      useremail: {
        required: true,
        email: true
      }
    },
    messages: {
      subject: "Please select a subject.",
      subjectother: {
        required: "Please enter other subject.",
        minlength: "Other subject must be at least 4 characters long.",
        maxlength: "Other subject must be less than 100 characters long."
      },
      comments: {
        required: "Please enter your comments.",
        minlength: "Comments must be at least 10 characters long.",
        maxlength: "Comments must be less than 100 characters long."
      },
	  contactname: {
        required: "Please enter your name.",
        minlength: "Name must be at least 5 characters long.",
        maxlength: "Name must be less than 30 characters long.",
		letterswithbasicpunc: "Letters only in a name."
      },
	  usertel: {
        required: "Please enter your comments.",
		phonenumbers: "Please enter a valid phone number.",
        minlength: "Phone number must be at least 8 characters long.",
        maxlength: "Phone number must be less than 20 characters long."
      },
      useremail: {
        required: "Please enter your email address.",
        email: "Please enter a valid email address."
      }                 
    },
    errorElement: "div"
  });        
});
</script>


<div class="col-lg-6">
    <form id="contact_form" name="contact_form" action="/feedback_thx.asp" method="post" class="form">
        <input type="hidden" id="feedbackkey" name="feedbackkey" value="<%=Session("feedbackkey")%>">
        <a name="create_form_error"></a>
        <div id="create_form_error"></div>
        <input type="hidden" name="messagetype" id="tcomplaint" value="complaint">


        <div class="form-group">
            <label for="subject"><span class="required">*</span>Subject</label>
            <select class="form-control" name="subject" id="subject">
                <option value=""></option>
                <option value="How to List">How to List</option>
                <option value="The Exchange (NSX)">The Exchange (NSX)</option>
                <option value="Market Data">Market Data</option>
                <option value="Advisers">Advisers</option>
                <option value="Facilitators">Facilitators</option>
                <option value="Participant Brokers">Participant Brokers</option>
                <option value="General">General</option>
                <option value="The Web Site">The Web Site</option>
                <option value="Fidelity Fund">Fidelity Fund</option>
                <option value="Compliance Committee">Compliance Committee</option>
                <option value="More Information">More Information</option>
                <option value="Privacy">Privacy</option>
                <option value="Other">(Other - please specify)</option>
            </select>
            <div id="other_desc" style="display:none;">
                <input class="form-control" type="text" name="subjectother" id="subjectother" alt="Other" maxlength="200" value="" placeholder="Email" />
            </div>
        </div>

        
        <div class="form-group">
            <label for="comments"><span class="required">*</span>Comments</label>
            <textarea id="comments" name="comments" class="form-control" rows="5" cols="10" placeholder="Email"></textarea>
        </div>

        <div class="form-group">
            <label for="contactname"><span class="required">*</span>Name</label>
            <input class="form-control" type="text" name="contactname" id="contactname" placeholder="Your name" maxlength="100" value="" />
        </div>
        
        <div class="form-group">
            <label for="contactemail"><span class="required">*</span>Email</label>
            <input class="form-control" type="text" name="contactemail" id="contactemail" placeholder="Your email address" maxlength="255" value="" />
        </div>
        
        <div class="form-group">
            <label for="usertel">Phone Number</label>
            <input class="form-control" type="text" name="usertel" id="usertel" placeholder="Your phone number" maxlength="20" value="" />
        </div>
        
        <div class="form-group">                
            <label for="contactrequested">Contact Me</label><br />
            <input type="checkbox" class="checkbox form-control" id="contactrequested" name="contactrequested"/>
            <label for="contactrequested">Contact me as soon as possible.</label>
        </div>

        <input class="btn btn-default" type="submit" value="Send">

        <div class="spacer"></div>
    </form>
</div>

<%
  'RenderContent page & "1", "editarea" 
%>
-->
</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->