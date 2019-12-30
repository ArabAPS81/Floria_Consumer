//
//  WebserviceHelper.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 07/06/19.
//  Copyright © 2019 Abhisek. All rights reserved.


class WebServiceConfigure {
    
    static func getHeadersForAuthentication() -> [String:String] {
        let token = Defults.init().getAuthenToken()
        let headers: [String: String] = [//"Content-Type":"application/json",
                      // "Accept": "application/json",
                       "Authorization":"Bearer " + (token ?? "")]
        return headers
    }
    
    static func getHeadersForAuthenticatedState() -> [String:String] {
        let token = Defults.init().getUserToken()
        let headers: [String: String] = [//"Content-Type":"application/json",
                      // "Accept": "application/json",
                       "Authorization":"Bearer " + (token ?? "")]
        return headers
    }
    static func getHeadersForUnauthenticatedState() -> [String:String] {
        let headers: [String: String] = [
                       "Accept": "application/json",
                       "Accept-Language": "ar"]
        return headers
    }
}
//"Content-Type":"application/json",
