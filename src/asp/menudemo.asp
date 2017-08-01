<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Menu Demo"
' meta_description = ""
alow_robots = "no"         
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<style type="text/css" media="screen">
.menu{
  padding:0px;
  width:180px;
}  

.menu li{
  min-height:35px;
  line-height:35px; 
  padding-left:8px;
  /*padding-right:8px;*/
  background-image:url('/img/vertical_menu_node.png');
  background-repeat:repeat-x;
  font-size:12px;
} 

.menu li a {
  color: #025390;
  text-decoration: none;
  text-shadow: 1px 1px 1px #FFFFFF;  
} 

.menu li a:hover {
  color: #024372;
  text-decoration: bold;
  text-shadow: 1px 1px 1px #FFFFFF;  
}
    
    
div.demo {
    background: none repeat scroll 0 0 #66AAFF;
    margin: 1em;
    padding: 20px;
    width: 18em;
}    
     
</style>
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
 
 
 
 
<div class="container_cont">  
<div id="sidemenu">
  <ul class="menu">
    <li><a href="#">Why List?</a></li>
    <li><a href="#">Why NSX?</a></li>
    <li><a href="#">NSX PRESS Service</a></li>
    <li><a href="#">Ways to List</a></li>
    <li><a href="#">Migrate From ASX</a></li>
    <li><a href="#">Trading Options</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="#">Standard</a></li>
          <li><a href="#">Closed Market</a></li>
          <li><a href="#">Trading Windows</a></li>
        </ul>
      </div>
    </li>
    <li><a href="#">Case Studies</a></li>
    <li><a href="#">Listing Process</a></li>
    <li><a href="#">Rules &amp; Notes</a>
      <div class="sidesub" style="display:none;">
        <ul style="padding-left:5px;">
          <li><a href="#">Listing Rules</a></li>
          <li><a href="#">Practice Notes</a></li>
        </ul>
      </div>
    </li>
    <li><a href="#">Sponsoring Broker List</a></li>
    <li><a href="#">Fees</a></li>
    <li><a href="#">FAQ</a></li>
    <li><a href="#">Brochures</a></li>
  </ul>
</div> 

  
  
</div>
<!--#INCLUDE FILE="footer.asp"-->