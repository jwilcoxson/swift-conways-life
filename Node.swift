//
//  Node.swift
//  Life
//
//  Created by Joe Wilcoxson on 4/12/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

import Foundation

var nodes: [WPoint: Node] = [:]

class Node {
    var alive: Bool
    var nextGenAlive = false
    var coordinates: WPoint
    var neighborsGenerated = false
    
    init(alive: Bool, coordinates: WPoint) {
        self.alive = alive
        self.coordinates = coordinates
        nodes[WPoint(x: self.coordinates.x, y: self.coordinates.y)] = self
        generateNeighbors()
    }
    
    func generateNeighbors() {
        
        //Living nodes create neighbor nodes
        if (self.alive)
        {
            //Loops to check the eight neighbors surrounding the current node
            
            //Outer Loop: Change in X posiiton for neighbors
            for deltaX in -1...1 {
                
                //Inner Loop: Change in Y position for neighbors
                for deltaY in -1...1 {
                    
                    //If both deltas are 0, then we are on the current node and 
                    //don't try to generate a node
                    if (!((deltaX == 0) && (deltaY == 0)))
                    {
                        //Calculate x,y position for neighbor
                        let nodeX = self.coordinates.x + deltaX
                        let nodeY = self.coordinates.y + deltaY
                        
                        //Generate a node if one doesn't exist
                        if (nodes[WPoint(x: nodeX, y: nodeY)] == nil)
                        {
                            let _ = Node(alive: false, coordinates: WPoint(x: nodeX, y: nodeY))
                        }
                    }
                }
            }
            neighborsGenerated = true
        }
    }
    
    func checkLife() {
        
        var livingNeighbors = 0
        
        //Loops to check the eight neighbors surrounding the current node
        
        //Outer Loop: Change in X posiiton for neighbors
        for deltaX in -1...1 {
            
            //Inner Loop: Change in Y position for neighbors
            for deltaY in -1...1 {
                
                //If both deltas are 0, then we are on the current node and
                //don't check for life
                if (!((deltaX == 0) && (deltaY == 0)))
                {
                    
                    //Calculate x,y position for neighbor
                    let nodeX = self.coordinates.x + deltaX
                    let nodeY = self.coordinates.y + deltaY
                    
                    //Skip checking nodes that don't exist yet
                    if (nodes[WPoint(x: nodeX, y: nodeY)] != nil)
                    {
                        //Increment the livingNeighbors counter if the node is alive
                        if (nodes[WPoint(x: nodeX, y: nodeY)]!.alive) {
                            livingNeighbors = livingNeighbors + 1
                        }
                    }
                }
            }
        }

        //Apply Conways Life Rules
        switch (livingNeighbors) {
        case 2:
            if (self.alive) {
                nextGenAlive = true
            }
            else {
                nextGenAlive = false
            }
        case 3:
            nextGenAlive = true
        default:
            nextGenAlive = false
        }

        //Delete dead nodes with no living neighbors
        if (livingNeighbors == 0 && !self.alive)
        {
            nodes[WPoint(x: self.coordinates.x, y: self.coordinates.y)] = nil
        }
        
    }
    
}

func ==(lhs: WPoint, rhs: WPoint) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

class WPoint : Hashable {
    var x : Int
    var y : Int
    
    var hashValue : Int {
        get {
            return "\(self.x),\(self.y)".hashValue
        }
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}