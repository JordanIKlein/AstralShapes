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
import StoreKit
import WebKit

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

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        musicCheck()
        if let view = self.view as! SKView? { // setting the view to an SKScene
            print("Here")
            let scene = MenuScene(size: view.bounds.size) // setting MenuScene as the first scene to display upon setup
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
}


