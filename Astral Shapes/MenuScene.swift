//
//  MenuScene.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/5/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//
import SpriteKit
import GameplayKit
var highScoreButton = UIButton(type: .system)
var aboutButton = UIButton(type: .custom)
var XPButton = UIButton(type: .custom)
var settingsScene = UIButton(type: .system)

var mute = UserDefaults.standard.bool(forKey: "mute") ?? false

class MenuScene: SKScene {
    var playButton = SKSpriteNode()
    let shooting = SKEmitterNode(fileNamed: "Fire")!
    var shootingStarTimer = Timer()
    var profileButton = SKSpriteNode()
    var profileLabel = SKLabelNode(fontNamed: "Press Start 2P")
    
    override func didMove(to view: SKView) {
        removeExtras()
        for view in view.subviews {
                   if view is UIButton{
                       view.removeFromSuperview()
                   }
        }
        randomVariable = 0
        continueVariable = 1
        downbackground()
        addButtons()
        runButton()
        musicCheck()
        shootingStarTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {_ in self.shootingStar()})
        }
    func musicCheck(){
            if UserDefaults.standard.url(forKey: "musicTrack") == url2 {
                if UserDefaults.standard.bool(forKey: "mute") == true {
                    player2?.play()
                    player2?.numberOfLoops = -1
                } else if UserDefaults.standard.bool(forKey: "mute") == false {
                    player2?.pause()
                    player2?.pause()
                }
            } else if UserDefaults.standard.url(forKey: "musicTrack") == url3 {
                if UserDefaults.standard.bool(forKey: "mute") == true {
                    player3?.play()
                    player3?.numberOfLoops = -1
                } else if UserDefaults.standard.bool(forKey: "mute") == false {
                    player3?.pause()
                }
            } else if UserDefaults.standard.url(forKey: "musicTrack") == url1{
                if UserDefaults.standard.bool(forKey: "mute") == true {
                    player?.play()
                    player?.numberOfLoops = -1
                } else if UserDefaults.standard.bool(forKey: "mute") == false {
                    player?.pause()
                }
            } else {
                if UserDefaults.standard.bool(forKey: "mute") == true {
                    player?.play()
                    player?.numberOfLoops = -1
                } else {
                    player?.pause()
                }
            }
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
//        profileButton.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.75)
//        profileButton.size = CGSize(width: 250, height: 60)
//        profileButton.name = "profileButton"
//        var profileButtonAnimation: SKAction
//        var profileButtonTextures:[SKTexture] = []
//        for i in 1...6 {
//               profileButtonTextures.append(SKTexture(imageNamed: "background\(i)"))
//         }
//        let profileButtonPlay = profileButtonTextures.shuffled()
//        profileButtonAnimation = SKAction.animate(with: profileButtonPlay, timePerFrame: 4.0)
//        let sepRepeat = SKAction.repeat(profileButtonAnimation, count: 6)
//        let gop = SKAction.group([sepRepeat,profileButtonAnimation])
//        profileButton.zPosition = 25
//        profileButton.run(SKAction.repeatForever(gop))
//        addChild(profileButton)
//        // adding the "Classic" text here
//        profileLabel.fontSize = 25
//        profileLabel.position = CGPoint(x: screenWidth/2, y: screenHeight * 0.735)
//        profileLabel.zPosition = 30
//        profileLabel.name = "profileLabel"
//        profileLabel.text = "Profile"
//        addChild(profileLabel)
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
        aboutButton.frame = CGRect (x: screenWidth/2 - 25, y: screenHeight * 0.7 , width: 50, height: 50)
        aboutButton.layer.cornerRadius = 0
        aboutButton.layer.borderWidth = 1
        aboutButton.layer.borderColor=UIColor.white.cgColor
        aboutButton.setImage(UIImage(named: "questionmark"), for: .normal)
        aboutButton.addTarget(self, action: #selector(aboutScene), for: UIControl.Event.touchUpInside)
        self.view!.addSubview(aboutButton)
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
        
    }
    @objc func aboutScene(sender: UIButton!) { // sending the User back to the Game
        let nextScene = AboutScene(size: scene!.size)
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
    @objc func profileSceneSender(sender: UIButton!) { // sending the User back to the Game
        let nextScene = ProfileScene(size: scene!.size)
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
//            else if nodesArray.first?.name == "profileButton" || nodesArray.first?.name == "profileLabel" {
//                xptxt.removeFromParent()
//                profileButton.removeFromParent()
//                let nextScene = ProfileScene(size: scene!.size)
//                let transition = SKTransition.fade(withDuration: 0.0)
//                nextScene.scaleMode = .aspectFill
//                scene?.view?.presentScene(nextScene,transition: transition)
//            }
        }
    }
}
