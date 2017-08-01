<script type="text/javascript">
/* $(document).ready(function() {
  $('.menu').corner("5px;cc:#FFF");
  $('.demo').corner("20px");
  $('.menu li a').click(function() {
    if ($(this).parent().has('.sidesub').length){
      $(this).parent().find('.sidesub').first().slideToggle('slow');
      return false; 
    }
    //location.href=$(this).attr('href');
  });  
}); */
</script>
XXX
<%
menu = Request.QueryString("menu")

If menu = "about" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/about_nsx">About NSX</a></li>
    <li><a href="<%=menu%>/history">History</a></li>
    <li><a href="<%=menu%>/nsx_news">NSX News</a></li>
    <li><a href="<%=menu%>/nsx_announcements">NSX Announcements</a></li>
    <li><a href="<%=menu%>/board_and_management">Board &amp; Management</a></li>
    <li><a href="<%=menu%>/nsx_reports">NSX Reports</a></li>
    <li><a href="<%=menu%>/governance">Governance</a></li>
    <li><a href="<%=menu%>/complaints_procedure">Complaints &amp; Procedures</a></li>
    <li><a href="<%=menu%>/contact_us">Contact Us</a></li>
  </ul>
</div>
<%
End If
If menu = "services" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/lvm_hosting_service">LVM Hosting Service</a></li>
    <li><a href="<%=menu%>/exchange_hosting_service">Exchange Hosting Service</a></li>
    <li><a href="<%=menu%>/marketing">Marketing</a></li>
  </ul>
</div>
<%
End If
If menu = "marketdata" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/company_search">Company Search &amp; Information</a></li>
    <li><a href="<%=menu%>/market_summary">Market Summary</a></li>
    <li>Official List
      <div class="sidesub" >
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/prices_list">Prices List</a></li>
          <li><a href="<%=menu%>/a_to_z_list">Official A-Z List</a></li>
        </ul>
      </div>    
    </li>
    <li>Announcements
      <div class="sidesub" >
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/search_by_company">Search By Company</a></li>
          <li><a href="<%=menu%>/market_list">Market List</a></li>
        </ul>
      </div>    
    </li>
    <li>NSX Indexes
      <div class="sidesub" >
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/prices">Prices</a></li>
          <li><a href="<%=menu%>/constituents">Constituents</a></li>
          <li><a href="<%=menu%>/definitions">Definitions</a></li>
        </ul>
      </div>    
    </li>    
    <li><a href="<%=menu%>/statistics">Statistics</a></li>
    <li><a href="<%=menu%>/weekly_event_reports">Weekly Event Reports</a></li>
    <li>Delisted &amp; Suspended Securities
      <div class="sidesub" >
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/suspended">Suspended</a></li>
          <li><a href="<%=menu%>/delisted">Delisted</a></li>
        </ul>
      </div> 
    </li>
  </ul>
</div>
<%
End If
If menu = "investors" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/find_a_broker">Find a Broker</a></li>
    <li><a href="<%=menu%>/company_search">Company Search &amp; Information</a></li>
    <li><a href="<%=menu%>/new_floats_ipos_and_issues">New Floats, IPOs &amp; Issues</a></li>
    <li><a href="<%=menu%>/inv_why_nsx">Why NSX</a></li>
    <li><a href="<%=menu%>/how_do_i_trade">How do I trade</a></li>
    <li><a href="<%=menu%>/security_types_listed_on_nsx">Security Types Listed on NSX</a></li>
    <li><a href="<%=menu%>/trading_hours_and_calendar">Trading Hours &amp; Calendar</a></li>
    <li><a href="<%=menu%>/trading_and_settlement_process">Settlement Process</a></li>
    <li><a href="<%=menu%>/mobile_apps_and_widgets">Mobile Apps &amp; Widgets</a></li>
  </ul>
</div>
<%
End If
If menu = "brokers_new" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/why_nsx">Why NSX?</a></li>
    <!-- li><a href="<%=menu%>/services_for_brokers">Services For Brokers</a></li -->
    <li><a href="<%=menu%>/application_process">Application Process</a></li>
    <li>Accessing NSX
      <div class="sidesub" >
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/overview">Overview</a></li>
          <li><a href="<%=menu%>/nsx_nets">NSX Nets</a></li>
          <li><a href="<%=menu%>/third_party_software">Third Party Software</a></li>
        </ul>
      </div>    
    </li>
    <li><a href="<%=menu%>/trading_and_settlement_process">Settlement Process</a></li>
    <li><a href="<%=menu%>/rules_and_notes">Rules &amp; Notes</a></li>
    <li><a href="<%=menu%>/fees">Fees</a></li>
    <li><a href="<%=menu%>/brochure_and_application_kit">Brochure &amp; Application Kit</a></li>
    <li><a href="<%=menu%>/nsx_broker_logo">NSX Broker Logo</a></li>
  </ul>
