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

### API for logged-in user
#### `GET /v1/u/{userId}/profile`
to get user's profile

##### Response body
```javascript
{
    "firstName": "Erwin",
    "lastName": "Lee ",
    "email": "tommy_fong.lee@hotmail.com",
    "phoneNumber": null,
    "cashbacks": 0
}
```

___
#### `GET /v1/u/{userId}/feeds`
to get user's feed information

##### Query parameters
  * `page` - [integer] - default(0)
  * the page number

##### Response body
```javascript
[
    {
        "sellerId": 5,
        "sellerName": "Sup Clothing",
        "sellerAddress": {
            "id": 3,
            "streetName": "238 Haji Lane",
            "buildingName": "Haji Lane",
            "floor": "",
            "unitNumber": "",
            "postalCode": "189222",
            "contact": "+6567633612",
            "shortDisplayAddress": "Haji Lane",
            "landmark": {
                "id": 1,
                "name": "Haji Lane",
                "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
            },
            "formattedAddress": "238 Haji Lane",
            "formattedFloorAndUnitAddres": ""
        },
        "sellerPicture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/f12d56a2-976f-4c17-b2c2-8843ce8ce354.jpg",
        "sellerCoverPicture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/ded02a3d-79bd-41c6-b26a-c6eb54fae2d9.jpg",
        "sellerTotalFollower": 8,
        "isFollowedByThisUser": true,
        "products": [
            {
                "id": "373",
                "name": "testing pixel",
                "likes": 0,
                "isLikedByThisUser": false,
                "brand": "",
                "variationsOverview": [
                    {
                        "id": 1233,
                        "size": null,
                        "colorHexCode": "#000000",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c53bbf81-38a8-4407-8ced-21569e85315f.jpg",
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/dc4d496c-6fb7-4645-b432-3f7e626f44d1.jpg"
                        ],
                        "labels": [
                            "NEW",
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 12,
                        "salePrice": null,
                        "stock": 123
                    }
                ]
            },
            {
                "id": "97",
                "name": "UNKL347 - FFFOUNDED (GREY)",
                "likes": 0,
                "isLikedByThisUser": false,
                "brand": "",
                "variationsOverview": [
                    {
                        "id": 259,
                        "size": "Int L",
                        "colorHexCode": "#c6c0c0",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/a147fb52-b793-440b-87eb-1237e5c2ca92.jpg",
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/fb662c4e-c5be-4435-8270-8a179713024d.jpg"
                        ],
                        "labels": [
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 35,
                        "salePrice": null,
                        "stock": 150
                    }
                ]
            },
            {
                "id": "83",
                "name": "UNKL347 - FORALL TRUCKR (NAVY)",
                "likes": 0,
                "isLikedByThisUser": false,
                "brand": "",
                "variationsOverview": [
                    {
                        "id": 242,
                        "size": null,
                        "colorHexCode": "#0d2b5d",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/a846094c-9b74-41ae-8f24-8a943e1192ff.jpg",
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/5e431a84-43d3-4774-b5b8-bc52a7d5c9cd.jpg",
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/74fc8cb8-4b35-47a1-a90e-81e76f950912.jpg"
                        ],
                        "labels": [
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 39,
                        "salePrice": null,
                        "stock": 100
                    }
                ]
            },
            {
                "id": "100",
                "name": "GOOD WORTH & CO. - FUCK IT TEE (HEATHER)",
                "likes": 0,
                "isLikedByThisUser": false,
                "brand": "",
                "variationsOverview": [
                    {
                        "id": 262,
                        "size": "Int S",
                        "colorHexCode": "#cbcbcb",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/e30adda9-26cd-403b-b25a-f4559a482221.jpg",
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c6d8a84d-f16e-4160-b54a-e62b3729273c.jpg"
                        ],
                        "labels": [
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 69,
                        "salePrice": null,
                        "stock": 99
                    },
                    {
                        "id": 263,
                        "size": "Int L",
                        "colorHexCode": "#cbcbcb",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/e30adda9-26cd-403b-b25a-f4559a482221.jpg",
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c6d8a84d-f16e-4160-b54a-e62b3729273c.jpg"
                        ],
                        "labels": [
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 69,
                        "salePrice": null,
                        "stock": 91
                    }
                ]
            },
            {
                "id": "95",
                "name": "UNKL347 - INTL (GREY)",
                "likes": 0,
                "isLikedByThisUser": false,
                "brand": "",
                "variationsOverview": [
                    {
                        "id": 256,
                        "size": "Int L",
                        "colorHexCode": "#c8c8c8",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/d519073d-f614-4176-bca9-ab590b1c2b87.jpg"
                        ],
                        "labels": [
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 35,
                        "salePrice": null,
                        "stock": 68
                    },
                    {
                        "id": 257,
                        "size": "Int XL",
                        "colorHexCode": "#c8c8c8",
                        "colorName": "",
                        "pictures": [
                            "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/d519073d-f614-4176-bca9-ab590b1c2b87.jpg"
                        ],
                        "labels": [
                            "FREE_SHIPPING"
                        ],
                        "originalPrice": 35,
                        "salePrice": null,
                        "stock": 68
                    }
                ]
            }
        ]
    }
]
```

##### Error codes for 404 response.

* `1` - userId Does not exist


___
#### `GET /v1/u/{userId}/address`
get address of a user

##### Response body
````javascript
[
    {
        "id": "101",
        "streetName": "testing",
        "floor": "12626",
        "unitNumber": "5552",
        "postalCode": "4161626",
        "alias": "testing",
        "contact": "611626"
    }
]
````

##### Error codes for 404 response.

* `1` - userId Does not exist

___
#### `POST /v1/u/{userId}/address`
add a new address of a user
#### Request Body
```javascript
{
  "streetName" : "220 bugis street 13",
  "floor" : "10",
  "unitNumber" : "3610",
  "postalCode": "210020",
  "alias" : "Brad Pitt",
  "contact" : "+677852351"
}
```
note that the json of this request body is similar to the response body of the
**GET v1/u/`{userId}`/address**, except that this request body does not contain the **address_id**. Also at each request, you can only add one address.

##### Response Body
`address_id`

note : the address_id is the id after successfully inserting into the db.

##### Error codes for 400 response.

* `1` - Invalid street name
* `2` - Invalid floor number
* `3` - invalid unit number
* `4` - Invalid postal code
* `6` - invalid alias
* `7` - invalid contact

##### Error codes for 404 response.

* `1` - userId Does not exist

___
#### `PUT /v1/u/{userId}/email`
to allow a user to change email

#### Request Body
```javascript
{
 	"email" : "newEmail"
}
```

##### response Body
no response body

___
#### `PUT /v1/u/{userId}/like/{productId}`
to allow a user to like a product

##### response Body
`current_total_like_of_the_product`

##### Error codes for 404 response.

* `1` - userId Does not exist
* `2` - ProductId does not exist

___
#### `DELETE /v1/u/{userId}/like/{productId}`
to allow a user to remove a product

##### response Body
`current_total_like_of_the_product`

##### Error codes for 404 response.

* `1` - userId Does not exist
* `2` - ProductId does not exist

___
#### `POST /v1/u/{userId}/follow/{sellerId}`
to allow a user to follow a seller

##### Response Body
`total_current_followers`

##### Error codes for 404 response.

* `1` - user id does not exist
* `2` - seller id does not exist

___
#### `DELETE /v1/u/{userId}/follow/{sellerId}`
to allow a user to follow a seller


##### Response Body
`total_current_followers`

##### Error codes for 404 response.

* `1` - user id Does not exist
* `2` - seller id does not exist

___
#### `GET /v1/u/{userId}/follows/products`
get all listed products

