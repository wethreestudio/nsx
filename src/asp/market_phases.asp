<!--#INCLUDE FILE="include_all.asp"-->
<%
page_title = "Market Phases"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "marketdata", "js/marketdata.js"
objCssIncludes.Add "marketdata", "css/marketdata.css"

%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
  <table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1"
  bgcolor="#FFFFFF">
    <tr>
      <td colspan="2" bgcolor="#FFFFFF">
        <h1>Market Phases</h1>
      </td>
    </tr>
    <tr>
      <td valign="top">
        <!--#INCLUDE FILE="lmenu.asp"-->
      </td>
      <td valign="top">
        <p>The following table outlines the market phases for NSX trading hours. All times are
        Australian Eastern Standard Time.</p>
        <h2>Market Phases Table</h2>
        
        <table align="center" cellpadding="5"
        style="border-bottom:1px solid #666666; border-collapse: collapse" width="100%"
        id="table2">
          <tr>
            <th style="background-color:#666666; color:#ffffff;" width="240">Market Phase</th>
            <th style="background-color:#666666; color:#ffffff;">Time</th>
            <th style="background-color:#666666; color:#ffffff;">Description</th>
            <th style="background-color:#666666; color:#ffffff;" align="right" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right"
              alt="" />
            </th>
          </tr>
          <tr>
            <td>
              <b>Start of Day Enquiry (enq)</b>
            </td>
            <td align="center" nowrap="nowrap">02:30 - 03:00</td>
            <td align="left">
              Market is visible for viewing access only. Enquiry mode.
            </td>
            <td align="right" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td bgcolor="#EEEEEE">
              <b>Pre-Open (pre)</b>
            </td>
            <td align="center" bgcolor="#EEEEEE">03:00 - 10:00</td>
            <td align="left" bgcolor="#EEEEEE">
              Orders may be entered, amended or withdrawn during this period but
              no matching takes place. Overnight crossings must be reported.
            </td>
            <td align="right" bgcolor="#EEEEEE" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td>
              <b>Normal (nml)</b>
            </td>
            <td align="center">10:00 - 16:00</td>
            <td align="left">Trading commences. Orders may be entered, amended or
            withdrawn during this period. Orders are matched on entry.</td>
            <td align="right" valign="top">
            <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" /></td>
          </tr>
          <tr>
            <td bgcolor="#EEEEEE">
              <b>Pre-Open prior to Closing (cls)</b>
            </td>
            <td align="center" bgcolor="#EEEEEE">16:00 - 16:04</td>
            <td align="left" bgcolor="#EEEEEE">The market is placed in Pre-open
            again. Orders can still be entered, amended and withdrawn but no matching takes
            place.</td>
            <td align="right" bgcolor="#EEEEEE" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td>
              <b>Closing Single Price Auction (nml)</b>
            </td>
            <td align="center">16:04 - 16:05</td>
            <td align="left">
              <span lang="EN-AU">Orders may be entered, amended and withdrawn but will now be
              automatically matched prior to closing.</span>
            </td>
            <td align="right" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td bgcolor="#EEEEEE">
              <b>Closing (cls)</b>
            </td>
            <td align="center" bgcolor="#EEEEEE">16:05 - 16:10</td>
            <td align="left" bgcolor="#EEEEEE">
              <span lang="EN-AU">This session is for market adjustment after trading ends. Orders
              can still be entered, amended or withdrawn however no matching occurs. Crossings
              must be reported.</span>
            </td>
            <td align="right" bgcolor="#EEEEEE" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td>
              <b>After Hours Adjust (aha)</b>
            </td>
            <td align="center">16:10 - 16:15</td>
            <td align="left">Orders can no longer be entered, however they can still be
              withdrawn and amended (but only to reduce quantity). Crossings must be
              reported.
            </td>
            <td align="right" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td bgcolor="#EEEEEE">
              <b>End of Day Enquiry (enq)</b>
            </td>
            <td align="center" bgcolor="#EEEEEE">16:15 - 23:00</td>
            <td align="left" bgcolor="#EEEEEE">Market is visible for viewing access only.</td>
            <td align="right" bgcolor="#EEEEEE" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF">
              <b>Shutdown</b>
            </td>
            <td align="center" bgcolor="#FFFFFF">23:00 - 02:30</td>
            <td align="left" bgcolor="#FFFFFF">System is not accessible. System Maintenance.</td>
            <td align="right" bgcolor="#FFFFFF" valign="top">
              <img border="0" src="images/nsxdiag.gif" width="22" height="11" align="right" alt="" />
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--#INCLUDE FILE="footer.asp"-->