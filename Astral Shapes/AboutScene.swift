//
//  About.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/5/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//
import Foundation
import SpriteKit
import GameplayKit
import UIKit
var aboutGame = SKLabelNode(fontNamed: "Press Start 2P")
var menuButton = SKLabelNode(fontNamed: "Press Start 2P")
let shooting = SKEmitterNode(fileNamed: "Fire")!
var HowToButton = UIButton(type: .system)

var shootingStarTimer = Timer()

class AboutScene: SKScene {
    override func didMove(to view: SKView) {
        //Main Functions of the game
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        removeExtras()
        aboutText()//Adding SK Labelnode
        downbackground()//Adding space background
        mainMenuFunc() // main menu button
        howToPlay()
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
    }
    func aboutText(){
        aboutGame.horizontalAlignmentMode = .left
        aboutGame.position = CGPoint(x: frame.minX + 10, y: frame.midY/2 + 40)
        aboutGame.fontColor = UIColor.white
        aboutGame.fontSize = 21
        aboutGame.zPosition = -9
        aboutGame.lineBreakMode = NSLineBreakMode.byWordWrapping
        aboutGame.name = "About"
        aboutGame.text = """
        -----About-----
        
        AstralShapes is
        a matching game.
        
        Similar to an
        IQ Test.
        
        Music by
        Prod. Riddiman
        "alone in space"
        
        Copyright © 2020
        Jordan Klein. All
        rights reserved.
        
        """
        aboutGame.numberOfLines = 0
        addChild(aboutGame)
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
    func howToPlay(){
        HowToButton.frame = CGRect (x: screenWidth/2 - 150, y: screenHeight * 0.75 , width: 300, height: 50)
        HowToButton.setTitle("How To Play", for: UIControl.State.normal)
        HowToButton.setTitleColor(UIColor.white, for: .normal)
        HowToButton.layer.cornerRadius = 0
        HowToButton.layer.borderWidth = 1
        HowToButton.layer.borderColor=UIColor.white.cgColor
        HowToButton.addTarget(self, action: #selector(howtoScene), for: UIControl.Event.touchUpInside)
        HowToButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        HowToButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(HowToButton)
    }
    @objc func howtoScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = HowToScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        //shootingStarTimer.invalidate()
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
