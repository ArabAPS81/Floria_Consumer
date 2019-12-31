//
//  UserDefults.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/29/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
class Defaults {
    
    
    
    func saveUserData(userId : Int , userName : String , phone : String){
        
    }
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
        } get {
            return UserDefaults.standard.bool(forKey: "logged")
        }
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
    
    
}
