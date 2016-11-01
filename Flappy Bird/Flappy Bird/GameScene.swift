//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Luís Machado on 27/07/16.
//  Copyright (c) 2016 LuisMachado. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    var started = false
    var startable = true
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode() //Background
    var pipe1 = SKSpriteNode()
    var pipe2 = SKSpriteNode()
    
    var movingObjects = SKSpriteNode()
    var labelContainer = SKSpriteNode()
    
    var timer = NSTimer()
    var rotationTimer = NSTimer()
    
    enum ColliderType: UInt32 {
        
        case Bird = 1
        case Object = 2
        case Gap = 4
    }
    
    var gameOver = false
    
    func makeBg() {
        //Background
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let moveBg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        let replaceBg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveBg,replaceBg]))
        
        //Rolling background filling
        for var i: CGFloat = 0; i < 3; i = i + 1 {
            
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width / 2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            bg.size.height = self.frame.height
            bg.runAction(moveBgForever)
            //self.addChild(bg)
            movingObjects.addChild(bg)
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        //self.physicsWorld.gravity = CGVectorMake(0.0, -8)
        
        self.addChild(movingObjects)
        self.addChild(labelContainer)
        makeBg()
        
        //ScoreLabel
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.size.height - 50)
        self.addChild(scoreLabel)
        
        //Bird
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        //bird.physicsBody = SKPhysicsBody(circleOfRadius: bgTexture.size().height/2) //make bird fall and detect collisions
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/2)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        bird.physicsBody!.dynamic = true
        bird.runAction(makeBirdFlap)
        
        
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue //objectos to collide should be on the same enum
        bird.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        
        self.addChild(bird)
        
        // ground to stop bird from falling forever
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody!.dynamic = false
        
        ground.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue //objects to collide should be on the same enum
        ground.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        self.addChild(ground)
        
        //avoid bird from falling at the beggining
        movingObjects.speed = 0
        bird.physicsBody!.dynamic = false
        
        //_ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
        
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.Gap.rawValue {
            score += 1
            scoreLabel.text = String(score)
        } else {
            
            if gameOver == false {
                gameOver = true
                self.speed = 0
                
                gameOverLabel.fontName = "Helvetica"
                gameOverLabel.fontSize = 20
                gameOverLabel.text = "Game Over! Tap to play again!"
                gameOverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                labelContainer.addChild(gameOverLabel)
                
                timer.invalidate()
                rotationTimer.invalidate()
                
                self.startable = false
                
                let seconds = 1.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))

                dispatch_after(dispatchTime, dispatch_get_main_queue(), {

                    self.startable = true

                })
            }
        }
        
    }
    
    func makePipes() {
    
        //PIPPING
        
        let gapHeight = bird.size.height * 4
        
        let movementAmount = arc4random() %  UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        let movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width/100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes,removePipes])
        
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.size.width, CGRectGetMidY(self.frame) + pipeTexture.size().height/2 + gapHeight/2 + pipeOffset)
        pipe1.runAction(moveAndRemovePipes)
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        pipe1.physicsBody!.dynamic = false
        pipe1.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue //objects to collide should be on the same enum
        pipe1.physicsBody!.collisionBitMask = ColliderType.Object.rawValue //objects to collide should be on the same enum
        //self.addChild(pipe1)
        movingObjects.addChild(pipe1)
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        pipe2 = SKSpriteNode(texture: pipe2Texture)
        pipe2.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.size.width, CGRectGetMidY(self.frame) - pipe2Texture.size().height/2 - gapHeight/2 + pipeOffset)
        pipe2.runAction(moveAndRemovePipes)
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue //objects to collide should be on the same enum
        pipe2.physicsBody!.collisionBitMask = ColliderType.Object.rawValue //objects to collide should be on the same enum
        pipe2.physicsBody!.dynamic = false
        pipe2.physicsBody!.dynamic = false
        //self.addChild(pipe2)
        movingObjects.addChild(pipe2)
        
        // Score trigger
        let gap = SKNode()
        gap.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeOffset)
        gap.runAction(moveAndRemovePipes)
        gap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 5, height: gapHeight))
        gap.physicsBody!.dynamic = false
        gap.physicsBody!.categoryBitMask = ColliderType.Gap.rawValue
        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue //objects to collide should be on the same enum
        gap.physicsBody!.collisionBitMask = ColliderType.Gap.rawValue //objects to collide should be on the same enum
        //self.addChild(gap)
        movingObjects.addChild(gap)
        
    
    }
    
    func birdRotation() {
        if bird.physicsBody?.velocity.dy > 0 {
            bird.zRotation = 0.5
        } else if bird.physicsBody?.velocity.dy < 0 {
            bird.zRotation = -0.5
        } else {
            bird.zRotation = 0
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        if started == false  {
            movingObjects.speed = 1
            bird.physicsBody!.dynamic = true
            started = true
            bird.physicsBody!.velocity = CGVectorMake(0, 0)
            bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))
            timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
            rotationTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameScene.birdRotation), userInfo: nil, repeats: true)
        } else {
            if gameOver == false {
                bird.physicsBody!.velocity = CGVectorMake(0, 0)
                bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))
            } else if startable == true {
                score = 0
                scoreLabel.text = "0"
                bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody!.angularVelocity = 0
                bird.zRotation = 0
                
                movingObjects.removeAllChildren()
                makeBg()
                self.speed = 1
                
                gameOver = false
                labelContainer.removeAllChildren()
                
                movingObjects.speed = 0
                bird.physicsBody!.dynamic = false
                started = false
                
                
            }
        }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
