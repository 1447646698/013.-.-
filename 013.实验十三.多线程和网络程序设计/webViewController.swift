//
//  webViewController.swift
//  013.实验十三.多线程和网络程序设计
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 李潘. All rights reserved.
//

import UIKit
import WebKit
class webViewController: UIViewController,WKUIDelegate,WKNavigationDelegate{

    
    //进度条
    @IBOutlet weak var progressView: UIProgressView!
    //加载网页的view
    @IBOutlet weak var webView: WKWebView!
    //网址输入框
    @IBOutlet weak var webText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始加载网址
        if let url = URL(string: "http://www.baidu.com") {
            webView.load(URLRequest(url: url))
            webView.navigationDelegate = self
            webView.uiDelegate = self
            webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        }
    }
    //获取网页的标题
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.title") { (title, error) in
            if let title = title as? String {
                self.title = title
            }
        }
    }
    //跳转到目标网址
    @IBAction func goWeb(_ sender: Any) {
        if let url = URL(string: webText.text ?? "") {
            webView.load(URLRequest(url: url))

        }
    }
    //返回
    @IBAction func backWeb(_ sender: Any) {
        webView.goBack()
    }
    //前进
    @IBAction func forwardWeb(_ sender: Any) {
        webView.goForward()
    }
    //重新加载
    @IBAction func reloadWeb(_ sender: Any) {
          webView.reload()
    }
    //加载default.html
    @IBAction func localBt(_ sender: Any) {
        if let url = Bundle.main.url(forResource: "default", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
    
    //为default.html中的选项添加对话框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            completionHandler()
        }))
        //显示对话框
        present(alert, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            completionHandler(false)
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        present(alert, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: prompt, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.text = defaultText
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(alert.textFields?.first?.text ?? "nil")
        }))
        present(alert, animated: true, completion: nil)

    }
    //设置进度条
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1 {
                progressView.progress = 0
                progressView.alpha = 0
            }
        }
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


