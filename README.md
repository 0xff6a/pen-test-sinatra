Penetration Testing Example
===========================

Using a full suite of penetration tests against my own app hosted on heroku. Original app details can be found [here](https://github.com/foxjerem/bookmark-manager)

I. Authentication
-----------------
- Brute force attacks cracks password easily. Attemp to halt attacks by limiting login attempts to 5 per session:
  - Using sinatra sessions. Easily bypassed by changing rack session id in each request
  ```shell
    if session[:login_attempts] > MAX_ATTEMPTS
      lock_account
    else
      attempt_authentication
    end
  ```
  - Using sinatra cookies.
