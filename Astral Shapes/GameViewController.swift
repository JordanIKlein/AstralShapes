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
import GameplayKit
import GoogleMobileAds


var player: AVAudioPlayer?
var player2: AVAudioPlayer?
var player3: AVAudioPlayer?
var randomVariable = Int()


func musicCheck(){
        if musicTrack == "lofimusic1" {
            let path = Bundle.main.path(forResource: "space.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                lofimusic1 = try AVAudioPlayer(contentsOf: url)
                lofimusic1?.play()
                lofimusic1?.numberOfLoops = -1
            } catch {
                // couldn't load file
            }
        } else if musicTrack == "lofimusic2" {
            let path = Bundle.main.path(forResource: "Sorry.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                lofimusic2 = try AVAudioPlayer(contentsOf: url)
                lofimusic2?.play()
                lofimusic2?.numberOfLoops = -1
            } catch {
                // couldn't load file
            }
        } else if musicTrack == "lofimusic3" {
            let path = Bundle.main.path(forResource: "home.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                lofimusic3 = try AVAudioPlayer(contentsOf: url)
                lofimusic3?.play()
                lofimusic3?.numberOfLoops = -1
            } catch {
                // couldn't load file
            }
        } else {
            let path = Bundle.main.path(forResource: "space.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                lofimusic1 = try AVAudioPlayer(contentsOf: url)
                lofimusic1?.play()
                lofimusic1?.numberOfLoops = -1
            } catch {
                // couldn't load file
            }
        }
}

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiating Banner View
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-4042774315695176/9107709738"
        bannerView.rootViewController = self
        // Single Request
        bannerView.load(GADRequest())
        bannerView.delegate = self
        // Music Time
        musicCheck()
        
        if let view = self.view as! SKView? { // setting the view to an SKScene
            let scene = MenuScene(size: view.bounds.size) // setting MenuScene as the first scene to display upon setup
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        if let viewwithTag = self.view.viewWithTag(100) {
            viewwithTag.removeFromSuperview()
        } else {
        }
        addBannerViewToView(bannerView)
    }
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        // Add image here which links to other app
        //protectTheDinos()
    }
    func protectTheDinos(){
        let imageName = "ad.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.tag = 100
        imageView.frame = CGRect(x: view.frame.minX, y: view.frame.maxY - 100, width: 425, height: 50)
        self.view.addSubview(imageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))

            // add it to the image view;
            imageView.addGestureRecognizer(tapGesture)
            // make sure imageView can be interacted with by user
        imageView.isUserInteractionEnabled = true
    }
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if let imageView = gesture.view as? UIImageView {
            //Here you can initiate your new ViewController
                if let url = URL(string: "https://apps.apple.com/us/app/id1524115459") {
                        UIApplication.shared.open(url, options: [:])
                }
            }
        }
    
    
}
