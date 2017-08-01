<%
function isleapyear(xx)
yy = xx mod 4
isleapyear = false
if yy = 0 then isleapyear = true else isleapyear = false
' special case for centuries
if right(xx,2) = "00" then
	yy = xx mod 400
	if yy = 0 then isleapyear = true else isleapyear = false
end if
end function

for i = 1 to 200
yr = 2000 + i
response.write yr & " " & isleapyear(yr) & "<br>"
next

%>
