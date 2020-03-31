//
//  GamemodeScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/22/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

let gamemodeSKLabelNode = SKLabelNode(fontNamed: "Press Start 2P")
var classicB = SKSpriteNode()
let classicSKLabelNode = SKLabelNode(fontNamed: "Press Start 2P")
var oneminuteButton = SKSpriteNode()
let oneminuteSKLabelNode = SKLabelNode(fontNamed: "Press Start 2P")
var adventureB = SKSpriteNode()
let adventureLabel = SKLabelNode(fontNamed: "Press Start 2P")

class GamemodeScene: SKScene {
override func didMove(to view: SKView) {
    for view in view.subviews {
        if view is UIButton{
            view.removeFromSuperview()
        }
    }
    downbackground() // adding the background
    mainMenuFunc() // adding a main menu button
    gamemodeSKNode() //adding a Gamemode Label
    classicButton() //adding a button transition to the Classic Gamemode
    oneMinuteButtonRUN() //adding a button transition to the One Minute Gamemode
    AdventureMode() //adding a button transition to the adventure Gamemode
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
    @objc func mainMenuScene(sender: UIButton!) { // sends user back to main menu
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    func gamemodeSKNode() {
        gamemodeSKLabelNode.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.8)
        gamemodeSKLabelNode.fontColor = UIColor.white
        gamemodeSKLabelNode.fontSize = 30
        gamemodeSKLabelNode.zPosition = -9
        gamemodeSKLabelNode.name = "gamemodeSKLabelNode"
        gamemodeSKLabelNode.text = "Gamemodes:"
        addChild(gamemodeSKLabelNode)
    }
    func classicButton() {
        // Classic Button here
        //if userLevel >= 10 {
            classicB.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.325)
            classicB.size = CGSize(width: 250, height: 60)
            classicB.name = "classicB"
            var classicBAnimation: SKAction
            let classicBTextures:[SKTexture] = [SKTexture(imageNamed: "background5"), SKTexture(imageNamed: "background2"), SKTexture(imageNamed: "background1")]
//            for i in 1...6 {
//                   classicBTextures.append(SKTexture(imageNamed: "background\(i)"))
//             }
            classicBAnimation = SKAction.animate(with: classicBTextures, timePerFrame: 4.0)
            let seqRepeat = SKAction.repeat(classicBAnimation, count: 3)
            let grp = SKAction.group([seqRepeat,classicBAnimation])
            classicB.zPosition = 25
            classicB.run(SKAction.repeatForever(grp))
            addChild(classicB)
            // adding the "Classic" text here
            classicSKLabelNode.run(SKAction.repeatForever(seqRepeat))
            classicSKLabelNode.fontSize = 25
            classicSKLabelNode.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.31)
            classicSKLabelNode.zPosition = 30
            classicSKLabelNode.name = "classicSKLabelNode"
            classicSKLabelNode.text = "RGB"
            addChild(classicSKLabelNode)
        //}
    }
    func oneMinuteButtonRUN() {
            oneminuteButton.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.525)
            oneminuteButton.size = CGSize(width: 250, height: 60)
            oneminuteButton.name = "oneminuteButton"
            var oneminuteButtonAnimation: SKAction
            var oneminuteButtonTextures:[SKTexture] = []
            for i in 1...6 {
                   oneminuteButtonTextures.append(SKTexture(imageNamed: "background\(i)"))
             }
            let colorPlay = oneminuteButtonTextures.shuffled()
            oneminuteButtonAnimation = SKAction.animate(with: colorPlay, timePerFrame: 4.0)
            let oepRepeat = SKAction.repeat(oneminuteButtonAnimation, count: 6)
            let cheese = SKAction.group([oepRepeat,oneminuteButtonAnimation])
            oneminuteButton.zPosition = 25
            oneminuteButton.run(SKAction.repeatForever(cheese))
            addChild(oneminuteButton)
            // adding the "One Minute" Text minute text
            oneminuteSKLabelNode.run(SKAction.repeatForever(oepRepeat))
            oneminuteSKLabelNode.fontSize = 23
            oneminuteSKLabelNode.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.51)
            oneminuteSKLabelNode.zPosition = 30
            oneminuteSKLabelNode.name = "oneminuteSKLabelNode"
            oneminuteSKLabelNode.text = "One Minute"
            addChild(oneminuteSKLabelNode)
    }
    func AdventureMode() {
            adventureB.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.725)
            adventureB.size = CGSize(width: 250, height: 60)
            adventureB.name = "adventureB"
            var adventureBAnimation: SKAction
            var adventureBTextures:[SKTexture] = []
            for i in 1...6 {
                   adventureBTextures.append(SKTexture(imageNamed: "background\(i)"))
             }
            let adPlay = adventureBTextures.shuffled()
            adventureBAnimation = SKAction.animate(with: adPlay, timePerFrame: 4.0)
            let plsRepeat = SKAction.repeat(adventureBAnimation, count: 6)
            let chedder = SKAction.group([plsRepeat,adventureBAnimation])
            adventureB.zPosition = 25
            adventureB.run(SKAction.repeatForever(chedder))
            addChild(adventureB)
            // adding the "One Minute" Text minute text
            adventureLabel.run(SKAction.repeatForever(plsRepeat))
            adventureLabel.fontSize = 23
            adventureLabel.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.71)
            adventureLabel.zPosition = 30
            adventureLabel.name = "adventureLabel"
            adventureLabel.text = "Basic"
            addChild(adventureLabel)
    }
    func downbackground() {
        let blackbackground = SKSpriteNode(imageNamed: "blackbackground")
        blackbackground.zPosition = -50
        blackbackground.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(blackbackground)
        let starstexture = SKTexture(imageNamed: "Stars")
        for i in 0 ... 8 {
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    if let location = touch?.location(in:self) {
        let nodesArray = self.nodes(at:location)
        if nodesArray.first?.name == "classicB" || nodesArray.first?.name == "classicSKLabelNode" {
            gamemodeSKLabelNode.removeFromParent()
            classicB.removeFromParent()
            classicSKLabelNode.removeFromParent()
            oneminuteButton.removeFromParent()
            adventureB.removeFromParent()
            adventureLabel.removeFromParent()
            let nextScene = ClassicScene(size: scene!.size)
            let transition = SKTransition.fade(withDuration: 0.5)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene,transition: transition)
            shootingStarTimer.invalidate()
                }
        if nodesArray.first?.name == "oneminuteSKLabelNode" || nodesArray.first?.name == "oneminuteButton" {
            gamemodeSKLabelNode.removeFromParent()
            classicB.removeFromParent()
            classicSKLabelNode.removeFromParent()
            oneminuteButton.removeFromParent()
            adventureB.removeFromParent()
            adventureLabel.removeFromParent()
            let nextScene = SpeedScene(size: scene!.size)
            let transition = SKTransition.fade(withDuration: 0.5)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene,transition: transition)
            shootingStarTimer.invalidate()
            }
        if nodesArray.first?.name == "adventureB" || nodesArray.first?.name == "adventureLabel" {
            oneminuteButton.removeFromParent()
            gamemodeSKLabelNode.removeFromParent()
            classicB.removeFromParent()
            classicSKLabelNode.removeFromParent()
            adventureB.removeFromParent()
            adventureLabel.removeFromParent()
            let nextScene = GameScene(size: scene!.size)
            let transition = SKTransition.fade(withDuration: 0.5)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene,transition: transition)
            shootingStarTimer.invalidate()
        }
        }
    }
    
    
}
