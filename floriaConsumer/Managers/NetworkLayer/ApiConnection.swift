//
//  ApiConnection.swift
//  Homy
//
//  Created by arabpas on 1/22/20.
//  Copyright © 2020 Mariam Elenna. All rights reserved.
//

import Foundation
import Alamofire
import Reachability
import PKHUD

class ApiConnection {
    
    class func request<T: Codable>(_ method: HTTPMethod = .get,
                                   url: String,
                                   parameters: [String: Any] = [:],
                                   headers: [String: String] = [:],
                                   showProgress: Bool = false,
                                   model: T.Type,
                                   completion: @escaping((T) -> ()),
                                   failure: @escaping((Error) -> ())) {
        
        let reachability = try! Reachability()
        try! reachability.startNotifier()
        switch reachability.connection {
        case .wifi , .cellular:
            if showProgress {HUD.show(.progress)}
            Alamofire.request(url, method: method, parameters: parameters,encoding: URLEncoding.default, headers: headers ).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print(value)
                    JSONResponseDecoder.decodeFrom(response.data!, returningModelType: model) { (result, error) in
                        if let result = result {
                            if showProgress {HUD.flash(.success)}
                            completion(result)
                        }else {
                            if showProgress {HUD.flash(.error)}
                            failure(error ?? HMError.failToParseJson)
                        }
                    }
                case .failure(let error):
                    if showProgress {HUD.flash(.error)}
                    failure(error)
                }
            }
        case .unavailable:
            failure(HMError.noInternetConnection)
            let vc = UIApplication.getTopViewController()
            let storyboard = UIStoryboard(name: "Notifications", bundle: nil)
            let locationsVC = storyboard.instantiateViewController(withIdentifier: "NoInternetViewController") as! NoInternetViewController
            locationsVC.modalPresentationStyle = .fullScreen
            vc?.present(locationsVC, animated: true, completion: nil)
            
            
        case .none:
            break
        }
        
        
    }
}



extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

enum HMError: Error {
    case noInternetConnection
    case failToParseJson
}
