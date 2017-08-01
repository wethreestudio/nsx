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
    <li><a href="why_list.asp">Why List?</a></li>
    <li><a href="why_nsx.asp">Why NSX?</a></li>
    <!--li><a href="nsx_press_service.asp">NSX PRESS Service</a></li-->
    <li><a href="ways_to_list.asp">Ways to List</a></li>
    <li><a href="migrate_from_asx.asp">Migrate From ASX</a></li>
    <li><a href="#">Trading Options</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="trading_options_standard.asp">Standard</a></li>
          <li><a href="trading_options_closed_market.asp">Closed Market</a></li>
          <li><a href="trading_options_windows.asp">Trading Windows</a></li>
        </ul>
      </div>
    </li>
    <li><a href="case_studies.asp">Case Studies</a></li>
    <li><a href="listing_process.asp">Listing Process</a></li>
    <li><a href="#">Rules &amp; Notes</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="listing_rules.asp">Listing Rules</a></li>
          <li><a href="practice_notes.asp">Practice Notes</a></li>
        </ul>
      </div>
    </li>
    <li><a href="sponsoring_broker_list.asp">Sponsoring Broker List</a></li>
    <li><a href="fees.asp">Fees</a></li>
    <li><a href="faq.asp">FAQ</a></li>
    <li><a href="brochures.asp">Brochures</a></li>
  </ul>
</div> 