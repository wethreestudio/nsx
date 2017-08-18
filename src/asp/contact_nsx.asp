<!--#INCLUDE FILE="include_all.asp"-->
<%

Function GetGuid() 
    Set TypeLib = CreateObject("Scriptlet.TypeLib") 
    GetGuid = Left(CStr(TypeLib.Guid), 38) 
    Set TypeLib = Nothing 
End Function  

Session("feedbackkey") = GetGuid()

' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If



%>
<!--#INCLUDE FILE="header.asp"-->
<script src="js/additional-methods.js" type="text/javascript"></script>
<script type="text/javascript"><!--
function gen_mail_to_link(lhs,rhs,subject)
{
document.write("<A HREF=\"mailto");
document.write(":" + lhs + "@");
document.write(rhs + "?subject=" + subject + "\">" + lhs + "@" + rhs + "<\/A>"); } 
// --> </SCRIPT>
<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage about-page">
    <div class="hero-banner-img">
            <img src="images/banners/iStock-468127886.jpg" />
    </div>
    
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">

                
                <h1>Contact us</h1>

               
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


		</div>


<div class="row">&nbsp;&nbsp;</div>

<h2>Send us a message</h2>




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
      messagetype: "required",
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
      contactemail: {
        required: true,
        email: true
      }
    },
    messages: {
      messagetype: "Please select a message type.",
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
	  usertel: {
        required: "Please enter your comments.",
		phonenumbers: "Please enter a valid phone number.",
        minlength: "Phone number must be at least 8 characters long.",
        maxlength: "Phone number must be less than 20 characters long."
      },
	  contactname: {
        required: "Please enter your name.",
        minlength: "Name must be at least 5 characters long.",
        maxlength: "Name must be less than 30 characters long.",
		letterswithbasicpunc: "Letters only in a name."
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

<div>
    <form id="contact_form" name="contact_form" action="/feedback_thx.asp" method="post">

        <div class="col-lg-6 col-md-6 col-sm-12 left-align nopad">
        <input type="hidden" id="feedbackkey" name="feedbackkey" value="<%=Session("feedbackkey")%>">
        <a name="create_form_error"></a>
        <div id="create_form_error"></div>


        <div class="form-group">
            <label for="subject" class="col-lg-2 col-md-2 col-sm-12 control-label text-right"><span class="required">*</span>Subject</label>
            <div class="col-lg-10 col-md-10 col-sm-12">
              
                <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject">
             
            </div>
        </div>

        <div class="form-group">
            <label for="comments" class="col-lg-2 col-md-2 col-sm-12 control-label text-right"><span class="required">*</span>Message</label>
            <div class="col-lg-10 col-md-10 col-sm-12">
                <textarea id="comments" class="form-control" name="comments" rows="5" cols="10" placeholder="Message"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label for="contactname" class="col-lg-2 col-md-2 col-sm-12 control-label text-right"><span class="required">*</span>Name</label>
            <div class="col-lg-10 col-md-10 col-sm-12">
                <input type="text" class="form-control" id="contactname" name="contactname" placeholder="Name">
            </div>
        </div>

        <div class="form-group">
            <label for="contactemail" class="col-lg-2 col-md-2 col-sm-12 control-label text-right"><span class="required">*</span>Email</label>
            <div class="col-lg-10 col-md-10 col-sm-12">
                <input type="email" class="form-control" id="contactemail" name="contactemail" placeholder="Email Address">
            </div>
        </div>

        <div class="form-group">
            <label for="contactphone" class="col-lg-2 col-md-2 col-sm-12 control-label text-right">Phone</label>
            <div class="col-lg-10 col-md-10 col-sm-12">
                <input type="phone" class="form-control" name="usertel" id="usertel" placeholder="Phone">
            </div>
        </div>

        <!--<div class="form-group">
            <label for="contactphone" class="col-sm-offset-2 col-sm-3 control-label text-right">Contact me</label>
            <div class="col-lg-6 col-md-6 col-sm-6">
                <input type="checkbox" class="form-control" id="contactrequested" name="contactrequested"><span>Contact me as soon as possible</span>
            </div>
        </div>-->

        <div class="form-group">
           
           <label for="contactphone" class="col-lg-2 col-md-2 col-sm-12 control-label text-right"></label>
            <div class="col-lg-10 col-md-10 col-sm-12 text-left">
                <input class="btn btn-primary request-kit popup left" type="submit" value="Submit">
            </div>
        </div>
        </div>
		<div class="col-lg-6 col-md-6 col-sm-12 left-align nopad"></div>
    </form>
    <div class="clearfix"></div>
</div>


<!--<div class="stylized myform">
    <form id="contact_form" name="contact_form" action="/feedback_thx.asp" method="post">
        <input type="hidden" id="feedbackkey" name="feedbackkey" value="<%=Session("feedbackkey")%>">
        <a name="create_form_error"></a>
        <div id="create_form_error"></div>
        <span class="stylized_label"><span class="required">*</span>Message Type
            <span class="small">&nbsp;</span>
        </span>
        <div class="input_container">
            <input type="radio" name="messagetype" id="tquestion" value="question" /><label for="tquestion">Question</label><br />
            <input type="radio" name="messagetype" id="tsuggestion" value="suggestion" /><label for="tsuggestion">Suggestion</label><br /> 
            <input type="radio" name="messagetype" id="tpraise" value="praise" /><label for="tpraise">Praise</label><br /> 
            <input type="radio" name="messagetype" id="tissue" value="issue" /><label for="tissue">Issue</label><br /> 
            <input type="radio" name="messagetype" id="tcomplaint" value="complaint" /><label for="tcomplaint">Complaint</label><br /> 
            <input type="radio" name="messagetype" id="wenquiry" value="website" /><label for="wenquiry">Website Enquiry</label><br /> 
            <input type="radio" name="messagetype" id="tproblem" value="problem" /><label for="tproblem">Problem</label><br /> 
        </div>
        <label for="subject" class="stylized_label"><span class="required">*</span>Subject
            <span class="small">&nbsp;</span>
        </label>
        <div class="input_container">
        <select class="stylized_input" name="subject" id="subject">
          <option value=""></option>
          <option value="How to List">How to List</option>
          <option value="The Exchange (NSX)">The Exchange (NSX)</option>
          <option value="Market Data">Market Data</option>
          <option value="Advisers">Advisers</option>
          <option value="Participant Brokers">Participant Brokers</option>
          <option value="General">General enquiry</option>
          <option value="The Web Site">Web Site enquiry</option>
          <option value="Fidelity Fund">Fidelity Fund</option>
          <option value="Compliance Committee">Compliance Committee</option>
          <option value="More Information">More Information</option>
          <option value="Privacy">Privacy</option>
          <option value="Other">(Other - please specify)</option>
        </select>
        <div id="other_desc" style="display:none;" >
          <input class="stylized_input" type="text" name="subjectother" id="subjectother" alt="Other" maxlength="200" value="" />
        </div>
        </div>

        <label for="comments" class="stylized_label"><span class="required">*</span>Comments
        <span class="small">&nbsp;</span>
        </label>
        <div class="input_container">
        <textarea id="comments" name="comments" rows="5" cols="10">
        </textarea></div>

        <label for="contactname" class="stylized_label"><span class="required">*</span>Name
        <span class="small">&nbsp;</span>
        </label>
        <div class="input_container">
        <input class="stylized_input" type="text" name="contactname" id="contactname" alt="Your name" maxlength="100" value="" />
        </div>

        <label for="contactemail" class="stylized_label"><span class="required">*</span>Email
        <span class="small">&nbsp;</span>
        </label>
        <div class="input_container">
        <input class="stylized_input" type="text" name="contactemail" id="contactemail" alt="Your email address" maxlength="255" value="" />
        </div>

        <label for="usertel" class="stylized_label">Phone Number
        <span class="small">&nbsp;</span>
        </label>
        <div class="input_container">
        <input class="stylized_input" type="text" name="usertel" id="usertel" alt="Your phone number" maxlength="20" value="" />
        </div>

        <label for="contactrequested" class="stylized_label">Contact Me
            <span class="small">&nbsp;</span>
        </label>
        <div class="input_container">
            <input type="checkbox" class="checkbox" id="contactrequested" name="contactrequested" /><label for="contactrequested">Contact me as soon as possible.</label>
        </div>

        <input class="stylized_button" type="submit" value="Send">
        <div class="spacer"></div>
    </form>
</div>
-->

</div>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->