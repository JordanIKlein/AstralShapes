//
//  GameViewController.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/5/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//
//  Banner ID: ca-app-pub-4042774315695176/9107709738
//  Banner Test ID: ca-app-pub-3940256099942544/2934735716
//  Video Reward ID: ca-app-pub-4042774315695176/1270254760
//  Video Reward Test ID: ca-app-pub-3940256099942544/1712485313
import UIKit
import SpriteKit
import AVFoundation
import AVKit
import Firebase
import GoogleMobileAds
import GameplayKit
import StoreKit
import WebKit

let inAppPurchaseB = UIButton(type:.system)
let continueGameB = UIButton(type:.system) // continues the game by watching a rewarded video
var player: AVAudioPlayer?
var player2: AVAudioPlayer?
var player3: AVAudioPlayer?
var randomVariable = Int()


let url1 = Bundle.main.url(forResource: "space", withExtension: "mp3")
let url2 = Bundle.main.url(forResource: "Sorry", withExtension: "mp3")
let url3 = Bundle.main.url(forResource: "home", withExtension: "mp3")

var musicTrack = UserDefaults.standard.url(forKey: "musicTrack") ?? url1
var MusicTimer = Timer()

func playSound() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url1!, fileTypeHint: AVFileType.mp3.rawValue)
        player2 = try AVAudioPlayer(contentsOf: url2!, fileTypeHint: AVFileType.mp3.rawValue)
        player3 = try AVAudioPlayer(contentsOf: url3!, fileTypeHint: AVFileType.mp3.rawValue)
    } catch let error {
        print(error.localizedDescription)
    }
}

class GameViewController: UIViewController , GADBannerViewDelegate, GADRewardBasedVideoAdDelegate{
    
    let ProductID = "com.JordanKlein.AstralShapes.RemoveAds"
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
    if let view = self.view as! SKView? {
        print("Random Variable: \(randomVariable)")
        if randomVariable != 1 {
            continueVariable = continueVariable + 1
            let scene = GameScene(size: view.bounds.size)
            view.presentScene(scene)
        } else {
//            xp = xp + 150
//            UserDefaults.standard.set(xp,forKey: "xp")
//            let scene = ProfileScene(size: view.bounds.size)
//            view.presentScene(scene)
        }
    }
}
    @IBOutlet weak var banner: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        banner.adUnitID = "ca-app-pub-4042774315695176/9107709738"
        banner.rootViewController = self
        banner.adSize = kGADAdSizeLargeBanner
        banner.load(GADRequest())
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-4042774315695176/1270254760")
        extraXP()
        continueButtonDisplay()
        //inAppPurchase()
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
       if let view = self.view as! SKView? { // setting the view to an SKScene
            let scene = MenuScene(size: view.bounds.size) // setting MenuScene as the first scene to display upon setup
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    func continueButtonDisplay() {
        if continueVariable == 1 { // Only will happen once
            continueGameB.setTitle("Extra Life?", for: UIControl.State.normal)
            continueGameB.setTitleColor(UIColor.white, for: .normal)
            continueGameB.layer.cornerRadius = 0
            continueGameB.layer.borderWidth = 1
            continueGameB.layer.borderColor=UIColor.white.cgColor
            continueGameB.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
            continueGameB.titleLabel!.textAlignment = NSTextAlignment.center
            continueGameB.frame = CGRect (x:self.view.frame.midX - 150, y: self.view.frame.midY + 100  , width: 300, height: 55)
            continueGameB.addTarget(self, action: #selector(continueG), for: UIControl.Event.touchUpInside)
        }
    }
    func extraXP() {
        XPButton.setTitle("150 XP?", for: UIControl.State.normal)
        XPButton.setTitleColor(UIColor.yellow, for: .normal)
        XPButton.layer.cornerRadius = 0
        XPButton.layer.borderWidth = 5
        XPButton.layer.borderColor=UIColor.yellow.cgColor
        XPButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 30)
        XPButton.titleLabel!.textAlignment = NSTextAlignment.center
        XPButton.frame = CGRect (x: screenWidth/2 - 125, y: screenHeight * 0.7 , width: 250, height: 75)
        XPButton.addTarget(self, action: #selector(xp100), for: UIControl.Event.touchUpInside)
    }
    @objc func continueG(sender: UIButton!) { // sending the User back to the Game
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                continueGameB.isEnabled = true
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            } else {
                GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-4042774315695176/1270254760")
            }
    }
    @objc func xp100(sender: UIButton!) { // sending the User back to the Game
            randomVariable = 1
            nxtLvlTimer.invalidate()
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                XPButton.isEnabled = true
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            } else {
                GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-4042774315695176/1270254760")
            }
    }
    func inAppPurchase(){
        //SKPaymentQueue.default().add(self)
        if  removeAds == 0 {
            inAppPurchaseB.setTitle("Remove Ads", for: UIControl.State.normal)
            inAppPurchaseB.setTitleColor(UIColor.green, for: .normal)
            inAppPurchaseB.layer.cornerRadius = 0
            inAppPurchaseB.layer.borderWidth = 1
            inAppPurchaseB.layer.borderColor=UIColor.white.cgColor
            inAppPurchaseB.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
            inAppPurchaseB.titleLabel!.textAlignment = NSTextAlignment.center
            inAppPurchaseB.frame = CGRect (x:self.view.frame.midX - 150, y: self.view.frame.midY + 100  , width: 300, height: 55)
            inAppPurchaseB.addTarget(self, action: #selector(inAppSender), for: UIControl.Event.touchUpInside)
        }
    }
    @objc func inAppSender(sender: UIButton!) { // sending the User back to the Game
//        if SKPaymentQueue.canMakePayments() {
//            let paymentRequest = SKMutablePayment()
//            paymentRequest.productIdentifier = ProductID
//            SKPaymentQueue.default().add(paymentRequest)
//        } else {
//            print("User unable to make payments")
//        }
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print (error)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


