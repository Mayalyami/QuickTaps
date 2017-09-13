//
//  ViewController.swift
//  QuickTaps
//
//  Created by Mayalyami on 9/2/17.
//  Copyright © 2017 Mayalyami. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Button: UIButton!
    
    @IBOutlet weak var BannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Label1.layer.cornerRadius = 5.0
        Button.layer.cornerRadius = 5.0
        
        BannerView.isHidden = true
        BannerView.delegate = self
        
        BannerView.adUnitID = "ca-app-pub-3083046965874410/3202540501"
        BannerView.adSize = kGADAdSizeSmartBannerPortrait
        BannerView.rootViewController = self
        BannerView.load(GADRequest())
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        BannerView.isHidden = false
        
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        BannerView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        
        if (value == nil) {
            Label2.text = "0"
        } else {
            Label2.text = value
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

