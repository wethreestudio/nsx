<!--#INCLUDE FILE="include_all.asp"-->
<%

Dim form_action
Dim invoice_number
Dim invoice_amount

invoice_number = Server.HTMLEncode(Request.Form("item_name"))
invoice_amount = Server.HTMLEncode(Request.Form("amount"))

form_action = "https://www.paypal.com/cgi-bin/webscr"
' form_action = "makepayment.asp"

page_title = "Make Payment"
alow_robots = "no"
objJsIncludes.Add "validate_js", "js/jquery.validate.js"


objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"

%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript">
$(document).ready(function () {

	$.validator.addMethod(
		"regex",
		function(value, element, regexp) {
			var re = new RegExp(regexp);
			return this.optional(element) || re.test(value);
		},
		"Please check your input."
	);

	$("#ppform").validate({ 
		errorPlacement: function(error, element) {
			error.insertBefore(element);
		},         
		rules: {
			item_name: { required: true, regex: /^([0-9]+\,?)*$/},
			amount: { required: true, regex: /^[0-9]+(\.[0-9][0-9])?$/, min: 0.01 },
		},
		messages: {
			item_name: { 
				required: "Please enter the invoice/reference number for this payment",
				regex: "Please use a valid invoice number. Separate multiple invoices using a comma"
			},
			amount: {
				required: "Please enter an amount for this payment",
				regex: "Amount must be in the format 0.00 without the dollar symbol",
				min: "The minimum amount is 0.01"
			}
		},
		errorElement: "div",
		submitHandler: function(form) {
			/*var amount = $('#invoice_amount').val();
			var handling;
			handling = 0.03 * amount;
			$('#handling').val(handling.toFixed(2));*/
			form.submit();
        }
  });        
});
</script>


<div class="container_cont">
<div class="user_content"> 
<div class="editarea">
<h1>Send a Payment to the National Stock Exchange of Australia Limited.</h1>
<h3>('NSX') ABN 11 000 902 063</h3>
<p>For your convenience the NSX has enabled invoice payment via Credit Card with PayPal as the service payment provider.  This means that you can use your PayPal account or if you don't have an account then you can use your credit card directly.  </p>
<p>To use your credit card please select the "Pay with a credit or debit card" option when you are transferred to the PayPal service. </p>
<p>Please enter your invoice number or payment reference number and the payment amount below then click "Send Payment". You will then be redirected to the PayPal site where PayPal will collect further information (Credit Card details) needed to complete the payment. 
</p>
<form name="_xclick" id="ppform" action="<%=form_action%>" method="post">
	<input type="hidden" name="cmd" value="_xclick">
	<input type="hidden" name="return" value="https://www.nsx.com.au/makepayment_success.asp">
	<input type="hidden" name="cancel_return" value="https://www.nsx.com.au/makepayment_cancel.asp">
	<input type="hidden" name="business" value="accounts@nsx.com.au">
	<input type="hidden" name="currency_code" value="AUD">
	<!-- input type="hidden" name="handling" id="handling" value="0" -->
	<table id="myTable" class="tablesorter">
		<tr>
			<td style="width:180px"><label for="invoice_number"><b>Invoice number</b></label></td>
			<td><input type="text" id="invoice_number" name="item_name" value="<%=invoice_number%>"></td>
		</tr>
		<tr>
			<td><label for="invoice_amount"><b>Amount (AUD)</b></label></td>
			<td><input type="text" id="invoice_amount" name="amount" value="<%=invoice_amount%>"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" border="0" name="submit" id="send_click" value="Send Payment" alt="Pay your NSX invoice by Credit Card"></td>
		</tr>
<tr><td colspan="2"><small>Notes: A 3% handling fee is automatically added to all Credit Card and PayPal payments. </small></td></tr>		
	</table>
	
</form>
</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->



