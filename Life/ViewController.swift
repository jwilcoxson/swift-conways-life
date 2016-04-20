//
//  ViewController.swift
//  Life
//
//  Created by Joe Wilcoxson on 4/12/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var timer = NSTimer()
    var generationCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = Node(alive: true, coordinates: WPoint(x: 50, y: 50))
        //let _ = Node(alive: true, coordinates: WPoint(x: 51, y: 50))
        let _ = Node(alive: true, coordinates: WPoint(x: 52, y: 50))
        let _ = Node(alive: true, coordinates: WPoint(x: 52, y: 51))
        //let _ = Node(alive: true, coordinates: WPoint(x: 51, y: 52))
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ViewController.cycle(_:)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    func cycle(t: NSTimer) {
        tick()

    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var nv : NodeView?
    
    func tick() {
        
        generationCount = generationCount + 1
        
        for x in nodes {
            if (!x.1.neighborsGenerated) {
                x.1.generateNeighbors()
            }
        }
        
        for x in nodes {
            x.1.checkLife()
        }
        
        for x in nodes {
            x.1.alive = x.1.nextGenAlive
            if (x.1.alive) {
                print("\(x.1.coordinates.x),\(x.1.coordinates.y) is alive")
            }
        }
        print("Generation \(generationCount)")
        print("There are \(nodes.count) nodes")
        
        nv?.needsDisplay = true
        
    }


}

