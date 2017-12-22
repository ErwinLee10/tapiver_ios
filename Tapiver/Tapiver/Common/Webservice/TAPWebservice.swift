//
//  TAPWebservice.swift
//  BCAInvestment
//
//  Created by HungHN on 11/24/17.
//  Copyright © 2017 HungHoang. All rights reserved.
//

import UIKit

import UIKit
import Foundation
import AFNetworking

typealias ServerResponseHandler = (_ success:Bool, _ response:TAPBaseEntity?) -> Void;

class TAPWebservice: NSObject {
    static let shareInstance = TAPWebservice()
    let requestManager:AFHTTPSessionManager!
    override init() {
        let securityPolicy:AFSecurityPolicy = AFSecurityPolicy();
        securityPolicy.allowInvalidCertificates = true
        securityPolicy.validatesDomainName = false;
        self.requestManager = AFHTTPSessionManager()
        self.requestManager.securityPolicy = securityPolicy
        
        let requestSerializer = AFJSONRequestSerializer()
        requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
        self.requestManager.requestSerializer = requestSerializer
        self.requestManager.responseSerializer = AFJSONResponseSerializer(readingOptions: .allowFragments)
        self.requestManager.requestSerializer.timeoutInterval = TimeInterval(60)
        
        if let contentType = self.requestManager.responseSerializer.acceptableContentTypes {
            let set = NSMutableSet(set: contentType)
            set.add("application/json")
            set.add("text/html")
            
            let setobj  = NSSet(set: set)
            self.requestManager.responseSerializer.acceptableContentTypes = setobj as? Set<String>
        }
    }
    
    // MARK: - Public methods
    
    func sendGETRequest(path:String!,
                        params:[String: Any]?,
                        responseObjectClass:TAPBaseEntity!,
                        responseHandler:@escaping ServerResponseHandler) {
        
        let header = ["Content-Type": "application/json",
                     "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""
                    ]
        let apiPath = API_PATH(path: path)
        
        sendGETRequest(path: apiPath, params: params as NSDictionary?, headers: header as NSDictionary, responseObjectClass: responseObjectClass, responseHandler: responseHandler)
    }
    
