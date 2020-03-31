//
//  HowToScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/5/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit


var introtxt = SKLabelNode(fontNamed: "Press Start 2P")
var boardofShapestxt = SKLabelNode(fontNamed: "Press Start 2P")
var scoretimetxt = SKLabelNode(fontNamed: "Press Start 2P")
let nextButton = UIButton(type: .system)
let backButton = UIButton(type: .system)
var currentP = 0


class HowToScene: SKScene,SKPhysicsContactDelegate {
    var Shape2 = SKSpriteNode()
    var Shape3 = SKSpriteNode()
    var Shape4 = SKSpriteNode()
    var Shape5 = SKSpriteNode()
    var Shape6 = SKSpriteNode()
    var Shape7 = SKSpriteNode()
    var Shape8 = SKSpriteNode()
    var Shape9 = SKSpriteNode()
    override func didMove(to view: SKView) {
        //Main Functions of the game
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        removeExtras()
        physics()
        mainView()
        downbackground() //Adding space background
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
    }
    func physics(){
        physicsWorld.gravity = CGVector(dx: 0.0,dy: 0.0) // old is  -5.0
        physicsWorld.contactDelegate = self
    }
    func mainView() {
        for view in view!.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
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
        if currentP <= 1 {
            nextButton.frame = CGRect (x:screenWidth/2 + 50, y:round(screenHeight * 0.7) , width: 100, height: 35)
            nextButton.setTitle("Next", for: UIControl.State.normal)
            nextButton.setTitleColor(UIColor.white, for: .normal)
            nextButton.layer.cornerRadius = 0
            nextButton.layer.borderWidth = 1
            nextButton.layer.borderColor=UIColor.white.cgColor
            nextButton.addTarget(self, action: #selector(nextSend), for: UIControl.Event.touchUpInside)
            nextButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 20)
            nextButton.titleLabel!.textAlignment = NSTextAlignment.center
            self.view!.addSubview(nextButton)
        }
        if currentP >= 1 {
            backButton.frame = CGRect (x:screenWidth/2 - 150, y:round(screenHeight * 0.7) , width: 100, height: 35)
            backButton.setTitle("Back", for: UIControl.State.normal)
            backButton.setTitleColor(UIColor.white, for: .normal)
            backButton.layer.cornerRadius = 0
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor=UIColor.white.cgColor
            backButton.addTarget(self, action: #selector(backSend), for: UIControl.Event.touchUpInside)
            backButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 20)
            backButton.titleLabel!.textAlignment = NSTextAlignment.center
            self.view!.addSubview(backButton)
        }
        if currentP == 0 {
            introduction() // first
        
        }
        if currentP == 1 {
            boardOfShapes() // creation of shapes
      
        }
        if currentP == 2 {
            matchShape ()
         
        }
    }
    func introduction(){
        playButton.removeFromParent()
        circleBlue.removeFromParent()
        Shape1.removeFromParent()
        Shape2.removeFromParent()
        Shape3.removeFromParent()
        Shape4.removeFromParent()
        Shape5.removeFromParent()
        Shape6.removeFromParent()
        Shape7.removeFromParent()
        Shape8.removeFromParent()
        Shape9.removeFromParent()
        introtxt.removeFromParent()
        boardofShapestxt.removeFromParent()
        introtxt.position = CGPoint(x: frame.midX, y: frame.maxY-(frame.midY/2))
        introtxt.fontColor = UIColor.white
        introtxt.fontSize = 23
        introtxt.zPosition = -9
        introtxt.name = "introtxt"
        introtxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        introtxt.text = """
        This is
        your shape!
        """
        introtxt.numberOfLines = 0
        addChild(introtxt)
        playButton.position = CGPoint(x: round(screenWidth/2), y: round(screenHeight * 0.2))
        playButton.size = CGSize(width: 75, height: 75)
        playButton.name = "cover"
        var playButtonAnimation: SKAction
        var playButtonTextures:[SKTexture] = []
        for i in 1...6 {
               playButtonTextures.append(SKTexture(imageNamed: "background\(i)"))
        }
        let randomPlay = playButtonTextures.shuffled()
        playButtonAnimation = SKAction.animate(with: randomPlay, timePerFrame: 4.0)
        let seq = SKAction.sequence([SKAction.wait(forDuration:4.8)])
        let seqRepeat = SKAction.repeat(seq, count: 7)
        let grp = SKAction.group([seqRepeat,playButtonAnimation])
        playButton.zPosition = -19
        playButton.run(SKAction.repeatForever(grp))
        addChild(playButton)
        circleBlue.position = CGPoint(x: round(screenWidth/2), y: round(screenHeight * 0.2))
        circleBlue.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
        addChild(circleBlue)
    }
    func boardOfShapes() {
        playButton.removeFromParent()
        circleBlue.removeFromParent()
        Shape1.removeFromParent()
        Shape2.removeFromParent()
        Shape3.removeFromParent()
        Shape4.removeFromParent()
        Shape5.removeFromParent()
        Shape6.removeFromParent()
        Shape7.removeFromParent()
        Shape8.removeFromParent()
        Shape9.removeFromParent()
        introtxt.removeFromParent()
        boardofShapestxt.removeFromParent()
        scoreAmount.removeFromParent()
        totalTime.removeFromParent()
        scoretimetxt.removeFromParent()
        addChild(playButton)
        addChild(circleBlue)
        boardofShapestxt.position = CGPoint(x: frame.midX, y: frame.midY)
        boardofShapestxt.fontColor = UIColor.white
        boardofShapestxt.fontSize = 23
        boardofShapestxt.zPosition = 10
        boardofShapestxt.name = "boardofShapestxt"
        boardofShapestxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        boardofShapestxt.text = """
        Match your
        
        shape and
        
        color here!
        """
        boardofShapestxt.numberOfLines = 0
        addChild(boardofShapestxt)
        randomShapes()
    }
    func matchShape(){
        playButton.removeFromParent()
        circleBlue.removeFromParent()
        Shape1.removeFromParent()
        Shape2.removeFromParent()
        Shape3.removeFromParent()
        Shape4.removeFromParent()
        Shape5.removeFromParent()
        Shape6.removeFromParent()
        Shape7.removeFromParent()
        Shape8.removeFromParent()
        Shape9.removeFromParent()
        introtxt.removeFromParent()
        boardofShapestxt.removeFromParent()
        scoreAmount.removeFromParent()
        totalTime.removeFromParent()
        scoretimetxt.removeFromParent()
        scoreAmount.zPosition = 40
        scoreAmount.fontSize = 30.0
        scoreAmount.name = "scoreAmount"
        scoreAmount.text = "3"
        scoreAmount.fontColor = UIColor.white
        scoreAmount.blendMode = .replace
        scoreAmount.position = CGPoint(x: frame.minX + screenWidth/6, y: frame.maxY - screenHeight/4)
        addChild(scoreAmount)
        //Time
        totalTime.zPosition = 40
        totalTime.fontSize = 20.0
        totalTime.name = "totaltime"
        totalTime.fontColor = UIColor.white
        totalTime.blendMode = .replace
        totalTime.position = CGPoint(x: frame.midX + frame.midX/3 , y: frame.maxY - screenHeight/4)
        totalTime.text = "Time: 7.1"
        addChild(totalTime)
        scoretimetxt.position = CGPoint(x: frame.midX, y: frame.midY)
        scoretimetxt.fontColor = UIColor.white
        scoretimetxt.fontSize = 21
        scoretimetxt.zPosition = 10
        scoretimetxt.name = "boardofShapestxt"
        scoretimetxt.lineBreakMode = NSLineBreakMode.byWordWrapping
        scoretimetxt.text = """
        Each game has a
        score and time
        counter.
        
        Good Luck!
        """
        scoretimetxt.numberOfLines = 0
        addChild(scoretimetxt)
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
    @objc func mainMenuScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    @objc func nextSend(sender: UIButton!) { // sending the user next
        if currentP <= 1{
            currentP = currentP + 1
            mainView()
        }
    }
    @objc func backSend(sender: UIButton!) { // sending the user back
        if currentP > 0{
            currentP = currentP - 1
            mainView()
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    if let location = touch?.location(in:self) {
        let nodesArray = self.nodes(at:location)
        if nodesArray.first?.name == "menuButton" {
            let nextScene = MenuScene(size: scene!.size)
            let transition = SKTransition.fade(withDuration: 0.5)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene,transition: transition)
            shootingStarTimer.invalidate()
            }
        }
    }
    func randomShapes() {
    //Creating an Array to represent the possible fake shapes
    var fakeArrayShapes:[SKSpriteNode] = [triRed,triGreen,triBlue,ciRed,ciGreen,ciBlue,sqRed,sqGreen,sqBlue,hexRed,hexGreen,hexBlue]
        Shape1 = ciBlue
        Shape1.name = "Shape1"
        while let idx = fakeArrayShapes.firstIndex(of:ciBlue) {
            fakeArrayShapes.remove(at: idx)
        }
        
        var shuffledFakeShape = fakeArrayShapes.shuffled()
        Shape2 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape3 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape4 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape5 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape6 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape7 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape8 = shuffledFakeShape.last!
        shuffledFakeShape.removeLast()
        Shape9 = shuffledFakeShape.last!
        
        //Shape 2
        if Shape2 == ciRed {
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == ciGreen{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == ciBlue{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == triRed{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == triGreen{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == triBlue{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == sqRed{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == sqGreen{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == sqBlue{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == hexRed{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == hexGreen{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape2.name = "Shape2"
        }
        if Shape2 == hexBlue{
            Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape2.name = "Shape2"
        }
        
        //Shape 3
        if Shape3 == ciRed {
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == ciGreen{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == ciBlue{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == triRed{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == triGreen{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == triBlue{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == sqRed{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == sqGreen{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == sqBlue{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == hexRed{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == hexGreen{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape3.name = "Shape3"
        }
        if Shape3 == hexBlue{
            Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape3.name = "Shape3"
        }
        //Shape 4
        if Shape4 == ciRed {
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == ciGreen{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == ciBlue{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == triRed{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == triGreen{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == triBlue{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == sqRed{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == sqGreen{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == sqBlue{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == hexRed{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == hexGreen{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape4.name = "Shape4"
        }
        if Shape4 == hexBlue{
            Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape4.name = "Shape4"
        }
        //Shape 5
        if Shape5 == ciRed {
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == ciGreen{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == ciBlue{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == triRed{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == triGreen{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == triBlue{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == sqRed{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == sqGreen{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == sqBlue{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == hexRed{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == hexGreen{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape5.name = "Shape5"
        }
        if Shape5 == hexBlue{
            Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape5.name = "Shape5"
        }
        //Shape 6
        if Shape6 == ciRed {
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == ciGreen{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == ciBlue{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == triRed{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == triGreen{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == triBlue{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == sqRed{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == sqGreen{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == sqBlue{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == hexRed{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == hexGreen{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape6.name = "Shape6"
        }
        if Shape6 == hexBlue{
            Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape6.name = "Shape6"
        }
        //Shape 7
        if Shape7 == ciRed {
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == ciGreen{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == ciBlue{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == triRed{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == triGreen{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == triBlue{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == sqRed{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == sqGreen{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == sqBlue{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == hexRed{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == hexGreen{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape7.name = "Shape7"
        }
        if Shape7 == hexBlue{
            Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape7.name = "Shape7"
        }
        //Shape 8
        if Shape8 == ciRed {
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == ciGreen{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == ciBlue{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == triRed{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == triGreen{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == triBlue{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == sqRed{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == sqGreen{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == sqBlue{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == hexRed{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == hexGreen{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape8.name = "Shape8"
        }
        if Shape8 == hexBlue{
            Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape8.name = "Shape8"
        }
        //Shape 9
        if Shape9 == ciRed {
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == ciGreen{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == ciBlue{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == triRed{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == triGreen{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == triBlue{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == sqRed{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == sqGreen{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == sqBlue{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == hexRed{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == hexGreen{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            Shape9.name = "Shape9"
        }
        if Shape9 == hexBlue{
            Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            Shape9.name = "Shape9"
        }
        
        
        let arrayOfPoints: [CGPoint] = [position1, position2, position3, position4, position5, position6, position7, position8, position9]
        var shuffledPoints = arrayOfPoints.shuffled()
        
        Shape1.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape2.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape3.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape4.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape5.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape6.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape7.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape8.position = shuffledPoints.last!
        shuffledPoints.removeLast()
        Shape9.position = shuffledPoints.last!
        
        Shape1.zPosition = 1
        Shape2.zPosition = 1
        Shape3.zPosition = 1
        Shape4.zPosition = 1
        Shape5.zPosition = 1
        Shape6.zPosition = 1
        Shape7.zPosition = 1
        Shape8.zPosition = 1
        Shape9.zPosition = 1
        
        //Physics for the fake shapes
        //Shape 1
        Shape1.physicsBody?.categoryBitMask = CollisionType.Shape1.rawValue
        Shape1.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape1.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape1.physicsBody?.isDynamic = false
        //Shape 2
        Shape2.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape2.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape2.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape2.physicsBody?.isDynamic = false
        //Shape 3
        Shape3.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape3.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape3.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape3.physicsBody?.isDynamic = false
        //Shape 4
        Shape4.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape4.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape4.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape4.physicsBody?.isDynamic = false
        //Shape 5
        Shape5.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape5.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape5.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape5.physicsBody?.isDynamic = false
        //Shape 6
        Shape6.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape6.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape6.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape6.physicsBody?.isDynamic = false
        //Shape 7
        Shape7.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape7.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape7.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape7.physicsBody?.isDynamic = false
        //Shape 8
        Shape8.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape8.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape8.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape8.physicsBody?.isDynamic = false
        
        Shape9.physicsBody?.categoryBitMask = CollisionType.everythingElse.rawValue
        Shape9.physicsBody?.contactTestBitMask = CollisionType.playerShape.rawValue
        Shape9.physicsBody?.collisionBitMask = CollisionType.playerShape.rawValue
        Shape9.physicsBody?.isDynamic = false

        addChild(Shape1)
        addChild(Shape2)
        addChild(Shape3)
        addChild(Shape4)
        addChild(Shape5)
        addChild(Shape6)
        addChild(Shape7)
        addChild(Shape8)
        addChild(Shape9)
    }
    //func HowToText(){
    //        HowTotxt.horizontalAlignmentMode = .left
    //        HowTotxt.position = CGPoint(x: frame.minX + 10, y: frame.midY/2)
    //        HowTotxt.fontColor = UIColor.white
    //        HowTotxt.fontSize = 21
    //        HowTotxt.zPosition = -9
    //        HowTotxt.lineBreakMode = NSLineBreakMode.byWordWrapping
    //        HowTotxt.name = "HowTo"
    //        HowTotxt.text = """
    //        ---How To Play---
    //
    //        Match the shape
    //        and color of your
    //        bottom shape by
    //        tapping one of
    //        the upper shapes.
    //
    //        Time? You start
    //        with five seconds
    //        and the game gets
    //        progressively more
    //        difficult as your
    //        score increases.
    //
    //        How? Tap one of
    //        the upper shapes.
    //        Be fast and beat
    //        the timer.
    //
    //        """
    //        HowTotxt.numberOfLines = 0
    //        addChild(HowTotxt)
    //    }
}