##### Query parameters
  * `page` - [integer] - default(0)
  * the page number
  * `categoryId` - [integer] - default(null)
    only products belong to this category will be shown, null means shows for all categoryId
  * `q` - [String - CASE IGNORED] - default(null)
    The q parameter specifies the query term to search for. note that if this parameter is specified, all the parameters except size and page will be ignored.
    For example : q="iphone", hasDeal = true. the hasDeal flag will be ignored
  * `minPrice` - [Number] - default(null)
    products that has price >= minPrice   
  * `maxPrice` - [Number] - default(null)
    products that has price < maxPrice
 
  * `sellerId` - [integer] - default(null)
    only products belong to this seller will be shown, null means shows for all sellerId
  * `hasDeal` -[boolean] - default(null)
    * if `hasDeal==true`, only products that have deal will be returned.
    * if `hasDeal==false`, only products that do not have deal will be returned.
    * if `hasDeal==null`, this param will be ignored and wont be a filter. Means will return all product that has deal and does not have deal
  * `isHot` -[boolean] - default(null)
    * if `isHot==true`, only products that labelled as isHot will be returned.
    * if `isHot==false`, only products that does not have isHot labelled will be returned.
    * if `isHot==null`, this param will be ignored and wont be a filter. Means will return all product that isHot and does not isHot labelled
  * `isFeatured` -[boolean] - default(null)
    * if `isFeatured==true`, only products that labelled as isFeatured will be returned.
    * if `isFeatured==false`, only products that does not have isFeatured labelled will be returned.
    * if `isFeatured==null`, this param will be ignored and wont be a filter. Means will return all product that isFeatured and does not isHot labelled
 * `isNew` -[boolean] - default(null)
    * if `isNew==true`, only products that labelled as isNew will be returned.
    * if `isNew==false`, only products that does not have isNew labelled will be returned.
    * if `isNew==null`, this param will be ignored and wont be a filter. Means will return all product that isNew and does not isHot labelled
  * note: **the parameters will be treated as &&, if isHot and hasDeal is true, only products that are hot AND has deal will be returned**


##### Response Body

```javascript
same json response body structure with GET /v1/products
```
___
#### `POST /v1/u/{userId}/review/{productId}`
to allow a user to review a product that they have bought

#### Request Body
```javascript
{
  "content" : "content of the review",
  "stars" : 5
}
```

##### Response Body
no response for this request

##### Error codes for 404 response.

* `1` - User id does not exist.
* `2` - product id does not exist.

___
#### `GET /v1/u/{userId}/orders`
to allow a user to retrieve their past orders

##### Query parameters - by default should be ordered by latest date of order
  * `page` - [integer] - default(0)
  * the page number

##### Response Body

``` javascript
[
  {
    "id": 315093298661,
    "orderDate": 1509301066340,
    "totalAmount": 72,
    "orderStatus": "CANCELLED",
    "shippingType": "Shipping",
    "shippingProvider": "Tapiver",
    "isPickup": false,
    "shippingAddress": {
      "streetName": "testing",
      "floor": "12626",
      "unitNumber": "5552",
      "postalCode": "4161626",
      "alias": "testing",
      "contact": "611626",
      "formattedAddress": "testing, #12626-5552",
      "formattedFloorAndUnitAddres": "#12626-5552"
    },
    "billingAddress": {
      "streetName": "testing",
      "floor": "12626",
      "unitNumber": "5552",
      "postalCode": "4161626",
      "alias": "testing",
      "contact": "611626",
      "formattedAddress": "testing, #12626-5552",
      "formattedFloorAndUnitAddres": "#12626-5552"
    },
    "shippingCost": 3,
    "cashback": null,
    "sellerId": 5,
    "sellerName": "Sup Clothing",
    "sellerPicture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/f12d56a2-976f-4c17-b2c2-8843ce8ce354.jpg",
    "sellerTotalFollower": 8,
    "isFollowedByThisUser": true,
    "sellerAddress": {
      "id": 3,
      "streetName": "238 Haji Lane",
      "buildingName": "Haji Lane",
      "floor": "",
      "unitNumber": "",
      "postalCode": "189222",
      "contact": "+6567633612",
      "shortDisplayAddress": "Haji Lane",
      "landmark": {
        "id": 1,
        "name": "Haji Lane",
        "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
      },
      "formattedAddress": "238 Haji Lane",
      "formattedFloorAndUnitAddres": ""
    },
    "items": [
      {
        "itemId": "100",
        "itemName": "GOOD WORTH & CO. - FUCK IT TEE (HEATHER)",
        "colorHexCode": "#cbcbcb",
        "colorName": "",
        "size": "L",
        "quantity": 1,
        "originalPrice": 69,
        "salePrice": null,
        "discountPercentage": 0,
        "finalPrice": 69,
        "itemPictures": [
          "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/e30adda9-26cd-403b-b25a-f4559a482221.jpg",
          "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c6d8a84d-f16e-4160-b54a-e62b3729273c.jpg"
        ]
      }
    ]
  }
]
```

##### Error codes for 404 response.

* `1` - User id does not exist.

____
#### `POST /v1/u/{userId}/orders/{orderId}/complete`
mark the order as completed

#### Request Body
no request body

#### Response Body
no Reponse body

___
#### `POST /v1/u/{userId}/orders/{orderId}/report`
report the order as having problem

#### Request Body
```javascript
message : "message"
```

#### Response Body
no Reponse body

___
#### `GET /v1/u/{userId}/cashback`
to allow a user to retrieve their cashback info


##### Response Body

``` javascript
{
    "earning": 353.45,
    "redeemable": 0,
    "redeemed": 353.45,
    "pending": 13.2,
    "processing": 0,
    "cashbacks": [
        {
            "id": 48,
            "orderDate": 1507332130117,
            "cashbackPercentage": 5,
            "cashbackAmount": 83.25,
            "status": "REDEEMED",
            "orderId": 315073609301
        },
        {
            "id": 47,
            "orderDate": 1507331358703,
            "cashbackPercentage": 5,
            "cashbackAmount": 9.25,
            "status": "PENDING",
            "orderId": 315073601581
        }
    ]
}
```

##### Error codes for 404 response.

* `1` - User id does not exist.

___
#### `GET /v1/u/{userId}/cashback/redemption`
to allow a user to retrieve their cashback redemption history

##### Response Body

``` javascript
[
    {
        "bankName": "Citibank",
        "accountName": "yoo",
        "accountNo": "464",
        "status": "PAID",
        "creationDate": 1504065053003,
        "amount": 47.7
    },
    {
        "bankName": "Citibank",
        "accountName": "xkxkxk",
        "accountNo": "16226895",
        "status": "PAID",
        "creationDate": 1504285898717,
        "amount": 222.5
    },
    {
        "bankName": "Citibank",
        "accountName": "rttr",
        "accountNo": "4644646",
        "status": "PAID",
        "creationDate": 1507332158877,
        "amount": 83.25
    }
]
```

##### Error codes for 404 response.

* `1` - User id does not exist.

___
#### `POST /v1/u/{userId}/cashback/redemption`
to allow a user request for cashback


##### Request Body

``` javascript
{
	"bankName" : "Uob",
	"accountNo" : "12121",
	"name" : "Tommy Lee"
}

```

##### Error codes for 404 response.

* `1` - User id does not exist.


___
#### `POST /v1/u/{userId}/feedback`
to allow a user to send feedback about the app

#### Request Body
```javascript
{
  "subject" : "Feedback Subject",
  "message" : "Feedback message Feedback message Feedback message Feedback message Feedback message"
}
```

##### Response Body
no response for this request

##### Error codes for 404 response.

* `1` - User id does not exist.

___
#### `POST /api/v1/u/{userId}/cart/productVariationId/{productVariationId}`
to add new item to the cart. In the case that the item is already in the cart, calling this API will change the quantity
of the item depending on the quantity parameters that you put. For example if 'item1' is already in the cart with quantity : 1,
if 'item1' is  inserted again with quantity : 2, the next value of the quantity will become 3. If the quantity supplied is negative value, the current value will be reduced with the new one. If the new value is less or equal to 0, the item will be deleted from the cart.

#### Request Body
```javascript
{
  "quantity" : Integer
}
```

##### Response Body
no response for this request

##### Error codes for 404 response.

* `30` - invalid value for quantity.

___
#### `DELETE /api/v1/u/{userId}/cart/productVariationId/{productVariationId}`
delete item from cart

#### Request Body
no request body

##### Response Body
no response for this request

#### `GET /api/v1/u/{userId}/cart`
get the cart of the user

#### Request Body
no request body

