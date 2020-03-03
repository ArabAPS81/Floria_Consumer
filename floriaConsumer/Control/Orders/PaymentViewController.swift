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
        webView.sizeToFit()
        let url = URL.init(string: urlString)!
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
    func responsePaymentFinish(_ response: PaymentResponse) {
        print(response)
        if response.http_code == 201 {
            showAlert("payment done is : \(response.data?.orderId ?? "")")
        }else {
            showAlert(response.error?.message?.body?.first)
        }
        
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

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            let bv = urlStr
        }
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {     //for making the content to fit with the device size
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        webView.evaluateJavaScript(jscript)
    }
}

struct PaymentResponse: Codable {
    let http_code: Int
    let message: String?
    let error:PaymentResponseError?
    let data: PaymentOrder?
    struct PaymentResponseError: Codable {
        let message : Message?
        struct Message : Codable {
            let body : [String]?
        }
    }
    
    struct PaymentOrder: Codable {
        let orderId: String?
        let decision: String?
    }
    
}
