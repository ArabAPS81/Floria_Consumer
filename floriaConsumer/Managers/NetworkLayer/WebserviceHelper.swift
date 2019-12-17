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
                       "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjIyZmU2ODdhMGM4NWJmM2MyMmRkZmNlYzkyMWFjNzcxYjhlOGYxN2Q1YjFmOWMyMWE3MzMxMWJmMmM3Mjg5MTc5YTEyMWM3MTRlZTg0ZDRlIn0.eyJhdWQiOiIxIiwianRpIjoiMjJmZTY4N2EwYzg1YmYzYzIyZGRmY2VjOTIxYWM3NzFiOGU4ZjE3ZDViMWY5YzIxYTczMzExYmYyYzcyODkxNzlhMTIxYzcxNGVlODRkNGUiLCJpYXQiOjE1NzY1Nzk2NzIsIm5iZiI6MTU3NjU3OTY3MiwiZXhwIjoxNjA4MjAyMDcyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.ShjtOdD6WbuiAjggI96i_HwRLQM8pZdgqexaLLnIySPTfmXuEf9gFci49AV_Aq-If5xqRZQO2r85Um0ZpGSdCwW_g0pX_WwDDVwcXnpZpnUY4Z9HdB6rnWS14etoRBFXWbUvUrBGjJbq8W2oNOZYEEcUU0UlVlipWM_W0c61gWLs6uXnnec3lzzYoMDZbDsW-q3eBfN9sBzutzpN9JTe2UefP-h8BG5Gu_Ob3G-rajLbhzBLaM09Eav1jK2rYbgS0I0qcO9fG7t33ZCJTSs7H_Hkq0H4aLJwgJBcbJTmWSZYliY4jFaZBsElQAe5DsnW_9AaTcYjTfNGXx27mBgZtumIB4VlbZm64FwiXJfflbyCeBVcdArO_mPuJjTQWNTHnLRtqxBitpohdp8mh8WFh1Cgk38O5ye_vifkN13MCo3pZD5tJZ_baxTIQocikvolu3W-67IK04mNwAmVFsEknKaB_fyVQk5mK7eQ0YjiHhGuxp2WLTn0wekYee2BpHStfcXnVEfHbLMDI038p5o4SlvV3NjishgIMguuYAsgUgqaJPfr6Lv3oEE0CuUC9VM40FjghG8QJu5SyShjK0Xhk2QdmFtCk8pSPd71iei62p8BX2JwK9OYS9g2LudTpzEwW1pGG4Zj0TCqhgdBjo-U0iKU5WWC8zc2uN7YzVWCaRQ"]
        return headers
    }
    static func getHeadersForUnauthenticatedState() -> [String:String] {
        let headers: [String: String] = ["Content-Type":"application/json",
                       "Accept": "application/json",
                       "Accept-Language": "en"]
        return headers
    }
                        
}

