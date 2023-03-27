//
//  DetailViewController.swift
//  workf
//
//  Created by 周子康 on 2021/5/28.
//

import UIKit
import  WebKit

class DetailViewController: UIViewController, WKUIDelegate {

    var newsweb : News?
    var addItemDelegate: AddItemDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let myURL = URL(string:newsweb!.path)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)*/
        guard let path = newsweb?.path else {return}
        
        guard let url = URL(string: path) else { return  }
        let urlRequest = URLRequest(url: url)
        self.webView.load(urlRequest)
        
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        let sectab = nav?.viewControllers.first as? FavorTableViewController
        addItemDelegate = sectab
        // Do any additional setup after loading the view.
    }
    @IBAction func favor(_ sender: Any) {
        print("OK")
        Favor.initDB()
        Favor.AddFavor(news: newsweb!)
        addItemDelegate?.addItem()
        
    }
    
    @IBOutlet weak var webView: WKWebView!
    /*
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration();
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self;
            view = webView;
        }
        */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
