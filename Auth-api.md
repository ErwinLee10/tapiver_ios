# Tapiver API documentation

## Credential

### Mobile client

Put SSO assertion in the HTTP header

 * Authorization : `Tapiver-SSO <Assertion String>`

## Overview

 * API design are similar to RESTful-style with JSON parameters in either query string or http body.
 * API base path is `/api` by default following with API version. Ex. `/api/v1/u/userA/info`.
 * Server expects correct MIME types. Server validates that JSON requests are sent with `Content-type: application/json`, and will always send JSON responses with `Content-type: application/json`.
 * All timestamps are the number of milliseconds since January 1, 1970, 00:00:00 UTC (Epoch) and must be in UTC time.

## Error handling

#### HTTP status code

Please be aware that HTTP status code is also meaningful. ([credits](http://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/))

 * __200 – OK__ – Everything is working
 * __201 – OK__ – New resource has been created
 * __204 – OK__ – The resource was successfully deleted
 * __304 – Not Modified__ – The client can use cached data
 * __400 – Bad Request__ – The request was invalid or cannot be served. The exact error should be explained in the error payload. E.g. The JSON is not valid
 * __401 – Unauthorized__ – The request requires an user authentication. (valid TBS-SSO assertion)
 * __403 – Forbidden__ – The server understood the request, but is refusing it or the access is not allowed.
 * __404 – Not found__ – There is no resource behind the URI.
 * __422 – Unprocessable Entity__ – Should be used if the server cannot process the entity, e.g. if an image cannot be formatted or mandatory fields are missing in the payload.
 * __500 – Internal Server Error__ – API developers should avoid this error. If an error occurs in the global catch blog, the stack trace should be logged and not returned as response.

#### Response with non-2xx status code

```javascript
{
  "error": {
  "code": 1, // detailed error code
  "reason": "Quota limit exceeded." // (optional) error reason. For debugging only and not supposed to show to user.
  }
}
```

#### Global error codes with Unauthroized (401)

* `-1` - not authenticated
* `-2` - session expired

#### Global error codes with Forbidden (403)

* `-1` - permission denied

### Authentication APIs

#### `POST /v1/login`

##### Query parameters
  * `username` - [String]
  * the seller username
  * `password` - [integer] - default(1)
  * the password of the seller


authenticate sellers or user with username and password (note currently it should not support user authentication with username and password).

#### Response Body
```javascript
{
   "userId" : 1,
   "webSessionId": "some long string"    // credential for making requests to other APIs
}
```


##### Error codes for 403 response.

* `1` - Password is wrong.

___
#### `POST /api/v1/auth/u/register-password (mobile)`
to register user with email and password

##### Query parameters
  * `email` - [String]
  * email of the user
  * `password` - [String] 
  * password of the user, must contain 1 alphabet and 1 digit and minimum length = 8

#### Response Body
```javascript
{
   "userId" : 1,
   "webSessionId": "some long string"    // credential for making requests to other APIs
}
```
___
#### `POST /api/v1/auth/forgot-password/:email`
forgot password functionality for a user

#### Response Body
```javascript
{
   "userId" : 1,
   "webSessionId": "some long string"    // credential for making requests to other APIs
}
```  

___
#### `POST /api/v1/auth/u/continue-with-facebook (mobile)`
to continue or register with facebook

##### Query parameters
  * `token` - [String]
  * token from facebook
 
#### Response Body
```javascript
{
   "userId" : 1,
   "webSessionId": "some long string"    // credential for making requests to other APIs
}
```

#### `DELETE /v1/auth/{user}/webSession`

*(for mobile client)*

Invalidate the web session id in the `Authorization` header.
