<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TEMPLATE 1</title>

<script src="shadedborder/shadedborder.js" type="text/javascript"></script>
<link href="css/simvse_style.css" rel="stylesheet" type="text/css" media="screen" />
</head>

<body>
<div id="wrap">

<div id="sbanner"><a href="#"><img src="images/ad_sample.gif" alt="Ad Sample" border="0" target="_blank" /></a></div>
<div id="sticker"><%
    session("region")=""
    server.execute "ticker2.asp"
    %></div>
<div id="stitle">
    <div id="simlogo"><img src="images/simvse.gif" border="0" alt="SIM VSE" /></div>
    <div id="search"><form><input type="text" name="Search" class="searchinput" value="Search for prices" onfocus="if
(this.value==this.defaultValue) this.value='';" /> <input type="image" src="images/search_but.gif" name="submit" /></form>

<form><input type="text" name="Search" class="searchinput" value="Search for companies" onfocus="if
(this.value==this.defaultValue) this.value='';" /> <input type="image" src="images/search_but.gif" name="submit" /></form></div>
</div>
<div id="simmenu">MENU</div>
<div id="simcontent">Content for  id "content" Goes Here</div>
<div class="simmain">
  <div class="simpromo" id="simpromo">
 	<img src="images/dedicatedstockexchange.jpg" width="615" height="205" hspace="5" vspace="6"  />
  </div>
  <div class="simleft">
    <div id="mdata_a">
    <img src="images/marketdata.gif" alt="market data" width="297" height="21" hspace="5" vspace="4" border="0" />
      <ul class="mdata">
        <li><a href="#">Official List /</a> view our list of Cleantech companies available for trading.</li>
        <li><a href="#">New issues & floats /</a> see the next offers coming to market.</li>
        <li><a href="#">Recent issues & floats /</a> see the latest securities available for trading.</li>
      </ul>
      <p class="more"><img src="images/more.gif" width="44" height="16" /></p>
    </div>
    <div id="mdata_b"> <img src="images/marketdata_rev.gif" alt="market data" width="297" height="21" hspace="5" vspace="4" border="0" />
      <p>GRAPH</p>
      <p class="more"><img src="images/more.gif" width="44" height="16" /></p>
    </div>
    <div id="mdata_c">
    <img src="images/marketdata_rev.gif" alt="market data" width="297" height="21" hspace="5" vspace="4" border="0" />
      <ul class="mdata">
        <li><a href="#">Official List /</a> view our list of Cleantech companies available for trading.</li>
        <li><a href="#">New issues & floats /</a> see the next offers coming to market.</li>
        <li><a href="#">Recent issues & floats /</a> see the latest securities available for trading.</li>
      </ul>
      <p class="more"><img src="images/more.gif" width="44" height="16" /></p>
    </div>
  </div>
  <div class="simcenter">
    <div id="trd_a">
    <img src="images/tradersbrokers.gif" alt="traders and brokers" width="297" height="21" hspace="5" vspace="4" border="0" />
      <ul class="mdata">
        <li><a href="#">How to trade</a> as a Private Investor or Broker.</li>
        <li><a href="#">Becoming a Broker</a> the why and how to.</li>
        <li><a href="#">Existing Brokers</a> view our directory of SIM VSE Brokers</li>
      </ul>
      <p class="more"><img src="images/more_lg.gif" width="43" height="16" /></p>
    </div>
    <div id="comp_a">
    <img src="images/companies.gif" alt="companies and advisors" width="297" height="21" hspace="5" vspace="4" border="0" />
      <ul class="mdata">
        <li><a href="#">Considering Listing /</a> A stock exchange dedicated solely to the Cleantech sector, SIM VSE is tailored to meet the specific needs of the Cleantech sector.</li>
        <li><a href="#">How to list /</a> A straight forward outline of the process of listing.</li>
        <li><a href="#">International Companies /</a> A global hub for Cleantech investment, SIM VSE welcomes listings from all over the world.</li>
      </ul>
      <p class="more"><img src="images/more_lg.gif" width="43" height="16" /></p> 
    </div>
    <div id="priv_a">
    <img src="images/privateinvestors.gif" alt="private investors" width="297" height="21" hspace="5" vspace="4" border="0" />
      <ul class="mdata">
        <li><a href="#">How to trade /</a> Your access to the market.</li>
        <li><a href="#">Find a Broker /</a> An easy to use search for a SIM VSE Broker.</li>
      </ul>
      <p class="more"><img src="images/more_lg.gif" width="43" height="16" /></p> 

    </div>
  </div>
