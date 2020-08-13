<!--- b2_authorize_account --->
<cfset request.b2_authorize_account=structNew()/>
<cfhttp method="get" url="https://api.backblazeb2.com/b2api/v2/b2_authorize_account" result="request.b2_authorize_account" username="#application.accesskeyid#" password="#application.awssecretkey#"></cfhttp>

<cfdump var="#request.b2_authorize_account#">

<cfset content=request.b2_authorize_account>
<cfset authdata=deserializeJson(content.filecontent)>
<cfdump var="#authdata.accountId#">
<cfdump var="#authdata.apiUrl#">
<cfdump var="#authdata.authorizationToken#">

<!--- b2_list_buckets --->
<cfset request.b2_list_buckets=structNew()/>
<cfhttp method="get" url="#authdata.apiUrl#/b2api/v2/b2_list_buckets" result="request.b2_list_buckets">
<cfhttpparam name="accountId" value="#authdata.accountId#">
<cfhttpparam type="header" name="Authorization" value="#authdata.authorizationToken#"></cfhttp>

<cfdump var="#request.b2_list_buckets#">

<!--- b2_list_file_names --->
<cfset buckets=request.b2_list_buckets>
<cfset bucketData=deserializeJson(buckets.filecontent)>
<cfdump var="#bucketData.buckets[1].bucketId#">

<cfset request.b2_list_buckets=structNew()/>
<cfhttp method="get" url="#authdata.apiUrl#/b2api/v2/b2_list_file_names" result="request.b2_list_buckets">
<cfhttpparam name="bucketId" value="#bucketData.buckets[1].bucketId#">
<cfhttpparam type="header" name="Authorization" value="#authdata.authorizationToken#"></cfhttp>

<cfdump var="#request.b2_list_buckets#">
