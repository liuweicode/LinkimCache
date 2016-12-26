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
    private static var _unitedDict: [AnyHashable: Any]?
    
    class var currentTokenDict: [AnyHashable: Any]
    {
        get {
            objc_sync_enter(self)
            if  _unitedDict == nil {
                _unitedDict = [AnyHashable: Any]()
                if let dict = UserDefaults.standard.object(forKey: kUserDefaultDataKey) as? [AnyHashable: Any]
                {
                    _ = dict.map{
                        _unitedDict![$0.0] = $0.1
                    }
                }
            }
            objc_sync_exit(self)
            return _unitedDict!
        }
        set{
            _unitedDict = newValue
        }
    }
    
    fileprivate class func saveAllData()
    {
        guard let myUnitedDict = _unitedDict else {
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
        guard let _ = _unitedDict else {
            return
        }
        _unitedDict!.removeAll()
        UserDefaultsData.saveAllData()
    }
}

extension UserDefaultsData
{
    class func userLoginPhone() -> String?
    {
        if let phone = UserDefaultsData.currentTokenDict["user_login_phone"] as? String
        {
            return phone
        }
        return nil
    }

    class func setUserLoginPhone(_ phone: String)
    {
        UserDefaultsData.currentTokenDict["user_login_phone"] = phone
        UserDefaultsData.saveAllData()
    }
    
    class func token() -> String?
    {
        if let token = UserDefaultsData.currentTokenDict["token"] as? String
        {
            return token
        }
        return nil
    }
    
    class func setToken(_ token: String)
    {
        UserDefaultsData.currentTokenDict["token"] = token
        UserDefaultsData.saveAllData()
    }

}
