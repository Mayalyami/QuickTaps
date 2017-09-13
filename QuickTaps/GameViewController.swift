//
//  GameViewController.swift
//  QuickTaps
//
//  Created by Mayalyami on 9/2/17.
//  Copyright © 2017 Mayalyami. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!

    @IBOutlet weak var BannerView: GADBannerView!
    
    
    var tapInt = 0
    var startInt = 3
    var startTimer = Timer()
    var gameInt = 10
    var gameTimer = Timer()
    var recordDate:String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Label1.layer.cornerRadius = 5.0
        Label2.layer.cornerRadius = 5.0
        Button.layer.cornerRadius = 5.0
        
        tapInt = 0
        ScoreLabel.text = String(tapInt)
        
        startInt = 3
        Button.setTitle(String(startInt), for: .normal)
        Button.isEnabled = false
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
        gameInt = 10
        TimeLabel.text = String(gameInt)
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey:"Record")
        recordDate = value
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TapMeButton(_ sender: Any) {
       tapInt += 1
        ScoreLabel.text = String(tapInt)
    }
    
    func startGameTimer(){
        startInt -= 1
        Button.setTitle(String(startInt), for: .normal)
        
        if startInt == 0 {
            startTimer.invalidate()
            Button.setTitle("TAP ME", for: .normal)
            Button.isEnabled = true
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
            
        }
    }
    
    func game(){
        gameInt -= 1
        TimeLabel.text = String(gameInt)
        
        if gameInt == 0 {
            gameTimer.invalidate()
            
            if recordDate == nil {
                let savedString = ScoreLabel.text
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "Record")
            }
            else {
                let score:Int? = Int(ScoreLabel.text!)
                let record:Int? = Int(recordDate)
                
                if score! > record! {
                    let savedString = ScoreLabel.text
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.set(savedString, forKey: "Record")
                }
            }
            
            
            
            Button.isEnabled = false
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(GameViewController.end), userInfo: nil, repeats: false)
        }
    }

    func end() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "EndGame") as! EndViewController
            vc.scoreData = ScoreLabel.text
            self.present(vc, animated: false, completion: nil)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let vc = UIStoryboard(name:"iPadStoryboard", bundle:nil).instantiateViewController(withIdentifier: "EndGame") as! EndViewController
            vc.scoreData = ScoreLabel.text
            self.present(vc, animated: false, completion: nil)
        }
    }
}
