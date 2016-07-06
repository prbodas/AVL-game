//
//  GameScene.swift
//  helloSpriteKit
//
//  Created by Prachi Bodas on 7/5/16.
//  Copyright (c) 2016 Prachi Bodas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //instance variables
    let man = SKSpriteNode(imageNamed:"StickMan")
    var tree:AVLtree = AVLtree.init()
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    var currentTreeLabels: [SKLabelNode] = []
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //label setup
        myLabel.text = ""
        myLabel.fontColor = UIColor.blackColor()
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //sprite setup
        man.anchorPoint = CGPointMake(0.5, 0)
        //man.position = CGPointMake(self.frame.size.width/2, 0)
        man.xScale = 0.12
        man.yScale = 0.12
        
        //scene setup
        self.backgroundColor = UIColor.whiteColor()
        
        self.insertToTree(5)
        self.insertToTree(2)
        //self.tree = tree.rotate_RL()
        
        man.position = CGPointMake(self.frame.size.width/2, self.getTreeYAtDepth(1.0) + 50)
        
        displayEntireTree()
        
        //add elements to self
        self.addChild(myLabel)
        self.addChild(man)
    }
    
    //tree displaying code
    
    func displayEntireTree()
    {
        self.removeChildrenInArray(currentTreeLabels)
        for var i = 1; i <= tree.getHeight(); i += 1
        {
            self.displayTree(CGFloat(i))
        }

    }
    
    func displayTree(depth:CGFloat)
    {
        
        print("in method")
        let center_at = (self.frame.width/2.0)/(pow(2.0,depth-1.0)+1.0)
        print ("Center_at = \(center_at)")
        var current = center_at + 256.0
        print ("Current = \(current)")
        let arr = tree.getNumsAtDepth(Int(depth))
        print("arr = \(arr)")
        
        for a in arr
        {
            print ("looping")
            let newLabel = SKLabelNode(fontNamed: "Chalkduster")
            
            if (a == -1)
            {
                newLabel.text = ""
            }else{
                newLabel.text = String(a)
            }
            
            newLabel.fontColor = UIColor.blackColor()
            newLabel.fontSize = 30
            newLabel.position = CGPoint(x: current, y: CGFloat(getTreeYAtDepth(depth)))
            currentTreeLabels.append(newLabel)
            self.addChild(newLabel)
            current = current + center_at
            print ("Current = \(current)")
        }
        
    }
    
    //highest y coordinate is at depth 1
    func getTreeYAtDepth(depth:CGFloat) -> CGFloat
    {
        return 100*(CGFloat(tree.getHeight())-depth)+50
    }
    
    //updating code
    
    func insertToTree(ins:Int)
    {
            
        //insert redisplay reposition
        tree.insertIntNoRotation(ins)
        self.displayEntireTree()
        man.position = CGPointMake(self.frame.size.width/2, self.getTreeYAtDepth(1.0) + 50)
        let balanceFactor = tree.balanceFactor()
        if (balanceFactor == 1)
        {
            //left>right
            man.zRotation = CGFloat(M_PI/4);
        }else if (balanceFactor == -1)
        {
            //left>right
            man.zRotation = CGFloat(-1*M_PI/4);
        }else if (abs(balanceFactor) > 1)
        {
            myLabel.text = "Game over"
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        /*for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }*/
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //man.position = CGPointMake(man.position.x, man.position.y+1)
        
    }
}
