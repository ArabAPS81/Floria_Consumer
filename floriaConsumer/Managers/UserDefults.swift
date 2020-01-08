//
//  UserDefults.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/29/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
class Defaults {
    
    
    func saveUserId(userId : Int){
        let def = UserDefaults.standard
        def.set(userId, forKey: "userId")
        def.synchronize()
        print(userId)
    }
    
    func getUserId()-> Int? {
        let def = UserDefaults.standard
        return def.integer(forKey: "userId")
    }
    
    var isUserLogged: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "logged")
            if !newValue {
                removeUserToken()
            }
        } get {
            return UserDefaults.standard.bool(forKey: "logged")
        }
    }
    
    private func removeUserToken(){
        let def = UserDefaults.standard
        def.removeObject(forKey: "token")
    }
    
    func saveUserToken(token : String){
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.synchronize()
        print(token)
    }
    
    func getUserToken()-> String? {
        let def = UserDefaults.standard
        return def.string(forKey: "token")
    }
    
    func saveAuthenToken(authenToken : String){
        let def = UserDefaults.standard
        def.set(authenToken, forKey: "authenToken")
        def.synchronize()
        print(authenToken)
    }
    
    func getAuthenToken()-> String? {
        let def = UserDefaults.standard
        return def.string(forKey: "authenToken")
    }
    
    
    func getUniqueID() -> String {
        if let id = UserDefaults.standard.string(forKey: "uuid") {
            return id
        }else {
            let id = NSUUID().uuidString
            UserDefaults.standard.set(id, forKey: "uuid")
            return id
        }
    }
  
    
    func saveUserData(email: String?, name: String?, phone: String?) {
        let def = UserDefaults.standard
        def.set(email, forKey: "email")
        def.set(name, forKey: "name")
        def.set(phone, forKey: "phone")
    }
    
    func getUser() -> userData {
        let def = UserDefaults.standard
        var user = userData.init()
        user.email = def.value(forKey: "email") as? String
        user.name = def.value(forKey: "name") as? String
        user.phone = def.value(forKey: "phone") as? String
        return user
    }
    
}

struct userData {
    var phone: String?
    var name: String?
    var email: String?
}
