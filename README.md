# nginx
An extended docker image codebase for nginx, also the version used by Astute Giraffe

Oauth
=====
This image contains oauth2-proxy and can run multiple instances of the same basis requirement. However, the multiple oauth2-proxy parameters must be passed in a single environment variable `OAUTH2PROXY_VARS` as multiple lines for it to work.

In order to pass file(s) for oauth2-proxy to use, add it as a config or secret.

Example:
```
OAUTH2PROXY_VARS="--redirect-url='https://localhost:8443/oauth2/callback1' --client-id='asdf.apps.googleusercontent.com' --client-secret='ABCDEFGHIJKLMNOPQRSTUVWX' --email-domain='example.com' --google-admin-email='admin@example.com' --google-group='dept1@example.com' --google-service-account-json=/service_account.json --cookie-secret='TESTINSECRET1234'
--redirect-url='https://localhost:8443/oauth2/callback2' --client-id='fdsa.apps.googleusercontent.com' --client-secret='1234EFGHIJKLMNOPQRSTUVWX' --email-domain='example2.com' --google-admin-email='admin@example2.com' --google-group='dept2@example2.com' --google-service-account-json=/service_account2.json --cookie-secret='TESTINSECRET4321'"
```
