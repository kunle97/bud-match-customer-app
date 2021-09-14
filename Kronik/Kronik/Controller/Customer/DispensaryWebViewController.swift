//
//  DispensaryWebViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/14/21.
//

import UIKit
import WebKit
class DispensaryWebViewController: UIViewController {
    private let webview: WKWebView = {
        let prefs =  WKPreferences()
        prefs.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        let wv = WKWebView(frame: .zero, configuration: config)
        return wv
    }()
    private let url:URL
    init(url:URL, title:String ){
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    @objc func didTapDone(){
        dismiss(animated: true, completion: nil )
    }
    @objc func didTapRefresh(){
        webview.load(URLRequest(url: url))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webview)
        webview.load(URLRequest(url: url))
        configureButtons()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }
    



}
