//
//  NodeView.swift
//  Life
//
//  Created by Joe Wilcoxson on 4/16/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

import Cocoa

class NodeView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        // Drawing code here.
        
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextSetRGBFillColor(context, 1, 0, 0, 1)
        
        for x in nodes {
            if (x.1.alive) {
                let _x = CGFloat(x.1.coordinates.x * 5)
                let _y = CGFloat(x.1.coordinates.y * 5)
                CGContextFillRect(context, CGRectMake(_x, _y, 4, 4))
            }
        }
        
        
    }
    
}
