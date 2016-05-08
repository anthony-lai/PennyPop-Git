//
//  GameScene.swift
//  PennyPop
//
//  Created by Anthony Lai on 5/7/16.
//  Copyright (c) 2016 Anthony Lai. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1
    static let Projectile: UInt32 = 0b10
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "player")
    let bleed1 = SKSpriteNode(imageNamed: "sparks")
    let bleed2 = SKSpriteNode(imageNamed: "sparks copy")
    let bleed3 = SKSpriteNode(imageNamed: "sparks copy 2")
    let bleed4 = SKSpriteNode(imageNamed: "sparks copy 3")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(player)
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        addMonster()
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        let monster = SKSpriteNode(imageNamed: "monster")
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
        monster.physicsBody?.dynamic = true
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None
        var randY = CGFloat(0.5)
        while (randY > CGFloat(0.45) && randY < CGFloat(0.55)) {
            randY = random(min: 0.1, max: 0.9)
        }
        var randX = CGFloat(0.5)
        while (randX > CGFloat(0.45) && randX < CGFloat(0.55)) {
            randX = random(min: 0.1, max: 0.9)
        }
        monster.position = CGPoint(x: randX * size.width, y: randY * size.height)
        addChild(monster)
        
    }
    
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.locationInNode(self)
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.dynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        let offset = touchLocation - projectile.position
        addChild(projectile)
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest1 = shootAmount / 80 + player.position
        let realDest2 = shootAmount / 40 + player.position
        let realDest3 = shootAmount / 40 * 2 + player.position
        let realDest4 = shootAmount / 40 * 3 + player.position
        let realDest5 = shootAmount / 40 * 4 + player.position
        let realDest6 = shootAmount / 40 * 5 + player.position
        let realDest7 = shootAmount / 40 * 6 + player.position
        let realDest8 = shootAmount / 40 * 7 + player.position
        let realDest9 = shootAmount / 40 * 8 + player.position
        let realDest10 = shootAmount + player.position
        let actionMove1 = SKAction.moveTo(realDest1, duration: 0.7)
        let actionMove2 = SKAction.moveTo(realDest2, duration: 0.6)
        let actionMove3 = SKAction.moveTo(realDest3, duration: 0.5)
        let actionMove4 = SKAction.moveTo(realDest4, duration: 0.4)
        let actionMove5 = SKAction.moveTo(realDest5, duration: 0.3)
        let actionMove6 = SKAction.moveTo(realDest6, duration: 0.2)
        let actionMove7 = SKAction.moveTo(realDest7, duration: 0.1)
        let actionMove8 = SKAction.moveTo(realDest8, duration: 0.1)
        let actionMove9 = SKAction.moveTo(realDest9, duration: 0.05)
        let actionMove10 = SKAction.moveTo(realDest10, duration: 0.01)
        
        let actionMoveDone = SKAction.removeFromParent()
        projectile.runAction(SKAction.sequence([actionMove1, actionMove2, actionMove3, actionMove4, actionMove5, actionMove6, actionMove7, actionMove8, actionMove9, actionMove10, actionMoveDone]))
    
    }
    
//        let tot = 10
//        
//        animateTouch(1, tot: tot, projectile: projectile, position: projectile.position, shootAmount: shootAmount)
//        
//    }
//    
//    func animateTouch(i: Int, tot: Int, projectile: SKSpriteNode, position: CGPoint, shootAmount: CGPoint) {
//        if (i == tot + 1) {
//            SKAction.removeFromParent()
//            return
//        }
//        let realDest = (shootAmount / CGFloat(tot)) + projectile.position
//        print(realDest)
//        let func2 = SKAction.runBlock({
//            self.animateTouch(i+1, tot: tot, projectile: projectile, position: realDest, shootAmount: shootAmount)
//        })
//        let actionMove = SKAction.moveTo(realDest, duration: (2.0 / Double(i / 2)))
//        projectile.runAction(SKAction.sequence([actionMove, func2]))
//    }
    
    func projectileDidCollideWithMonster(projectile:SKSpriteNode, monster:SKSpriteNode) {
        projectile.removeFromParent()
        bleed(monster)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
            projectileDidCollideWithMonster(secondBody.node as! SKSpriteNode, monster: firstBody.node as! SKSpriteNode)
        }
        
    }
    
    func showBleed1() {
        addChild(bleed1)
    }
    func showBleed2() {
        addChild(bleed2)
    }
    func showBleed3() {
        addChild(bleed3)
    }
    func showBleed4() {
        addChild(bleed4)
    }
    
    func hideBleed1() {
        bleed1.removeFromParent()
    }
    func hideBleed2() {
        bleed2.removeFromParent()
    }
    func hideBleed3() {
        bleed3.removeFromParent()
    }
    func hideBleed4() {
        bleed4.removeFromParent()
    }
    
    func bleed(monster: SKSpriteNode) {
        bleed1.position = monster.position
        bleed2.position = monster.position
        bleed3.position = monster.position
        bleed4.position = monster.position
        let time = 0.025
        runAction(SKAction.sequence([   SKAction.runBlock(showBleed1),
                                        SKAction.waitForDuration(time),
                                        SKAction.runBlock(hideBleed1),
                                        SKAction.runBlock(showBleed2),
                                        SKAction.waitForDuration(time),
                                        SKAction.runBlock(hideBleed2),
                                        SKAction.runBlock(showBleed3),
                                        SKAction.waitForDuration(time),
                                        SKAction.runBlock(hideBleed3),
                                        SKAction.runBlock(showBleed4),
                                        SKAction.waitForDuration(time),
                                        SKAction.runBlock(hideBleed4),
            
            ]))
    }
    
}
