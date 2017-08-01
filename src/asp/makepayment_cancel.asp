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

%>
<!--#INCLUDE FILE="header.asp"-->

<div class="container_cont">
<div class="user_content"> 
<div class="editarea">
<h1>Payment Cancelled</h1>
<p>Your payment request has been cancelled.
</p>

</div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->



