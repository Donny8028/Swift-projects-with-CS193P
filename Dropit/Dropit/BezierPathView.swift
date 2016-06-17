//
//  BezierPathView.swift
//  Dropit
//
//  Created by 賢瑭 何 on 2016/3/17.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class BezierPathView: UIView {
    var barriers = [String:UIBezierPath]()
    
    func drawBarrier(name:String , path: UIBezierPath?) {
        barriers[name] = path
        setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {
        for (_,path) in barriers {
            UIColor.yellowColor().setFill()
            path.fill()
        }
    }
}
