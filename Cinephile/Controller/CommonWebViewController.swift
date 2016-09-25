//
//  CommonWebViewController.swift
//  Cinephile
//
//  Created by omer ozkul on 24/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit

class CommonWebViewController: UIViewController {

    @IBOutlet weak var commonWebView: UIWebView!
    var htmlStr: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonWebView.loadHTMLString(htmlStr, baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
