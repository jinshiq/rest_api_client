#README

####Environment

Ruby version: 2.2.4

Rails version: 4.2.5.1


##Overview

This ia a REST_API client application. It shows how to call REST_API from the API provider applciation 'rest_api_provider' and parse the JSON data. 
Via this API client application, you can create, read, update and delete data and files on the API provider server.  

The API provider <b>'rest_api_provider'</b> creates two APIs, one for <b>User</b> model and the other for <b>Photo</b> model. 
<b>User</b> model has text fields only and is designed to require no API authentication for API access, 
while <b>Photo</b> model contains image field and is designed to require API authentication.

This application uses <b>RestClient</b> gem to parse JSON data and uses <b>'figaro'</b> gem to hide sensitive information 
such as <b>API_KEY</b> when accessing third-party's API (i.e. 'rest_api_provider' in our case).


##Call REST_API and parse JSON data
If <b>API authenticaion</b> is not requred, e.g. the <b>User</b> api in our case, use the code as below.

```ruby
url = "http://localhost:3000/users.json"
response = RestClient.get(url)
@users = JSON.parse(response.body)
```

If <b>API authenticaion</b> is requred, e.g. the <b>Photo</b> api in our case,  set url like as below.

```ruby
url = "http://localhost:3000/api/v1/photos.json?token=22XRYWnwHdMrYthba1PbtAtt"
response = RestClient.get(url)
@photos = JSON.parse(response.body)
```

That means a valid <b>API_KEY</b> should be passed to url for authentication. 



