//
//  StoreViewController.swift
//  QuickTaps
//
//  Created by Mayalyami on 9/4/17.
//  Copyright © 2017 Mayalyami. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Button1: UIButton!
    
    @IBOutlet weak var BuyButton: UIButton!
    
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var ProductDescription: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Label1.layer.cornerRadius = 5.0
        Button1.layer.cornerRadius = 5.0
        BuyButton.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func purchase(_ sender: Any) {
    }

}