</div>
<%
End If
If menu = "brokers_existing" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/broker_aids">Broker Benefits</a></li>
    <!-- li><a href="<%=menu%>/services_for_brokers">Services For Brokers</a></li -->
    <li><a href="<%=menu%>/data_providers">Data Providers</a></li>
    <li><a href="<%=menu%>/broker_supervision">Broker Supervision</a></li>
    <li><a href="<%=menu%>/broker_list">Broker List</a></li>
    <li><a href="<%=menu%>/rules_and_notes">Rules &amp; Notes</a></li>
    <li><a href="<%=menu%>/be_fees">Fees</a></li>
    <li><a href="<%=menu%>/broker_forms">Broker Forms</a></li>
    <li><a href="<%=menu%>/broker_admin_login">Broker Admin Login</a></li>
    <li><a href="<%=menu%>/nsx_broker_logo">NSX Broker Logo</a></li>
  </ul>
</div>
<%
End If
If menu = "advisers_new" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/an_why_nsx">Why NSX?</a></li>
    <li><a href="<%=menu%>/what_is_an_adviser">What is an Adviser</a></li>
    <li><a href="<%=menu%>/adv_application_process">Application Process</a></li>
    <li><a href="<%=menu%>/adv_fees">Fees</a></li>
    <li><a href="<%=menu%>/ad_brochure_and_application_kit">Brochure &amp; Application Kit</a></li>
    <li><a href="<%=menu%>/nsx_adviser_logo">NSX Adviser Logo</a></li>
  </ul>
</div>
<%
End If
If menu = "advisers_existing" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/ae_why_nsx">Why NSX?</a></li>
    <!--li><a href="<%=menu%>/services_for_advisers">Services For Advisers</a></li-->
    <li><a href="<%=menu%>/adviser_list">Adviser List</a></li>
    <li><a href="<%=menu%>/adviser_forms">Adviser Forms</a></li>
    <li><a href="<%=menu%>/adv_fees">Fees</a></li>
    <li><a href="<%=menu%>/nsx_adviser_logo">NSX Adviser Logo</a></li>
  </ul>
</div>
<%
End If
If menu = "companies_listed" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <!-- li><a href="<%=menu%>/listed_nsx_press_service">NSX PRESS Services</a></li -->
    <li><a href="<%=menu%>/listing_rules_and_notes">Listing Rules &amp; Notes</a></li>
    <li>Administration
      <div class="sidesub" >
        <ul style="padding-left:5px;">
          <li><a href="<%=menu%>/about_sponsoring_brokers">About Sponsoring Brokers</a></li>
          <li><a href="<%=menu%>/about_nominated_advisors">About Nominated Advisers</a></li>
          <li><a href="<%=menu%>/waivers">Waivers</a></li>
        </ul>
      </div>    
    </li>
    <li><a href="<%=menu%>/comp_fees">Fees</a></li>
    <!-- li><a href="<%=menu%>/comp_faqs">FAQs</a></li -->
    <li><a href="<%=menu%>/company_forms">Company Forms</a></li>
    <li><a href="<%=menu%>/nsx-listed_logo">NSX-Listed Logo</a></li>
    <!-- li><a href="<%=menu%>/company_admin_login">Company Admin Login</a></li -->
  </ul>
</div>
<%
End If
If menu = "companies_pre_listed" Then
%>
<div id="sidemenu">
  <ul class="menu">
    <li><a href="<%=menu%>/why_list">Why List?</a></li>
    <li><a href="<%=menu%>/cpl_why_nsx">Why NSX?</a></li>
    <!-- li><a href="<%=menu%>/nsx_press_service">NSX PRESS Service</a></li -->
    <li><a href="<%=menu%>/ways_to_list">Ways to List</a></li>
    <li><a href="<%=menu%>/migrate_from_asx">Migrate From ASX</a></li>
    <li><a href="<%=menu%>/trading_options_standard">Trading Options</a></li>
    <li><a href="<%=menu%>/case_studies">Case Studies</a></li>
    <li><a href="<%=menu%>/listing_process">Listing Process</a></li>
    <li><a href="<%=menu%>/listing_rules">Rules &amp; Notes</a></li>
    <li><a href="<%=menu%>/sponsoring_broker_list">Sponsoring Broker List</a></li>
    <li><a href="<%=menu%>/comp_fees">Fees</a></li>
    <li><a href="<%=menu%>/comppl_faq">FAQ</a></li>
    <li><a href="<%=menu%>/brochures">Brochures</a></li>
  </ul>
</div> 
<%
End If
%> 