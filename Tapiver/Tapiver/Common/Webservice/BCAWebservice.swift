//
//  BCAWebservice.swift
//  BCAInvestment
//
//  Created by HungHN on 11/24/17.
//  Copyright © 2017 HungHoang. All rights reserved.
//

import UIKit

import UIKit
import Foundation
import AFNetworking

typealias ServerResponseHandler = (_ success:Bool, _ response:BCABaseEntity?) -> Void;

class BCAWebservice: NSObject {
    static let shareInstance = BCAWebservice()
    let requestManager:AFHTTPSessionManager!
    override init() {
        let securityPolicy:AFSecurityPolicy = AFSecurityPolicy();
        securityPolicy.allowInvalidCertificates = true
        securityPolicy.validatesDomainName = false;
        self.requestManager = AFHTTPSessionManager();
        let set = NSMutableSet(set: (self.requestManager!.responseSerializer.acceptableContentTypes)!)
        set.add("application/json")
        set.add("text/html")
        let setobj  = NSSet(set: set)
        self.requestManager.securityPolicy = securityPolicy;
        self.requestManager!.responseSerializer.acceptableContentTypes = setobj as? Set<String>
        //        let requestSerializer:AFHTTPRequestSerializer = AFHTTPRequestSerializer()
        let requestSerializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
        requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
        self.requestManager!.requestSerializer = requestSerializer
        self.requestManager!.responseSerializer = AFJSONResponseSerializer()
        self.requestManager!.requestSerializer.timeoutInterval = TimeInterval(60)
    }
    
    func sendGETRequest(path:String!,
                        params:NSDictionary?,
                        headers:NSDictionary?,
                        responseObjectClass:BCABaseEntity!,
                        responseHandler:@escaping ServerResponseHandler) -> Void {
        
        let allKeys = headers?.allKeys as? [String] ?? []
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager!.get(path, parameters: params, progress: nil, success: {(task, responseObject) -> Void in
            print("responseObject ->> \(String(describing: responseObject))")
            if responseObject is NSDictionary {
                responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
            } else {
                responseObjectClass.parserResponse(dic: responseObject as! NSDictionary)
            }
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) -> Void in
            responseHandler(false, nil);
        })
    }
    
    func sendPOSTRequest (path:String!,
                          params:NSDictionary?,
                          headers:NSDictionary?,
                          responseObjectClass:BCABaseEntity!,
                          responseHandler:@escaping ServerResponseHandler) -> Void {
        let allKeys = headers?.allKeys as? [String] ?? []
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        self.requestManager!.post(path, parameters:params , progress: nil, success: {(task, responseObject) -> Void in
            
            print("responseObject ->> \(String(describing: responseObject))")
            responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
            responseHandler(true, responseObjectClass);
        }, failure: { (task, responseOBJ) -> Void in
            
            print(task?.error ?? "error  null")
            responseHandler(false, nil);
        })
        
    }
    
    func sendMultiPartFile(path: String,
                           params:NSDictionary?,
                           headers:NSDictionary?,
                           fileData: Data!,
                           fileName: String,
                           responseObjectClass:BCABaseEntity!,
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
            responseObjectClass.parserResponse(dic:(responseObject as? NSDictionary)!)
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) -> Void in
            
            print(task?.error ?? "error  null")
            responseHandler(false, nil);
        })
    }
    
    
    private func convertParamsToJson(params:NSDictionary) -> String {
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
