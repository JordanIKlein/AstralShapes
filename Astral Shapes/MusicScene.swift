//
//  MusicScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 3/6/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MusicScene: SKScene {
var defaultMusic = UIButton(type: .system)
var lofiMix1 = UIButton(type: .system)
var lofiMix2 = UIButton(type: .system)
var constantTimer = Timer()
override func didMove(to view: SKView) {
    //Main Functions of the game
    for view in view.subviews {
               if view is UIButton{
                   view.removeFromSuperview()
               }
    }
    addingButtons()
    downbackground()
    constantTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in self.constantCheck()})
}
    func constantCheck(){
        if musicTrack! == url1 {
            defaultMusic.backgroundColor = UIColor.systemTeal
            lofiMix1.backgroundColor = nil
            lofiMix2.backgroundColor = nil
        }
        if musicTrack! == url2 {
            defaultMusic.backgroundColor = nil
            lofiMix1.backgroundColor = UIColor.systemTeal
            lofiMix2.backgroundColor = nil
        }
        if musicTrack! == url3 {
            defaultMusic.backgroundColor = nil
            lofiMix1.backgroundColor = nil
            lofiMix2.backgroundColor = UIColor.systemTeal
        }
    }
    func addingButtons(){
        //main menu
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
        //default music
        defaultMusic.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.3 , width: 300, height: 50)
        defaultMusic.setTitle("Space", for: UIControl.State.normal)
        defaultMusic.setTitleColor(UIColor.white, for: .normal)
        defaultMusic.layer.cornerRadius = 0
        defaultMusic.layer.borderWidth = 1
        defaultMusic.layer.borderColor=UIColor.white.cgColor
        defaultMusic.addTarget(self, action: #selector(defaultMusicSender), for: UIControl.Event.touchUpInside)
        defaultMusic.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        defaultMusic.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(defaultMusic)
        //lofi mix 1
        lofiMix1.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.45 , width: 300, height: 50)
        lofiMix1.setTitle("Sorry", for: UIControl.State.normal)
        lofiMix1.setTitleColor(UIColor.white, for: .normal)
        lofiMix1.layer.cornerRadius = 0
        lofiMix1.layer.borderWidth = 1
        lofiMix1.layer.borderColor=UIColor.white.cgColor
        lofiMix1.addTarget(self, action: #selector(lofiMix1Sender), for: UIControl.Event.touchUpInside)
        lofiMix1.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        lofiMix1.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(lofiMix1)
        
        //lofi mix 2
        lofiMix2.frame = CGRect (x:screenWidth/2 - 150, y:screenHeight * 0.6 , width: 300, height: 50)
        lofiMix2.setTitle("Home", for: UIControl.State.normal)
        lofiMix2.setTitleColor(UIColor.white, for: .normal)
        lofiMix2.layer.cornerRadius = 0
        lofiMix2.layer.borderWidth = 1
        lofiMix2.layer.borderColor=UIColor.white.cgColor
        lofiMix2.addTarget(self, action: #selector(lofiMix2Sender), for: UIControl.Event.touchUpInside)
        lofiMix2.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        lofiMix2.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(lofiMix2)
    }
    @objc func mainMenuScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    @objc func defaultMusicSender(sender: UIButton!) { // Pausing first song (if there is one) then playing another one
        musicTrack = url1
        UserDefaults.standard.set(url1, forKey: "musicTrack")
        player?.play()
        player?.numberOfLoops = -1
        player2?.pause()
        player3?.pause()
        volumeButton.setTitleColor(UIColor.white, for: .normal)
        mute = true
        UserDefaults.standard.set(true,forKey: "mute")
    }
    @objc func lofiMix1Sender(sender: UIButton!) { // Pausing first song (if there is one) then playing another one
        musicTrack = url2
        UserDefaults.standard.set(url2, forKey: "musicTrack")
        player2?.play()
        player2?.numberOfLoops = -1
        player?.pause()
        player3?.pause()
        volumeButton.setTitleColor(UIColor.white, for: .normal)
        mute = true
        UserDefaults.standard.set(true,forKey: "mute")
    }
    @objc func lofiMix2Sender(sender: UIButton!) { // Pausing first song (if there is one) then playing another one
        player?.pause()
        musicTrack = url3
        UserDefaults.standard.set(url3, forKey: "musicTrack")
        player3?.play()
        player3?.numberOfLoops = -1
        player?.pause()
        player2?.pause()
        volumeButton.setTitleColor(UIColor.white, for: .normal)
        mute = true
        UserDefaults.standard.set(true,forKey: "mute")
    }
    func downbackground() {
        let blackbackground = SKSpriteNode(imageNamed: "blackbackground")
        blackbackground.zPosition = -50
        blackbackground.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(blackbackground)
        let starstexture = SKTexture(imageNamed: "Stars")
        let planets = SKTexture(imageNamed: userSetBackground )
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
            
            let pT = SKSpriteNode(texture: planets)
            pT.zPosition = -20
            pT.anchorPoint = CGPoint(x: 0, y: 0)
            pT.position = CGPoint(x: (planets.size().width * CGFloat (i)) - CGFloat(1 * i), y: 0)
            self.addChild(pT)
            let moveBackp = SKAction.moveBy(x: -planets.size().width, y: 0, duration: 45)
            let moveResetp = SKAction.moveBy(x: planets.size().width, y: 0, duration: 0)
            let moveLoopp = SKAction.sequence([moveBackp, moveResetp])
            let moveForeverp = SKAction.repeatForever(moveLoopp)
            pT.run(moveForeverp)
        }
    }
}