##### Response Body
```
{
  "cartItemsPerSeller": [
    {
      "sellerName": "Luca & Vic",
      "sellerId": 1,
      "sellerAddress": {
        "id": 1,
        "streetName": "29 Haji Lane",
        "buildingName": "Haji Lane",
        "floor": "",
        "unitNumber": "",
        "postalCode": "238898",
        "contact": "+6567633612",
        "shortDisplayAddress": "Haji Lane",
        "landmark": {
          "id": 1,
          "name": "Haji Lane",
          "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
        },
        "formattedAddress": "29 Haji Lane",
        "formattedFloorAndUnitAddres": ""
      },
      "totalPrice": 65,
      "productVariations": [
        {
          "name": "Sleeveless Tie-Waist Dress Green",
          "brand": "Marc & Molly's",
          "originalPrice": 65,
          "salePrice": null,
          "finalPrice": 65,
          "quantity": 1,
          "availableStock": 70,
          "pictureUrl": "https://s3-ap-southeast-1.amazonaws.com/tapiver/hello@lucavic.com/PRODUCT/fcc23fc3-7c84-4a9a-809d-de148c1e007a.jpg",
          "id": 45,
          "size": "4",
          "colorHexCode": "#3fb3b6",
          "colorName": "",
          "categoryId": 227,
          "categoryName": "Girls",
          "onSale": false
        }
      ],
      "shippingOptions": [
        {
          "id": 1,
          "provider": "",
          "type": "Normal Shipping",
          "price": 0,
          "isPickup": false,
          "additionalInformation": {
            "time": "5 days",
            "cashbackPercentage": null,
            "cashbackEarned": null
          },
          "freeShipping": false
        },
        {
          "id": 2,
          "provider": "",
          "type": "Registered Shipping",
          "price": 3,
          "isPickup": false,
          "additionalInformation": {
            "time": "2 days",
            "cashbackPercentage": null,
            "cashbackEarned": null
          },
          "freeShipping": false
        },
        {
          "id": 4,
          "provider": "Store",
          "type": "Pickup",
          "price": 0,
          "isPickup": true,
          "additionalInformation": {
            "time": "1 day",
            "cashbackPercentage": 5,
            "cashbackEarned": 3.25
          },
          "freeShipping": false
        }
      ]
    }
  ],
  "coupon": null,
  "finalTotalAmount": 65,
  "originalTotalAmount": 65
}
```

#### `GET /api/v1/u/{userId}/cart/voucher/{voucherName}`
get the cart of the user and applied a given voucher name

#### Request Body
no request body

##### Response Body
```
{
    "cartItemsPerSeller": [
        {
            "sellerName": "Luca & Vic",
            "sellerId": 1,
            "sellerAddress": {
                "id": 1,
                "streetName": "29 Haji Lane",
                "buildingName": "Haji Lane",
                "floor": "",
                "unitNumber": "",
                "postalCode": "238898",
                "contact": "+6567633612",
                "shortDisplayAddress": "Haji Lane",
                "landmark": {
                    "id": 1,
                    "name": "Haji Lane",
                    "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
                },
                "formattedAddress": "29 Haji Lane",
                "formattedFloorAndUnitAddres": ""
            },
            "totalPrice": 65,
            "productVariations": [
                {
                    "name": "Sleeveless Tie-Waist Dress Green",
                    "brand": "Marc & Molly's",
                    "originalPrice": 65,
                    "salePrice": null,
                    "finalPrice": 65,
                    "quantity": 1,
                    "availableStock": 70,
                    "pictureUrl": "https://s3-ap-southeast-1.amazonaws.com/tapiver/hello@lucavic.com/PRODUCT/fcc23fc3-7c84-4a9a-809d-de148c1e007a.jpg",
                    "id": 45,
                    "size": "4",
                    "colorHexCode": "#3fb3b6",
                    "colorName": "",
                    "categoryId": 227,
                    "categoryName": "Girls",
                    "onSale": false
                }
            ],
            "shippingOptions": [
                {
                    "id": 1,
                    "provider": "",
                    "type": "Normal Shipping",
                    "price": 0,
                    "isPickup": false,
                    "additionalInformation": {
                        "time": "5 days",
                        "cashbackPercentage": null,
                        "cashbackEarned": null
                    },
                    "freeShipping": false
                },
                {
                    "id": 2,
                    "provider": "",
                    "type": "Registered Shipping",
                    "price": 3,
                    "isPickup": false,
                    "additionalInformation": {
                        "time": "2 days",
                        "cashbackPercentage": null,
                        "cashbackEarned": null
                    },
                    "freeShipping": false
                },
                {
                    "id": 4,
                    "provider": "Store",
                    "type": "Pickup",
                    "price": 0,
                    "isPickup": true,
                    "additionalInformation": {
                        "time": "1 day",
                        "cashbackPercentage": 5,
                        "cashbackEarned": 3.25
                    },
                    "freeShipping": false
                }
            ]
        }
    ],
    "coupon": {
        "name": "erwin",
        "totalSaving": 5,
        "percentage": 7,
        "isPercentageDiscount": false,
        "message": null,
        "id": 1
    },
    "finalTotalAmount": 60,
    "originalTotalAmount": 65
}
```

___
#### `POST /api/v1/u/{userId}/checkout`


#### Request Body
```javascript
{
	"stripeToken" : "tok_1A7EhKGaV3oLL0KEZZoFzi2V",
	"totalAmountWithoutShipping" : 60,
	"totalAmountIncludeShipping": 62,
	"couponName" : "discount5",
	"shippingAddressId" : 1,
	"billingAddressId" : 1,
	"orderPerSellers": [{
		"sellerId" : 1,
		"shippingId": 1,
		"subAmount": 60
	}]
}
```

##### Response Body
no response for this request if successful


___
## Generic API for non-login user or not user specific

#### `GET /v1/discover`
to get all the trending shops

##### Query parameters
  * `page` - [integer] - default(0)
  * the page number
  * `landmarkId` - [integer] - default(null)
  * only products that where the seller has an address on that landmark will be given
  * `userId` - [Long] - default(null)
    this is optional field, if this param is given, the return response will not have seller that is followed by this user
  

##### Response Body
the response body format is the same with **`GET v1/u/{userId}/feed`**

#### `GET /v1/s/overview`

##### Query parameters - by default should be ordered by latest date of order
  * `page` - [integer] - default(0)
  * the page number
  * `q` - [String]
  * the seller name to match, does not have to be exact, ignore case-sensitive
  * `landmarkId` - [integer] - default(null)
  * only seller that has an address on that landmark will be given
  * `userId` - [Long] - default(null)
    if userId is given, isFollowedByThisUser and isLikedByThisUser should have the correct info regarding to the user
  

___
#### `GET /v1/products`
get all listed products

##### Query parameters
  * `page` - [integer] - default(0)
  * the page number
  * `userId` - [Long] - default(null)
    this is optional field, if this param is given, the return value isLikedByThisUser will be set accordingly.
  * `categoryId` - [integer] - default(null)
    only products belong to this category will be shown, null means shows for all categoryId
  * `landmarkId` - [integer] - default(null)
    only products that where the seller has an address on that landmark will be given
  * `q` - [String - CASE IGNORED] - default(null)
    The q parameter specifies the query term to search for. note that if this parameter is specified, all the parameters except size and page will be ignored.
    For example : q="iphone", hasDeal = true. the hasDeal flag will be ignored
  * `minPrice` - [Number] - default(null)
    products that has price >= minPrice   
  * `maxPrice` - [Number] - default(null)
    products that has price < maxPrice
  * `sellerId` - [integer] - default(null)
    only products belong to this seller will be shown, null means shows for all sellerId
  * `hasDeal` -[boolean] - default(null)
     * if `hasDeal==true`, only products that have deal will be returned.
    * if `hasDeal==false`, only products that do not have deal will be returned.
    * if `hasDeal==null`, this param will be ignored and wont be a filter. Means will return all product that has deal and does not have deal
    
  * `sortBy` - [String] - default(null)
     available criteria : POPULARITY, MIN_PRICE, MAX_PRICE, LATEST
  * `isHot` -[boolean] - default(null)
    * if `isHot==true`, only products that labelled as isHot will be returned.
    * if `isHot==false`, only products that does not have isHot labelled will be returned.
    * if `isHot==null`, this param will be ignored and wont be a filter. Means will return all product that isHot and does not isHot labelled
  * `isFeatured` -[boolean] - default(null)
    * if `isFeatured==true`, only products that labelled as isFeatured will be returned.
    * if `isFeatured==false`, only products that does not have isFeatured labelled will be returned.
     * if `isFeatured==null`, this param will be ignored and wont be a filter. Means will return all product that isFeatured and does not isHot labelled
 * `isNew` -[boolean] - default(null)
    * if `isNew==true`, only products that labelled as isNew will be returned.
    * if `isNew==false`, only products that does not have isNew labelled will be returned.
    * if `isNew==null`, this param will be ignored and wont be a filter. Means will return all product that isNew and does not isHot labelled
  * note: **the parameters will be treated as &&, if isHot and hasDeal is true, only products that are hot AND has deal will be returned**


##### Response Body

