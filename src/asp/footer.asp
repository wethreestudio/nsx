<!-- begin footer.asp -->

</div><!-- /end container -->

<footer class="footer">
    <div class="subfooter-back">
        <div class="container subfooter-cont">
            <div class="row">
              
                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 footer-col1">
                    <div class="footer-listing-box">
              	        <img class="" src="images/footer/iStock-474486151.jpg">
              	        <div class="footer-listing-button">
				            <button id="request-btn-2" class="btn btn-default" href="javascript:void(0);" onclick="_gaq.push(['_trackEvent', 'ListingKit', 'PopupClick', 'companies_pre_listed'])">Get listed</button>
				        </div>
                    </div>
		        </div>
              
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 footer-col2">
                    <h3>NSX MARKET</h3>
                     <ul class="sub-footer-links">
                         <li><a href="/listing/why-list-with-us/">Why List with Us</a></li>
                         <li><a href="/listing/getting-started/">Getting Started</a></li>
                         <li><a href="/investing/upcoming-listings/">Upcoming Listings</a></li>
                         <li><a href="/investing/recent-listings/">Recent Listings</a></li>
                         <li><a href="/marketdata/market-summary/">Market Summary</a></li>
                     </ul>
                     <div class="clearfix"></div>
                </div>
                
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 footer-col3">
					<h3><a href="/about/our-business/">ABOUT NSX</a></h3>
                    <ul class="sub-footer-links">
                        <li><a href="/about/our-business/">Our Business</a></li>
                        <li><a href="/about/governance/">Governance</a></li>
                        <li><a href="/about/investor-relations/">Investor Relations</a></li>
                        <li><a href="/about/media-centre/">Media Centre</a></li>
                        <li><a href="/about/contact-us/">Contact us</a></li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                
            </div>
        </div>
    </div>
    <div class="container lower-footer">
        <div class="row">
            <div class="footer-bottom-cont">
                <div class="col-sm-8 footer-left">
                    <span>&copy; Copyright <%=Year(Now())%> </span><span>National Stock Exchange of Australia</span> <span class="spacer"><i style="display:none;">-</i>ABN 11 000 902 063</span>
                </div>
                <div class="col-sm-3 footer-right">
                    <a href="/privacy.asp">Privacy</a> <a target="_blank" href="/tc.asp">Legal</a>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</footer>

<script type="text/javascript">
	
	
	//var titleVal = $("h1").text();
	//console.log(titleVal);
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
	
$(document).ready(function () {
    $("#request-btn-2").click(function(){ $('div#Listing-PopUp').animate({opacity: 'toggle'}, 'slow');});
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
    <form id="listingkitform" action="/request_listing_kit.asp" method="post" novalidate>

    <div class="col-lg-4 col-md-4 col-sm-8 col-xs-12 popup-holder" style="margin: auto auto;float: none">
        <a id="close" class="nsx-sprite" onclick="$('#Listing-PopUp').fadeOut();" href="javascript:void(0)"><i class="fa fa-times-circle" aria-hidden="true"></i></a>
        <div id="Listing-PopUp-body">
            <!--<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 popup-left">
                <h2>Listing is easier than you think. The market of choice for innovative and growth companies!</h2>
                <p>Many companies are seeking a listing exchange that is customer focused, flexible, responsive, innovative, helpful and offers real value for money.</p>
                <ul id="Pop-up-list">
        	        <li>Simple Rules</li>
                    <li>Tailored listing criteria</li>
                    <li>Low costs</li>
                    <li>Help offered at every step</li>
                </ul>
                <p>or call <strong>02 8378 6400</strong></p>
                <div class="clearfix"></div>
            </div>-->
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                
                <h2>Talk to us about our IPO process</h2>
		        <input type="hidden" value="<%=Now()%>" name="fax" id="fax">
                <input type="hidden" name="ret" id="ret" value="/companies_pre_listed/why_list/">
                
		        <div class="fieldset" style="padding:15px;">
        	        <div class="row">
            	        <div class="">
                            <label class="required name" for="name">FULL NAME</label>
                            <input id="name" name="name" class="valid" type="text" placeholder="">
                        </div>
                    </div>
                    <div class="row">
                        <div for="email" generated="true" class="listingformerror" style="display: none;">Email address seems to be incorrect</div><div class="">
                            <label class="required mail" for="email">EMAIL</label>
                            <input id="email" name="email" type="text" placeholder="" class="valid">
                        </div>
                    </div>
                    <div class="row">
                        <div class="">
                            <label class="required phone" for="phone">PHONE</label>
                            <input id="phone" name="phone" type="text" placeholder="" class="valid">
                        </div>
                    </div>
                    <div class="row">
                        <div class="">
                            <label class="company" for="company">COMPANY</label>
                            <input id="company" name="company" type="text" placeholder="" class="valid">
                        </div>
                    </div>
        	        <button id="get-list" type="submit" class="btn btn-primary request-kit popup">Start now</button>
                    <div class="clearfix"></div>
		        </div>
                
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    </form>
</div>
	
</body>
</html>
<%
  DBDisconnect()
%>