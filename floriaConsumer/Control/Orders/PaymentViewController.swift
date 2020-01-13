//
//  PaymentViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 1/13/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import WebKit

class PaymentViewController: UIViewController,WKUIDelegate{
    
    var webView: WKWebView!
    var urlString: String!
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
            // webView.
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let url = URL.init(string: urlString)!
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
    func responsePaymentFinish(_ response: PaymentResponse) {
        print(response)
        showAlert("payment done is : \(response.http_code ?? 0)")
    }
    
    func showAlert(_ message: String?) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension PaymentViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.getElementsByTagName(\"pre\")[0].innerHTML") { (resultString, error) in
            if error == nil {
                guard let htmlString = resultString as? String else { return}
               // htmlString = "{\"status\":true}"
                JSONResponseDecoder.decodeFrom(htmlString.data(using: .utf8)!, returningModelType: PaymentResponse.self) { (result, erorr) in
                    if result != nil {
                        self.responsePaymentFinish(result!)
                    }
                }
            }
        }
    }
}

struct PaymentResponse: Codable {
    let http_code: Int?
    let message: String?
    let error:PaymentResponseError?
    struct PaymentResponseError: Codable {
        let message : Message?
        struct Message : Codable {
            let body : [String]?
        }
    }
}
