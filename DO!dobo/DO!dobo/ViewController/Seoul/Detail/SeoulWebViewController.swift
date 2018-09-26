//
//  SeoulWebViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import WebKit
import SilentScrolly

class SeoulWebViewController: UIViewController, SilentScrollable {
    
    //silentscrolly
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle(showStyle: .lightContent, hideStyle: .default)
    }
    
    var silentScrolly: SilentScrolly?
    
    var cosUrl: String = ""
    
    @IBOutlet weak var webView: WKWebView!{
        didSet {
            webView.navigationDelegate = self
            webView.scrollView.delegate = self
            let url = URL (string: cosUrl)
            let requestObj = URLRequest(url: url!)
            webView.load(requestObj)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: silentscrolly
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        silentDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSilentScrolly(webView.scrollView, followBottomView: tabBarController?.tabBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        silentWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        silentDidDisappear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        silentWillTranstion()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        silentDidScroll()
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        showNavigationBar()
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SeoulWebViewController: UIScrollViewDelegate {
    
    func scrollViewDidScrolld(_ scrollView: UIScrollView) {
        silentDidScroll()
    }
    
    func scrollViewShouldScrollToTopd(_ scrollView: UIScrollView) -> Bool {
        showNavigationBar()
        return true
    }
}

extension SeoulWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showNavigationBar()
    }
}