    func sendGETRequest(path:String!,
                        params:NSDictionary?,
                        headers:NSDictionary?,
                        responseObjectClass:TAPBaseEntity!,
                        responseHandler:@escaping ServerResponseHandler) -> Void {
        
        let allKeys = headers?.allKeys as? [String] ?? []
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        print("====================\nRequest: path: \(path) \n params: \n \(String(describing: params))")
        
        self.requestManager!.get(path, parameters: params, progress: nil, success: {(task, responseObject) -> Void in
            print("responseObject ->> \n\(String(describing: responseObject))")
            if let response = responseObject as? NSDictionary {
                responseObjectClass?.parserResponse(dic: response)
            } else if let response = responseObject as? [NSDictionary] {
                responseObjectClass?.parserResponseArray(dics: response)
            } else {
                responseHandler(false, responseObjectClass);
                return
            }
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) -> Void in
            responseHandler(false, nil);
        })
    }
    
    func sendPOSTRequest(path:String!,
                        params:[String: Any]?,
                        responseObjectClass:TAPBaseEntity!,
                        responseHandler:@escaping ServerResponseHandler) {
        
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""
        ]
        let apiPath = API_PATH(path: path)
        
        sendPOSTRequest(path: apiPath, params: params as NSDictionary?, headers: header as NSDictionary, responseObjectClass: responseObjectClass, responseHandler: responseHandler)
    }
    
    func logout(responseHandler: @escaping(_ success: Bool) -> Void) {
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        let path = API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "0")/logout")
        self.requestManager.delete(path, parameters: nil, success: { (task, responseObject) in
            TAPGlobal.shared.deleteProfileModel()
            TAPGlobal.shared.deleteLoginModel()
            TAPGlobal.shared.saveHasLogin(isLogin: false)
            responseHandler(true)
        }, failure: { (task, responseObject) in
            responseHandler(false)
        })
    }
    
    func sendPOSTRequest (path:String!,
                          params:NSDictionary?,
                          headers:NSDictionary?,
                          responseObjectClass:TAPBaseEntity!,
                          responseHandler:@escaping ServerResponseHandler) -> Void {
        let allKeys = headers?.allKeys as? [String] ?? []
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager!.post(path, parameters:params , progress: nil, success: {(task, responseObject) -> Void in
            
            print("responseObject ->> \(String(describing: responseObject))")
            if let response = responseObject as? NSDictionary {
                responseObjectClass?.parserResponse(dic: response)
            } else if let response = responseObject as? [NSDictionary] {
                responseObjectClass?.parserResponseArray(dics: response)
            } else {
                responseHandler(false, responseObjectClass);
                return
            }
            responseHandler(true, responseObjectClass);
        }, failure: { (task, responseOBJ) -> Void in
            
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false, nil);
        })
        
    }
    
    func sendPOSTRequest (path:String!, params:NSDictionary?, responseHandler: @escaping(_ success: Bool, _ value: Int) -> Void) {
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager!.post(path, parameters:params , progress: nil, success: {(task, responseObject) -> Void in
            
            print("responseObject ->> \(String(describing: responseObject))")
            responseHandler(true, responseObject as! Int)
            
        }, failure: { (task, responseOBJ) -> Void in
            
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false, 0)
        })
        
    }
    
    func sendPOSTRequest (path:String!, params:NSDictionary?, responseHandler: @escaping(_ success: Bool) -> Void) {
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager!.post(path, parameters:params , progress: nil, success: {(task, responseObject) -> Void in
            
            print("responseObject ->> \(String(describing: responseObject))")
            responseHandler(true)
            
        }, failure: { (task, responseOBJ) -> Void in
            
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false)
        })
        
    }
    
    func sendDELETERequest(path: String, responseHandler: @escaping(_ success: Bool) -> Void) {
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        let apiPath = API_PATH(path: path)
        
        print("====================\nRequest: path: \(apiPath)")
        self.requestManager.delete(apiPath, parameters: nil, success: { (task, responseObject) -> Void in
            responseHandler(true);
        }) { (task, responseOBJ) in
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false);
        }
    }
    
    func sendDELETERequest(path: String, responseHandler: @escaping(_ success: Bool, _ response: Any?) -> Void) {
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        let apiPath = API_PATH(path: path)
        
        print("====================\nRequest: path: \(apiPath)")
        self.requestManager.delete(apiPath, parameters: nil, success: { (task, responseObject) -> Void in
            responseHandler(true,responseObject);
        }) { (task, responseOBJ) in
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false,responseOBJ);
        }
    }
    
    func sendPUTRequest(path: String, parameters: [String: Any]?, responseHandler: @escaping(_ success: Bool) -> Void) {
        
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        let apiPath = API_PATH(path: path)
        
        print("====================\nRequest: path: \(apiPath)")
        self.requestManager.put(apiPath, parameters: parameters, success: { (task, responseObject) -> Void in
            responseHandler(true);
        }) { (task, responseOBJ) in
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false);
        }
    }
    
    func sendPUTRequest(path: String, parameters: [String: Any]?, responseHandler: @escaping(_ success: Bool, _ response: Any?) -> Void) {
        
        let header = ["Content-Type": "application/json",
                      "Authorization": TAPGlobal.shared.getLoginModel()?.webSessionId ?? ""] as NSDictionary
        let allKeys = header.allKeys as? [String] ?? []
        for key in allKeys {
            let value = header.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        let apiPath = API_PATH(path: path)
        
        print("====================\nRequest: path: \(apiPath)")
        self.requestManager.put(apiPath, parameters: parameters, success: { (task, responseObject) -> Void in
            responseHandler(true, responseObject);
        }) { (task, responseOBJ) in
            print("errorObject ->> \(String(describing: responseOBJ))")
            responseHandler(false, responseOBJ);
        }
    }
    
    func sendMultiPartFile(path: String,
                           params:NSDictionary?,
                           headers:NSDictionary?,
                           fileData: Data!,
                           fileName: String,
                           responseObjectClass:TAPBaseEntity!,
                           responseHandler:@escaping ServerResponseHandler) -> Void {
        let allKeys = headers?.allKeys as? [String] ?? []
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        self.requestManager!.post(path, parameters: params, constructingBodyWith: { (data: AFMultipartFormData!) in

            data.appendPart(withFileData: fileData, name: "", fileName: fileName, mimeType: "image/*")
        }, progress: nil,success: {(task, responseObject) -> Void in
            
            print("responseObject ->> \(String(describing: responseObject))")
            if let response = responseObject as? NSDictionary {
                responseObjectClass?.parserResponse(dic: response)
            } else if let response = responseObject as? [NSDictionary] {
                responseObjectClass?.parserResponseArray(dics: response)
            } else {
                responseHandler(false, responseObjectClass);
                return
            }
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) -> Void in
            
            print(task?.error ?? "error  null")
            responseHandler(false, nil);
        })
    }
    
    
   
}

// MARK: - Private methods
extension TAPWebservice {
    fileprivate func convertParamsToJson(params:NSDictionary) -> String {
        do {
            if let data:NSData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) as NSData? {
                if let jsonString = String.init(data: data as Data, encoding: String.Encoding.utf8) {
                    return jsonString
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}
