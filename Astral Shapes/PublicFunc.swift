//
//  PublicFunc.swift
//  Astral Shapes
//
//  Created by Jordan Klein on 2/28/20.
//  Copyright © 2020 JordanKlein. All rights reserved.
//

import GameplayKit
import SpriteKit


var userLevel = UserDefaults.standard.integer(forKey: "userLevel") ?? 0

func removeExtras(){
        backgroundMainMenutexture.removeFromParent()
        xpText.removeFromParent()
        leveltxt.removeFromParent()
        nextUnlocks.removeFromParent()
        nxtlvltxt.removeFromParent()
        introtxt.removeFromParent()
        classicB.removeFromParent()
        classicSKLabelNode.removeFromParent()
        oneminuteButton.removeFromParent()
        oneminuteSKLabelNode.removeFromParent()
        scoreLabel.removeFromParent()
        scoreNumber.removeFromParent()
        menuButton.removeFromParent()
        aboutGame.removeFromParent()
        background.removeFromParent()
        playButton.removeFromParent()
        totalTime.removeFromParent()
        scoreAmount.removeFromParent()
        playerShape.removeFromParent()
        Shape1.removeFromParent()
        ciRed.removeFromParent()
        ciBlue.removeFromParent()
        ciGreen.removeFromParent()
        ciYellow.removeFromParent()
        ciOrange.removeFromParent()
        ciPurple.removeFromParent()
        triGreen.removeFromParent()
        triBlue.removeFromParent()
        triRed.removeFromParent()
        triYellow.removeFromParent()
        triOrange.removeFromParent()
        triPurple.removeFromParent()
        sqPurple.removeFromParent()
        sqOrange.removeFromParent()
        sqYellow.removeFromParent()
        sqRed.removeFromParent()
        sqBlue.removeFromParent()
        sqGreen.removeFromParent()
        hexPurple.removeFromParent()
        hexYellow.removeFromParent()
        hexOrange.removeFromParent()
        hexRed.removeFromParent()
        hexBlue.removeFromParent()
        hexGreen.removeFromParent()
        circleRed.removeFromParent()
        circleBlue.removeFromParent()
        circleGreen.removeFromParent()
        circleOrange.removeFromParent()
        circleYellow.removeFromParent()
        circlePurple.removeFromParent()
        triangleRed.removeFromParent()
        triangleBlue.removeFromParent()
        triangleGreen.removeFromParent()
        triangleYellow.removeFromParent()
        triangleOrange.removeFromParent()
        trianglePurple.removeFromParent()
        hexagonRed.removeFromParent()
        hexagonBlue.removeFromParent()
        hexagonGreen.removeFromParent()
        hexagonYellow.removeFromParent()
        hexagonOrange.removeFromParent()
        hexagonPurple.removeFromParent()
        squareRed.removeFromParent()
        squareBlue.removeFromParent()
        squareGreen.removeFromParent()
        squareYellow.removeFromParent()
        squareOrange.removeFromParent()
        squarePurple.removeFromParent()
}



