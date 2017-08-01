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

<div id="sidemenu">
  <ul class="menu">
    <!--li><a href="nsx_press_service1.asp">NSX PRESS Services</a></li-->
    <li><a href="listing_rules_and_notes.asp">Listing Rules &amp; Notes</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="trading_options_standard.asp">Listing Rules</a></li>
          <li><a href="trading_options_closed_market.asp">Practice Notes</a></li>
        </ul>
      </div>
    </li>
    <li><a href="why_nsx.asp">Administration</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="trading_options_standard.asp">About Sponsoring Brokers</a></li>
          <li><a href="trading_options_closed_market.asp">About Nominated Advisers</a></li>
          <li><a href="trading_options_closed_market.asp">Waivers</a></li>
        </ul>
      </div>    
    </li>
    <li><a href="ways_to_list.asp">Fees</a></li>
    <li><a href="migrate_from_asx.asp">FAQs</a></li>
    <li><a href="migrate_from_asx.asp">Company Forms</a></li>
    <li><a href="migrate_from_asx.asp">NSX-Listed Logo</a></li>
    <li><a href="migrate_from_asx.asp">Company Admin Login</a></li>
  </ul>
</div> 