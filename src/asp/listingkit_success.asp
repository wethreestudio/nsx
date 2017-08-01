<!--#INCLUDE FILE="include_all.asp"-->
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<%

return_url = Request.QueryString("ret")
goodreturl = true
If instr(return_url,"<Script") > 0 or instr(return_url,"<") > 0 or instr(return_url,">") > 0 or instr(return_url,".nsx") = 0 Then
	spammsg = spammsg & " Treat this message as potential SPAM. returnurl3. Includes potential script."
	return_url = "https://www.nsx.com.au"
	goodreturl = false
End If

'Response.Redirect "/marketdata/prices"

'Response.End

page_title = "Listing Kit Requested"
' meta_description = ""
' alow_robots = "no"
' objJsIncludes.Add "marketdata", "js/marketdata.js"
' objCssIncludes.Add "marketdata", "css/marketdata.css"
%>
<!--#INCLUDE FILE="header.asp"-->

<div class="hero-banner subpage <%= hero_banner_class %>">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Listing Kit Request</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="container_cont">
                <div class="editarea">
                    <h1>Listing Kit Requested</h1>
                    <p>
                    The National Stock Exchange of Australia greatly appreciates that you took some time to request a Listing Kit. We will contact you shortly to discuss your requirements.
                    </p>
                    <p>
                    Please <a href="<%
if goodreturl then 
response.write return_url
else 
response.write "https://www.nsx.com.au"
end if
%>">click here</a> to return to your previous page.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--#INCLUDE FILE="footer.asp"-->