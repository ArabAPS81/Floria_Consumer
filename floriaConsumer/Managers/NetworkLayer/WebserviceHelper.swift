//
//  WebserviceHelper.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 07/06/19.
//  Copyright © 2019 Abhisek. All rights reserved.


class WebServiceConfigure {
    
    static func getHeadersForAuthenticatedState() -> [String:String] {
        let headers: [String: String] = ["Content-Type":"application/json",
                       "Accept": "application/json",
                       "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImU1MTNmZDNmMjYxNThhN2Q1YzZlNzViYzM3MTk1NTEyZGRlMWIyMDIzYzIzMDAyMTRjMDIwYmI4ZTcxODM1YTQ0NDQyZTJkZTcwODc3YTI2In0.eyJhdWQiOiIxIiwianRpIjoiZTUxM2ZkM2YyNjE1OGE3ZDVjNmU3NWJjMzcxOTU1MTJkZGUxYjIwMjNjMjMwMDIxNGMwMjBiYjhlNzE4MzVhNDQ0NDJlMmRlNzA4NzdhMjYiLCJpYXQiOjE1NzM5MjUzMDEsIm5iZiI6MTU3MzkyNTMwMSwiZXhwIjoxNjA1NTQ3NzAxLCJzdWIiOiI3Iiwic2NvcGVzIjpbXX0.mTwnhov6Vhmt9Pktvno63ArQY8gucHeFYzrbaAe7yhunDPtb488MD9t0977KIixDeFSbMeZmn2s6-a5gtV9lecY8-y3NhbHmovBeSHlCEl1Siaf0uH_ZtXZGb9F1VvuK3RVWhj1iQH91ZVuTohpf6hIvo2cq08yTtZBx4SfbCgK5Zq9ZCVvnNdNXnBbHyl3J8HduMDd-V-N6cBBuHfAO4nN0hgEkd023kp_VG_VTsQHZa36b3bxhe24JrFDvxh8hXn3Bc9TUx4Dgannu99uoMa0M-sr4Y2Xs1hm3x3AskbuRsICARiVMIBXI7j2871Fi1Bt7VN7nHJV9QfZdnzYM6fFN07w8hFSF6nhu2qU4PpvPm9cfvpctn6ztjNtslCS--A_te_FEqjXiQfLLmoLrjPv5xtoN7xhVmDxV0JR1LXsXRtVyFUy0OjlJjfnnnyJVL3lCbX50lK-Zlla6Xr03pUX2MAi47VngIvAFZfe0Ebqt06qQ7wCUXjkMoKn5iAGvv6m_vFS2lduEoQXiO7m1AeRFJqn4Gg63n8S1434Bz1seq1dY8l4kkDL2yfoAbcdgTM89ilS896PlZU-crI-R_Po4TNRFwFTXk-DCKORgj5dvJfJGECHIIUtfz4QTP6gjXateYHB92sdQRDo1KxcmU3YE3cUpH6Sn9ZX6C2AsGL8"]
        return headers
    }
    static func getHeadersForUnauthenticatedState() -> [String:String] {
        let headers: [String: String] = ["Content-Type":"application/json",
                       "Accept": "application/json",
                       "Accept-Language": "en"]
        return headers
    }
                        
}

