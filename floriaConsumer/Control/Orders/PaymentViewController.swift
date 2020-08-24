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
    var orderId: Int!
    
    
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
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("back", comment: ""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(_ sender: Any) {
        let service = OrderServices.init(delegate: self)
        service.cancelOrder(merchantRefNum: orderId)
        navigationController?.popViewController(animated: true)
    }
    
    func responsePaymentFinish(_ response: PaymentResponse) {
        print(response)
        if response.http_code == 201 || response.http_code == 200 || response.success! {
            showAlert("payment done is")
        }else {
            showFailureAlert(response.message)
        }
        
    }
    
    func showAlert(_ message: String?) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.navToOrdersVC()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showFailureAlert(_ message: String?) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func navToOrdersVC() {
        let ordersVC = OrdersViewController.newInstance()
        let home = self.navigationController!.viewControllers.first!
        self.navigationController?.setViewControllers([home,ordersVC], animated: true)
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
                        webView.loadHTMLString("", baseURL: nil)
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

extension PaymentViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    
}

struct PaymentResponse: Codable {
    let http_code: Int?
    let success: Bool?
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
