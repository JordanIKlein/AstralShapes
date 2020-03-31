//
//  HighscoreScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/24/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class HighscoreScene: SKScene {
    var highscoretxt = SKLabelNode(fontNamed: "Press Start 2P")
    var classictxt = SKLabelNode(fontNamed: "Press Start 2P")
    var classictxt1 = SKLabelNode(fontNamed: "Press Start 2P")
    var classictxt2 = SKLabelNode(fontNamed: "Press Start 2P")
    var classictxt3 = SKLabelNode(fontNamed: "Press Start 2P")
    var speedruntxt = SKLabelNode(fontNamed: "Press Start 2P")
    var speedruntxt1 = SKLabelNode(fontNamed: "Press Start 2P")
    var speedruntxt2 = SKLabelNode(fontNamed: "Press Start 2P")
    var speedruntxt3 = SKLabelNode(fontNamed: "Press Start 2P")
    var adventuretxt = SKLabelNode(fontNamed: "Press Start 2P")
    var adventuretxt1 = SKLabelNode(fontNamed: "Press Start 2P")
    var adventuretxt2 = SKLabelNode(fontNamed: "Press Start 2P")
    var adventuretxt3 = SKLabelNode(fontNamed: "Press Start 2P")
    
    override func didMove(to view: SKView) {
        //Main Functions of the game
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        removeExtras()
        downbackground() //Adding space background
        mainMenuFunc()//Adding Main Menu Button
        adventureScores() //adding the adventure scores
        oneminuteScores() // addin the top 3 one minute scores
        classicScores() // adding the classic scores
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
    }
    func adventureScores(){
        adventuretxt.position = CGPoint(x: screenWidth/2 - speedruntxt.frame.width/2, y: screenHeight * 0.8)
        adventuretxt.fontColor = UIColor.white
        adventuretxt.fontSize = 20
        adventuretxt.zPosition = -10
        adventuretxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        adventuretxt.name = "adventuretxt"
        adventuretxt.text = "Basic:"
        addChild(adventuretxt)
        adventuretxt1.position = CGPoint(x: screenWidth/2 - speedruntxt1.frame.width/2, y: screenHeight * 0.75)
        adventuretxt1.fontColor = UIColor.white
        adventuretxt1.fontSize = 18
        adventuretxt1.zPosition = -10
        adventuretxt1.lineBreakMode = NSLineBreakMode.byWordWrapping
        adventuretxt1.name = "adventuretxt1"
        adventuretxt1.text = "1. \(highscoreArray[0])"
        addChild(adventuretxt1)
        
        adventuretxt2.position = CGPoint(x: screenWidth/2 - speedruntxt2.frame.width/2, y: screenHeight * 0.7)
        adventuretxt2.fontColor = UIColor.white
        adventuretxt2.fontSize = 18
        adventuretxt2.zPosition = -10
        adventuretxt2.lineBreakMode = NSLineBreakMode.byWordWrapping
        adventuretxt2.name = "adventuretxt2"
        adventuretxt2.text = "2. \(highscoreArray[1])"
        addChild(adventuretxt2)
        adventuretxt3.position = CGPoint(x: screenWidth/2 - speedruntxt3.frame.width/2, y: screenHeight * 0.65)
        adventuretxt3.fontColor = UIColor.white
        adventuretxt3.fontSize = 18
        adventuretxt3.zPosition = -10
        adventuretxt3.lineBreakMode = NSLineBreakMode.byWordWrapping
        adventuretxt3.name = "adventuretxt3"
        adventuretxt3.text = "3. \(highscoreArray[2])"
        addChild(adventuretxt3)
    }
    func oneminuteScores(){
        speedruntxt.position = CGPoint(x: screenWidth/2 - speedruntxt.frame.width/2, y: screenHeight * 0.60)
        speedruntxt.fontColor = UIColor.white
        speedruntxt.fontSize = 20
        speedruntxt.zPosition = -10
        speedruntxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        speedruntxt.name = "speedruntxt"
        speedruntxt.text = "One Minute:"
        addChild(speedruntxt)
        speedruntxt1.position = CGPoint(x: screenWidth/2 - speedruntxt1.frame.width/2, y: screenHeight * 0.55)
        speedruntxt1.fontColor = UIColor.white
        speedruntxt1.fontSize = 18
        speedruntxt1.zPosition = -10
        speedruntxt1.lineBreakMode = NSLineBreakMode.byWordWrapping
        speedruntxt1.name = "speedruntxt1"
        speedruntxt1.text = "1. \(speedrunArray[0])"
        addChild(speedruntxt1)
        speedruntxt2.position = CGPoint(x: screenWidth/2 - speedruntxt2.frame.width/2, y: screenHeight * 0.5)
        speedruntxt2.fontColor = UIColor.white
        speedruntxt2.fontSize = 18
        speedruntxt2.zPosition = -10
        speedruntxt2.lineBreakMode = NSLineBreakMode.byWordWrapping
        speedruntxt2.name = "speedruntxt2"
        speedruntxt2.text = "2. \(speedrunArray[1])"
        addChild(speedruntxt2)
        speedruntxt3.position = CGPoint(x: screenWidth/2 - speedruntxt3.frame.width/2, y: screenHeight * 0.45)
        speedruntxt3.fontColor = UIColor.white
        speedruntxt3.fontSize = 18
        speedruntxt3.zPosition = -10
        speedruntxt3.lineBreakMode = NSLineBreakMode.byWordWrapping
        speedruntxt3.name = "speedruntxt3"
        speedruntxt3.text = "3. \(speedrunArray[2])"
        addChild(speedruntxt3)
    }
    func classicScores(){
        classictxt.position = CGPoint(x: screenWidth/2 - classictxt.frame.width/2, y: screenHeight * 0.40)
        classictxt.fontColor = UIColor.white
        classictxt.fontSize = 20
        classictxt.zPosition = -10
        classictxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        classictxt.name = "classictxt"
        classictxt.text = "RGB:"
        addChild(classictxt)
        classictxt1.position = CGPoint(x: screenWidth/2 - classictxt1.frame.width/2, y: screenHeight * 0.35)
        classictxt1.fontColor = UIColor.white
        classictxt1.fontSize = 18
        classictxt1.zPosition = -10
        classictxt1.lineBreakMode = NSLineBreakMode.byWordWrapping
        classictxt1.name = "classictxt1"
        classictxt1.text = "1. \(classicScoreArray[0])"
        addChild(classictxt1)
        classictxt2.position = CGPoint(x: screenWidth/2 - classictxt2.frame.width/2, y: screenHeight * 0.3)
        classictxt2.fontColor = UIColor.white
        classictxt2.fontSize = 18
        classictxt2.zPosition = -10
        classictxt2.lineBreakMode = NSLineBreakMode.byWordWrapping
        classictxt2.name = "classictxt2"
        classictxt2.text = "2. \(classicScoreArray[1])"
        addChild(classictxt2)
        classictxt3.position = CGPoint(x: screenWidth/2 - classictxt3.frame.width/2, y: screenHeight * 0.25)
        classictxt3.fontColor = UIColor.white
        classictxt3.fontSize = 18
        classictxt3.zPosition = -10
        classictxt3.lineBreakMode = NSLineBreakMode.byWordWrapping
        classictxt3.name = "classictxt3"
        classictxt3.text = "3. \(classicScoreArray[2])"
        addChild(classictxt3)
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
    func removeExtras(){
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
