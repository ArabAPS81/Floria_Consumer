//
//  WebserviceHelper.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 07/06/19.
//  Copyright © 2019 Abhisek. All rights reserved.


class WebServiceConfigure {
    
    static func getHeadersForAuthenticatedState() -> [String:String] {
        let headers: [String: String] = [//"Content-Type":"application/json",
                      // "Accept": "application/json",
                       "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjFhYWY3ODlmNWVjMzQ2NjM5YjEwN2Q0OThjNmRmY2NjODhiYmRlZDhhZGY1Njk3NTUxMjJmZDI0NzZjYTZkMDQzNGNiYWJkMzA5OGY4NTlhIn0.eyJhdWQiOiIxIiwianRpIjoiMWFhZjc4OWY1ZWMzNDY2MzliMTA3ZDQ5OGM2ZGZjY2M4OGJiZGVkOGFkZjU2OTc1NTEyMmZkMjQ3NmNhNmQwNDM0Y2JhYmQzMDk4Zjg1OWEiLCJpYXQiOjE1NzY5MTkxOTMsIm5iZiI6MTU3NjkxOTE5MywiZXhwIjoxNjA4NTQxNTkzLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.ROXb4OIAIr5PDX8ZULP25pIkNFy4HSB7j3z8g0P5s2lVxzB-GoKZLntLke1twdbpO1EHdk2k1uPTtID40SZ9iKrm6qwBrq8PmZ5MnrJy3YPHxqvFL0cLyNoYMMzXN-pMLKgoRHSlpbgZBXjbiJkvIUamW2FoZA5TozG1Ybv_QVbFrWSAATbEQQjnG61oy7kzNQDT70xZAr43zueAOiwwEVJl66oUCU1wP1VfRy37ncPOaVpX_jT4K1XUcYsCW1BnyLQXPqgOP0zvkJgpEs--0MnUkKMpyUsLPGMLDDwCxVlIFI5twMPY0rjUAC-PXTp8o85W6zRV1v7QpW7c9TjXJ0a8RENI5vppycBUNT-nLyRp-dsldLk_XoZXzozKOeICXAZoD0jVbbTqdgwRNCLPg_iwizzP1aVzEomfQ_xWugHVKMVmOOr9n8ZmPwaVTCVa2e00FNOdOPuEQG8fZ7vOGwL1gyBWWOf_OT08MxIRDWdYKHyvMTvnRn2SU1TRkjz3EmcW6N7ssuw-LYZwwdVPrWW9zcuV5G7kqkT38TcrCiapSCA8h1xCaknB0Fe8t5bEFZfoFTat5dQ--nQ7QNxeTNVSurTkshmWeZpR4b31x7jnmL9zQMVglznuKYrGF2IoeQfPCSRFvZOaHpfa0czJmMtuRA7ON7KSuRmdN9oFgjg"]
        return headers
    }
    static func getHeadersForUnauthenticatedState() -> [String:String] {
        let headers: [String: String] = ["Content-Type":"application/json",
                       "Accept": "application/json",
                       "Accept-Language": "en"]
        return headers
    }
                        
}

