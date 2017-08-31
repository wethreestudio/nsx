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
				            <button id="request-btn-2" class="btn btn-default" href="#" onclick="_gaq.push(['_trackEvent', 'ListingKit', 'PopupClick', 'companies_pre_listed'])" data-toggle="modal" data-target="#Listing-PopUp">Get listed</button>
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
$(document).ready(function () {
    $('#ret').val(encodeURI(document.URL));
    $("#listingkitform").validate({ 
	 errorPlacement: function(error, element) {
      error.insertAfter($(element));
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

<div class="modal fade" tabindex="-1" role="dialog" id="Listing-PopUp">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title">Talk to us about our IPO process</h3>
              </div>
              <form id="listingkitform" action="/request_listing_kit.asp" method="post" novalidate>
              <div class="modal-body">
   		        <input type="hidden" value="<%=Now()%>" name="fax" id="fax">
                <input type="hidden" name="ret" id="ret" value="/companies_pre_listed/why_list/">
                
    	        <div class="form-group">
        	        <label class="control-label required name" for="name">FULL NAME</label>
                    <input id="name" name="name" class="valid" type="text" placeholder="">
                </div>
                <div class="form-group">
                    <div for="email" generated="true" class="listingformerror" style="display: none;">Email address seems to be incorrect</div>
                    <label class="required mail control-label" for="email">EMAIL</label>
                    <input id="email" name="email" type="text" placeholder="" class="valid">
                </div>
                <div class="form-group">
                    <label class="required phone control-label" for="phone">PHONE</label>
                    <input id="phone" name="phone" type="text" placeholder="" class="valid">
                </div>
                <div class="form-group">
                    <label class="company control-label" for="company">COMPANY</label>
                    <input id="company" name="company" type="text" placeholder="" class="valid">
                </div>
            </div>
            <div class="modal-footer">
                <button id="get-list" type="submit" class="btn btn-primary request-kit popup">Start now</button>
            </div>
            </form>
        </div>
    </div>
</div>
	
</body>
</html>
<%
  DBDisconnect()
%>