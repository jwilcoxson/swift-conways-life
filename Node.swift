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
        if (self.alive)
        {
            for deltaX in -1...1 {
                for deltaY in -1...1 {
                    if (!((deltaX == 0) && (deltaY == 0)))
                    {
                        let nodeX = self.coordinates.x + deltaX
                        let nodeY = self.coordinates.y + deltaY
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
        
        //print("Checking \(self.coordinates.x),\(self.coordinates.y)")
        //print("================")
        
        for deltaX in -1...1 {
            for deltaY in -1...1 {
                if (!((deltaX == 0) && (deltaY == 0)))
                {
                    let nodeX = self.coordinates.x + deltaX
                    let nodeY = self.coordinates.y + deltaY
                    //print("Checking \(nodeX),\(nodeY)")
                    
                    if (nodes[WPoint(x: nodeX, y: nodeY)] != nil)
                    {
                        if (nodes[WPoint(x: nodeX, y: nodeY)]!.alive) {
                            //print("Neighbor \(nodeX),\(nodeY) is alive")
                            livingNeighbors = livingNeighbors + 1
                        }
                    }
                }
            }
        }
        //print("\(self.coordinates.x),\(self.coordinates.y) has \(livingNeighbors) living neghbors")
        if (self.alive) {
            //print("\(self.coordinates.x),\(self.coordinates.y) is alive")
            if (livingNeighbors < 2 || livingNeighbors > 3) {
                nextGenAlive = false
                //print("\(self.coordinates.x),\(self.coordinates.y) will die")
            }
            else {
                nextGenAlive = true
                //print("\(self.coordinates.x),\(self.coordinates.y) will live")
            }
        }
        else {
            print("\(self.coordinates.x),\(self.coordinates.y) is dead")
            if (livingNeighbors == 3) {
                nextGenAlive = true
                //print("\(self.coordinates.x),\(self.coordinates.y) will live")
            }
            else {
                nextGenAlive = false
                //print("\(self.coordinates.x),\(self.coordinates.y) will die")
            }
        }
        
        if (livingNeighbors == 0 && !self.alive)
        {
            nodes[WPoint(x: self.coordinates.x, y: self.coordinates.y)] = nil
        }
        
        print("")
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