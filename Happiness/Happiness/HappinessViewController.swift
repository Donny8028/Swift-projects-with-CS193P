//
//  HappinessViewController.swift
//  Happiness
//
//  Created by 賢瑭 何 on 2016/2/17.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDateSource {
    
    struct Constant {
        static let pinscale:CGFloat = 4
    }
    
    @IBAction func pinnable(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Changed :
            let pintranslation = sender.translationInView(faceView)
            let happinessChange = -Int(pintranslation.y / Constant.pinscale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        case .Ended :
            fallthrough
        default :break
        }
    }

    
    func tappable(gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .Changed :
            if gesture.numberOfTapsRequired == 2  && gesture.numberOfTouchesRequired == 1{
                fallthrough
            }
        case .Ended :
            happiness = 50
        default : break
        }
    }
    
    
    @IBOutlet weak var faceView: Face!{
        didSet{
            faceView.delegate = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.pinchable(_:))))
            faceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HappinessViewController.tappable(_:))))
        }
    }
    
    var happiness:Int = 75 {
        didSet {
            happiness = min(max(happiness, 0 ) , 100)
            UIUpdate()
        }
    }


    func UIUpdate () {
        faceView.setNeedsDisplay()
    }
    
    func smilinessformhappiness(sender: Face) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    
}
