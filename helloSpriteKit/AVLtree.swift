//
//  AVLtree.swift
//  helloSpriteKit
//
//  Created by Prachi Bodas on 7/5/16.
//  Copyright © 2016 Prachi Bodas. All rights reserved.
//

import Foundation


class AVLtree:NSObject
{
    
    let MAX_HEIGHT = 5
    
    var isEmpty: Bool = true
    var node: Int!
    var left: AVLtree!
    var right: AVLtree!
    
    override init() {
        super.init()
        isEmpty = true
    }
    
    func withParams(n:Int, l:AVLtree, r:AVLtree)
    {
        isEmpty = false
        left = l
        right = r
        node = n
    }
    
    func getHeight() -> Int
    {
        if (self.isEmpty)
        {
            return 0
        }else{
            let lheight = left.getHeight()
            let rheight = right.getHeight()
            if (lheight>rheight)
            {
                return (1+lheight)
            }else{
                return (1+rheight)
            }
        }
    }
    
    func balanceFactor() -> Int
    {
        if (self.isEmpty)
        {
            return 0
        }else{
            return left.getHeight() - right.getHeight()
        }
    }
    
    class func isInvariantGood(T:AVLtree) -> Bool
    {
        if (abs(T.balanceFactor()) >= 2){
            return false
        }else if (T.isEmpty){
            return true
        }else{
            return (isInvariantGood(T.left)) && (isInvariantGood(T.right))
        }
    }
    
    //duplicates ignored
    func insertIntNoRotation(n:Int)
    {
        if (isEmpty)
        {
            isEmpty = false
            node = n
            left = AVLtree.init()
            right = AVLtree.init()
        }else{
            if (n > node)
            {
                print("right insert \(n)")
                right.insertIntNoRotation(n)
            }else if (n < node)
            {
                print("left insert \(n)")
                left.insertIntNoRotation(n)
            }
        }
    }
    
    //depth starts at 1
    func getNumsAtDepth(d:Int) -> [Int]
    {
        if (isEmpty)
        {
            var arr: [Int] = []
            for _ in 0 ..< Int(pow(2.0, Float(d-1)))
            {
                arr.append(-1)
            }
            return arr
        }else if (d == 1)
        {
            return [node]
        }else{
            return left.getNumsAtDepth(d-1) + right.getNumsAtDepth(d-1)
        }
    }
    
    
    //tree rotation code
    func rotate_left() -> AVLtree
    {
        if (!(self.isEmpty || self.right.isEmpty))
        {
            let temp = self.right
            self.right = self.right.left;
            temp.left = self;
            return temp
        }else{
            print("return empty")
            return AVLtree.init()
        }
    }
    
    func rotate_right() -> AVLtree
    {
        if (!(self.isEmpty || self.left.isEmpty))
        {
            let temp = self.left;
            self.left = self.left.right;
            temp.right = self;
            return temp
        }else{
            return AVLtree.init()
        }
    }
    
    func rotate_RL() -> AVLtree
    {
        if (self.left.isEmpty || self.isEmpty)
        {
            return AVLtree.init()
        }
        self.left = self.left.rotate_left();
        return self.rotate_right()
    }
    
    func rotate_LR() -> AVLtree
    {
        if (self.right.isEmpty || self.isEmpty)
        {
            return AVLtree.init()
        }
        self.right = self.right.rotate_right();
        return self.rotate_left()
    }

    

}