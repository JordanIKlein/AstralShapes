//
//  MenuScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/5/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//
import SpriteKit
import GameplayKit
import AVFoundation

var highScoreButton = UIButton(type: .system)
let howToPlayButton = UIButton(type: .system)
var XPButton = UIButton(type: .custom)
var settingsScene = UIButton(type: .system)
var aboutButton = UIButton(type: .system)
var musicTrack = UserDefaults.standard.string(forKey: "musicTrack") ?? "lofimusic1"

class MenuScene: SKScene {
    var playButton = SKSpriteNode()
    let shooting = SKEmitterNode(fileNamed: "Fire")!
    var shootingStarTimer = Timer()
    
    override func didMove(to view: SKView) {
        removeExtras()
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        randomVariable = 0
        continueBasic = 1
        continueRGB = 1
        downbackground()
        addButtons()
        mainTitle()
        runButton()
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
        }
    
    func shootingStar(){
        shooting.removeFromParent()
        addChild(shooting)
        shooting.zPosition = -25
        let getXValue = GKRandomDistribution(lowestValue: Int(frame.minX + 200), highestValue: Int(frame.maxX))
        let getYValue = GKRandomDistribution(lowestValue: Int(frame.minY + 200), highestValue: Int(frame.maxY - 50))
        let xPosition = CGFloat(getXValue.nextInt())
        let yPosition = CGFloat(getYValue.nextInt())
        shooting.position = CGPoint(x: xPosition, y: yPosition)
        let shootingMove = SKAction.moveBy(x: -250, y: -150, duration: 2.5)
        shooting.run(shootingMove)
        shooting.run(SKAction.sequence([SKAction.self.fadeIn(withDuration: 0.5),SKAction.wait(forDuration: 1.0),SKAction.self.fadeOut(withDuration: 1),SKAction.self.removeFromParent()]))
        
    }
    func runButton() {
        playButton.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.6)
        playButton.size = CGSize(width: 250, height: 50)
        playButton.name = "playButton"
        var playButtonAnimation: SKAction
        var playButtonFadeIn: SKAction
        var playButtonFadeOut: SKAction
        var playButtonTextures:[SKTexture] = []
         for i in 1...7 {
               playButtonTextures.append(SKTexture(imageNamed: "button\(i)"))
         }
        let randomPlay = playButtonTextures.shuffled()
        playButtonAnimation = SKAction.animate(with: randomPlay, timePerFrame: 5.0)
        playButtonFadeIn = SKAction.fadeIn(withDuration: 0.5)
        playButtonFadeOut = SKAction.fadeOut(withDuration: 0.5)
        let seq = SKAction.sequence([playButtonFadeIn,SKAction.wait(forDuration:4.0),playButtonFadeOut])
        let seqRepeat = SKAction.repeat(seq, count: 7)
        let grp = SKAction.group([seqRepeat,playButtonAnimation])
        playButton.zPosition = 25
        playButton.run(SKAction.repeatForever(grp))
        addChild(playButton)
    }
    func addButtons(){
        highScoreButton.frame = CGRect (x: screenWidth/2 - 125, y: screenHeight * 0.5 , width: 250, height: 50)
        highScoreButton.setTitle("Highscore", for: UIControl.State.normal)
        highScoreButton.setTitleColor(UIColor.white, for: .normal)
        highScoreButton.layer.cornerRadius = 0
        highScoreButton.layer.borderWidth = 1
        highScoreButton.layer.borderColor=UIColor.white.cgColor
        highScoreButton.addTarget(self, action: #selector(highscoreScene), for: UIControl.Event.touchUpInside)
        highScoreButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        highScoreButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(highScoreButton)
        // Settings Button
        settingsScene.frame = CGRect (x: screenWidth/2 - 125, y: screenHeight * 0.6 , width: 250, height: 50)
        settingsScene.setTitle("Settings", for: UIControl.State.normal)
        settingsScene.setTitleColor(UIColor.white, for: .normal)
        settingsScene.layer.cornerRadius = 0
        settingsScene.layer.borderWidth = 1
        settingsScene.layer.borderColor=UIColor.white.cgColor
        settingsScene.addTarget(self, action: #selector(settingTheScene), for: UIControl.Event.touchUpInside)
        settingsScene.titleLabel!.font = UIFont(name: "Press Start 2P", size: 25)
        settingsScene.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(settingsScene)
        // How to Play Button
        howToPlayButton.frame = CGRect (x: screenWidth/2 - 125, y: screenHeight * 0.7 , width: 250, height: 50)
        howToPlayButton.layer.cornerRadius = 0
        howToPlayButton.layer.borderWidth = 1
        howToPlayButton.layer.borderColor=UIColor.white.cgColor
        howToPlayButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 20)
        howToPlayButton.setTitle("How To Play", for: .normal)
        howToPlayButton.setTitleColor(UIColor.white, for: .normal)
        howToPlayButton.titleLabel!.textAlignment = NSTextAlignment.center
        howToPlayButton.addTarget(self, action: #selector(howToScene), for: UIControl.Event.touchUpInside)
        self.view!.addSubview(howToPlayButton)
        // About Button
        aboutButton.frame = CGRect (x:screenWidth/2 - 125, y:screenHeight * 0.8 , width: 250, height: 50)
        aboutButton.setTitle("About", for: UIControl.State.normal)
        aboutButton.setTitleColor(UIColor.white, for: .normal)
        aboutButton.layer.cornerRadius = 0
        aboutButton.layer.borderWidth = 1
        aboutButton.layer.borderColor=UIColor.white.cgColor
        aboutButton.addTarget(self, action: #selector(aboutScene), for: UIControl.Event.touchUpInside)
        aboutButton.titleLabel!.font = UIFont(name: "Press Start 2P", size: 20)
        aboutButton.titleLabel!.textAlignment = NSTextAlignment.center
        self.view!.addSubview(aboutButton)
    }
    @objc func aboutScene(sender: UIButton!) { // sending the user to about
        let nextScene = AboutScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    @objc func howToScene(sender: UIButton!) { // sending the user to how to
        let nextScene = HowToScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    
    @objc func highscoreScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = HighscoreScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
    }
    @objc func settingTheScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = SettingScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.0)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene,transition: transition)
        shootingStarTimer.invalidate()
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in:self) {
        let nodesArray = self.nodes(at:location)
            if nodesArray.first?.name == "playButton" {
                playButton.removeFromParent()
                let nextScene = GamemodeScene(size: scene!.size)
                let transition = SKTransition.fade(withDuration: 0.0)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene,transition: transition)
            }
        }
    }
    func mainTitle(){
        let mainText = SKLabelNode(fontNamed: "Press Start 2P")
        mainText.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.75)
        mainText.text = "Astral Shapes"
        mainText.fontSize = 14
        mainText.zPosition = 10000
        let arrayOfColors = [UIColor.systemTeal,UIColor.orange,UIColor.green,UIColor.systemPink,UIColor.red]
        let upScaling = SKAction.scale(by: 2.0, duration: 2.0)
        let downScaling = SKAction.scale(by: 0.5, duration: 2.0)
        let colorChange = SKAction.run {
            let fontColor = arrayOfColors.randomElement()
            mainText.fontColor = fontColor
        }
        //Change colors?
        let seq = SKAction.sequence([colorChange,upScaling,colorChange,downScaling])
        mainText.run(SKAction.repeatForever(seq))
        addChild(mainText)
    }
}
