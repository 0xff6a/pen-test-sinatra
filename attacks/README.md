Creating brute force attack against my app
==========================================

Created basic brute force attack tool using ruby Net::HTTP library.

Tool take a command line input as follows:
```shell
ruby attacks/launcher.rb http://localhost:9292/sessions email:1@2.com password:passwords.txt
```

This will generate a series of post requests to the target trying each password in the file. Have set up listeners for either a status code or an html element which will define when we have been successfully authenticated

To Do:
------
- Handle second payload
- Create payloads from function
- Create new attack spoofing new session id on each attack

Classes
-------
- Payload: a form parameter name and a set of values (can be loaded from file)
- BruteForceAttack: creates post requests to deliver payloads to a target resource
- AttackAnalyzer: checks attack responses for indicators of success (page content, status codes, etc)
