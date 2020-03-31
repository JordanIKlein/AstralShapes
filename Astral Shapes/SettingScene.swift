//
//  SettingScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/26/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

var removeAds = UserDefaults.standard.integer(forKey: "ads")
var volumeButton = UIButton(type: .system)

class SettingScene: SKScene {
    
    var settingtxt = SKLabelNode(fontNamed: "Press Start 2P")
    var languageButton = UIButton(type: .system)
    var backgroundButton = UIButton(type: .system)
    var musicButton = UIButton(type: .system)
    var muteTimer = Timer()
    
    override func didMove(to view: SKView) {
        //Main Functions of the game
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        removeExtras()
        settingtheText()//Adding SK Labelnode
        music() // volume button
        downbackground()//Adding space background
        mainMenuFunc() // main menu button
        backgroundScene()// adding a background button
        musicChoice() // different music tracks
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
        muteTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in self.musicTitle()})
    }
    func settingtheText(){
        settingtxt.position = CGPoint(x: screenWidth/2 - settingtxt.frame.width/2, y: screenHeight * 0.8)
        settingtxt.fontColor = UIColor.white
        settingtxt.fontSize = 30
        settingtxt.zPosition = -10
        settingtxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        settingtxt.name = "highscoretxt"
        settingtxt.text = "Settings:"
        addChild(settingtxt)
        if removeAds == 0 {
            self.view!.addSubview(inAppPurchaseB)
        }
    }
    func musicTitle() {
        if UserDefaults.standard.bool(forKey: "mute") == false {
            volumeButton.setTitle("Unmute", for: UIControl.State.normal)
        } else if UserDefaults.standard.bool(forKey: "mute") == true {
            volumeButton.setTitle("Mute", for: UIControl.State.normal)
        }
    }
    func music(){
        volumeButton.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.3 , width: 300, height: 50)
        volumeButton.layer.cornerRadius = 0
        volumeButton.layer.borderWidth = 1
        volumeButton.layer.borderColor=UIColor.white.cgColor
        volumeButton.addTarget(self, action: #selector(musicSender), for: UIControl.Event.touchUpInside)
        volumeButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 27)
        volumeButton.titleLabel!.textAlignment = NSTextAlignment.center
        volumeButton.setTitleColor(UIColor.white, for: .normal)
        if UserDefaults.standard.bool(forKey: "mute") == false {
            volumeButton.setTitle("Unmute", for: UIControl.State.normal)
        } else if UserDefaults.standard.bool(forKey: "mute") == true {
            volumeButton.setTitle("Mute", for: UIControl.State.normal)
        }
        self.view!.addSubview(volumeButton)
    }
    @objc func musicSender(sender: UIButton!) { // sending the User back to the Game
        if UserDefaults.standard.bool(forKey: "mute") == true {
            volumeButton.setTitle("Unmute", for: UIControl.State.normal)
            player?.pause()
            player2?.pause()
            player3?.pause()
            UserDefaults.standard.set(false,forKey: "mute")
        } else if UserDefaults.standard.bool(forKey: "mute") == false {
            volumeButton.setTitle("Mute", for: UIControl.State.normal)
            if musicTrack == url2 {
                player2?.play()
                player2?.numberOfLoops = -1
                player?.pause()
                player3?.pause()
            } else if musicTrack == url3 {
                player3?.play()
                player3?.numberOfLoops = -1
                player?.pause()
                player2?.pause()
            } else if musicTrack == url1 || musicTrack != url1 {
                player?.play()
                player?.numberOfLoops = -1
                player2?.pause()
                player3?.pause()
            }
            UserDefaults.standard.set(true,forKey: "mute")
        }
    }
    func musicChoice() {
        musicButton.frame = CGRect (x: screenWidth/2 - 150, y: screenHeight * 0.6 , width: 300, height: 50)
        musicButton.setTitle("Music Track", for: UIControl.State.normal)
        musicButton.setTitleColor(UIColor.white, for: .normal)
        musicButton.layer.cornerRadius = 0
        musicButton.layer.borderWidth = 1
        musicButton.layer.borderColor=UIColor.white.cgColor
        musicButton.addTarget(self, action: #selector(musicTypes), for: UIControl.Event.touchUpInside)
        musicButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        musicButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(musicButton)
    }
    @objc func musicTypes(sender: UIButton!) {
        let nextScene = MusicScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    
    func languages(){
//        languageButton.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.4 , width: 300, height: 50)
//        languageButton.setTitle("Language", for: UIControl.State.normal)
//        languageButton.setTitleColor(UIColor.white, for: .normal)
//        languageButton.layer.cornerRadius = 0
//        languageButton.layer.borderWidth = 1
//        languageButton.layer.borderColor=UIColor.white.cgColor
//        languageButton.addTarget(self, action: #selector(languageSender), for: UIControl.Event.touchUpInside)
//        languageButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 27)
//        languageButton.titleLabel!.textAlignment = NSTextAlignment.center
//        self.view!.addSubview(languageButton)
    }
    @objc func languageSender(sender: UIButton!) { // sending the User back to the Game
//        let nextScene = LanguageScene(size: scene!.size)
//        let transition = SKTransition.fade(withDuration: 0.5)
//        nextScene.scaleMode = .aspectFill
//        scene?.view?.presentScene(nextScene,transition: transition)
//        shootingStarTimer.invalidate()
    }
    func downbackground() {
        let blackbackground = SKSpriteNode(imageNamed: "blackbackground")
        blackbackground.zPosition = -50
        blackbackground.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(blackbackground)
        let starstexture = SKTexture(imageNamed: "Stars")
        for i in 0 ... 8
        {
            let starsT = SKSpriteNode(texture: starstexture)
            starsT.zPosition = -30
            starsT.anchorPoint = CGPoint(x: 0, y: 0)
            starsT.position = CGPoint(x: (starstexture.size().width * CGFloat (i)) - CGFloat(1 * i), y: 0)
            self.addChild(starsT)
            let moveBack = SKAction.moveBy(x: -starstexture.size().width, y: 0, duration: 15)
            let moveReset = SKAction.moveBy(x: starstexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveBack, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsT.run(moveForever)
        }
    }
    func shootingStar(){
        shooting.removeFromParent()
        addChild(shooting)
        shooting.zPosition = -10
        let getXValue = GKRandomDistribution(lowestValue: Int(frame.minX + 200), highestValue: Int(frame.maxX))
        let getYValue = GKRandomDistribution(lowestValue: Int(frame.minY + 200), highestValue: Int(frame.maxY - 50))
        let xPosition = CGFloat(getXValue.nextInt())
        let yPosition = CGFloat(getYValue.nextInt())
        shooting.position = CGPoint(x: xPosition, y: yPosition)
        let shootingMove = SKAction.moveBy(x: -250, y: -150, duration: 2.5)
        shooting.run(shootingMove)
        shooting.run(SKAction.sequence([SKAction.self.fadeIn(withDuration: 0.5),SKAction.wait(forDuration: 1.0),SKAction.self.fadeOut(withDuration: 1),SKAction.self.removeFromParent()]))
    }
    func mainMenuFunc() {
        mainMenuS.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.05 , width: 300, height: 50)
        mainMenuS.setTitle("Main Menu", for: UIControl.State.normal)
        mainMenuS.setTitleColor(UIColor.white, for: .normal)
        mainMenuS.layer.cornerRadius = 0
        mainMenuS.layer.borderWidth = 1
        mainMenuS.layer.borderColor=UIColor.white.cgColor
        mainMenuS.addTarget(self, action: #selector(mainMenuScene), for: UIControl.Event.touchUpInside)
        mainMenuS.titleLabel!.font = UIFont(name: "Press Start 2P", size: 27)
        mainMenuS.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(mainMenuS)
    }
    @objc func mainMenuScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    func backgroundScene(){
        backgroundButton.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.45 , width: 300, height: 50)
        backgroundButton.setTitle("Backgrounds", for: UIControl.State.normal)
        backgroundButton.setTitleColor(UIColor.white, for: .normal)
        backgroundButton.layer.cornerRadius = 0
        backgroundButton.layer.borderWidth = 1
        backgroundButton.layer.borderColor=UIColor.white.cgColor
        backgroundButton.addTarget(self, action: #selector(backgroundSender), for: UIControl.Event.touchUpInside)
        backgroundButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        backgroundButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(backgroundButton)
    }
    @objc func backgroundSender(sender: UIButton!) { // sending the User back to the Game
        let nextScene = BackgroundScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    func removeExtras(){
        settingtxt.removeFromParent()
        menuButton.removeFromParent()
        aboutGame.removeFromParent()
        background.removeFromParent()
        totalTime.removeFromParent()
        scoreAmount.removeFromParent()
        playerShape.removeFromParent()
        ciRed.removeFromParent()
        ciBlue.removeFromParent()
        ciGreen.removeFromParent()
        triGreen.removeFromParent()
        triBlue.removeFromParent()
        triRed.removeFromParent()
        sqRed.removeFromParent()
        sqBlue.removeFromParent()
        sqGreen.removeFromParent()
        hexRed.removeFromParent()
        hexBlue.removeFromParent()
        hexGreen.removeFromParent()
        circleRed.removeFromParent()
        circleBlue.removeFromParent()
        circleGreen.removeFromParent()
        triangleRed.removeFromParent()
        triangleBlue.removeFromParent()
        triangleGreen.removeFromParent()
        hexagonRed.removeFromParent()
        hexagonBlue.removeFromParent()
        hexagonGreen.removeFromParent()
        squareRed.removeFromParent()
        squareBlue.removeFromParent()
        squareGreen.removeFromParent()
    }
}
