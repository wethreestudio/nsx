<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Feedback"
' meta_description = ""
alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->


<div class="container_cont">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" rowspan="2" bgcolor="#FFFFFF"><!--#INCLUDE FILE="lmenu.asp"--></td>
  </tr>
  <tr>
    <td class="plaintext" valign="top" bgcolor="#FFFFFF">
    
    


  <h1 align="left">FEEDBACK</h1>

<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="JavaScript" Type="text/javascript"><!--
function FrontPage_Form1_Validator(theForm)
{

  if (theForm.Username.value == "")
  {
    alert("Please enter a value for the \"Your Real Name\" field.");
    theForm.Username.focus();
    return (false);
  }

  if (theForm.Username.value.length < 5)
  {
    alert("Please enter at least 5 characters in the \"Your Real Name\" field.");
    theForm.Username.focus();
    return (false);
  }

  if (theForm.UserEmail.value == "")
  {
    alert("Please enter a value for the \"Valid E-Mail Address\" field.");
    theForm.UserEmail.focus();
    return (false);
  }

  if (theForm.UserEmail.value.length < 7)
  {
    alert("Please enter at least 7 characters in the \"Valid E-Mail Address\" field.");
    theForm.UserEmail.focus();
    return (false);
  }
  return (true);
}
//--></script><!--webbot BOT="GeneratedScript" endspan --><form METHOD="POST" ACTION="feedback_thx.asp" name="FrontPage_Form1" language="JavaScript" onsubmit="return FrontPage_Form1_Validator(this)">
  
    <h2>&nbsp;<font face="Arial" size="2">What kind of comment would you like to send?</font>
    </h2>
    <p>
    <input type="radio" name="MessageType" id="tquestion" value="Question" checked> <label for="tquestion">Question</label><br> 
    <input type="radio" name="MessageType" id="tsuggestion" value="Suggestion"> <label for="tsuggestion">Suggestion</label><br>  
    <input type="radio" name="MessageType" id="tpraise" value="Praise"> <label for="tpraise">Praise</label><br>
    <input type="radio" name="MessageType" id="tissue" value="Issue"> <label for="tissue">Issue</label><br>
    <input type="radio" name="MessageType" id="tcomplaint" value="Complaint"> <label for="tcomplaint">Complaint</label><br>
    <input type="radio" name="MessageType" id="tproblem" value="Problem"> <label for="tproblem">Problem</label><br>
    </p>
    <h2>&nbsp;<font face="Arial" size="2">What about us do you wish to comment
  on?</font>
    </h2>
    <dl>
      <dd><font face="Arial" size="2">
      <select name="Subject" size="1" style="border: 1 solid #6D7BA0;background-color:#EEEEEE">
      <option value="How to List">How to List</option>
      <option>the Exchange (NSX)</option>
      <option value="Market Data">Market Data</option>
		<option value="Advisers">Advisers</option>
		<option value="Facilitators">Facilitators</option>
		<option value="Participant Brokers">Participant Brokers</option>
      <option selected>General</option>
      <option>the Web Site</option>
      <option value="Fidelity Fund">Fidelity Fund</option>
      <option value="Compliance Committee">Compliance Committee</option>
      <option value="More Information">More Information</option>
      <option value="Privacy">Privacy</option>
      <option>(Other - please specify)</option></select><tt> </tt><b>other</b>: 
      <input type="text" size="20" maxlength="256" name="SubjectOther" style="border: 1 solid #6D7BA0;background-color:#EEEEEE">
      </font></dd>
    </dl>
    <h2>
    <font face="Arial" size="2">

Enter your comments,
  suggestions or feedback in the space
  provided below.</font>
    </h2>
    <dl>
      <dd><font face="Arial" size="2">
      <textarea name="Comments" rows="5" cols="30" style="border: 1px solid #6D7BA0;background-color:#EEEEEE"></textarea>
      </font></dd>
    </dl>
    <h2>
    <font face="Arial" size="2">

If you would like us to contact you then
  please tell us how to get in touch with you.&nbsp; <br>Please fill in your name and at
least one contact method.</font>
    </h2>
    <dl>
      <dd>
      <table border="0" cellpadding="0" width="70%" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
          <td width="20%" align="left" class="textlabel" bgcolor="#FFFFFF">Name&nbsp;&nbsp;</td>
          <td width="80%" bgcolor="#FFFFFF"><tt><font face="Arial" size="2">
          <!--webbot bot="Validation" s-display-name="Your Real Name" b-value-required="TRUE" i-minimum-length="5" --><input type="text" size="20" name="Username" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"><img border="0" src="images/dotgold.gif" width="11" height="11">
          </font></tt></td>
        </tr>
        <tr>
          <td width="11%" align="left" class="textlabel" bgcolor="#FFFFFF">E-mail&nbsp;&nbsp;</td>
          <td width="89%" bgcolor="#FFFFFF"><tt><font face="Arial" size="2">
          <!--webbot bot="Validation" s-display-name="Valid E-Mail Address" b-value-required="TRUE" i-minimum-length="7" --><input type="text" size="20" name="UserEmail" style="border: 1 solid #6D7BA0;background-color:#EEEEEE"><img border="0" src="images/dotgold.gif" width="11" height="11">
          </font></tt></td>
        </tr>
        <tr>
          <td width="11%" align="left" class="textlabel" bgcolor="#FFFFFF">Phone&nbsp;&nbsp;</td>
          <td width="89%" bgcolor="#FFFFFF"><tt><font face="Arial" size="2">
          <input type="text" size="20" maxlength="256" name="UserTel" style="border: 1 solid #6D7BA0;background-color:#EEEEEE">
          </font></tt></td>
        </tr>
      </table></dd>
    </dl>
    <dl>
      <dd><font face="Arial" size="2">
      <input type="checkbox" name="ContactRequested" value="Yes get back to them asap">
          Please contact me as soon as possible regarding
      this matter.
</font></dd>
    </dl>
    <div align="left">
		<h2><tt><font face="Arial" size="2">Items marked with 
        <img border="0" src="images/dotgold.gif" width="11" height="11">
        are mandatory.&nbsp; We need this information so that we can help you.</font></tt>
		</h2>
	</div>
    
      <p align="left"><font face="Arial" size="2">
      <input type="submit" value="Submit Comments">
      </font></p>
    
  
  <input type="hidden" name="recipient" value="support@nsxa.com.au"><input type="hidden" name="subject" value="NSX FEEDBACK"><input type="hidden" name="redirect" value="<%= Application("nsx_SiteRootURL") %>/thxfeed.htm">

	<input type="hidden" name="additionalcomments" value=" ">

</form>





    </td>
  </tr>
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->