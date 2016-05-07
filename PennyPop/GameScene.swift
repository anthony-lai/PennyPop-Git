//
//  GameScene.swift
//  PennyPop
//
//  Created by Anthony Lai on 5/7/16.
//  Copyright (c) 2016 Anthony Lai. All rights reserved.
//ß

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(player)
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        addMonster()
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        let monster = SKSpriteNode(imageNamed: "monster")
        
        var randY = CGFloat(0.5)
        while (randY > CGFloat(0.45) && randY < CGFloat(0.55)) {
            randY = random(min: 0.1, max: 0.9)
        }
        var randX = CGFloat(0.5)
        while (randX > CGFloat(0.45) && randX < CGFloat(0.55)) {
            randX = random(min: 0.1, max: 0.9)
        }
        
        monster.position = CGPoint(x: randX * size.width, y: randY * size.height)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
//        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
//        let actionMove = SKAction.moveTo(CGPoint(x: -monster.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        monster.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
}