```javascript
[
  {
    "id": "373",
    "name": "testing pixel",
    "sellerName": "Sup Clothing",
    "sellerId": 5,
    "sellerPicture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/f12d56a2-976f-4c17-b2c2-8843ce8ce354.jpg",
    "sellerCoverPicture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/ded02a3d-79bd-41c6-b26a-c6eb54fae2d9.jpg",
    "sellerTotalFollower": 8,
    "sellerAddress": {
      "id": 3,
      "streetName": "238 Haji Lane",
      "buildingName": "Haji Lane",
      "floor": "",
      "unitNumber": "",
      "postalCode": "189222",
      "contact": "+6567633612",
      "shortDisplayAddress": "Haji Lane",
      "landmark": {
        "id": 1,
        "name": "Haji Lane",
        "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
      },
      "formattedAddress": "238 Haji Lane",
      "formattedFloorAndUnitAddres": ""
    },
    "isLikedByThisUser": false,
    "likes": 0,
    "brand": "",
    "variationsOverview": [
      {
        "id": 1233,
        "size": null,
        "colorHexCode": "#000000",
        "colorName": "",
        "pictures": [
          "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c53bbf81-38a8-4407-8ced-21569e85315f.jpg",
          "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/dc4d496c-6fb7-4645-b432-3f7e626f44d1.jpg"
        ],
        "labels": [
          "NEW",
          "FREE_SHIPPING"
        ],
        "originalPrice": 12,
        "salePrice": null,
        "stock": 123
      }
    ]
  }
]
```

##### Error codes for 400 response.
* `3` - Invalid flag has deal
* `4` - Invalid flag is hot
* `5` - Invalid flag is featured


____
#### `GET /products/{productId}/details`
get a details for a specific product, like the shipping cost and the available stock

##### Query parameters
  * `userId` - [Long] - default(null)
    this is optional field, if this param is given, the return value isLikedByThisUser will be set accordingly.
    
##### Response Body
```javascript
{
    "name": "testing pixel",
    "sellerName": "Sup Clothing",
    "sellerId": "5",
    "sellerPicture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/f12d56a2-976f-4c17-b2c2-8843ce8ce354.jpg",
    "sellerTotalFollower": 8,
    "sellerAddress": {
        "id": 3,
        "streetName": "238 Haji Lane",
        "buildingName": "Haji Lane",
        "floor": "",
        "unitNumber": "",
        "postalCode": "189222",
        "contact": "+6567633612",
        "shortDisplayAddress": "Haji Lane",
        "landmark": {
            "id": 1,
            "name": "Haji Lane",
            "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
        },
        "formattedAddress": "238 Haji Lane",
        "formattedFloorAndUnitAddres": ""
    },
    "openingHours": {
        "0": [
            "08:00 - 19:30"
        ],
        "1": [
            "08:00 - 19:30"
        ],
        "2": [
            "08:00 - 19:30"
        ],
        "3": [
            "08:00 - 19:30"
        ],
        "4": [
            "08:00 - 19:30"
        ],
        "5": [
            "08:00 - 19:30"
        ],
        "6": [
            "08:00 - 19:30"
        ]
    },
    "likes": 0,
    "isLikedByThisUser": false,
    "isSellerFollowedByUser": false,
    "description": "testing pixel",
    "brand": "",
    "shippingsCost": [
        {
            "provider": "",
            "type": "Normal Shipping",
            "price": 0,
            "additionalInformation": {
                "time": "5 days",
                "cashbackPercentage": null,
                "freeShippingThreshold": 80
            },
            "isPickup": false
        },
        {
            "provider": "",
            "type": "Registered Shipping",
            "price": 3,
            "additionalInformation": {
                "time": "2 days",
                "cashbackPercentage": null,
                "freeShippingThreshold": null
            },
            "isPickup": false
        },
        {
            "provider": "Tapiver",
            "type": "Shipping",
            "price": 3,
            "additionalInformation": {
                "time": "2 days",
                "cashbackPercentage": null,
                "freeShippingThreshold": null
            },
            "isPickup": false
        },
        {
            "provider": "Store",
            "type": "Pickup",
            "price": 0,
            "additionalInformation": {
                "time": "1 day",
                "cashbackPercentage": 5,
                "freeShippingThreshold": null
            },
            "isPickup": true
        }
    ],
    "latestReviews": [],
    "variations": [
        {
            "id": 1233,
            "size": null,
            "colorHexCode": "#000000",
            "colorName": "",
            "pictures": [
                "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c53bbf81-38a8-4407-8ced-21569e85315f.jpg",
                "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/dc4d496c-6fb7-4645-b432-3f7e626f44d1.jpg"
            ],
            "labels": [
                "NEW",
                "FREE_SHIPPING"
            ],
            "originalPrice": 12,
            "salePrice": null,
            "stock": 123
        }
    ],
    "categoryId": 140,
    "categoryName": "Shirt Accessories"
}
```

##### Error codes for 404 response.

* `1` - product does not exist.


___
#### `GET /v1/products/{productId}/reviews`
get the reviews of the products sorted by the submission date.

##### Query parameters
  * `page` - [integer] - default(0)
  * the page number

##### Response Body
```javascript
[
  {
    "username" : "yoseph12",
    "review" : "packaging was very good, fast shipping",
    "stars" : "4",
    "review_date" : "in_timestamp"
  }
]
```

##### Error codes for 404 response.

* `1` - product does not exist.


___
#### `GET /v1/landmark`
to get all the landmark

##### Query parameters
not applicable

##### Response Body
```javascript
[
   {
    "id": 1,
    "name": "Haji Lane",
    "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
   }
]
```


#### `GET /v1/maintenance`
to get maintenance date if any

##### Query parameters
not applicable

#### Response Body
```
{
  "title" : "title",
  "description" : "content",
  "start" : 1212121212,
  "end" : 1212121212
}
```

___
#### `GET /v1/categories`
to get all the categories with subcategories (nested)

##### Query parameters
* `hasProducts` - if true will return all categories that has products, false will return all categories that has no products else will return all
* `landmarkId` - if not null will return category filtered by landmarkId
* `sellerId` - if not null will return category filtered by sellerId

