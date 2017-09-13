//
//  EndViewController.swift
//  QuickTaps
//
//  Created by Mayalyami on 9/2/17.
//  Copyright © 2017 Mayalyami. All rights reserved.
//

import UIKit
import Social
import MessageUI
import GoogleMobileAds

class EndViewController: UIViewController, MFMailComposeViewControllerDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var ScoreLabel: UILabel!

    @IBOutlet weak var BannerView: GADBannerView!
    
    var scoreData:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        Label1.layer.cornerRadius = 5.0
        Label2.layer.cornerRadius = 5.0
        Button1.layer.cornerRadius = 5.0
        Button2.layer.cornerRadius = 5.0
        Button3.layer.cornerRadius = 5.0
        Button4.layer.cornerRadius = 5.0
        
        ScoreLabel.text = scoreData
        
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
    
    @IBAction func RestartGame(_ sender: Any) {
        //dimiss first view
        self.dismiss(animated: false, completion: nil)
        //dismiss game view
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func ShareTwitter(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let twitter:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitter.setInitialText("My final score was: \(ScoreLabel.text!). Download QuickTaps right now and try to beat that ;)")
            
            self.present(twitter, animated: true, completion: nil)
            
        }
        else {
            let alert = UIAlertController(title: "Twitter Account", message: "Please log into your twitter account within the settings", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func ShareEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            
            mail.mailComposeDelegate = self
            mail.setToRecipients(nil)
            mail.setSubject("QuickTaps - I bet you can't beat me!")
            mail.setMessageBody("My final score was: \(ScoreLabel.text!). Download QuickTaps right now and try to beat that ;)", isHTML: false)
            
            self.present(mail, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Email Account", message: "Please log into your email account", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func ShareSMS(_ sender: Any) {
        if MFMessageComposeViewController.canSendText() {
            
            let message:MFMessageComposeViewController = MFMessageComposeViewController()
            
            message.messageComposeDelegate = (self as! MFMessageComposeViewControllerDelegate)
            message.recipients = nil
            message.body = "My final score was: \(ScoreLabel.text!). Download QuickTaps right now and try to beat that ;)"
            
            self.present(message, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Warning!", message: "This device can not send SMS message", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func messageComposeController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult, error: Error?) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
