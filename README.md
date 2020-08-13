# cfml-backblaze 
This is a port of the BackBlaze API to use with Lucee (and Adobe CF). 
See https://www.backblaze.com/b2/docs/b2_authorize_account.html

Usage:
Clone the repo, change the variables in Application.cfc for your account 
 
{   application.accesskeyid= "your_accesskeyID";
    application.awssecretkey= "your_awssecretkey";
}

and

{
  "aws": {
    "region": "us-west-000",
    "bucket": "backblazeb2.com",
    "accessID": "your_accessID",
    "secretKey": "your_secretKey"
  }
}

Fire up a Luccee instance with CommandBox -:  
box server start

Open the browser on the Lucee port and go to (change the port for your env):
http://127.0.0.1:55635/example/index.cfm

Enjoy all the goodeness BackBlaze gives you. 
Peace and things.

:D
