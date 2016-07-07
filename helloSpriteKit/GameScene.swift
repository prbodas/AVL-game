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
    let TREE_MAX:UInt32 = 100
    var timerRepetitions = 0
    var rotationTimer:NSTimer!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //label setup
        myLabel.text = ""
        myLabel.fontColor = UIColor.blackColor()
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //sprite setup
        man.anchorPoint = CGPointMake(0.5, 0)
        man.xScale = 0.12
        man.yScale = 0.12
        
        //scene setup
        self.backgroundColor = UIColor.whiteColor()
        
        //self.insertToTree(5)
        //self.insertToTree(6)
        //self.insertToTree(7)
        //self.tree = tree.rotate_RL()
        
        man.position = CGPointMake(self.frame.size.width/2, self.getTreeYAtDepth(1.0) + 50)
        
        displayEntireTree()
        
        //display the rotation buttons
        let buttonarr = [Button.init(text: "L", name: "left"),
                         Button.init(text: "R", name: "right"),
                         Button.init(text: "LR", name: "left-right"),
                         Button.init(text: "RL", name:  "right-left")]
        
        
        //add elements to self
        for button in buttonarr
        {
            self.addChild(button)
        }
        self.addChild(myLabel)
        self.addChild(man)
        
        //position setting
        Button.addPositionsAndSizes(buttonarr,
                                    screenSize: CGSizeMake(self.frame.width, self.frame.height))
        
        //create AVL timer
        rotationTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(GameScene.insertRandomNumToTree), userInfo: nil, repeats: true)

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
        
        //print("in method")
        let center_at = (self.frame.width/2.0)/(pow(2.0,depth-1.0)+1.0)
        //print ("Center_at = \(center_at)")
        var current = center_at + 256.0
        //print ("Current = \(current)")
        let arr = tree.getNumsAtDepth(Int(depth))
        print("arr = \(arr) at depth \(depth)")
        
        for a in arr
        {
            //print ("looping")
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
            //print ("Current = \(current)")
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
        //if the balance is off, the user loses the game
        if (!AVLtree.isInvariantGood(tree))
        {
            gameOver(false)
        }else{
        
            //otherwise, the game continues
            tree.insertIntNoRotation(ins)
            self.displayEntireTree()
        
            //tilt man based on post-insertion balance factor
            man.position = CGPointMake(self.frame.size.width/2, self.getTreeYAtDepth(1.0) + 50)
            let balanceFactor = tree.balanceFactor()
            if (balanceFactor > 0)
            {
                //left>right
                man.zRotation = CGFloat(M_PI/8);
            }else if (balanceFactor < 0)
            {
                //left>right
                man.zRotation = CGFloat(-1*M_PI/8);
            }else{
                man.zRotation = CGFloat(0);
            }
        }
        
    }
    
    func insertRandomNumToTree()
    {
        if (self.timerRepetitions >= 10)
        {
            gameOver(true)
        }else{
            self.timerRepetitions += 1
            let random = Int(arc4random_uniform(TREE_MAX))
            self.insertToTree(random)
        }
    }
    
    func gameOver(didWin:Bool)
    {
        rotationTimer = nil
        
        if (didWin)
        {
            myLabel.text = "You Win!"
            man.zRotation = CGFloat(-1*M_PI/8);
        }else{
            myLabel.text = "Game Over"
            let rotateMan = SKAction.moveTo(CGPointMake(0.0, 0.0), duration: 5.0)
            man.runAction(rotateMan)
            //exit game
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        print ("touchbegan")
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //man.position = CGPointMake(man.position.x, man.position.y+1)
        
    }
}
