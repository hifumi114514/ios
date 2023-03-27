//
//  FavorViewController.swift
//  workf
//
//  Created by NICOLAS ENRICO. on 2021/6/7.
//

import UIKit
import WebKit

class FavorViewController: UIViewController {

    //var favorweb : [[String:AnyObject]]?
    var favorpath:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = favorpath else {return}
        
        guard let url = URL(string: path) else { return  }
        let urlRequest = URLRequest(url: url)
        self.FavorWebView.load(urlRequest)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var FavorWebView: WKWebView!
    
   

}
