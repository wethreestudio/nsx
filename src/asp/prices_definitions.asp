

<!--#INCLUDE FILE="mobile_redirect.asp"-->
<!--#INCLUDE FILE="include_all.asp"--><%
Response.CodePage = 65001
page_title = "NSX - National Stock Exchange of Australia"
meta_description = "Official site of the National Stock Exchange of Australia, the market of choice for growth style Australian and International companies."
meta_keywords = "NSX, equities, company floats, IPO, investing, brokers, listed companies, stock exchange, Newcastle NSW"
' alow_robots = "no"
objJsIncludes.Add "default_js", "/js/default.js"
objJsIncludes.Add "jquery_autocomplete_js", "/js/jquery.autocomplete.js"
' objCssIncludes.Add "jquery_autocomplete_css", "/css/jquery.autocomplete.css"

menu ="home"
page ="home"
%>
<!--#INCLUDE FILE="header.asp"-->
<%
Server.Execute "side_menu.asp"
%>

<!--TODO OWNINCLUDE FILE="hero_banner.asp"-->

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Definitions</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<%
Server.Execute "content_lower_nav.asp"
%>



<!--<div class="container_wrapper">--><!-- old container_wrapper-->     	
<div class="container subpage main-content">
<div class="editarea">    	

    	
<div class="f-w-table">
<div class="table-responsive"><table>
    <thead>
        <tr>
            <th colspan="5">
            <p>Glossary <span>of NSX terms and acronyms.</span></p>
            <img class="water-mark" alt="" src="/images/nsx-water-mark.png" /></th>
        </tr>
    </thead>
    <tfoot>
    <tr>
        <td colspan="5">&nbsp;</td>
    </tr>
    </tfoot>
    <tbody>
        <tr class="sub-header">
            <td align="left" width="110">Item</td>
            <td align="left">Definition</td>
        </tr>
        <tr class="alt">
            <td align="left">AEST</td>
            <td align="left">Australian Eastern Standard Time.</td>
        </tr>
        <tr>
            <td align="left">Name</td>
            <td align="left">The name of the company or security issuer trading on NSX</td>
        </tr>
        <tr class="alt">
            <td align="left">Code</td>
            <td align="left">The official NSX trading symbol. ASX codes and NSX codes are mutually exclusive. That is, no company trading on the NSX will have the same code as another company trading on the ASX.</td>
        </tr> 
        <tr>
            <td align="left">Date/Time</td>
            <td align="left">The date and time for which the currently displayed data are applicable.  Time is Newcastle, Australia time which is the same as Australia Eastern Standard Time (AEST).</td>
        </tr> 
        <tr class="alt">
            <td align="left">Last Price</td>
            <td align="left">The last traded price for the day.  If there have been no trades for the day then the last traded price taken from the previous day.  If the security has never traded then the last price is the IPO price</td>
        </tr> 
        <tr>
            <td align="left">% Change</td>
            <td align="left">Percentage movement in the last price compared to the Open price for the day.</td>
        </tr>
        <tr class="alt">
            <td align="left">% Daily Change</td>
            <td align="left">Percentage movement in the last price compared to the previous day's last price.</td>
        </tr> 
        <tr>
            <td align="left">Bid</td>
            <td align="left">The last price at which a security was tendered for purchase.</td>
        </tr>
        <tr class="alt">
            <td align="left">Offer</td>
            <td align="left">The last price at which the security was tendered for sale.</td>
        </tr> 
        <tr>
            <td align="left">Status</td>
            <td align="left">The current trading status of each security.<br>
Blank = No messages, Active<br>
NR = Company Announcement Received<br>
TH = Trading Halt Imposed<br>
SU = Suspended<br>
XD = Ex Dividend<br>
XI = Ex-Interest
            </td>
        </tr>
        <tr class="alt">
            <td align="left">Open</td>
            <td align="left">The first traded price of the day.  If there has been no trades then open is the previous last traded price.</td>
        </tr> 
        <tr>
            <td align="left">High</td>
            <td align="left">The highest price at which a trade occurred during the day.</td>
        </tr>
        <tr class="alt">
            <td align="left">Low</td>
            <td align="left">The lowest price at which a trade occurred during the day.</td>
        </tr> 
        <tr>
            <td align="left">Volume</td>
            <td align="left">The cumulative volume traded for the day. </td>
        </tr>
        <tr class="alt">
            <td align="left">ANNA</td>
            <td align="left">
National Numbering Agencies in each member country have the responsibility for administering the international standards for ISIN (International Securities Identification Number) ISO 6166 and for CFI (Classification of Financial Instruments) ISO 10962 within their country.<br>
<b>Website:</b>&nbsp;<a href="http://www.anna-web.com">www.anna-web.com</a>
            </td>
        </tr> 
        <tr>
            <td align="left">ISIN</td>
            <td align="left">
The International Standards Organisation (ISO) has provided a standard (ISO 6166) for the numbering of securities. This standard is intended for use in any application in the trading and administration of securities.<br>

The international securities identification number (ISIN) is a code which uniquely identifies a specific securities' issue.<br>The ISIN consists of:<br>
<ul>
  <li>a prefix which is a 2-character alpha country code.  (e.g. AU for Australia)</li>
  <li>a 9-character code which identifies the security. (e.g. NSX Trading Symbol padded with leading zeros)</li>
  <li>a check character computed using the modulus 10 formula "Double-Add-Double" formula.</li>
</ul>
<br>
<b>Website:</b>&nbsp;<a href="http://www.iso.ch">www.iso.ch</a>           
            
            </td>
        </tr>                                                
        <tr class="alt">
            <td align="left">PE x</td>
            <td align="left">Price Earnings Ratio (times) - Last Price divided by Diluted Earnings Per Share (EPS).  Diluted EPS is as reported by the issuer as at the end of balance date.</td>
        </tr> 
        <tr>
            <td align="left">Div Yld %</td>
            <td align="left">Dividend Yield (as a percentage) - Annualised Dividend Per Share divided by the Last Price expressed as a percentage.  Dividend Per Share is as reported by the issuer.</td>
        </tr>
                         
                       
    </tbody>
</table></div>
</div>    	
    	

	</div>
	</div>
<!-- begin footer.asp -->

</div><!-- /end container -->



<!--#INCLUDE FILE="footer.asp"-->
