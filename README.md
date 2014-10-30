Penetration Testing Example
===========================

Using a full suite of penetration tests against my own app hosted on heroku. Original app details can be found [here](https://github.com/foxjerem/bookmark-manager)

See README in attacks subdirectory for details of the attack code

I. Authentication
-----------------
Created a simplified brute force attack (using only 10 password guesses loaded from a file) using the Net::HTTP library. Attack cracks password easily. Attemp to halt attacks by limiting login attempts to 5 per user:

 - Using sessions/cookies: 
  ```shell
    if session[:login_attempts] > MAX_ATTEMPTS
      lock_account
    else
      attempt_authentication
    end
  ```
  ***Easily bypassed by changing rack session id in each request***

 - Saving login attempts to database as login_attempts
  ```shell
  user = User.first(:email => email)
  user.update(:login_attempts => user.login_attempts + 1)

  if user && user.login_attempts > MAX_ATTEMPTS
    lock_account
  else
    attempt_authentication
  end
  ```
  ***Prevents previous attack***

Main authentication is now secure, but how about my forgotten password/password change?
