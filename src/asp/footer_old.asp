<!-- begin footer.asp -->

</div><!-- /end container -->

<footer class="footer">
     <div class="subfooter-back">
         <div class="container subfooter-cont">
             <div class="row">
                 <div class="col-lg-12 col-md-12">
                     <h3>Categories</h3>
                     <ul class="sub-footer-links">
                         <li><a href="#">Investing</a></li>
                         <li><a href="/companies_pre_listed/why_list">Listing</a></li>
                         <li><a href="/investors/find_a_broker">Trading</a></li>
                         <li><a href="/marketdata/company_search">Data</a></li>
                         <li><a href="/">Login</a></li>
                     </ul>
                 </div>
             </div>
        </div>
    </div>
    <div class="container lower-footer">
        <div class="row">
            <div class="footer-bottom-cont">
                <div class="col-sm-8 footer-left">
                    <span>© Copyright <%=Year(Now())%> National Stock Exchange of Australia</span> <span class="spacer">ABN: 01 333 666 999</span>
                </div>
                <div class="col-sm-3 footer-right">
                    <a href="/privacy.asp">PRIVACY</a> <a target="_blank" href="/tc.asp">LEGAL</a>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
 </footer>

<!--
    <footer class="footer1">
		<div class="container subfooter-cont">
			<div class="row">
				<div class="col-lg-3 col-md-3">
					<ul class="list-unstyled clear-margins">
						<li class="widget-container widget_nav_menu">
						<h3>Services</h3>
							<ul>
								<li><a href="/companies_pre_listed/why_list">List</a></li>
								<li><a href="/investors/find_a_broker">Trade</a></li>
								<li><a href="/marketdata/company_search">Data</a></li>
								<li><a href="https://<%=Request.ServerVariables("SERVER_NAME")%>/makepayment.asp">Payments</a></li>
							</ul>
						</li>
					</ul>
				</div>
			    <div class="col-lg-3 col-md-3">
				    <ul class="list-unstyled clear-margins">
					    <li class="widget-container widget_nav_menu">
					    <h3>About</h3>
						    <ul>
							    <li><a href="/about/history">History</a></li>
							    <li><a href="/about/board_and_management">Board & Management</a></li>
							    <li><a href="/about/nsx_reports">Reports</a></li>
							    <li><a href="/about/governance">Governance</a></li>
							    <li><a href="/about/complaints_procedures">Complaints & Procedure</a></li>
							    <li><a href="/about/contact_us">Contact Us</a></li>
						    </ul>
					    </li>
				    </ul>
			    </div>
		    </div>
        </div>
	</footer>
    <div class="footer-bottom">
        <div class="container">
             <div class="row">
                 <div class="footer-bottom-cont">
                     <div class="col-sm-4">
                         <div class=""><img src="/images/footer_logo.png"/></div>
                     </div>
                     <div class="col-sm-8">
                         <div class="footer-links">
                             <span>© Copyright <%=Year(Now())%> National Stock Exchange of Australia Limited ('NSX') ABN 11 000 902 063</span> <a href="/tc.asp">TERMS OF USE</a> <a target="_blank" href="/privacy.asp">PRIVACY STATEMENT</a>
                         </div>
                     </div>
                 </div>
             </div>
        </div>
    </div>
	-->

<script type="text/javascript">
$(document).ready(function () {
    $("#request-btn").click(function(){ $('div#Listing-PopUp').animate({opacity: 'toggle'}, 'slow');});
    $('#ret').val(encodeURI(document.URL));
  $("#listingkitform").validate({ 
	 errorPlacement: function(error, element) {
      error.insertBefore($(element).parent());
    },       
    rules: {
      name: "required",
      email: { required: true, email: true } 
    },
    messages: {
	  name: {
		required: "Your name is required",
	  },
      email: {
        required: "Your email address is required",
        email: "Email address seems to be incorrect"
      }               
    },
    errorElement: "div",
	errorClass:"listingformerror"
  });        
});
</script>
<script type="text/javascript">
$(document).ready(function () {
	$("#request-btn-banner").click(function(){ $('div#Listing-PopUp').animate({opacity: 'toggle'}, 'slow');});
	$('#ret').val(encodeURI(document.URL));

    $("#listingkitform").validate({ 
	 errorPlacement: function(error, element) {
      error.insertBefore($(element).parent());
    },       
    rules: {
      name: "required",
      email: { required: true, email: true } 
    },
    messages: {
	  name: {
		required: "Your name is required",
	  },
      email: {
        required: "Your email address is required",
        email: "Email address seems to be incorrect"
      }               
    },
    errorElement: "div",
	errorClass:"listingformerror"
  });        
});
</script>


<div id="Listing-PopUp" class="nsx-sprite;" style="display:none;">
<form id="listingkitform" action="/request_listing_kit.asp" method="post">
    <div id="Listing-PopUp-body">
        <a id="close" class="nsx-sprite" onclick="$('#Listing-PopUp').fadeOut();" href="javascript:void(0)"> </a>
        <p id="title">List on the market of choice for innovative<br /> and growth companies!</p>
        <p id="txt">Listing is easier and far less expensive than you might think. Enter your Name and Email address and we will send you a Listing Kit or call you.</p>
        <div id="pop-up-logo" class="nsx-sprite"></div>
        <ul id="Pop-up-list">
        	<li><span class="nsx-sprite"></span>Simple Rules</li>
            <li><span class="nsx-sprite"></span>Tailored listing criteria</li>
            <li><span class="nsx-sprite"></span>Low costs</li>
            <li><span class="nsx-sprite"></span>Help offered at every step</li>
        </ul>
        <div class="clear"></div>
		
		<input type="hidden" value="<%=Now()%>" name="fax" id="fax">
			<input type="hidden" name="ret" id="ret" value="">
        <!-- fieldset -->
		<div class="fieldset">
        	<div class="row">
            	<div class="left">
                    <label class="nsx-sprite required name left" for="name">&nbsp;</label>
                    <input id="name" name="name" class="left" type="text" placeholder="Your Name (required)">
                </div>
                <div class="right">
                    <label class="nsx-sprite phone left"  for="phone">&nbsp;</label>
                    <input id="phone" name="phone" type="text" placeholder="Your Phone (optional)">
                </div>
            	<div class="clear"></div>	
            </div>
            <div class="row">
            	<div class="left">
                    <label class="nsx-sprite required mail left" for="email">&nbsp;</label>
                    <input id="email" name="email" type="text" placeholder="Your Email (required)">
                </div>
                <div class="right">
                    <label class="nsx-sprite company left"  for="company">&nbsp;</label>
                    <input id="company" name="company" type="text" placeholder="Your Company (optional)">
                </div>
                <div class="clear"></div>
            </div>
        	<button id="get-list" type="submit" class="btn btn-default">Get Listing Kit</button>
		</div>
        <!-- /fieldset -->
        <p id="call">Or Call <strong>NSX</strong> on <span>+61 (02) 4921 2430</span></p>
    </div>
    </form>
</div>	
	
</body>
</html>
<%
  DBDisconnect()
%>