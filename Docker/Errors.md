# Docker Errors

```sh 
# When you have 2 docker containers that one of them needs to connect to the other to retrieve some information you might get this error which means you need to properly connect them to each other
Whitelabel Error Page
This application has no explicit mapping for /error, so you are seeing this as a fallback.

Sat Aug 01 19:20:06 GMT 2020
There was an unexpected error (type=Internal Server Error, status=500).
Connection refused (Connection refused) executing GET http://localhost:8000/currency-exchange/from/EUR/to/INR

#WATCH
Indian Master 2/32
```