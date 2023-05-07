//
//  PicsDetailViewController.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import UIKit
import WebKit

class PicsDetailViewController: UIViewController {

    var pic: Pics!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: pic.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
