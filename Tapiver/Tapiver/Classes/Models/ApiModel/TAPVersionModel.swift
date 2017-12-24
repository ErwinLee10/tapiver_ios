//
//  TAPVersionModel.swift
//  Tapiver
//
//  Created by admin on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

class TAPVersionModel: TAPBaseEntity {
    var latestVersionCode: Int?
    var latestVersionName: String?
    var minimumVersionSupportedCode: Int?
    var minimumVersionSupportedName: String?
    var recommendedVersionToUpdateCode: Int?
    var recommendedVersionToUpdateName: String?
    
    override func parserResponse(dic: NSDictionary) {
        guard let latestVersion: NSDictionary = dic.value(forKey: "latestVersion") as? NSDictionary else { return }
        latestVersionCode = latestVersion.value(forKey: "versionCode") as? Int
        latestVersionName = latestVersion.value(forKey: "versionName") as? String
        
        guard let minimumVersionSupported: NSDictionary = dic.value(forKey: "minimumVersionSupported") as? NSDictionary else { return }
        minimumVersionSupportedCode = minimumVersionSupported.value(forKey: "versionCode") as? Int
        minimumVersionSupportedName = minimumVersionSupported.value(forKey: "versionName") as? String
        
        guard let recommendedVersionToUpdate: NSDictionary = dic.value(forKey: "recommendedVersionToUpdate") as? NSDictionary else { return }
        recommendedVersionToUpdateCode = recommendedVersionToUpdate.value(forKey: "versionCode") as? Int
        recommendedVersionToUpdateName = recommendedVersionToUpdate.value(forKey: "versionName") as? String
    }
}
