//
//  Button.swift
//  helloSpriteKit
//
//  Created by Prachi Bodas on 7/6/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import SpriteKit

class Button: SKSpriteNode {
    
    let label = SKLabelNode(fontNamed: "Chalkboard")
    
    init(text: String, name:String)
    {
        super.init(texture: nil, color: UIColor.whiteColor(), size: CGSizeZero)
        
        //instance var setting
        //label settings
        self.addChild(label)
        label.horizontalAlignmentMode = .Center
        label.verticalAlignmentMode = .Center
        label.fontSize = 45
        label.fontColor = UIColor.whiteColor()
        label.text = text
        
        //node code
        self.color = UIColor.blackColor()
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        /*let dimension = screenSize.width/DIVIDER
        node.size = CGSizeMake(dimension, dimension)
        node.name = name*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func addPositionsAndSizes(buttons:[Button], screenSize:CGSize)
    {
        let width = screenSize.width/2
        let dim = width/CGFloat(buttons.count+1)
        let between = dim/CGFloat(buttons.count+1) //space between buttons and margin
        var current = (between + dim/2)*2
        for button in buttons
        {
            button.size = CGSize(width: dim, height: dim)
            button.position = CGPoint(x: current, y: screenSize.height - dim/2 - 10)
            current += (dim + between)
        }
    }
}