</div>
<div class="simright">
	<div id="announ_a">
    <img src="images/announcements.gif" alt="announcements" width="296" height="21" hspace="5" vspace="4" border="0" />
      <ul class="announ" >
        <li><span class="announ-date">26 July 2010</span><a href="#">AUS companies joining the Main market raise over $1 billion in July.</a></li>
        <li><span class="announ-date">25 July 2010</span><a href="#">London Stock Exchange to add new private investor price promotion.</a></li>
        <li><span class="announ-date">24 July 2010</span><a href="#">Senior hire and Board changes to strengthen LSEG Post Trade.</a></li>
        
      </ul>
      <p class="more"><img src="images/more_lg.gif" width="43" height="16" /></p> 
    </div>
	<div id="news_a">
    <img src="images/newscleantech.gif" alt="news / cleantech" width="296" height="21" hspace="5" vspace="4" border="0" />
        <div class="subnews">
			<a href="#"><img src="images/sample_news.jpg" alt="NEWS" class="floatLeft" /><span class="newsheading">SEDOL</span> <span class="newsdesc">eum iriure dolor in</span></a>
        </div>
        <div class="subnews">
			<a href="#"><img src="images/sample_news.jpg" alt="NEWS" class="floatLeft" /><span class="newsheading">SEDOL</span> <span class="newsdesc">eum iriure dolor in</span></a>
        </div>
        <div class="subnews">
			<a href="#"><img src="images/sample_news.jpg" alt="NEWS" class="floatLeft" /><span class="newsheading">SEDOL</span> <span class="newsdesc">eum iriure dolor in</span></a>
        </div>
      <p class="more"><img src="images/more_lg.gif" width="43" height="16" /></p> 
    </div>
	<div id="tools_a">
    <img src="images/tools.gif" alt="tools and services" width="296" height="21" hspace="5" vspace="4" border="0" />
      <ul class="announ">
        <li><span class="announ-date">Tools Heading Here</span><a href="#">AUS companies joining the Main market raise over $1 billion in July.</a></li>
        <li><span class="announ-date">Services Heading Here</span><a href="#">London Stock Exchange to add new private investor price promotion.</a></li>
      </ul>
      <p class="more"><img src="images/more_lg.gif" width="43" height="16" /></p>
      </div>
</div>
<div id="footer">
    <div id="footera">
    	<p>SIM VSE</p>
        <p class="simfooterdesc">SIM VSE is an equity capital market that was launched in 2007. Focused solely on cleantech investment opportunities, SIM VSE has no constraints on size of market or size of company to list.</p>
    </div>
    <div id="footerb"><p>Comapnies & Issuers</p>
    	<ul>
            <li><a href="#">SIM VSE Listing</a></li>
            <li><a href="#">Regulation</a></li>
            <li><a href="#">Benefits of Listing</a></li>
            <li><a href="#">Listing Fees</a></li>
        </ul>
        </div>
    <div id="footerc"><p>Investors & Brokers</p>
        <ul>
            <li><a href="#">Clean Tech</a></li>
            <li><a href="#">Becoming a Trader</a></li>
            <li><a href="#">Regulations</a></li>
            <li><a href="#">Broker Login</a></li>
        </ul>
        </div>
    <div id="footerd"><p>Market Information</p>
        <ul>
            <li><a href="#">SIM VSE Overview</a></li>
            <li><a href="#">Delayed Prices</a></li>
            <li><a href="#">Live Announcements</a></li>
            <li><a href="#">Market Publications</a></li>
        </ul>
        </div>
    <div id="footere"><p>News & Press</p>
        <ul>
            <li><a href="#">SIM VSE Listing</a></li>
            <li><a href="#">Regulation</a></li>
            <li><a href="#">Benefits of Listing</a></li>
            <li><a href="#">Listing Fees</a></li>
        </ul>
        </div>
    <div id="footerf"><p>More</p>
        <ul>
            <li><a href="#">About SIM VSE</a></li>
            <li><a href="#">Contact Us</a></li>
            <li><a href="#">Sitemap</a></li>
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Disclaimer</a></li>
        </ul>
        </div>
</div>
<div id="copyright">Copyright 2010 SIM VSE. All rights reserved.</div>
</div>


  <script language="javascript" type="text/javascript">
    var myBorder = RUZEE.ShadedBorder.create({ corner:1, shadow:4 });
    myBorder.render('announ_a');
	myBorder.render('mdata_a');
	myBorder.render('mdata_b');
	myBorder.render('mdata_c');
	myBorder.render('trd_a');
	myBorder.render('comp_a');
	myBorder.render('priv_a');
	myBorder.render('news_a');
	myBorder.render('tools_a');
	myBorder.render('simpromo');
  </script>

</body>
</html>
