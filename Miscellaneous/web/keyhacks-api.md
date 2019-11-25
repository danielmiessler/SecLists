<p align="center">
  <img src="https://user-images.githubusercontent.com/18099289/56750563-558a9400-6784-11e9-8175-ee2a19ee9d75.png" width="300px">
</p>
</br>

KeyHacks shows ways in which particular API keys found on a Bug Bounty Program can be used, to check if they are valid.

# Table of Contents

- [Algolia API key](#Algolia-API-key)
- [Asana Access token](#Asana-Access-Token)
- [AWS Access Key ID and Secret](#AWS-Access-Key-ID-and-Secret)
- [Bit.ly Access token](#Bitly-Access-token)
- [Branch.io Key and Secret](#BranchIO-Key-and-Secret)
- [Buildkite Access token](#Buildkite-Access-token)
- [DataDog API key](#DataDog-API-key)
- [Deviant Art Access Token](#Deviant-Art-Access-Token)
- [Deviant Art Secret](#Deviant-Art-Secret)
- [Dropbox API](#Dropbox-API)
- [Facebook Access Token  ](#Facebook-Access-Token)
- [Facebook AppSecret](#Facebook-AppSecret)
- [Firebase](#Firebase)
- [Github client id and client secret](#Github-client-id-and-client-secret)
- [GitHub private SSH key](#GitHub-private-SSH-key)
- [Github Token](#Github-Token)
- [Gitlab personal access token](#Gitlab-personal-access-token)
- [Google Cloud Messaging (GCM)](#Google-Cloud-Messaging)
- [Google Maps API key](#Google-Maps-API-key)
- [Google Recaptcha key](#Google-Recaptcha-key)

- [Heroku API key](#Heroku-API-key)
- [Instagram Access Token](#Instagram-Access-Token)
- [MailChimp API Key](#MailChimp-API-Key)
- [MailGun Private Key](#MailGun-Private-Key)
- [Mapbox API key](#Mapbox-API-Key)
- [Microsoft Azure Tenant](#Microsoft-Azure-Tenant)
- [Microsoft Shared Access Signatures (SAS)](#Microsoft-Shared-Access-Signatures-(SAS))
- [pagerduty API token](#pagerduty-API-token)
- [Paypal client id and secret key](#Paypal-client-id-and-secret-key)
- [Pendo Integration Key](#Pendo-Integration-Key)
- [Razorpay API key and secret key](#Razorpay-keys)
- [Salesforce API key](#Salesforce-API-key)
- [SauceLabs Username and access Key](#SauceLabs-Username-and-access-Key)
- [SendGrid API Token](#SendGrid-API-Token)
- [Slack API token](#Slack-API-token)
- [Slack Webhook](#Slack-Webhook)
- [Spotify Access Token](#Spotify-Access-Token)
- [Square](#Square)
- [Stripe Live Token](#Stripe-Live-Token)
- [Travis CI API token](#Travis-CI-API-token)
- [Twilio Account_sid and Auth token](#Twilio-Account_sid-and-Auth-token)
- [Twitter API Secret](#Twitter-API-Secret)
- [Twitter Bearer token](#Twitter-Bearer-token)
- [WakaTime API Key](#WakaTime-API-Key)
- [WPEngine API Key](#WPEngine-API-Key)
- [Zapier Webhook Token](#Zapier-Webhook-Token)
- [Zendesk Access token](#Zendesk-Access-Token)


# Detailed Information
## [Slack Webhook](https://api.slack.com/incoming-webhooks)

If the below command returns `missing_text_or_fallback_or_attachments`, it means that the URL is valid, any other responses would mean that the URL is invalid.
```
curl -s -X POST -H "Content-type: application/json" -d '{"text":""}' "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
```

## [Slack API token](https://api.slack.com/web)
```
curl -sX POST "https://slack.com/api/auth.test?token=xoxp-TOKEN_HERE&pretty=1"
```

## [SauceLabs Username and access Key](https://wiki.saucelabs.com/display/DOCS/Account+Methods)
```
curl -u USERNAME:ACCESS_KEY https://saucelabs.com/rest/v1/users/USERNAME
```

## Facebook AppSecret

You can generate access tokens by visiting the URL below.

```
https://graph.facebook.com/oauth/access_token?client_id=ID_HERE&client_secret=SECRET_HERE&redirect_uri=&grant_type=client_credentials
```

## Facebook Access Token  
```
https://developers.facebook.com/tools/debug/accesstoken/?access_token=ACCESS_TOKEN_HERE&version=v3.2
```

## [Firebase](https://firebase.google.com/)
Requires a **custom token**, and an **API key**.

1. Obtain ID token and refresh token from custom token and API key: `curl -s -XPOST -H 'content-type: application/json' -d '{"custom_token":":custom_token"}' 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=:api_key'`
2. Exchange ID token for auth token: `curl -s -XPOST -H 'content-type: application/json' -d '{"idToken":":id_token"}' https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=:api_key'`

## [Github Token](https://developer.github.com/v3/)
```
curl -s -u "user:apikey" https://api.github.com/user
curl -s -H "Authorization: token TOKEN_HERE" "https://api.github.com/users/USERNAME_HERE/orgs"
# Check scope of your api token
curl "https://api.github.com/rate_limit" -i -u "user:apikey" | grep "X-OAuth-Scopes:"
```

## [Github client id and client secret](https://developer.github.com/v3/#oauth2-keysecret)
```
curl 'https://api.github.com/users/whatever?client_id=xxxx&client_secret=yyyy'
```

## [Google Cloud Messaging](https://developers.google.com/cloud-messaging/)
```
curl -s -X POST --header "Authorization: key=AI..." --header "Content-Type:application/json" 'https://gcm-http.googleapis.com/gcm/send' -d '{"registration_ids":["1"]}'
```

## GitHub private SSH key

SSH private keys can be tested against github.com to see if they are registered against an existing user account. If the key exists the username corresponding to the key will be provided. ([source](https://github.com/streaak/keyhacks/issues/2))

```
$ ssh -i <path to SSH private key> -T git@github.com
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

## [Twilio Account_sid and Auth token](https://www.twilio.com/docs/iam/api/account)
```
curl -X GET 'https://api.twilio.com/2010-04-01/Accounts.json' -u ACCOUNT_SID:AUTH_TOKEN
```

## [Twitter API Secret](https://developer.twitter.com/en/docs/basics/authentication/guides/bearer-tokens.html)
```
curl -u 'API key:API secret key' --data 'grant_type=client_credentials' 'https://api.twitter.com/oauth2/token'
```

## [Twitter Bearer token](https://developer.twitter.com/en/docs/accounts-and-users/subscribe-account-activity/api-reference/aaa-premium)
```
curl --request GET --url https://api.twitter.com/1.1/account_activity/all/subscriptions/count.json --header 'authorization: Bearer TOKEN'
```

## [Deviant Art Secret](https://www.deviantart.com/developers/authentication)
```
curl https://www.deviantart.com/oauth2/token -d grant_type=client_credentials -d client_id=ID_HERE -d client_secret=mysecret
```

## [Deviant Art Access Token](https://www.deviantart.com/developers/authentication)
```
curl https://www.deviantart.com/api/v1/oauth2/placebo -d access_token=Alph4num3r1ct0k3nv4lu3
```

## [Pendo Integration Key](https://help.pendo.io/resources/support-library/api/index.html?bash#authentication)
```
curl -X GET https://app.pendo.io/api/v1/feature -H 'content-type: application/json' -H 'x-pendo-integration-key:KEY_HERE'
curl -X GET https://app.pendo.io/api/v1/metadata/schema/account -H 'content-type: application/json' -H 'x-pendo-integration-key:KEY_HERE'
```

## [SendGrid API Token](https://sendgrid.com/docs/API_Reference/api_v3.html)
```
curl -X "GET" "https://api.sendgrid.com/v3/scopes" -H "Authorization: Bearer SENDGRID_TOKEN-HERE" -H "Content-Type: application/json"
```

## [Square](https://squareup.com/)
**Detection:**

App id/client secret:  `sq0[a-z]{3}-[0-9A-Za-z\-_]{22,43}`
Auth token: `EAAA[a-zA-Z0-9]{60}`

**Test App id & client secret:**
```
curl "https://squareup.com/oauth2/revoke" -d '{"access_token":"[RANDOM_STRING]","client_id":"[APP_ID]"}'  -H "Content-Type: application/json" -H "Authorization: Client [CLIENT_SECRET]"
```

Response indicating valid credentials:
```
empty
```

Response indicating invalid credentials:
```
{
  "message": "Not Authorized",
  "type": "service.not_authorized"
}
```

**Test Auth token:**
```
curl https://connect.squareup.com/v2/locations -H "Authorization: Bearer [AUHT_TOKEN]"
```

Response indicating valid credentials:
```
{"locations":[{"id":"CBASELqoYPXr7RtT-9BRMlxGpfcgAQ","name":"Coffee \u0026 Toffee SF","address":{"address_line_1":"1455 Market Street","locality":"San Francisco","administrative_district_level_1":"CA","postal_code":"94103","country":"US"},"timezone":"America/Los_Angeles"........
```

Response indicating invalid credentials:
```
{"errors":[{"category":"AUTHENTICATION_ERROR","code":"UNAUTHORIZED","detail":"This request could not be authorized."}]}
```

## Dropbox API
```
curl -X POST https://api.dropboxapi.com/2/users/get_current_account --header "Authorization: Bearer TOKEN_HERE"
```

## [AWS Access Key ID and Secret](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

Install [awscli](https://aws.amazon.com/cli/), set the [access key and secret to environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html), and execute the following command:
```
AWS_ACCESS_KEY_ID=xxxx AWS_SECRET_ACCESS_KEY=yyyy aws sts get-caller-identity
```

AWS credentials' permissions can be determined using [Enumerate-IAM](https://github.com/andresriancho/enumerate-iam).
This gives broader view of the discovered AWS credentials privileges instead of just checking S3 buckets.

```
git clone https://github.com/andresriancho/enumerate-iam
cd  enumerate-iam
./enumerate-iam.py --access-key AKIA... --secret-key StF0q...
```


## [MailGun Private Key](https://documentation.mailgun.com/en/latest/api_reference.html)
```
curl --user 'api:key-PRIVATEKEYHERE' "https://api.mailgun.net/v3/domains"
```

## Microsoft Azure Tenant
Format:
```
CLIENT_ID: [0-9a-z\-]{36}
CLIENT_SECRET: [0-9A-Za-z\+\=]{40,50}
TENANT_ID: [0-9a-z\-]{36}
```
Verification:
```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d 'client_id=<CLIENT_ID>&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret=<CLIENT_SECRET>&grant_type=client_credentials' 'https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token'
```

## [Microsoft Shared Access Signatures (SAS)](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/storage/common/storage-dotnet-shared-access-signature-part-1.md)

The following powershell can be used to test a Shared Access Signature Token:
```powershell
static void UseAccountSAS(string sasToken)
{
    // Create new storage credentials using the SAS token.
    StorageCredentials accountSAS = new StorageCredentials(sasToken);
    // Use these credentials and the account name to create a Blob service client.
    CloudStorageAccount accountWithSAS = new CloudStorageAccount(accountSAS, "account-name", endpointSuffix: null, useHttps: true);
    CloudBlobClient blobClientWithSAS = accountWithSAS.CreateCloudBlobClient();

    // Now set the service properties for the Blob client created with the SAS.
    blobClientWithSAS.SetServiceProperties(new ServiceProperties()
    {
        HourMetrics = new MetricsProperties()
        {
            MetricsLevel = MetricsLevel.ServiceAndApi,
            RetentionDays = 7,
            Version = "1.0"
        },
        MinuteMetrics = new MetricsProperties()
        {
            MetricsLevel = MetricsLevel.ServiceAndApi,
            RetentionDays = 7,
            Version = "1.0"
        },
        Logging = new LoggingProperties()
        {
            LoggingOperations = LoggingOperations.All,
            RetentionDays = 14,
            Version = "1.0"
        }
    });

    // The permissions granted by the account SAS also permit you to retrieve service properties.
    ServiceProperties serviceProperties = blobClientWithSAS.GetServiceProperties();
    Console.WriteLine(serviceProperties.HourMetrics.MetricsLevel);
    Console.WriteLine(serviceProperties.HourMetrics.RetentionDays);
    Console.WriteLine(serviceProperties.HourMetrics.Version);
}
```

## [Heroku API key](https://devcenter.heroku.com/articles/platform-api-quickstart)
```
curl -X POST https://api.heroku.com/apps -H "Accept: application/vnd.heroku+json; version=3" -H "Authorization: Bearer API_KEY_HERE"
```
## [Mapbox API key](https://docs.mapbox.com/api/)

Mapbox secret keys start with `sk`, rest start with `pk` (public token), `sk` (secret token), or `tk` (temporary token).

```
curl "https://api.mapbox.com/geocoding/v5/mapbox.places/Los%20Angeles.json?access_token=ACCESS_TOKEN"
```

## [Salesforce API key](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart_oauth.htm)
```
curl https://instance_name.salesforce.com/services/data/v20.0/ -H 'Authorization: Bearer access_token_here'
```

## [Algolia API key](https://www.algolia.com/doc/rest-api/search/#overview)

Be cautious when running this command, since the payload might execute within an administrative environment, depending on what index you are editing the `highlightPreTag` of. It's recommended to use a more silent payload (such as XSS Hunter) to prove the possible cross-site scripting attack.

```
curl --request PUT \
  --url https://<application-id>-1.algolianet.com/1/indexes/<example-index>/settings \
  --header 'content-type: application/json' \
  --header 'x-algolia-api-key: <example-key>' \
  --header 'x-algolia-application-id: <example-application-id>' \
  --data '{"highlightPreTag": "<script>alert(1);</script>"}'
```

## [Zapier Webhook Token](https://zapier.com/help/how-get-started-webhooks-zapier/)
```
curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"name":"streaak"}' "webhook_url_here"
```

## [pagerduty API token](https://support.pagerduty.com/docs/using-the-api)
```
curl -H "Accept: application/vnd.pagerduty+json;version=2"  -H "Authorization: Token token=TOKEN_HERE" -X GET  "https://api.pagerduty.com/schedules"
```

## [BrowserStack ACCESSKEY](https://www.browserstack.com/automate/rest-api)
```
curl -u "USERNAME:ACCESS_KEY" https://api.browserstack.com/automate/plan.json
```

## [Google Maps API key](https://developers.google.com/maps/documentation/javascript/get-api-key)

Visit the following URL to check for validity:

```
https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=KEY_HERE
https://maps.googleapis.com/maps/api/staticmap?center=40.714728,-73.998672&zoom=12&size=2500x2000&maptype=roadmap&key=KEY_HERE
```

## [Google Recaptcha key](https://developers.google.com/recaptcha/docs/verify)

Send a POST to the following URL:

```
https://www.google.com/recaptcha/api/siteverify
```

`secret` and `response` are two required POST parameters, where `secret` is the key and `response` is the response to test for.

Regular expression: `^6[0-9a-zA-Z_-]{39}$`. The API key always starts with a 6 and is 40 chars long. Read more here: https://developers.google.com/recaptcha/docs/verify.

## [Branch.IO Key and Secret](https://docs.branch.io/pages/apps/deep-linking-api/#app-read)

Visit the following URL to check for validity:

```
https://api2.branch.io/v1/app/KEY_HERE?branch_secret=SECRET_HERE
```

## [Bit.ly Access token](https://dev.bitly.com/authentication.html)

Visit the following URL to check for validity:

```
https://api-ssl.bitly.com/v3/shorten?access_token=ACCESS_TOKEN&longUrl=https://www.google.com
```

## [Buildkite Access token](https://buildkite.com/docs/apis/rest-api)
```
curl -H "Authorization: Bearer ACCESS_TOKEN" \
https://api.buildkite.com/v2/user
```

## [Asana Access token](https://asana.com/developers/documentation/getting-started/auth#personal-access-token)
```
curl -H "Authorization: Bearer ACCESS_TOKEN" https://app.asana.com/api/1.0/users/me
```

## [Zendesk Access token](https://support.zendesk.com/hc/en-us/articles/203663836-Using-OAuth-authentication-with-your-application)
```
curl https://{subdomain}.zendesk.com/api/v2/tickets.json \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

## [MailChimp API Key](https://developer.mailchimp.com/documentation/mailchimp/reference/overview/)
```
curl --request GET --url 'https://<dc>.api.mailchimp.com/3.0/' --user 'anystring:<API_KEY>' --include
```

## [WPEngine API Key](https://wpengineapi.com/)

This issue can be further exploited by checking out [@hateshape](https://github.com/hateshape/)'s gist https://gist.github.com/hateshape/2e671ea71d7c243fac7ebf51fb738f0a.

```
curl "https://api.wpengine.com/1.2/?method=site&account_name=ACCOUNT_NAME&wpe_apikey=WPENGINE_APIKEY"
```

## [DataDog API key](https://docs.datadoghq.com/api/)
```
curl "https://api.datadoghq.com/api/v1/dashboard?api_key=<api_key>&application_key=<application_key>"
```

## [Travis CI API token](https://developer.travis-ci.com/gettingstarted)

```
curl -H "Travis-API-Version: 3" -H "Authorization: token <TOKEN>" https://api.travis-ci.com/user
```

## [WakaTime API Key](https://wakatime.com/developers)
```
curl "https://wakatime.com/api/v1/users/current/projects/?api_key=KEY_HERE"
```

## [Spotify Access Token](https://developer.spotify.com/documentation/general/guides/authorization-guide/)
```
curl -H "Authorization: Bearer <ACCESS_TOKEN>" https://api.spotify.com/v1/me
```

## [Instagram Access Token](https://www.instagram.com/developer/endpoints/users/)
Visit the following URL to check for validity
```
https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
```

## [Gitlab personal access token](https://docs.gitlab.com/ee/api/README.html#personal-access-tokens)
```
curl "https://gitlab.example.com/api/v4/projects?private_token=<your_access_token>"
```

## [Paypal client id and secret key](https://developer.paypal.com/docs/api/get-an-access-token-curl/)
```
curl -v https://api.sandbox.paypal.com/v1/oauth2/token \
   -H "Accept: application/json" \
   -H "Accept-Language: en_US" \
   -u "client_id:secret" \
   -d "grant_type=client_credentials"
```

The access token can be further used to extract data from the PayPal API. More information: https://developer.paypal.com/docs/api/overview/#make-rest-api-calls.

This can be verified using:

```
curl -v -X GET "https://api.sandbox.paypal.com/v1/identity/oauth2/userinfo?schema=paypalv1.1" -H "Content-Type: application/json" -H "Authorization: Bearer [ACCESS_TOKEN]"
```

## [Stripe Live Token](https://stripe.com/docs/api/authentication)

```
curl https://api.stripe.com/v1/charges -u token_here:
```

Keep the colon at the end of the token to prevent `cURL` from requesting a password.

The token is always in the following format: `sk_live_24charshere`, where the `24charshere` part contains 24 characters from `a-z A-Z 0-9`. There is also a test key, which starts with `sk_test`, but this key is worthless since it is only used for testing purposes and most likely doesn't contain any sensitive information. The live key, on the other hand, can be used to extract/retrieve a lot of info — ranging from charges to the complete product list.

Keep in mind that you will never be able to get the full credit card information since Stripe only gives you the last 4 digits.

More info/complete documentation: https://stripe.com/docs/api/authentication.

## [Razorpay API key and Secret key](https://razorpay.com/docs/api/)

This can be verified using:

```
curl -u <YOUR_KEY_ID>:<YOUR_KEY_SECRET> \
  https://api.razorpay.com/v1/payments
```

# Contributing

I welcome contributions from the public.

### Using the issue tracker 💡

The issue tracker is the preferred channel for bug reports and features requests.

### Issues and labels 🏷

The bug tracker utilizes several labels to help organize and identify issues.

### Guidelines for bug reports 🐛

Use the GitHub issue search — check if the issue has already been reported.

# ⚠ Legal Disclaimer

This project is made for educational and ethical testing purposes only. Usage of this tool for attacking targets without prior mutual consent is illegal. Developers assume no liability and are not responsible for any misuse or damage caused by this tool.