##### Response Body
```javascript
[
  {
    "id": 1,
    "name": "Women's Fashion",
    "sub": [
      {
        "id": 9,
        "name": "Clothing",
        "sub": [
          {
            "id": 64,
            "name": "Dresses",
            "sub": []
          },
          {
            "id": 65,
            "name": "Tops/Shirts",
            "sub": []
          },
          {
            "id": 66,
            "name": "Blouses",
            "sub": []
          },
          {
            "id": 67,
            "name": "Sweaters",
            "sub": []
          },
          {
            "id": 68,
            "name": "Cardigans, Sweaters & Hoodies",
            "sub": []
          },
          {
            "id": 69,
            "name": "Jackets & Coats",
            "sub": []
          },
          {
            "id": 70,
            "name": "Skirts",
            "sub": []
          },
          {
            "id": 71,
            "name": "Pants",
            "sub": []
          },
          {
            "id": 72,
            "name": "Jeans",
            "sub": []
          },
          {
            "id": 73,
            "name": "Shorts",
            "sub": []
          },
          {
            "id": 74,
            "name": "Plus sizes",
            "sub": []
          },
          {
            "id": 75,
            "name": "Muslim Wear",
            "sub": []
          },
          {
            "id": 76,
            "name": "Traditional clothes",
            "sub": []
          },
          {
            "id": 341,
            "name": "Swimwear",
            "sub": []
          }
        ]
      },
      {
        "id": 10,
        "name": "Bags & Wallets",
        "sub": [
          {
            "id": 77,
            "name": "Handbags",
            "sub": []
          },
          {
            "id": 78,
            "name": "Sling Bags",
            "sub": []
          },
          {
            "id": 79,
            "name": "Tote Bags",
            "sub": []
          },
          {
            "id": 80,
            "name": "Backpacks",
            "sub": []
          },
          {
            "id": 81,
            "name": "Wallets",
            "sub": []
          },
          {
            "id": 368,
            "name": "Cluthes",
            "sub": []
          },
          {
            "id": 369,
            "name": "Bag Accessories",
            "sub": []
          },
          {
            "id": 370,
            "name": "Card and Key Holders",
            "sub": []
          },
          {
            "id": 371,
            "name": "Coin Pouches",
            "sub": []
          },
          {
            "id": 372,
            "name": "Wristlets",
            "sub": []
          }
        ]
      },
      {
        "id": 11,
        "name": "Underwear & socks",
        "sub": [
          {
            "id": 82,
            "name": "Bras",
            "sub": []
          },
          {
            "id": 83,
            "name": "Panties",
            "sub": []
          },
          {
            "id": 84,
            "name": "Sleepwear",
            "sub": []
          },
          {
            "id": 85,
            "name": "Body shapers",
            "sub": []
          },
          {
            "id": 86,
            "name": "Lingerie",
            "sub": []
          },
          {
            "id": 87,
            "name": "Leggings",
            "sub": []
          },
          {
            "id": 88,
            "name": "Stockings",
            "sub": []
          },
          {
            "id": 89,
            "name": "Socks",
            "sub": []
          },
          {
            "id": 373,
            "name": "Tights",
            "sub": []
          }
        ]
      },
      {
        "id": 12,
        "name": "Shoes",
        "sub": [
          {
            "id": 90,
            "name": "Heels",
            "sub": []
          },
          {
            "id": 91,
            "name": "Flat Shoes",
            "sub": []
          },
          {
            "id": 92,
            "name": "Sandals",
            "sub": []
          },
          {
            "id": 93,
            "name": "Slippers",
            "sub": []
          },
          {
            "id": 94,
            "name": "Boots",
            "sub": []
          },
          {
            "id": 95,
            "name": "Sneakers",
            "sub": []
          },
          {
            "id": 364,
            "name": "Shoes accessories",
            "sub": []
          },
          {
            "id": 365,
            "name": "Mules, Clogs & Slippers",
            "sub": []
          },
          {
            "id": 366,
            "name": "Slides & Flip Flops",
            "sub": []
          },
          {
            "id": 367,
            "name": "Wedges",
            "sub": []
          }
        ]
      },
      {
        "id": 13,
        "name": "Jewellery",
        "sub": [
          {
            "id": 96,
            "name": "Bracelets & Bangles",
            "sub": []
          },
          {
            "id": 97,
            "name": "Necklaces & Pendants",
            "sub": []
          },
          {
            "id": 98,
            "name": "Rings",
            "sub": []
          },
          {
            "id": 99,
            "name": "Earrings",
            "sub": []
          },
          {
            "id": 100,
            "name": "Jewellery Sets",
            "sub": []
          },
          {
            "id": 101,
            "name": "Fine Gold",
            "sub": []
          },
          {
            "id": 388,
            "name": "Pins & Brooches",
            "sub": []
          }
        ]
      },
      {
        "id": 14,
        "name": "Watches",
        "sub": [
          {
            "id": 102,
            "name": "Fashion",
            "sub": []
          },
          {
            "id": 103,
            "name": "Business",
            "sub": []
          },
          {
            "id": 104,
            "name": "Casual",
            "sub": []
          },
          {
            "id": 105,
            "name": "Sports",
            "sub": []
          }
        ]
      },
      {
        "id": 15,
        "name": "Accessories",
        "sub": [
          {
            "id": 106,
            "name": "Hats / Caps",
            "sub": []
          },
          {
            "id": 107,
            "name": "Sunglasses",
            "sub": []
          },
          {
            "id": 108,
            "name": "Eyeglasses",
            "sub": []
          },
          {
            "id": 109,
            "name": "Belts",
            "sub": []
          },
          {
            "id": 110,
            "name": "Scarves",
            "sub": []
          },
          {
            "id": 111,
            "name": "Hair Accessories",
            "sub": []
          },
          {
            "id": 374,
            "name": "Gloves",
            "sub": []
          },
          {
            "id": 375,
            "name": "Others",
            "sub": []
          },
          {
            "id": 376,
            "name": "Umbrellas",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 2,
    "name": "Men's Fashion",
    "sub": [
      {
        "id": 16,
        "name": "Clothing",
        "sub": [
          {
            "id": 112,
            "name": "Jackets & Coats",
            "sub": []
          },
          {
            "id": 113,
            "name": "T-shirts",
            "sub": []
          },
          {
            "id": 114,
            "name": "Pants",
            "sub": []
          },
          {
            "id": 115,
            "name": "Jeans",
            "sub": []
          },
          {
            "id": 116,
            "name": "Shirts",
            "sub": []
          },
          {
            "id": 117,
            "name": "Sweaters & Cardigans",
            "sub": []
          },
          {
            "id": 118,
            "name": "Suits",
            "sub": []
          },
          {
            "id": 119,
            "name": "Underwear",
            "sub": []
          },
          {
            "id": 120,
            "name": "Socks",
            "sub": []
          },
          {
            "id": 121,
            "name": "Swimwear",
            "sub": []
          },
          {
            "id": 122,
            "name": "Muslim Wear",
            "sub": []
          },
          {
            "id": 381,
            "name": "Traditional clothes",
            "sub": []
          }
        ]
      },
      {
        "id": 17,
        "name": "Bags & Wallets",
        "sub": [
          {
            "id": 123,
            "name": "Shoulder bags",
            "sub": []
          },
          {
            "id": 124,
            "name": "Sling bags",
            "sub": []
          },
          {
            "id": 125,
            "name": "Messenger bags",
            "sub": []
          },
          {
            "id": 126,
            "name": "Business Bags",
            "sub": []
          },
          {
            "id": 127,
            "name": "Backpacks",
            "sub": []
          },
          {
            "id": 128,
            "name": "Wallets",
            "sub": []
          },
          {
            "id": 377,
            "name": "Bag Accessories",
            "sub": []
          },
          {
            "id": 378,
            "name": "Card and Key Holders",
            "sub": []
          },
          {
            "id": 379,
            "name": "Coin Pouches",
            "sub": []
          },
          {
            "id": 380,
            "name": "Tote bags",
            "sub": []
          }
        ]
      },
      {
        "id": 18,
        "name": "Eyewear",
        "sub": [
          {
            "id": 129,
            "name": "Sunglasses",
            "sub": []
          },
          {
            "id": 130,
            "name": "Eyeglasses",
            "sub": []
          }
        ]
      },
      {
        "id": 19,
        "name": "Shoes",
        "sub": [
          {
            "id": 131,
            "name": "Sneakers",
            "sub": []
          },
          {
            "id": 132,
            "name": "Slip-Ons & Loafers",
            "sub": []
          },
          {
            "id": 133,
            "name": "Formal shoes",
            "sub": []
          },
          {
            "id": 134,
            "name": "Sandals",
            "sub": []
          },
          {
            "id": 135,
            "name": "Boots",
            "sub": []
          },
          {
            "id": 432,
            "name": "Mules & Clogs",
            "sub": []
          },
          {
            "id": 433,
            "name": "Flip Flops",
            "sub": []
          }
        ]
      },
      {
        "id": 20,
        "name": "Accessories",
        "sub": [
          {
            "id": 136,
            "name": "Bracelets",
            "sub": []
          },
          {
            "id": 137,
            "name": "Necklaces & Pendants",
            "sub": []
          },
          {
            "id": 138,
            "name": "Rings",
            "sub": []
          },
          {
            "id": 139,
            "name": "Earrings",
            "sub": []
          },
          {
            "id": 140,
            "name": "Shirt Accessories",
            "sub": []
          },
          {
            "id": 382,
            "name": "Hats / Caps",
            "sub": []
          },
          {
            "id": 383,
            "name": "Scarves",
            "sub": []
          },
          {
            "id": 384,
            "name": "Gloves",
            "sub": []
          },
          {
            "id": 385,
            "name": "Suspenders",
            "sub": []
          },
          {
            "id": 386,
            "name": "Belts",
            "sub": []
          },
          {
            "id": 387,
            "name": "Others",
            "sub": []
          }
        ]
      },
      {
        "id": 21,
        "name": "Watches",
        "sub": [
          {
            "id": 141,
            "name": "Business",
            "sub": []
          },
          {
            "id": 142,
            "name": "Casual",
            "sub": []
          },
          {
            "id": 143,
            "name": "Fashion",
            "sub": []
          },
          {
            "id": 144,
            "name": "Sports",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 3,
    "name": "Electronics",
    "sub": [
      {
        "id": 22,
        "name": "Mobiles",
        "sub": [
          {
            "id": 145,
            "name": "Mobiles",
            "sub": []
          }
        ]
      },
      {
        "id": 23,
        "name": "Tablets",
        "sub": [
          {
            "id": 146,
            "name": "Tablets",
            "sub": []
          }
        ]
      },
      {
        "id": 24,
        "name": "Accessories",
        "sub": [
          {
            "id": 147,
            "name": "Power banks",
            "sub": []
          },
          {
            "id": 148,
            "name": "Phone cases",
            "sub": []
          },
          {
            "id": 149,
            "name": "Laptop & Tablet accessories",
            "sub": []
          },
          {
            "id": 150,
            "name": "Screen protectors",
            "sub": []
          },
          {
            "id": 151,
            "name": "Batteries & chargers",
            "sub": []
          },
          {
            "id": 152,
            "name": "Cables & docks",
            "sub": []
          },
          {
            "id": 153,
            "name": "Car accessories",
            "sub": []
          },
          {
            "id": 154,
            "name": "Parts & Tools",
            "sub": []
          },
          {
            "id": 155,
            "name": "Memory Cards",
            "sub": []
          },
          {
            "id": 412,
            "name": "Computer Accessories",
            "sub": []
          },
          {
            "id": 413,
            "name": "Network Components",
            "sub": []
          }
        ]
      },
      {
        "id": 25,
        "name": "Audio",
        "sub": [
          {
            "id": 156,
            "name": "Headphones & Headsets",
            "sub": []
          },
          {
            "id": 157,
            "name": "Portable Speakers",
            "sub": []
          },
          {
            "id": 158,
            "name": "Home Audio & Theater",
            "sub": []
          }
        ]
      },
      {
        "id": 26,
        "name": "Computers",
        "sub": [
          {
            "id": 159,
            "name": "Hybrid Laptop",
            "sub": []
          },
          {
            "id": 160,
            "name": "Gaming Laptop",
            "sub": []
          },
          {
            "id": 161,
            "name": "Traditional laptops",
            "sub": []
          },
          {
            "id": 162,
            "name": "Macbooks",
            "sub": []
          },
          {
            "id": 414,
            "name": "Computer Software",
            "sub": []
          },
          {
            "id": 415,
            "name": "Desktop",
            "sub": []
          },
          {
            "id": 416,
            "name": "Gaming Desktop",
            "sub": []
          }
        ]
      },
      {
        "id": 417,
        "name": "Printers & Accessories",
        "sub": [
          {
            "id": 418,
            "name": "3D Printing",
            "sub": []
          },
          {
            "id": 419,
            "name": "Printer Memory Modules",
            "sub": []
          },
          {
            "id": 420,
            "name": "Printer Cutter",
            "sub": []
          },
          {
            "id": 421,
            "name": "Fax Machines",
            "sub": []
          },
          {
            "id": 422,
            "name": "Printer Stands",
            "sub": []
          },
          {
            "id": 423,
            "name": "Printers",
            "sub": []
          },
          {
            "id": 424,
            "name": "Ink",
            "sub": []
          }
        ]
      },
      {
        "id": 425,
        "name": "Storage",
        "sub": [
          {
            "id": 426,
            "name": "NAS",
            "sub": []
          },
          {
            "id": 427,
            "name": "USB Flash Drives",
            "sub": []
          },
          {
            "id": 428,
            "name": "Internal Hard Drives",
            "sub": []
          },
          {
            "id": 429,
            "name": "External Hard Drives",
            "sub": []
          },
          {
            "id": 430,
            "name": "Solid State Drives",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 4,
    "name": "Health & Beauty",
    "sub": [
      {
        "id": 27,
        "name": "Skin Care",
        "sub": [
          {
            "id": 163,
            "name": "Face Masks",
            "sub": []
          },
          {
            "id": 164,
            "name": "Moisturisers & Cream",
            "sub": []
          },
          {
            "id": 165,
            "name": "Cleansers",
            "sub": []
          },
          {
            "id": 166,
            "name": "Serum & Essence",
            "sub": []
          },
          {
            "id": 167,
            "name": "Face Scrubs & Peels",
            "sub": []
          },
          {
            "id": 168,
            "name": "Scar Cream",
            "sub": []
          },
          {
            "id": 169,
            "name": "Sunscreen",
            "sub": []
          },
          {
            "id": 170,
            "name": "Toner & Mists",
            "sub": []
          },
          {
            "id": 171,
            "name": "Dermacare",
            "sub": []
          },
          {
            "id": 172,
            "name": "Eye cream",
            "sub": []
          }
        ]
      },
      {
        "id": 28,
        "name": "Makeup",
        "sub": [
          {
            "id": 173,
            "name": "Face",
            "sub": []
          },
          {
            "id": 174,
            "name": "Eyes",
            "sub": []
          },
          {
            "id": 175,
            "name": "Lips",
            "sub": []
          },
          {
            "id": 176,
            "name": "Makeup Tools & Accessories",
            "sub": []
          },
          {
            "id": 177,
            "name": "Nail care",
            "sub": []
          },
          {
            "id": 178,
            "name": "Makeup Kits",
            "sub": []
          },
          {
            "id": 179,
            "name": "Body",
            "sub": []
          },
          {
            "id": 180,
            "name": "Makeup Removers",
            "sub": []
          }
        ]
      },
      {
        "id": 29,
        "name": "Fragrances",
        "sub": [
          {
            "id": 181,
            "name": "Women",
            "sub": []
          },
          {
            "id": 182,
            "name": "Men",
            "sub": []
          }
        ]
      },
      {
        "id": 30,
        "name": "Beauty Tools",
        "sub": [
          {
            "id": 183,
            "name": "Hair Styling",
            "sub": []
          },
          {
            "id": 184,
            "name": "Skin care tools",
            "sub": []
          },
          {
            "id": 185,
            "name": "Slimmers & massagers",
            "sub": []
          },
          {
            "id": 186,
            "name": "Hair removal",
            "sub": []
          },
          {
            "id": 187,
            "name": "Spa Products",
            "sub": []
          }
        ]
      },
      {
        "id": 31,
        "name": "Men's Care",
        "sub": [
          {
            "id": 188,
            "name": "Hair care",
            "sub": []
          },
          {
            "id": 189,
            "name": "Shaving",
            "sub": []
          },
          {
            "id": 190,
            "name": "Body & skin care",
            "sub": []
          }
        ]
      },
      {
        "id": 32,
        "name": "Personal Care",
        "sub": [
          {
            "id": 191,
            "name": "Hair care",
            "sub": []
          },
          {
            "id": 192,
            "name": "Bath & Body",
            "sub": []
          },
          {
            "id": 193,
            "name": "Oral Care",
            "sub": []
          },
          {
            "id": 194,
            "name": "Eye care",
            "sub": []
          },
          {
            "id": 195,
            "name": "Deodorants",
            "sub": []
          },
          {
            "id": 196,
            "name": "Feminine care",
            "sub": []
          },
          {
            "id": 197,
            "name": "Adult diapers",
            "sub": []
          },
          {
            "id": 198,
            "name": "Personal Safety",
            "sub": []
          }
        ]
      },
      {
        "id": 33,
        "name": "Food Supplements",
        "sub": [
          {
            "id": 199,
            "name": "Well Being",
            "sub": []
          },
          {
            "id": 200,
            "name": "Weight Management",
            "sub": []
          },
          {
            "id": 201,
            "name": "Beauty Supplements",
            "sub": []
          },
          {
            "id": 202,
            "name": "Sports Nutrition",
            "sub": []
          }
        ]
      },
      {
        "id": 34,
        "name": "Medical Supplies",
        "sub": [
          {
            "id": 203,
            "name": "Medical Supplies",
            "sub": []
          }
        ]
      },
      {
        "id": 35,
        "name": "Personal Pleasure",
        "sub": [
          {
            "id": 204,
            "name": "Personal Pleasure",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 5,
    "name": "Kids, Baby &Gifts",
    "sub": [
      {
        "id": 36,
        "name": "Diapering",
        "sub": [
          {
            "id": 205,
            "name": "Disposable Diapers",
            "sub": []
          },
          {
            "id": 206,
            "name": "Diaper Bags",
            "sub": []
          },
          {
            "id": 207,
            "name": "Cloth Diapers",
            "sub": []
          },
          {
            "id": 208,
            "name": "Diapering care",
            "sub": []
          },
          {
            "id": 209,
            "name": "Changing Kits",
            "sub": []
          },
          {
            "id": 210,
            "name": "Wipes",
            "sub": []
          }
        ]
      },
      {
        "id": 37,
        "name": "Baby Gear",
        "sub": [
          {
            "id": 211,
            "name": "Strollers",
            "sub": []
          },
          {
            "id": 212,
            "name": "Carriers",
            "sub": []
          },
          {
            "id": 213,
            "name": "Car Seats",
            "sub": []
          },
          {
            "id": 214,
            "name": "Harnesses & leashes",
            "sub": []
          },
          {
            "id": 215,
            "name": "Walkers",
            "sub": []
          },
          {
            "id": 216,
            "name": "Swings, bouncers & jumpers",
            "sub": []
          },
          {
            "id": 217,
            "name": "Playards",
            "sub": []
          }
        ]
      },
      {
        "id": 38,
        "name": "Feeding",
        "sub": [
          {
            "id": 218,
            "name": "Milk Formula",
            "sub": []
          },
          {
            "id": 219,
            "name": "Bottle Feeding",
            "sub": []
          },
          {
            "id": 220,
            "name": "Breastfeeding",
            "sub": []
          },
          {
            "id": 221,
            "name": "Baby & Toddler Food",
            "sub": []
          },
          {
            "id": 222,
            "name": "Highchairs & Booster seats",
            "sub": []
          },
          {
            "id": 223,
            "name": "Utensils",
            "sub": []
          },
          {
            "id": 389,
            "name": "Vitamins",
            "sub": []
          },
          {
            "id": 390,
            "name": "Food Blenders",
            "sub": []
          }
        ]
      },
      {
        "id": 39,
        "name": "Clothing & Accessories",
        "sub": [
          {
            "id": 224,
            "name": "New Born",
            "sub": []
          },
          {
            "id": 225,
            "name": "Baby Girls",
            "sub": []
          },
          {
            "id": 226,
            "name": "Baby Boys",
            "sub": []
          },
          {
            "id": 227,
            "name": "Girls",
            "sub": []
          },
          {
            "id": 228,
            "name": "Boys",
            "sub": []
          }
        ]
      },
      {
        "id": 40,
        "name": "Maternity",
        "sub": [
          {
            "id": 229,
            "name": "Maternity Clothing",
            "sub": []
          },
          {
            "id": 230,
            "name": "Maternity Care",
            "sub": []
          }
        ]
      },
      {
        "id": 41,
        "name": "Pacifiers & Accessories",
        "sub": [
          {
            "id": 231,
            "name": "Pacifiers & Accessories",
            "sub": []
          }
        ]
      },
      {
        "id": 42,
        "name": "Toys & Games",
        "sub": [
          {
            "id": 232,
            "name": "Sports & Outdoor Play",
            "sub": []
          },
          {
            "id": 233,
            "name": "Learning & Education",
            "sub": []
          },
          {
            "id": 234,
            "name": "Dolls & Acessories",
            "sub": []
          },
          {
            "id": 235,
            "name": "Stufed Toys",
            "sub": []
          },
          {
            "id": 236,
            "name": "Blocks & Building",
            "sub": []
          },
          {
            "id": 237,
            "name": "Kids Arts & Craft",
            "sub": []
          },
          {
            "id": 238,
            "name": "Baby & Toddler Toys",
            "sub": []
          },
          {
            "id": 239,
            "name": "Action Figures & Collectibles",
            "sub": []
          },
          {
            "id": 240,
            "name": "Puzzle",
            "sub": []
          },
          {
            "id": 241,
            "name": "Play Vehicles",
            "sub": []
          }
        ]
      },
      {
        "id": 342,
        "name": "Collectibles & Gifts",
        "sub": [
          {
            "id": 344,
            "name": "Gift Cards",
            "sub": []
          },
          {
            "id": 345,
            "name": "Collectibles",
            "sub": []
          },
          {
            "id": 346,
            "name": "Crafts",
            "sub": []
          },
          {
            "id": 347,
            "name": "Gadgets",
            "sub": []
          },
          {
            "id": 348,
            "name": "Stationery",
            "sub": []
          },
          {
            "id": 349,
            "name": "Gift Ideas",
            "sub": []
          }
        ]
      },
      {
        "id": 343,
        "name": "Kids Furniture",
        "sub": [
          {
            "id": 350,
            "name": "Kids Bed",
            "sub": []
          },
          {
            "id": 351,
            "name": "Wardrobe",
            "sub": []
          },
          {
            "id": 352,
            "name": "Desks & Tables",
            "sub": []
          },
          {
            "id": 353,
            "name": "Chairs",
            "sub": []
          },
          {
            "id": 354,
            "name": "Bookcases & Storage",
            "sub": []
          },
          {
            "id": 355,
            "name": "Wall Solutions",
            "sub": []
          },
          {
            "id": 356,
            "name": "Kids Home Accessories",
            "sub": []
          },
          {
            "id": 391,
            "name": "Bedding",
            "sub": []
          },
          {
            "id": 392,
            "name": "Mattresses",
            "sub": []
          }
        ]
      },
      {
        "id": 358,
        "name": "Shoes & Bags",
        "sub": [
          {
            "id": 357,
            "name": "Kids Bags",
            "sub": []
          },
          {
            "id": 359,
            "name": "Boys Shoes",
            "sub": []
          },
          {
            "id": 360,
            "name": "Girls Shoes",
            "sub": []
          },
          {
            "id": 361,
            "name": "Baby Boys Shoes",
            "sub": []
          },
          {
            "id": 362,
            "name": "Baby Girls Shoes",
            "sub": []
          },
          {
            "id": 363,
            "name": "New Born Shoes",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 6,
    "name": "Sports & Outdoors",
    "sub": [
      {
        "id": 43,
        "name": "Exercise & Fitness",
        "sub": [
          {
            "id": 242,
            "name": "Cardio Equipment",
            "sub": []
          },
          {
            "id": 243,
            "name": "Strength Equipment",
            "sub": []
          },
          {
            "id": 244,
            "name": "Fitness Accessories",
            "sub": []
          },
          {
            "id": 245,
            "name": "Weight",
            "sub": []
          },
          {
            "id": 246,
            "name": "Yoga",
            "sub": []
          },
          {
            "id": 247,
            "name": "Pilates",
            "sub": []
          },
          {
            "id": 248,
            "name": "Martial Arts",
            "sub": []
          }
        ]
      },
      {
        "id": 44,
        "name": "Team Sports",
        "sub": [
          {
            "id": 249,
            "name": "Football",
            "sub": []
          },
          {
            "id": 250,
            "name": "Basketball",
            "sub": []
          },
          {
            "id": 251,
            "name": "Volleyball",
            "sub": []
          },
          {
            "id": 252,
            "name": "Cricket",
            "sub": []
          },
          {
            "id": 253,
            "name": "Gymnastics",
            "sub": []
          },
          {
            "id": 254,
            "name": "Other team sports",
            "sub": []
          }
        ]
      },
      {
        "id": 45,
        "name": "Racquet Sports",
        "sub": [
          {
            "id": 255,
            "name": "Badminton",
            "sub": []
          },
          {
            "id": 256,
            "name": "Table Tennis",
            "sub": []
          },
          {
            "id": 257,
            "name": "Tennis",
            "sub": []
          },
          {
            "id": 258,
            "name": "Squash",
            "sub": []
          },
          {
            "id": 259,
            "name": "Other Rachquet Sports",
            "sub": []
          }
        ]
      },
      {
        "id": 46,
        "name": "Outdoor Recreation",
        "sub": [
          {
            "id": 260,
            "name": "Cycling",
            "sub": []
          },
          {
            "id": 261,
            "name": "Camping & Hiking",
            "sub": []
          },
          {
            "id": 262,
            "name": "Fishing",
            "sub": []
          },
          {
            "id": 263,
            "name": "Scooters",
            "sub": []
          },
          {
            "id": 264,
            "name": "Inline & Roller Skating",
            "sub": []
          },
          {
            "id": 265,
            "name": "Skateboards",
            "sub": []
          },
          {
            "id": 266,
            "name": "Swimming",
            "sub": []
          },
          {
            "id": 267,
            "name": "Diving & Snorkeling",
            "sub": []
          },
          {
            "id": 268,
            "name": "Climbing",
            "sub": []
          },
          {
            "id": 269,
            "name": "Golf",
            "sub": []
          },
          {
            "id": 270,
            "name": "Shooting",
            "sub": []
          }
        ]
      },
      {
        "id": 47,
        "name": "Men Sportswear",
        "sub": [
          {
            "id": 271,
            "name": "Men Sports Shoes",
            "sub": []
          },
          {
            "id": 272,
            "name": "Men Sports Clothing",
            "sub": []
          },
          {
            "id": 273,
            "name": "Men Sports Bags",
            "sub": []
          }
        ]
      },
      {
        "id": 48,
        "name": "Women Sports Wear",
        "sub": [
          {
            "id": 274,
            "name": "Women Sports Shoes",
            "sub": []
          },
          {
            "id": 275,
            "name": "Women Sports Clothing",
            "sub": []
          },
          {
            "id": 276,
            "name": "Women Sports Bags",
            "sub": []
          }
        ]
      },
      {
        "id": 49,
        "name": "Sports & Accessories",
        "sub": [
          {
            "id": 277,
            "name": "Protective Goggles",
            "sub": []
          },
          {
            "id": 278,
            "name": "Water Bottles",
            "sub": []
          },
          {
            "id": 279,
            "name": "Sports & Outdoor Trackers",
            "sub": []
          },
          {
            "id": 280,
            "name": "Electronics & Gadgets",
            "sub": []
          },
          {
            "id": 281,
            "name": "Sports medicine",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 7,
    "name": "Home Appliances",
    "sub": [
      {
        "id": 50,
        "name": "Kitchen Appliances",
        "sub": [
          {
            "id": 282,
            "name": "Food Preparation",
            "sub": []
          },
          {
            "id": 283,
            "name": "Fryers",
            "sub": []
          },
          {
            "id": 284,
            "name": "Rice Cooker & Steamers",
            "sub": []
          },
          {
            "id": 285,
            "name": "Coffee Machines & Accessories",
            "sub": []
          },
          {
            "id": 286,
            "name": "Juicers",
            "sub": []
          },
          {
            "id": 287,
            "name": "Kettles  Thermopots",
            "sub": []
          },
          {
            "id": 288,
            "name": "Toasters & Sandwich makers",
            "sub": []
          },
          {
            "id": 289,
            "name": "Electric Knives & Sharpeners",
            "sub": []
          },
          {
            "id": 290,
            "name": "Water purifiers",
            "sub": []
          }
        ]
      },
      {
        "id": 51,
        "name": "Garment Care",
        "sub": [
          {
            "id": 291,
            "name": "Irons",
            "sub": []
          },
          {
            "id": 292,
            "name": "Sewing Machines",
            "sub": []
          },
          {
            "id": 293,
            "name": "Garment Steamers",
            "sub": []
          }
        ]
      },
      {
        "id": 52,
        "name": "Large Appliances",
        "sub": [
          {
            "id": 294,
            "name": "Refrigerators",
            "sub": []
          },
          {
            "id": 295,
            "name": "Washers& Dryers",
            "sub": []
          },
          {
            "id": 296,
            "name": "Microwaves & Ovens",
            "sub": []
          },
          {
            "id": 297,
            "name": "Wine Cellars",
            "sub": []
          },
          {
            "id": 298,
            "name": "Cooktops",
            "sub": []
          },
          {
            "id": 299,
            "name": "Freezers",
            "sub": []
          },
          {
            "id": 300,
            "name": "Ranges & Hobs",
            "sub": []
          },
          {
            "id": 301,
            "name": "Hoods",
            "sub": []
          }
        ]
      },
      {
        "id": 53,
        "name": "Cooling & Heating",
        "sub": [
          {
            "id": 302,
            "name": "Air conditioners",
            "sub": []
          },
          {
            "id": 303,
            "name": "AIr coolers",
            "sub": []
          },
          {
            "id": 304,
            "name": "Fans",
            "sub": []
          },
          {
            "id": 305,
            "name": "Air Purifiers & Dehumidifiers",
            "sub": []
          },
          {
            "id": 306,
            "name": "Water Heater",
            "sub": []
          },
          {
            "id": 307,
            "name": "Ventilation",
            "sub": []
          }
        ]
      }
    ]
  },
  {
    "id": 8,
    "name": "Home & Living",
    "sub": [
      {
        "id": 54,
        "name": "Kitchen & Dining",
        "sub": [
          {
            "id": 308,
            "name": "Cookware",
            "sub": []
          },
          {
            "id": 309,
            "name": "Bakeware",
            "sub": []
          },
          {
            "id": 310,
            "name": "Cooking knives",
            "sub": []
          },
          {
            "id": 311,
            "name": "Kitchen Tools",
            "sub": []
          },
          {
            "id": 312,
            "name": "Tableware",
            "sub": []
          },
          {
            "id": 313,
            "name": "Kitchen Storage",
            "sub": []
          }
        ]
      },
      {
        "id": 55,
        "name": "Housekeeping",
        "sub": [
          {
            "id": 314,
            "name": "Vacuum Cleaners",
            "sub": []
          },
          {
            "id": 315,
            "name": "Steam Mops",
            "sub": []
          },
          {
            "id": 316,
            "name": "Laundry Accessories",
            "sub": []
          },
          {
            "id": 317,
            "name": "Cleaning Products",
            "sub": []
          }
        ]
      },
      {
        "id": 56,
        "name": "Furniture",
        "sub": [
          {
            "id": 318,
            "name": "Sofa & Sectionals",
            "sub": []
          },
          {
            "id": 319,
            "name": "Accent Chairs",
            "sub": []
          },
          {
            "id": 320,
            "name": "Dining Chairs & Stools",
            "sub": []
          },
          {
            "id": 321,
            "name": "Tables & Desks",
            "sub": []
          },
          {
            "id": 322,
            "name": "TV Consoles",
            "sub": []
          },
          {
            "id": 323,
            "name": "Storage Furniture",
            "sub": []
          },
          {
            "id": 324,
            "name": "Beds & Mattresses",
            "sub": []
          },
          {
            "id": 325,
            "name": "Bedroom Furniture",
            "sub": []
          },
          {
            "id": 327,
            "name": "Furniture Sets",
            "sub": []
          }
        ]
      },
      {
        "id": 57,
        "name": "Outdoor & Garden",
        "sub": [
          {
            "id": 328,
            "name": "Lawn & Garden",
            "sub": []
          },
          {
            "id": 329,
            "name": "Grills & Materials",
            "sub": []
          },
          {
            "id": 330,
            "name": "Outdoor Decor",
            "sub": []
          }
        ]
      },
      {
        "id": 58,
        "name": "Home Improvement",
        "sub": [
          {
            "id": 331,
            "name": "Power Tools",
            "sub": []
          },
          {
            "id": 332,
            "name": "Hand Tools",
            "sub": []
          },
          {
            "id": 333,
            "name": "Flashlights",
            "sub": []
          },
          {
            "id": 334,
            "name": "Electrical",
            "sub": []
          },
          {
            "id": 335,
            "name": "Safety & Security",
            "sub": []
          },
          {
            "id": 405,
            "name": "Housekeeping",
            "sub": []
          },
          {
            "id": 406,
            "name": "Hardware",
            "sub": []
          },
          {
            "id": 407,
            "name": "Plumbing",
            "sub": []
          },
          {
            "id": 408,
            "name": "Flooring",
            "sub": []
          },
          {
            "id": 409,
            "name": "Bathroom Fixtures",
            "sub": []
          },
          {
            "id": 410,
            "name": "Kitchen Fixtures",
            "sub": []
          },
          {
            "id": 411,
            "name": "Others",
            "sub": []
          }
        ]
      },
      {
        "id": 59,
        "name": "Lighting",
        "sub": [
          {
            "id": 336,
            "name": "Lighting",
            "sub": []
          }
        ]
      },
      {
        "id": 60,
        "name": "Home Decor",
        "sub": [
          {
            "id": 337,
            "name": "Clocks",
            "sub": []
          },
          {
            "id": 399,
            "name": "Other Home Decor",
            "sub": []
          },
          {
            "id": 400,
            "name": "Curtains, Blinds & Shades",
            "sub": []
          },
          {
            "id": 401,
            "name": "Wall Art",
            "sub": []
          },
          {
            "id": 402,
            "name": "Decor Pillows, Inserts & Covers",
            "sub": []
          },
          {
            "id": 403,
            "name": "Rugs & Carpets",
            "sub": []
          },
          {
            "id": 404,
            "name": "Mirrors",
            "sub": []
          }
        ]
      },
      {
        "id": 61,
        "name": "Bedding",
        "sub": [
          {
            "id": 338,
            "name": "Comforters, Blankets & Throws",
            "sub": []
          },
          {
            "id": 393,
            "name": "Sheets",
            "sub": []
          },
          {
            "id": 394,
            "name": "Bedding Sets",
            "sub": []
          },
          {
            "id": 395,
            "name": "Bedding Accessories",
            "sub": []
          },
          {
            "id": 396,
            "name": "Pillows & Bolsters",
            "sub": []
          },
          {
            "id": 431,
            "name": "Mattresses & Protectors",
            "sub": []
          }
        ]
      },
      {
        "id": 62,
        "name": "Bath",
        "sub": [
          {
            "id": 339,
            "name": "Towels, Mats & Robes",
            "sub": []
          },
          {
            "id": 397,
            "name": "Bathroom Accessories",
            "sub": []
          },
          {
            "id": 398,
            "name": "Shower Accessories",
            "sub": []
          }
        ]
      },
      {
        "id": 63,
        "name": "Storage & Organisation",
        "sub": [
          {
            "id": 340,
            "name": "Storage & Organisation",
            "sub": []
          }
        ]
      }
    ]
  }
]
```
