//
//  LUserDefaultsCache.swift
//  LinkimCache
//
//  Created by 刘伟 on 23/12/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import Foundation

let kUserDefaultDataKey = "kUserDefaultDataKey"

class UserDefaultsData
{
    fileprivate static var unitedDict: [AnyHashable: Any]?
    
    class func currentTokenDict() -> [AnyHashable: Any]
    {
        objc_sync_enter(self)
        if  unitedDict == nil {
            unitedDict = [AnyHashable: Any]()
            if let dict = UserDefaults.standard.object(forKey: kUserDefaultDataKey) as? [AnyHashable: Any]
            {
                _ = dict.map{
                    unitedDict![$0.0] = $0.1
                }
            }
        }
        objc_sync_exit(self)
        return unitedDict!
    }
    
    fileprivate class func saveAllData()
    {
        guard let myUnitedDict = unitedDict else {
            return
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: myUnitedDict, options: .init(rawValue: 0))
        {
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: kUserDefaultDataKey)
            userDefaults.synchronize()
        }
    }
    
    class func clearAllData()
    {
        guard let _ = unitedDict else {
            return
        }
        unitedDict!.removeAll()
        UserDefaultsData.saveAllData()
    }
}
