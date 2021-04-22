//
//  WebViewController.swift
//  Test
//
//  Created by Олег Савельев on 20.04.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func shareButton(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [htmlUrl], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    var htmlUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: htmlUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
        // Do any additional setup after loading the view.
    }


}
