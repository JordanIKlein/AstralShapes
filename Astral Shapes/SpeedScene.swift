//
//  SpeedScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/23/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

var speedrunArray = UserDefaults.standard.array(forKey: "speedrun") as? [Int] ?? [0, 0, 0]

class SpeedScene: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        //Main Functions of the game
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        removeExtras()
        score = 0
        seconds = 60.0
        physics() //Physics
        downbackground() // Moving Background
        addingScoreTimeLabels() // adding score and time labels
        startGame() // initialization of the game so that the game constantly updates only after we're in the game scene
        runButton() // button behind the main shape we are looking for
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
        }
    func runButton() {
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
    }
    func continueGame(){
        // Adding the continue button for a continuation of the game.
        if continueVariable == 1 {
            self.view!.addSubview(continueGameB)
        }
        
        // Main Menu Button
        mainMenuS.frame = CGRect (x:frame.midX - 125, y:frame.maxY * 0.2 , width: 250, height: 40)
        mainMenuS.setTitle("Main Menu", for: UIControl.State.normal)
        mainMenuS.setTitleColor(UIColor.white, for: .normal)
        mainMenuS.layer.cornerRadius = 0
        mainMenuS.layer.borderWidth = 1
        mainMenuS.layer.borderColor=UIColor.white.cgColor
        mainMenuS.addTarget(self, action: #selector(mainMenuScene), for: UIControl.Event.touchUpInside)
        mainMenuS.titleLabel!.font = UIFont(name: "Press Start 2P", size: 27)
        mainMenuS.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(mainMenuS)
        // Adding the score label
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY * 0.6)
        scoreLabel.fontSize = 30
        scoreLabel.text = "Score:"
        scoreLabel.fontName = "Press Start 2P"
        scoreLabel.name = "scoreLabel"
        scoreLabel.color = UIColor.black
        scoreLabel.zPosition = 55
        addChild(scoreLabel)
        scoreNumber.position = CGPoint(x: frame.midX, y: frame.maxY * 0.5)
        scoreNumber.fontSize = 30
        scoreNumber.text = "\(score)"
        scoreNumber.fontName = "Press Start 2P"
        scoreNumber.name = "scoreLabel"
        scoreNumber.color = UIColor.black
        scoreNumber.zPosition = 55
        addChild(scoreNumber)
        replayButton.frame = CGRect (x:frame.midX - 125, y:frame.midY + 20 , width: 250, height: 40)
        replayButton.setTitle("Replay", for: UIControl.State.normal)
        replayButton.setTitleColor(UIColor.white, for: .normal)
        replayButton.layer.cornerRadius = 0
        replayButton.layer.borderWidth = 1
        replayButton.layer.borderColor=UIColor.white.cgColor
        replayButton.addTarget(self, action: #selector(gameScene2), for: UIControl.Event.touchUpInside)
        replayButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 27)
        replayButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(replayButton)
        
//        xpText.position = CGPoint(x: frame.midX, y: frame.maxY * 0.85)
//        xpText.fontSize = 25
//        xpText.fontName = "Press Start 2P"
//        xpText.name = "xptext"
//        xpText.color = UIColor.black
//        xpText.zPosition = 55
//        if xp < 1975 {
//            if score <= 25 && score > 20 {
//                xp = xp + 15
//                xpText.text = "XP earned: 15"
//                UserDefaults.standard.set(xp, forKey: "xp")
//            } else if score <= 50 && score > 25 {
//                xp = xp + 20
//                xpText.text = "XP earned: 20"
//                UserDefaults.standard.set(xp, forKey: "xp")
//            } else if score > 50 {
//                xp = xp + 25
//                xpText.text = "XP earned: 25"
//                UserDefaults.standard.set(xp, forKey: "xp")
//            } else {
//                xpText.text = ""
//            }
//        } else {
//            xpText.text = ""
//        }
//        addChild(xpText)
        
        guard score > speedrunArray.last ?? 0 else { return }
        speedrunArray.append(score)  // add new core to array
        speedrunArray.sort(by:>)     // sort by value
        UserDefaults.standard.set(Array(speedrunArray.prefix(3)), forKey: "speedrun")
    }
    func continueFunc(){
            scoreNumber.removeFromParent()
            scoreLabel.removeFromParent()
                for view in view!.subviews {
                    if view is UIButton{
                        view.removeFromSuperview()
                    }
                }
        }
    @objc func mainMenuScene(sender: UIButton!) { // sending the User back to the Game
        removeExtras()
        playButton.removeFromParent()
        scoreAmount.removeFromParent()
        totalTime.removeFromParent()
        classicB.removeFromParent()
        classicSKLabelNode.removeFromParent()
        oneminuteButton.removeFromParent()
        oneminuteSKLabelNode.removeFromParent()
        shootingStarTimer.invalidate()
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    @objc func gameScene2(sender: UIButton!) { // sending the User back to the Game
        shootingStarTimer.invalidate()
        let nextScene = GameScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
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
            
            if nodesArray.first?.name == "Shape1" {
                score = score + 1
                restartTimer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: {_ in self.newSetup()})
            } else if nodesArray.first?.name == "Shape2" {
               gameOver()
            } else if nodesArray.first?.name == "Shape3" {
               gameOver()
            } else if nodesArray.first?.name == "Shape4" {
               gameOver()
            } else if nodesArray.first?.name == "Shape5" {
               gameOver()
            } else if nodesArray.first?.name == "Shape6" {
               gameOver()
            } else if nodesArray.first?.name == "Shape7" {
               gameOver()
            } else if nodesArray.first?.name == "Shape8" {
               gameOver()
            } else if nodesArray.first?.name == "Shape9" {
               gameOver()
            }
        }
    }
    func startGame(){
        constantUpdate()// sets highscore and prints the score as well as the time left in 10 second intravels
        addingPlayerShape()//add shape player
        randomShapes() //adding the shapes
    }
    func newSetup(){ // Removes any extra nodes, avoiding SKParent Node issues
        removeExtras()
        addingScoreTimeLabels()
        runButton()
        addingPlayerShape()
        randomShapes() //adds the random shapes
        if seconds <= 0.0 {
            gameOver()
        }
    }
    func updateScoreTime(){
        seconds = seconds - 0.1
        if seconds <= 0.0 {
            gameOver()
        }
        scoreAmount.text = "\(score)"
        totalTime.text = "Time:\((seconds*100).rounded()/100)"
    }
    func constantUpdate(){
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in self.updateScoreTime()})
    }
    func gameOver(){
        // returnback score
        removeExtras()
        playButton.removeFromParent()
        scoreAmount.removeFromParent()
        totalTime.removeFromParent()
        officialTimer.invalidate()
        updateTimer.invalidate()
        correctTimer.invalidate()
        seconds = 7.0
        continueGame()
    }
    
    func physics(){
        physicsWorld.gravity = CGVector(dx: 0.0,dy: 0.0) // old is  -5.0
        physicsWorld.contactDelegate = self
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
    
    func addingScoreTimeLabels(){
        //Implementing score text to display "Score" text
        scoreAmount.zPosition = 40
        scoreAmount.fontSize = 30.0
        scoreAmount.name = "scoreAmount"
        scoreAmount.fontColor = UIColor.white
        scoreAmount.blendMode = .replace
        scoreAmount.position = CGPoint(x: frame.minX + screenWidth/6, y: frame.maxY - screenHeight/11)
        addChild(scoreAmount)
        //Time
        totalTime.zPosition = 40
        totalTime.fontSize = 20.0
        totalTime.name = "totaltime"
        totalTime.fontColor = UIColor.white
        totalTime.blendMode = .replace
        totalTime.position = CGPoint(x: frame.midX + frame.midX/3 , y: frame.maxY - screenHeight/11)
        addChild(totalTime)
    }

    func addingPlayerShape(){
        //Play positions
        if userLevel < 5 {
        let arrayShapes:[SKSpriteNode] = [triangleRed,triangleGreen,triangleBlue,circleGreen,circleBlue,circleRed,squareGreen,squareRed,squareBlue, hexagonGreen, hexagonBlue,hexagonRed]
        let shuffleShape = arrayShapes.shuffled()
        playerShape = shuffleShape.randomElement()! //the player's Shape
        let bottom = CGPoint(x: round(screenWidth/2), y: round(screenHeight * 0.2))
        playerShape.position = bottom
        playerShape.zPosition = 100
        
        if playerShape == circleBlue{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleBlue.size.width, height: circleBlue.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
            
        }
        if playerShape == circleGreen{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleGreen.size.width, height: circleGreen.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
        
        }
        if playerShape == circleRed{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleRed.size.width, height: circleRed.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
            
        }
        if playerShape == triangleBlue{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleBlue.size.width, height: triangleBlue.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
           
        }
        if playerShape == triangleGreen{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleGreen.size.width, height: triangleGreen.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
     
        }
        if playerShape == triangleRed{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleRed.size.width, height: triangleRed.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
         
        }
        if playerShape == squareBlue{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareBlue.size.width, height: squareBlue.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
    
        }
        if playerShape == squareGreen{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareGreen.size.width, height: squareGreen.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
     
        }
        if playerShape == squareRed{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareRed.size.width, height: squareRed.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
         
        }
        if playerShape == hexagonBlue{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonBlue.size.width, height: hexagonBlue.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
         
        }
        if playerShape == hexagonGreen{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonGreen.size.width, height: hexagonGreen.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
            
        }
        if playerShape == hexagonRed{
            playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonRed.size.width, height: hexagonRed.size.height))
            playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
            playerShape.name = "playerShape"
            
        }
        addChild(playerShape)
            
        } else if userLevel >= 5 {
            let arrayShapes:[SKSpriteNode] = [triangleRed,triangleGreen,triangleBlue,trianglePurple,triangleOrange,triangleYellow,circleGreen,circleBlue,circleRed,circleYellow,circlePurple,circleOrange,squareGreen,squareRed,squareBlue,squareYellow,squareOrange,squarePurple,hexagonGreen, hexagonBlue,hexagonRed,hexagonOrange,hexagonPurple,hexagonYellow]
            
                let shuffleShape = arrayShapes.shuffled()
                playerShape = shuffleShape.randomElement()! //the player's Shape
                let bottom = CGPoint(x: round(screenWidth/2), y: round(screenHeight * 0.2))
                playerShape.position = bottom
                playerShape.zPosition = 1000
                
                if playerShape == circleBlue{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleBlue.size.width, height: circleBlue.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == circleGreen{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleGreen.size.width, height: circleGreen.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                
                }
                if playerShape == circleRed{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleRed.size.width, height: circleRed.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == circleYellow{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleBlue.size.width, height: circleBlue.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == circleOrange{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleGreen.size.width, height: circleGreen.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                
                }
                if playerShape == circlePurple{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: circleRed.size.width, height: circleRed.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == triangleBlue{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleBlue.size.width, height: triangleBlue.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                   
                }
                if playerShape == triangleGreen{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleGreen.size.width, height: triangleGreen.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
             
                }
                if playerShape == triangleRed{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleRed.size.width, height: triangleRed.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                 
                }
                if playerShape == triangleYellow{
                       playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleBlue.size.width, height: triangleBlue.size.height))
                       playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                       playerShape.name = "playerShape"
                      
                   }
                if playerShape == triangleOrange{
                       playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleGreen.size.width, height: triangleGreen.size.height))
                       playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                       playerShape.name = "playerShape"
                
                   }
                if playerShape == trianglePurple{
                       playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triangleRed.size.width, height: triangleRed.size.height))
                       playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                       playerShape.name = "playerShape"
                    
                   }
                if playerShape == squareBlue{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareBlue.size.width, height: squareBlue.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
            
                }
                if playerShape == squareGreen{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareGreen.size.width, height: squareGreen.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
             
                }
                if playerShape == squareRed{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareRed.size.width, height: squareRed.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                 
                }
                if playerShape == squareYellow{
                        playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareBlue.size.width, height: squareBlue.size.height))
                        playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                        playerShape.name = "playerShape"
                
                    }
                if playerShape == squareOrange{
                        playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareGreen.size.width, height: squareGreen.size.height))
                        playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                        playerShape.name = "playerShape"
                 
                    }
                if playerShape == squarePurple{
                        playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: squareRed.size.width, height: squareRed.size.height))
                        playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                        playerShape.name = "playerShape"
                     
                    }
                if playerShape == hexagonBlue{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonBlue.size.width, height: hexagonBlue.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                 
                }
                if playerShape == hexagonGreen{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonGreen.size.width, height: hexagonGreen.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == hexagonRed{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonRed.size.width, height: hexagonRed.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == hexagonYellow{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonBlue.size.width, height: hexagonBlue.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                 
                }
                if playerShape == hexagonOrange{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonGreen.size.width, height: hexagonGreen.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                if playerShape == hexagonPurple{
                    playerShape.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexagonRed.size.width, height: hexagonRed.size.height))
                    playerShape.physicsBody?.categoryBitMask = CollisionType.playerShape.rawValue
                    playerShape.name = "playerShape"
                    
                }
                addChild(playerShape)
        }
    }
    func randomShapes() {
    //Creating an Array to represent the possible fake shapes
    if userLevel < 5 {
        var fakeArrayShapes:[SKSpriteNode] = [triRed,triGreen,triBlue,ciRed,ciGreen,ciBlue,sqRed,sqGreen,sqBlue,hexRed,hexGreen,hexBlue]
        
        if playerShape == circleBlue{
            Shape1 = ciBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:ciBlue) {
                fakeArrayShapes.remove(at: idx)
            }
        }
        if playerShape == circleGreen{
            Shape1 = ciGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:ciGreen) {
                fakeArrayShapes.remove(at: idx)
            }
        }
        if playerShape == circleRed{
            Shape1 = ciRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:ciRed) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == triangleBlue{
            Shape1 = triBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:triBlue) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == triangleGreen{
            Shape1 = triGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:triGreen) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == triangleRed{
            Shape1 = triRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:triRed) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == squareBlue{
            Shape1 = sqBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:sqBlue) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == squareGreen{
            Shape1 = sqGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:sqGreen) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == squareRed{
            Shape1 = sqRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:sqRed) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == hexagonBlue{
            Shape1 = hexBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:hexBlue) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == hexagonGreen{
            Shape1 = hexGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:hexGreen) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
        if playerShape == hexagonRed{
            Shape1 = hexRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexBlue.size.height))
            while let idx = fakeArrayShapes.firstIndex(of:hexRed) {
                fakeArrayShapes.remove(at: idx)
            }
                    }
            var shuffledFakeShape = fakeArrayShapes.shuffled()
            let Shape2 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape3 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape4 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape5 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape6 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape7 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape8 = shuffledFakeShape.last!
            shuffledFakeShape.removeLast()
            let Shape9 = shuffledFakeShape.last!
            
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
            
            Shape1.zPosition = 20
            Shape2.zPosition = 20
            Shape3.zPosition = 20
            Shape4.zPosition = 20
            Shape5.zPosition = 20
            Shape6.zPosition = 20
            Shape7.zPosition = 20
            Shape8.zPosition = 20
            Shape9.zPosition = 20
            
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
        } else if userLevel >= 5 {
        
        var fakeArrayShapes2:[SKSpriteNode] = [triRed,triGreen,triBlue,triYellow,triOrange,triPurple,ciRed,ciGreen,ciBlue,ciYellow,ciOrange,ciPurple,sqRed,sqGreen,sqBlue,sqYellow,sqOrange,sqPurple,hexRed,hexGreen,hexBlue,hexYellow,hexOrange,hexPurple]
        
        if playerShape == circleBlue{
            Shape1 = ciBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:ciBlue) {
                fakeArrayShapes2.remove(at: idx)
            }
        }
        if playerShape == circleGreen{
            Shape1 = ciGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:ciGreen) {
                fakeArrayShapes2.remove(at: idx)
            }
        }
        if playerShape == circleRed{
            Shape1 = ciRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:ciRed) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == circleYellow{
            Shape1 = ciYellow
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:ciYellow) {
                fakeArrayShapes2.remove(at: idx)
            }
        }
        if playerShape == circleOrange{
            Shape1 = ciOrange
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:ciOrange) {
                fakeArrayShapes2.remove(at: idx)
            }
        }
        if playerShape == circlePurple{
            Shape1 = ciPurple
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:ciPurple) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == triangleBlue{
            Shape1 = triBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:triBlue) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == triangleGreen{
            Shape1 = triGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:triGreen) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == triangleRed{
            Shape1 = triRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:triRed) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == triangleYellow{
            Shape1 = triYellow
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:triYellow) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == triangleOrange{
            Shape1 = triOrange
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:triOrange) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == trianglePurple{
            Shape1 = triPurple
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:triPurple) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == squareBlue{
            Shape1 = sqBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:sqBlue) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == squareGreen{
            Shape1 = sqGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:sqGreen) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == squareRed{
            Shape1 = sqRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:sqRed) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == squareYellow{
            Shape1 = sqYellow
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:sqYellow) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == squareOrange{
            Shape1 = sqOrange
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:sqOrange) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == squarePurple{
            Shape1 = sqPurple
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:sqPurple) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == hexagonBlue{
            Shape1 = hexBlue
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:hexBlue) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == hexagonGreen{
            Shape1 = hexGreen
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:hexGreen) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == hexagonRed{
            Shape1 = hexRed
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:hexRed) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == hexagonYellow{
            Shape1 = hexYellow
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:hexYellow) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == hexagonOrange{
            Shape1 = hexOrange
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:hexOrange) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
        if playerShape == hexagonPurple{
            Shape1 = hexPurple
            Shape1.name = "Shape1"
            Shape1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
            while let idx = fakeArrayShapes2.firstIndex(of:hexPurple) {
                fakeArrayShapes2.remove(at: idx)
            }
                    }
            var shuffledFakeShape2 = fakeArrayShapes2.shuffled()
            let Shape2 = shuffledFakeShape2.last!
            
            shuffledFakeShape2.removeLast()
            let Shape3 = shuffledFakeShape2.last!
    
            shuffledFakeShape2.removeLast()
            let Shape4 = shuffledFakeShape2.last!
      
            shuffledFakeShape2.removeLast()
            let Shape5 = shuffledFakeShape2.last!
       
            shuffledFakeShape2.removeLast()
            let Shape6 = shuffledFakeShape2.last!

            shuffledFakeShape2.removeLast()
            let Shape7 = shuffledFakeShape2.last!

            shuffledFakeShape2.removeLast()
            let Shape8 = shuffledFakeShape2.last!
    
            shuffledFakeShape2.removeLast()
            let Shape9 = shuffledFakeShape2.last!
        
            
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
            if Shape2 == ciYellow {
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == ciOrange{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == ciPurple{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == triYellow{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == triOrange{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == triPurple{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == sqYellow{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == sqOrange{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == sqPurple{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == hexYellow{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == hexOrange{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape2.name = "Shape2"
            }
            if Shape2 == hexPurple{
                Shape2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape2.name = "Shape2"
            }
            //Shape 3
            if Shape3 == ciRed {
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape3.name = "Shape3"
            }
            if Shape3 == ciGreen{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == ciBlue{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == triRed{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == triGreen{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == triBlue{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == sqRed{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == sqGreen{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == sqBlue{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == hexRed{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == hexGreen{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == hexBlue{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == ciYellow {
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == ciOrange{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == ciPurple{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == triYellow{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == triOrange{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == triPurple{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == sqYellow{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == sqOrange{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == sqPurple{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == hexYellow{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == hexOrange{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape3.name = "Shape2"
            }
            if Shape3 == hexPurple{
                Shape3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape3.name = "Shape2"
            }
            //Shape 4
            if Shape4 == ciRed {
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == ciGreen{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == ciBlue{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == triRed{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == triGreen{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == triBlue{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == sqRed{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == sqGreen{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == sqBlue{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == hexRed{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == hexGreen{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == hexBlue{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == ciYellow {
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == ciOrange{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == ciPurple{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == triYellow{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == triOrange{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == triPurple{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == sqYellow{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == sqOrange{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == sqPurple{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == hexYellow{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == hexOrange{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape4.name = "Shape2"
            }
            if Shape4 == hexPurple{
                Shape4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape4.name = "Shape2"
            }
            //Shape 5
            if Shape5 == ciRed {
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == ciGreen{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == ciBlue{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == triRed{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == triGreen{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == triBlue{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == sqRed{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == sqGreen{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == sqBlue{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == hexRed{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == hexGreen{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == hexBlue{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == ciYellow {
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == ciOrange{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == ciPurple{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == triYellow{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == triOrange{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == triPurple{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == sqYellow{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == sqOrange{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == sqPurple{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == hexYellow{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == hexOrange{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape5.name = "Shape2"
            }
            if Shape5 == hexPurple{
                Shape5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape5.name = "Shape2"
            }
            //Shape 6
            if Shape6 == ciRed {
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == ciGreen{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == ciBlue{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == triRed{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == triGreen{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == triBlue{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == sqRed{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == sqGreen{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == sqBlue{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == hexRed{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == hexGreen{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == hexBlue{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == ciYellow {
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == ciOrange{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == ciPurple{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == triYellow{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == triOrange{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == triPurple{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == sqYellow{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == sqOrange{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == sqPurple{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == hexYellow{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == hexOrange{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape6.name = "Shape2"
            }
            if Shape6 == hexPurple{
                Shape6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape6.name = "Shape2"
            }
            //Shape 7
            if Shape7 == ciRed {
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == ciGreen{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == ciBlue{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == triRed{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == triGreen{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == triBlue{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == sqRed{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == sqGreen{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == sqBlue{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == hexRed{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == hexGreen{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == hexBlue{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == ciYellow {
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == ciOrange{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == ciPurple{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == triYellow{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == triOrange{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == triPurple{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == sqYellow{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == sqOrange{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == sqPurple{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == hexYellow{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape7 .name = "Shape2"
            }
            if Shape7 == hexOrange{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape7.name = "Shape2"
            }
            if Shape7 == hexPurple{
                Shape7.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape7.name = "Shape2"
            }
            //Shape 8
            if Shape8 == ciRed {
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == ciGreen{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == ciBlue{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == triRed{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == triGreen{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == triBlue{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == sqRed{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == sqGreen{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == sqBlue{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == hexRed{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == hexGreen{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == hexBlue{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == ciYellow {
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == ciOrange{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == ciPurple{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == triYellow{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == triOrange{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == triPurple{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == sqYellow{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == sqOrange{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == sqPurple{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == hexYellow{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == hexOrange{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape8.name = "Shape2"
            }
            if Shape8 == hexPurple{
                Shape8.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape8.name = "Shape2"
            }
            //Shape 9
            if Shape9 == ciRed {
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciRed.size.width, height: ciRed.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == ciGreen{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciGreen.size.width, height: ciGreen.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == ciBlue{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciBlue.size.width, height: ciBlue.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == triRed{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triRed.size.width, height: triRed.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == triGreen{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triGreen.size.width, height: triGreen.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == triBlue{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triBlue.size.width, height: triBlue.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == sqRed{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqRed.size.width, height: sqRed.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == sqGreen{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqGreen.size.width, height: sqGreen.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == sqBlue{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqBlue.size.width, height: sqBlue.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == hexRed{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexRed.size.width, height: hexRed.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == hexGreen{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexGreen.size.width, height: hexGreen.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == hexBlue{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexBlue.size.width, height: hexBlue.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == ciYellow {
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciYellow.size.width, height: ciYellow.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == ciOrange{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciOrange.size.width, height: ciOrange.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == ciPurple{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ciPurple.size.width, height: ciPurple.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == triYellow{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triYellow.size.width, height: triYellow.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == triOrange{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triOrange.size.width, height: triOrange.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == triPurple{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: triPurple.size.width, height: triPurple.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == sqYellow{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqYellow.size.width, height: sqYellow.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == sqOrange{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqOrange.size.width, height: sqOrange.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == sqPurple{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sqPurple.size.width, height: sqPurple.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == hexYellow{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexYellow.size.width, height: hexYellow.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == hexOrange{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexOrange.size.width, height: hexOrange.size.height))
                Shape9.name = "Shape2"
            }
            if Shape9 == hexPurple{
                Shape9.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hexPurple.size.width, height: hexPurple.size.height))
                Shape9.name = "Shape2"
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
    }
        
}

