//
//  RealmHelper.swift
//  DiscordLogin
//
//  Created by Papillon on 2021/09/09.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static let shared = RealmHelper()
    let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    
    func getAccessToken() -> String? {
        if let auth = realm.objects(Auth.self).first {
            return auth.accessToken
        }
        
        return nil
    }
    
    func getAuthCode() -> String? {
        if let auth = realm.objects(Auth.self).first {
            return auth.code
        }
        
        return nil
    }
    
    func getAuth() -> Auth? {
        return realm.objects(Auth.self).first
    }
    
    func setAuthCode(code: String) {
        if let auth = realm.objects(Auth.self).first {
            try! realm.write {
                realm.delete(auth)
            }
        }
        
        let auth = Auth()
        auth.code = code
        
        try! realm.write {
            realm.add(auth)
        }
    }
    
    func setAuth(auth: Auth) {
        if let auth = realm.objects(Auth.self).first {
            try! realm.write {
                realm.delete(auth)
            }
        }
        
        try! realm.write {
            realm.add(auth)
        }
    }
}

class Auth: Object {
    
    @objc dynamic var accessToken: String = ""
    @objc dynamic var code: String = ""
    @objc dynamic var refreshToken: String = ""
}
