//
//  WebSeoulViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 18..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import SilentScrolly

class WebSeoulViewController: UIViewController, SilentScrollable {
    
    //silentscrolly
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle(showStyle: .lightContent, hideStyle: .default)
    }
    
    var silentScrolly: SilentScrolly?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        
        let url = URL (string: "http://korean.visitseoul.net/walkingtour/%EB%8F%84%EB%B3%B4%EA%B4%80%EA%B4%91%EC%9D%B4%EB%9E%80_/15020")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)

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

extension UIViewController {
    //백버튼
    func setBackBtn(color : UIColor? = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)){
        let backBTN = UIBarButtonItem(image: UIImage(named: "icBackBtn"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
}

