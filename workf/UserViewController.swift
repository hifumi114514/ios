//
//  UserViewController.swift
//  workf
//
//  Created by 周子康 on 2021/5/19.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let loginVC = UserLoginViewController()
        present(loginVC, animated: true, completion: nil)
    }
    
    

}
