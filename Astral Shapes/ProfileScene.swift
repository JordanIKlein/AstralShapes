//
//  ProfileScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/28/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
var leveltxt = SKLabelNode(fontNamed: "Press Start 2P")
var nextUnlocks = SKLabelNode(fontNamed: "Press Start 2P")
var nextUpgrade = UserDefaults.standard.integer(forKey: "nextUpgrade") ?? 5
var levelTest = UIButton(type: .system)
var nxtlvltxt = SKLabelNode(fontNamed: "Press Start 2P")
var xptxt = SKLabelNode(fontNamed: "Press Start 2P")
var xp = UserDefaults.standard.integer(forKey: "xp")
var nxtLvlTimer = Timer()

class ProfileScene: SKScene {
    override func didMove(to view: SKView) {
        xptxt.removeFromParent()
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        removeExtras()
        downbackground()
        theLabels()// adds a background to the scene
        mainMenuFunc()
        nxtLvlTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {_ in self.nextlvl()})
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
    func theLabels() {
        xpText.removeFromParent()
        leveltxt.removeFromParent()
        nextUnlocks.removeFromParent()
        nxtlvltxt.removeFromParent()
        leveltxt.position = CGPoint(x: screenWidth/2 , y: screenHeight * 0.8)
        leveltxt.fontColor = UIColor.white
        leveltxt.fontSize = 30
        leveltxt.zPosition = -10
      
        leveltxt.name = "leveltxt"
        addChild(leveltxt)
        nextUnlocks.position = CGPoint(x: screenWidth/2 , y: screenHeight * 0.65)
        nextUnlocks.fontColor = UIColor.white
        nextUnlocks.fontSize = 20
        nextUnlocks.zPosition = -10
        
        nextUnlocks.name = "nextUnlockstxt"
        addChild(nextUnlocks)
        xptxt.position = CGPoint(x: screenWidth/2 , y: screenHeight * 0.725)
        xptxt.fontColor = UIColor.white
        xptxt.fontSize = 20
        xptxt.zPosition = -10
        xptxt.name = "xptxt"
        addChild(xptxt)
        nxtlvltxt.position = CGPoint(x: screenWidth/2 , y: screenHeight/2 - 15)
        nxtlvltxt.fontColor = UIColor.systemTeal
        nxtlvltxt.fontSize = 15
        nxtlvltxt.zPosition = -10
    
        nxtlvltxt.name = "nextlvltxt"
        nxtlvltxt.numberOfLines = 0
        addChild(nxtlvltxt)
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
        
        if xp <= 1925 {
            self.view!.addSubview(XPButton)
        }
    }
    @objc func mainMenuScene(sender: UIButton!) { // sends user back to main menu
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    func nextlvl(){
        checkUserLevel()
        nextUnlocks.text = "Level \(nextUpgrade) unlocks:" // add a level variable
        leveltxt.text = "Level:\(userLevel)" // add a level variable
        if userLevel < 5 || userLevel == 0 {
            nextUpgrade = 5
            nxtlvltxt.text = """
            - Yellow Color
            
            - Orange Color
            
            - Purple Color
            """
            xptxt.text = "XP needed: \(500-xp)"
            UserDefaults.standard.set(5,forKey: "nextUpgrade")
        } else if userLevel < 10 || userLevel == 5 {
            nextUpgrade = 10
            nxtlvltxt.text = """
            
            - Classic Gamemode!
            
            - Backgrounds!
            
            - Astroid Background!
            
            """
            xptxt.text = "XP needed: \(1000-xp)"
            UserDefaults.standard.set(10,forKey: "nextUpgrade")
        } else if userLevel < 15 || userLevel == 10 {
            nextUpgrade = 15
            xptxt.text = "XP needed: \(1500-xp)"
            nxtlvltxt.text = """
            
            - Music Tracks Unlocked!
            
            - Lofi Mix #1!
            
            - Lofi Mix #2!
            
            """
            UserDefaults.standard.set(15,forKey: "nextUpgrade")
        } else if userLevel <= 20 || userLevel == 15 {
            nextUpgrade = 20
            xptxt.text = "XP needed: \(2000-xp)"
            nxtlvltxt.text = """
            Congrats! You have
            
            completed all of the
            
            unlockables for now.
            
            Sit tight!
            
            """
            UserDefaults.standard.set(20,forKey: "nextUpgrade")
        }
//        } else if userLevel < 25 || userLevel == 20 {
//            nextUpgrade = 25
//            xptxt.text = "XP needed: \(2500-xp)"
//            nxtlvltxt.text = """
//            Congrats! You have
//
//            completed all of the
//
//            unlockables for now.
//
//            Sit tight!
//
//            """
//            UserDefaults.standard.set(25,forKey: "nextUpgrade")
//        } else if userLevel < 30 || userLevel == 25 {
//            nextUpgrade = 30
//            xptxt.text = "XP needed: \(3000-xp)"
//            nxtlvltxt.text = """
//            Congrats! You have
//
//            completed all of the
//
//            unlockables for now.
//
//            Sit tight!
//
//            """
//            UserDefaults.standard.set(30,forKey: "nextUpgrade")
//        } else if userLevel < 35 || userLevel == 30 {
//            nextUpgrade = 35
//            xptxt.text = "XP needed: \(3500-xp)"
//            nxtlvltxt.text = """
//            Congrats! You have
//
//            completed all of the
//
//            unlockables for now.
//
//            Sit tight!
//
//            """
//            UserDefaults.standard.set(35,forKey: "nextUpgrade")
//        } else if userLevel < 40 || userLevel == 35 {
//            nextUpgrade = 40
//            xptxt.text = "XP needed: \(4000-xp)"
//            nxtlvltxt.text = """
//            Congrats! You have
//
//            completed all of the
//
//            unlockables for now.
//
//            Sit tight!
//
//            """
//            UserDefaults.standard.set(40,forKey: "nextUpgrade")
//        } else if userLevel < 45 || userLevel == 40{
//            nextUpgrade = 45
//            xptxt.text = "XP needed: \(4500-xp)"
//            nxtlvltxt.text = """
//            Congrats! You have
//
//            completed all of the
//
//            unlockables for now.
//
//            Sit tight!
//
//            """
//            UserDefaults.standard.set(45,forKey: "nextUpgrade")
//        } else if userLevel < 50 || userLevel == 45 {
//            nextUpgrade = 50
//            xptxt.text = "XP needed: \(5000-xp)"
//            nxtlvltxt.text = """
//            Congrats! You have
//
//            completed all of the
//
//            unlockables for now.
//
//            Sit tight!
//
//            """
//            UserDefaults.standard.set(50,forKey: "nextUpgrade")
//        } else if userLevel >= 50 || userLevel == 50 {
//            xptxt.text = "XP needed: 0"
//            nxtlvltxt.position = CGPoint(x: screenWidth/2 , y: screenHeight/2 - 15)
//            nxtlvltxt.text = """
//
//            You finished the game!
//
//            """
//        }
    }
    func checkUserLevel(){
//        if xp >= 5000 {
//            userLevel = 50
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4900 {
//            userLevel = 49
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4800 {
//            userLevel = 48
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4700 {
//            userLevel = 47
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4600 {
//            userLevel = 46
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4500 {
//            userLevel = 45
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4400 {
//            userLevel = 44
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4300 {
//            userLevel = 43
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4200 {
//            userLevel = 42
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4100 {
//            userLevel = 41
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 4000 {
//            userLevel = 40
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3900 {
//            userLevel = 39
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3800 {
//            userLevel = 38
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3700 {
//            userLevel = 37
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3600 {
//            userLevel = 36
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3500 {
//            userLevel = 35
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3400 {
//            userLevel = 34
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3300 {
//            userLevel = 33
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3200 {
//            userLevel = 32
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3100 {
//            userLevel = 31
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 3000 {
//            userLevel = 30
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2900 {
//            userLevel = 29
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2800 {
//            userLevel = 28
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2700 {
//            userLevel = 27
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2600 {
//            userLevel = 26
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2500 {
//            userLevel = 25
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2400 {
//            userLevel = 24
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2300 {
//            userLevel = 23
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2200 {
//            userLevel = 22
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else if xp >= 2100 {
//            userLevel = 21
//            UserDefaults.standard.set(userLevel,forKey: "userLevel")
//        } else
        if xp >= 2000 {
            userLevel = 20
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1900 {
            userLevel = 19
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1800  {
            userLevel = 18
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1700 {
            userLevel = 17
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1600 {
            userLevel = 16
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1500{
            userLevel = 15
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1400 {
            userLevel = 14
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1300 {
            userLevel = 13
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1200{
            userLevel = 12
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1100  {
            userLevel = 11
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 1000 {
            userLevel = 10
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 900 {
            userLevel = 9
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 800 {
            userLevel = 8
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 700  {
            userLevel = 7
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 600 {
            userLevel = 6
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 500 {
            userLevel = 5
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 400 {
            userLevel = 4
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 300{
            userLevel = 3
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 200 {
            userLevel = 2
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else if xp >= 100 {
            userLevel = 1
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        } else {
            userLevel = 0
            UserDefaults.standard.set(userLevel,forKey: "userLevel")
        }
        
    }
//    func levelTester() {
//        levelTest.frame = CGRect (x: screenWidth/2 - 75, y: screenHeight/2 - 75 , width: 50, height: 50)
//        levelTest.layer.cornerRadius = 0
//        levelTest.layer.borderWidth = 1
//        levelTest.layer.borderColor=UIColor.white.cgColor
//        levelTest.backgroundColor = UIColor.green
//        levelTest.addTarget(self, action: #selector(levelTestSender), for: UIControl.Event.touchUpInside)
//        self.view!.addSubview(levelTest)
//    }
//    @objc func levelTestSender(sender: UIButton!) { // sending the User back to the Game
//        xp = xp + 100
//        UserDefaults.standard.set(xp,forKey: "xp")
//    }
    
}
