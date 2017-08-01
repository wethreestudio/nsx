<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<%CHECKFOR = "CSX" 

MerchID = Session("MerchID")
if len(MerchID)=0 then
	MerchID = request("MerchID")
end if
if len(MerchID)=0 then 
	Session("errmsg")="Logon Expired. Please logon on."
	response.redirect "default.asp"
end if

%>
<!--#INCLUDE FILE="admin/merchtools.asp"-->
<!--#INCLUDE FILE="member_check.asp"-->
<% 
' save organisation to file
Response.Buffer = "True" 
nsxcode = ucase(session("nsxcode")) 

errmsg=""

Set ConnPasswords = Server.CreateObject("ADODB.Connection")
Set CmdEditUser = Server.CreateObject("ADODB.Recordset")
ConnPasswords.Open Application("nsx_WriterConnectionString")   
SQL = "SELECT * FROM codetails WHERE (nsxcode = '" & SafeSqlParameter(nsxcode) & "')"
CmdEditUser.Open SQL, ConnPasswords, 1, 3
CmdEditUser.Fields("agweb0") = InsertAP(Request.Form("agweb0"))
CmdEditUser.Fields("agweb1") = InsertAP(Request.Form("agweb1"))
CmdEditUser.Fields("agweb2") = InsertAP(Request.Form("agweb2"))
CmdEditUser.Fields("agweb3") = InsertAP(Request.Form("agweb3"))
CmdEditUser.Fields("agweb4") = InsertAP(Request.Form("agweb4"))
CmdEditUser.Fields("agweb5") = InsertAP(Request.Form("agweb5"))
CmdEditUser.Fields("agweb6") = InsertAP(Request.Form("agweb6"))
CmdEditUser.Fields("agweb7") = InsertAP(Request.Form("agweb7"))
CmdEditUser.Fields("agweb8") = InsertAP(Request.Form("agweb8"))
CmdEditUser.Fields("agweb9") = InsertAP(Request.Form("agweb9"))
CmdEditUser.Fields("agemail0") = InsertAP(Request.Form("agemail0"))
CmdEditUser.Fields("agemail1") = InsertAP(Request.Form("agemail1"))
CmdEditUser.Fields("agemail2") = InsertAP(Request.Form("agemail2"))
CmdEditUser.Fields("agemail3") = InsertAP(Request.Form("agemail3"))
CmdEditUser.Fields("agemail4") = InsertAP(Request.Form("agemail4"))
CmdEditUser.Fields("agemail5") = InsertAP(Request.Form("agemail5"))
CmdEditUser.Fields("agemail6") = InsertAP(Request.Form("agemail6"))
CmdEditUser.Fields("agemail7") = InsertAP(Request.Form("agemail7"))
CmdEditUser.Fields("agemail8") = InsertAP(Request.Form("agemail8"))
CmdEditUser.Fields("agemail9") = InsertAP(Request.Form("agemail9"))
CmdEditUser.Fields("agNature") = InsertAP(Request.Form("agNature"))
CmdEditUser.Fields("agbuild") = InsertAP(Request.Form("agbuild"))
CmdEditUser.Fields("aglevel") = InsertAP(Request.Form("aglevel"))
CmdEditUser.Fields("agaddress") = InsertAP(Request.Form("agaddress"))
CmdEditUser.Fields("agstate") = Request.Form("agstate")
CmdEditUser.Fields("agcountry") = InsertAP(Request.Form("agcountry"))
CmdEditUser.Fields("agcity") = InsertAP(Request.Form("agcity"))
CmdEditUser.Fields("agsuburb") = InsertAP(Request.Form("agsuburb"))
CmdEditUser.Fields("agpcode") = InsertAP(Request.Form("agpcode"))
CmdEditUser.Fields("agpobox") = InsertAP(Request.Form("agpobox"))
CmdEditUser.Fields("agposuburb") = InsertAP(Request.Form("agposuburb"))
CmdEditUser.Fields("agpopcode") = InsertAP(Request.Form("agpopcode"))
CmdEditUser.Fields("agstrapline") = InsertAP(Request.Form("agstrapline"))
CmdEditUser.Fields("agphone") = InsertAP(Request.Form("agphone"))
CmdEditUser.Fields("agfax") = InsertAP(Request.Form("agfax"))

' officer details
'CmdEditUser.Fields("agChairman") = InsertAP(Request.Form("agChairman"))
'CmdEditUser.Fields("agMD") = InsertAP(Request.Form("agMD"))
'CmdEditUser.Fields("agSecretary") = InsertAP(Request.Form("agSecretary"))
'CmdEditUser.Fields("agDirectors") = InsertAP(Request.Form("agDirectors"))

' corporate details
'CmdEditUser.Fields("agacn") = InsertAP(Request.Form("agacn"))
'CmdEditUser.Fields("agabn") = InsertAP(Request.Form("agabn"))
'CmdEditUser.Fields("agPactivities") = InsertAP(Request.Form("agPactivities"))
'CmdEditUser.Fields("agregistry") = Request.Form("agregistry")
CmdEditUser.Fields("agbankers") = InsertAP(Request.Form("agbankers"))
'CmdEditUser.Fields("agbrokers") = InsertAP(Request.Form("agbrokers"))
'CmdEditUser.Fields("agadvisers") = InsertAP(Request.Form("agadvisers"))
'CmdEditUser.Fields("agfacilitators") = InsertAP(Request.Form("agfacilitators"))
CmdEditUser.Fields("agsolicitors") = InsertAP(Request.Form("agsolicitors"))
CmdEditUser.Fields("agaccountants") = InsertAP(Request.Form("agaccountants"))
'CmdEditUser.Fields("agtrustee") = InsertAP(Request.Form("agtrustee"))

'profile details
CmdEditUser.Fields("agwho") = InsertAP(Request.Form("agwho"))


CmdEditUser.Fields("RecordDateStamp") = Now()
CmdEditUser.Fields("RecordChangeUser") = Session("USERNAME")

CmdEditUser.Update
CmdEditUser.Close
Set CmdEditUser = Nothing
ConnPasswords.Close
Set ConnPasswords = Nothing
Response.Redirect "company_edit_co_details.asp" %>