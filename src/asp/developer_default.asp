<!--#INCLUDE FILE="include_all.asp"-->
<%
lap = 1
cl = array("#EEEEEE","#FFFFFF")
	lap = (-lap)+1
%>
<!--#INCLUDE FILE="header.asp"-->
<div class="container_cont">
<div class="editarea">
  <div class="table-responsive"><table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1" bgcolor="#FFFFFF">
    <tr>
      <td class="plaintext" colspan="2" bgcolor="#FFFFFF">
      
        <h1>NETS DEVELOPER HOME PAGE</h1>
      
      </td>
    </tr>
    <tr>
      <td class="plaintext" valign="top"><!--#INCLUDE FILE="lmenu.asp"--></td>
      <td class="plaintext" valign="top">
      
		<h2>Who this page is for?</h2>
		<p align="justify">This page is designed for developers wishing to interact with NSX 
		data feeds.&nbsp; You will find the latest version of the Trader 
		Workstation and Feed API's that are available.&nbsp; Releases include 
		documentation for each feed.&nbsp; The interfaces cover the NSXA, SIM 
		VSE and SPSE (Fiji) markets.</p>
		<div class="table-responsive"><table border="0" width="100%" id="table4" cellspacing="1" cellpadding="2">
  <tr >
				<td class="plaintext" width="80%" nowrap>
				<h2>Trader Workstation - Graphical User Interface </h2>
				</td>
				<td class="plaintext" width="10%">
				<p align="center"><b>Click to download</b></td>
				<td class="plaintext" width="10%">
				<p align="right"><b>Size</b></td>
			</tr>
  <tr  bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="80%" nowrap>Release 1.1.5 - Windows (live version) - June 2009</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/tw%20release%201-1-5/NSX-TW-1-1-5.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				6.50mb</td>
			</tr>
  		</table></div>
		<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
		<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
		<div class="table-responsive"><table border="0" width="100%" id="table11" cellspacing="1" cellpadding="2">
  <tr >
				<td class="plaintext" width="50%" nowrap>
				<h2>NETS API - Windows - Release v1-1-17 - 23 March 2011<br>
				Visual Studio 2008 version</h2>
				</td>
				<td class="plaintext" width="30%" nowrap>
				<b>Description</b></td>
				<td class="plaintext" width="10%">
				<p align="center"><b>Click to download</b></td>
				<td class="plaintext" width="10%">
				<p align="right"><b>Size</b></td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext" width="50%" nowrap>
				<u>Full Message Set</u></td>
				<td class="plaintext" width="30%" nowrap>
				&nbsp;</td>
				<td class="plaintext" width="10%" align="center">
				&nbsp;</td>
				<td class="plaintext" width="10%" align="right">
				&nbsp;</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_examples_client.1-1-0.zip</td>
				<td class="plaintext" width="30%" nowrap>
				Documentation -&nbsp; <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-1-17/full/x_stream_client_sdk_examples_client.1-1-0.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				65kb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_WIN32_MSVC9client.1-1-0.zip</td>
				<td class="plaintext" width="30%" nowrap>
				Messages - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-1-17/full/x_stream_client_sdk_WIN32_MSVC9client.1-1-0.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				22mb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext" width="50%" nowrap>
				<u>OMX NSX Message Set</u></td>
				<td class="plaintext" width="30%" nowrap>
				&nbsp;</td>
				<td class="plaintext" width="10%" align="center">
				&nbsp;</td>
				<td class="plaintext" width="10%" align="right">
				&nbsp;</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_examples_client.1-1-0.zip</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset messages 
				documentation - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-1-17/omx%20nsx/x_stream_client_sdk_examples_client.1-1-0.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				65kb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'">
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_WIN32_MSVC9om_nsx.1-1-0.zip</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset messages - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-1-17/omx%20nsx/x_stream_client_sdk_WIN32_MSVC9om_nsx.1-1-0.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				15mb</td>
			</tr>
  		</table></div>
      	<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
		<div class="table-responsive"><table border="0" width="100%" id="table9" cellspacing="1" cellpadding="2">
  <tr >
				<td class="plaintext" width="50%" nowrap>
				<h2>NETS API - Windows - Release v1-1-4-2 - 21 May 2010<br>
				visual studio 2005 version - Discontinued</h2>
				</td>
				<td class="plaintext" width="30%" nowrap>
				<b>Description</b></td>
				<td class="plaintext" width="10%">
				<p align="center"><b>Click to download</b></td>
				<td class="plaintext" width="10%">
				<p align="right"><b>Size</b></td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_WIN32_msdev2005_om_nsx.1-0-6.zip</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset messages 
				documentation - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-0-6/windows%202005/x_stream_client_sdk_WIN32_msdev2005_om_nsx.1-0-6.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				9mb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_examples_client.1-0-6.zip</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset examples - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-1-4-2/x_stream_client_sdk_examples_client.1-0-6.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				63kb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_WIN32_msdev2005_client.1-0-6.zip</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset messages - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-0-6/windows%202005/x_stream_client_sdk_WIN32_msdev2005_client.1-0-6.zip">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				21mb</td>
			</tr>
		</table></div>
      	<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
		<div class="table-responsive"><table border="0" width="100%" id="table10" cellspacing="1" cellpadding="2">
			<tr>
				<td class="plaintext" width="50%" nowrap>
				<h2>NETS API - Linux - Release v1-1-4-2 - 3 Oct 2008</h2>
				</td>
				<td class="plaintext" width="30%" nowrap>
				<b>Description</b></td>
				<td class="plaintext" width="10%">
				<p align="center"><b>Click to download</b></td>
				<td class="plaintext" width="10%">
				<p align="right">&nbsp;<b>Size</b></td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_doc_om_nsx.1-0-6.tar.gz</td>
				<td class="plaintext" width="30%" nowrap>
				Full message set documentation</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-1-4-2/x_stream_client_sdk_doc_om_nsx.1-0-6.tar.gz">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				5mb</td>
			</tr>
  		</table></div>
		<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
		<div class="table-responsive"><table border="0" width="100%" id="table8" cellspacing="1" cellpadding="2">
			<tr>
				<td class="plaintext" width="50%" nowrap>
				<h2>NETS API - Linux - Release v1-0-6 - 27 July 2007</h2>
				</td>
				<td class="plaintext" width="30%" nowrap>
				<b>Description</b></td>
				<td class="plaintext" width="10%">
				<p align="center"><b>Click to download</b></td>
				<td class="plaintext" width="10%">
				<p align="right">&nbsp;<b>Size</b></td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_doc_om_nsx.1-0-6.tar.gz </td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset messages 
				documentation - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-0-6/linux/x_stream_client_sdk_doc_om_nsx.1-0-6.tar.gz">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				5mb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_examples_om_nsx.1-0-6.tar.gz</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset examples - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-0-6/linux/x_stream_client_sdk_examples_om_nsx.1-0-6.tar.gz">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				22kb</td>
			</tr>
  <tr bgcolor="<%=cl(lap)%>" onMouseOver="this.bgColor='#CCCCDD'" onmouseout="this.bgColor='<%=cl(lap)%>'"><%lap = (-lap)+1%>
				<td class="plaintext" width="50%" nowrap>
				x_stream_client_sdk_Linux_gnu_om_nsx.1-0-6.tar.gz</td>
				<td class="plaintext" width="30%" nowrap>
				NSX subset messages - <br>
				including order management</td>
				<td class="plaintext" width="10%" align="center">
				<a href="tw/api%20release%201-0-6/linux/x_stream_client_sdk_Linux_gnu_om_nsx.1-0-6.tar.gz">
				<img border="0" src="images/vendor_images/download_arrow.png" width="17" height="18"></a></td>
				<td class="plaintext" width="10%" align="right">
				5mb</td>
			</tr>
		</table></div>
		<h2>Accreditation for above APIs</h2>
		<p>New information vendors and developers of software are required to be 
		accredited for usage of the NETS API.&nbsp; Please see the following 
		document for more information:
		<a href="documents/developers/NSX%20NETS%20API%20Accreditation%20Procedure%20200708.pdf">
		NSX NETS API Accreditation Procedure.pdf</a></p>
		<h2>NETS FIX API</h2>
		<p align="justify">The NETS FIX API is based on version 4.4 of
		<a target="_blank" href="http://www.fixprotocol.org">FIX</a>.&nbsp; The 
		NETS FIX API can be used in place of the native API provided above.&nbsp; 
		Please note that the replacement is not complete as the FIX protocol 
		does not implement the full set of NETS API commands.&nbsp; However NSX 
		has mapped as much of the functionality that is required to manage 
		orders and execute trades.&nbsp; The NETS FIX API allows for 
		transmission of market data as well as management and and execution of 
		orders in real time.<p>Full documentation for FIX can be obtained from 
		the <a href="http://www.fixprotocol.org">FIX Protocol Organisation</a>.<p>
		NSX's implementation of version 4.4 FIX is available 
		<a href="/documents/developers/NSX%20Developers%20Guide%20FIX%2044lv07.pdf">here</a>.<h2>NSX Web 
		APIs</h2>
		<p>In addition to the Native and FIX APIs, NSX provides access to its 
		market data via Web based APIs.&nbsp; These APIs encompass</p>
		<ul>
			<li>Current Price and Trade Summary</li>
			<li>Market Depth by security</li>
			<li>Company Announcements</li>
			<li>Daily Price History</li>
			<li>Monthly Price History</li>
			<li><a href="whatis_rss.asp">RSS feeds</a></li>
		</ul>
		<p align="justify">Web based APIs are useful for web developers to 
		incorporate NSX trading data on listed company websites.&nbsp; For 
		example, an NSX listed company wishing to report its trading data on its 
		own website in its own display format.&nbsp; Announcement and Daily 
		price history are also available.&nbsp; Daily price histories are useful 
		for those wishing to create charts or analysis tables for the selected 
		security.&nbsp; For Further information please <a href="feedback2.asp">
		contact us</a>.</p>
		<h2>About NETS</h2>
		<p>NETS is the NSX Electronic Trading System and is based on software 
		provided by NASDAQ OMX.<p>&nbsp;
      </td>
    </tr>
  </table></div>
</div>
</div>
<!--#INCLUDE FILE="footer.asp"-->
