//
//  BackgroundScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 3/2/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//UI buttons that set the background
var userSetBackground = UserDefaults.standard.string (forKey: "background") ?? "backgroundMainMenuLong"
var backgroundTimer = Timer()
var mainBackgroundButton = UIButton(type: .system)
var astroidBackgroundButton = UIButton(type: .system)
//current main background
let backgroundMainMenutexture = SKSpriteNode(imageNamed: userSetBackground)

class BackgroundScene: SKScene {
override func didMove(to view: SKView) {
    //Main Functions of the game
    for view in view.subviews {
               if view is UIButton{
                   view.removeFromSuperview()
               }
    }
    removeExtras()
    downbackground()
    addingButtons()
    titles()
    }
    func titles(){
        if userSetBackground == "backgroundMainMenuLong"{
            mainBackgroundButton.setTitleColor(UIColor.red, for: .normal)
            mainBackgroundButton.backgroundColor = UIColor.systemTeal
            astroidBackgroundButton.setTitleColor(UIColor.white, for: .normal)
            astroidBackgroundButton.backgroundColor = nil
        } else if userSetBackground == "astroidBackground" {
            mainBackgroundButton.setTitleColor(UIColor.white, for: .normal)
            mainBackgroundButton.backgroundColor = nil
            astroidBackgroundButton.backgroundColor = UIColor.systemTeal
            astroidBackgroundButton.setTitleColor(UIColor.red, for: .normal)
        }
    }
    func downbackground() {
        let backgroundMainMenutexture = SKSpriteNode(imageNamed: userSetBackground)
        backgroundMainMenutexture.zPosition = -20
        backgroundMainMenutexture.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(backgroundMainMenutexture)
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
    func addingButtons() {
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
        mainBackgroundButton.frame = CGRect (x:screenWidth/2 - 100, y:screenHeight * 0.5 , width: 200, height: 50)
        mainBackgroundButton.setTitle("Planets", for: UIControl.State.normal)
        mainBackgroundButton.layer.cornerRadius = 0
        mainBackgroundButton.layer.borderWidth = 1
        mainBackgroundButton.layer.borderColor=UIColor.white.cgColor
        mainBackgroundButton.addTarget(self, action: #selector(mainBackground), for: UIControl.Event.touchUpInside)
        mainBackgroundButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 18)
        mainBackgroundButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(mainBackgroundButton)
        
//        if userLevel >= 10 {
        astroidBackgroundButton.frame = CGRect (x:screenWidth/2 - 100, y:screenHeight * 0.25 , width: 200, height: 50)
        astroidBackgroundButton.setTitle("Astroids", for: UIControl.State.normal)
        astroidBackgroundButton.layer.cornerRadius = 0
        astroidBackgroundButton.layer.borderWidth = 1
        astroidBackgroundButton.layer.borderColor=UIColor.white.cgColor
        astroidBackgroundButton.addTarget(self, action: #selector(astroidBackground), for: UIControl.Event.touchUpInside)
        astroidBackgroundButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 18)
        astroidBackgroundButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(astroidBackgroundButton)
        //}
    }
    @objc func mainMenuScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    @objc func mainBackground(sender: UIButton!) { // sending the User back to the Game
        userSetBackground = "backgroundMainMenuLong"
        UserDefaults.standard.set(userSetBackground, forKey: "background")
        titles()
        let nextScene = BackgroundScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    @objc func astroidBackground(sender: UIButton!) { // sending the User back to the Game
        userSetBackground = "astroidBackground"
        UserDefaults.standard.set(userSetBackground, forKey: "background")
        titles()
        let nextScene = BackgroundScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    
}
