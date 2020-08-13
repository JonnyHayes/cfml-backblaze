/**
* backblaze.cfc
* Copyright 2020 Jonathan Hayes
* Licensed under MIT (https://github.com/jonnyhayes/backblaze.cfc/blob/master/LICENSE)
*/


component output="false" displayname="backblaze.cfc"  {

    public struct function b2_authorize_account(username="username",password="password"){
      // b2_authorize_account https://www.backblaze.com/b2/docs/b2_authorize_account.html
      request.b2_authorize_account = structNew();
      http method="get" url="https://api.backblazeb2.com/b2api/v2/b2_authorize_account" result="request.b2_authorize_account" username="#username#" password="#password#";

      var content = request.b2_authorize_account;
      var authdata = deserializeJson(content.filecontent);
      return authdata;

    }
    public struct function b2_list_buckets(apiUrl="apiUrl",authorizationToken="authorizationToken",accountId="accountId")  {
        // b2_list_buckets https://www.backblaze.com/b2/docs/b2_list_buckets.html
        request.b2_list_buckets = structNew();
        http method="get" url="#apiUrl#/b2api/v2/b2_list_buckets" result="request.b2_list_buckets" {
            httpparam name="accountId"  value="#accountId#";
            httpparam type="header" name="Authorization"  value="#authorizationToken#";
        }
        var buckets = request.b2_list_buckets;
        var bucketData = deserializeJson(buckets.filecontent);
        return bucketData;

    }

    public struct function b2_list_file_names(apiUrl="apiUrl",authorizationToken="authorizationToken",bucketId="bucketId",startFileName="startFileName", clipName="clipName" ,fullFilePath="fullFilePath")  {
        // b2_list_file_names https://www.backblaze.com/b2/docs/b2_list_file_names.html
        request.b2_list_file_names = structNew();
        http method="get" url="#apiUrl#/b2api/v2/b2_list_file_names" result="request.b2_list_file_names" {
            httpparam name="bucketId"  value="#bucketId#";
            httpparam type="header" name="Authorization"  value="#authorizationToken#";
            httpparam name="maxFileCount"  value="500";
             // httpparam name="startFileName"  value="#startFileName#";
            httpparam name="prefix"  value="#fullFilePath#";
        }
        var files = request.b2_list_file_names;
        var filesData = deserializeJson(files.filecontent);

        return filesData;

    }

    public void function b2_download_file_by_name(apiUrl="apiUrl",authorizationToken="authorizationToken",filesDownloadAuth="filesDownloadAuth",downloadUrl="downloadUrl", bucketName="bucketName",fileName="fileName", shortName="shortName")  {
        // b2_download_file_by_name https://www.backblaze.com/b2/docs/b2_download_file_by_name.html
        cfcookie(name="fileDownload", value="true", expires="now"); // special cookie used by jquery fileDownload plugin
        cfheader(name="Content-Disposition", value="attachment; filename=#shortName#");
        cfheader(name="Content-Type", value="application/force-download");
        cfheader(name="Content-Type", value="application/octet-stream");
        cfheader(name="Content-Type", value="application/download");
        cfcontent(type="*/*", file="#downloadUrl#/file/#bucketName#/#fileName#?Authorization=#authorizationToken#");

    }



    public struct function b2_download_file_by_id(apiUrl="apiUrl",authorizationToken="authorizationToken",filesDownloadAuth="filesDownloadAuth",downloadUrl="downloadUrl", bucketName="bucketName",fileId="fileId",uri="uri")  {

        // b2_download_file_by_name https://www.backblaze.com/b2/docs/b2_download_file_by_name.html
        request.b2_download_file_by_id = structNew();
        http method="get" url="#apiUrl#/b2api/v2/b2_download_file_by_id" result="request.b2_download_file_by_id" {
            httpparam name="fileId"  value="#fileId#";
            httpparam type="header" name="Authorization"  value="#authorizationToken#";
        }
        var oneFile = request.b2_download_file_by_id;
        // fileData = deserializeJson(oneFile.filecontent);
        return oneFile;
    }


    public struct function b2_get_download_authorization(apiUrl="apiUrl",authorizationToken="authorizationToken",bucketId="bucketId",fileNamePrefix="fileNamePrefix")  {
        // b2_get_download_authorization https://www.backblaze.com/b2/docs/b2_get_download_authorization.html
        request.b2_get_download_authorization = structNew();
        http method="get" url="#apiUrl#/b2api/v2/b2_get_download_authorization" result="request.b2_get_download_authorization" {
            httpparam name="bucketId"  value="#bucketId#";
            httpparam name="validDurationInSeconds"  value="60";
            httpparam name="fileNamePrefix"  value="private";
            httpparam type="header" name="Authorization"  value="#authorizationToken#";
        }
        file = request.b2_get_download_authorization;
        fileData = deserializeJson(file.filecontent);
        return fileData;

    }

}
