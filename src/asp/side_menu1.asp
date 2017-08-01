<script type="text/javascript">
$(document).ready(function() {
  $('.menu').corner("10px;cc:#FFF");
  $('.demo').corner("20px");
  $('.menu li a').click(function() {
    if ($(this).parent().has('.sidesub').length){
      $(this).parent().find('.sidesub').first().slideToggle('slow');
      return false; 
    }
    location.href=$(this).attr('href');
  });  
}); 
</script>
<%
menu = Request.QueryString("menu")
Response.Write menu
respnose.end
If menu = "advisers_new" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/why_nsx">Why NSX?</a></li>
    <li><a href="<%=menu%>/what_is_an_adviser">What is an Adviser</a></li>
    <li><a href="<%=menu%>/services_for_advisers">Services For Advisers</a></li>
    <li><a href="<%=menu%>/application_process">Application Process</a></li>
    <li><a href="<%=menu%>/fees">Fees</a></li>
    <li><a href="<%=menu%>/brochure_and_application_kit">Brochure &amp; Application Kit</a></li>
    <li><a href="<%=menu%>/nsx_adviser_logo">NSX Adviser Logo</a></li>
  </ul>
</div>
<%
End If
If menu = "advisers_existing" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/why_nsx">Why NSX?</a></li>
    <li><a href="<%=menu%>/services_for_advisers">Services For Advisers</a></li>
    <li><a href="<%=menu%>/adviser_list">Adviser List</a></li>
    <li><a href="<%=menu%>/adviser_forms">Adviser Forms</a></li>
    <li><a href="<%=menu%>/fees">Fees</a></li>
    <li><a href="<%=menu%>/nsx_adviser_logo">NSX Adviser Logo</a></li>
  </ul>
</div>
<%
End If
If menu = "companies_listed" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <!--li><a href="<%=menu%>/nsx_press_service">NSX PRESS Services</a></li-->
    <li><a href="<%=menu%>/listing_rules_and_notes">Listing Rules &amp; Notes</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/listing_rules">Listing Rules</a></li>
          <li><a href="<%=menu%>/practice_notes">Practice Notes</a></li>
        </ul>
      </div>
    </li>
    <li><a href="<%=menu%>/administration">Administration</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/about_sponsoring_brokers">About Sponsoring Brokers</a></li>
          <li><a href="<%=menu%>/about_nominated_advisors">About Nominated Advisers</a></li>
          <li><a href="<%=menu%>/waivers">Waivers</a></li>
        </ul>
      </div>    
    </li>
    <li><a href="<%=menu%>/fees">Fees</a></li>
    <li><a href="<%=menu%>/faqs>FAQs</a></li>
    <li><a href="<%=menu%>/company_forms">Company Forms</a></li>
    <li><a href="<%=menu%>/nsx-listed_logo">NSX-Listed Logo</a></li>
    <li><a href="<%=menu%>/company_admin_login">Company Admin Login</a></li>
  </ul>
</div>
<%
End If
If menu = "companies_pre_listed" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/why_list">Why List?</a></li>
    <li><a href="<%=menu%>/why_nsx">Why NSX?</a></li>
    <!--li><a href="<%=menu%>/nsx_press_service">NSX PRESS Service</a></li-->
    <li><a href="<%=menu%>/ways_to_list">Ways to List</a></li>
    <li><a href="<%=menu%>/migrate_from_asx">Migrate From ASX</a></li>
    <li><a href="#">Trading Options</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/trading_options_standard">Standard</a></li>
          <li><a href="<%=menu%>/trading_options_closed_market">Closed Market</a></li>
          <li><a href="<%=menu%>/trading_options_windows">Trading Windows</a></li>
        </ul>
      </div>
    </li>
    <li><a href="<%=menu%>/case_studies">Case Studies</a></li>
    <li><a href="<%=menu%>/listing_process">Listing Process</a></li>
    <li><a href="#">Rules &amp; Notes</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/listing_rules">Listing Rules</a></li>
          <li><a href="<%=menu%>/practice_notes">Practice Notes</a></li>
        </ul>
      </div>
    </li>
    <li><a href="<%=menu%>/sponsoring_broker_list">Sponsoring Broker List</a></li>
    <li><a href="<%=menu%>/fees">Fees</a></li>
    <li><a href="<%=menu%>/faq">FAQ</a></li>
    <li><a href="<%=menu%>/brochures">Brochures</a></li>
  </ul>
</div> 
<%
End If
%> 