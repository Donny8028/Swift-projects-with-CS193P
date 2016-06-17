//
//  ViewController.swift
//  Dropit
//
//  Created by 賢瑭 何 on 2016/3/14.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBOutlet weak var gameView: BezierPathView!
    /*It will crash when it set " var animator = UIDynamicAnimator(referenceView: gameView), becase you cant
    use the gameView while the property is in the middle of initializing only when all property got set.
    two way to solve
    1. set it to nil until viewDidLoad then set it back to gameView
    2. Using lazy and Clousure function , that's a way to put it in a method.
    */
    
    lazy var animator:UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.gameView)
        // be careful the gameview got set in viewdidload
    }()
    
    let behaviors = DropBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.delegate = self
        animator.addBehavior(behaviors) //雖然添加時間是viewDidload但是只要在behavior subclass中添加childBehavior 則animator的behavior也會隨之添加”後來“的behavior
    }
    struct DrawPath {
        static let CircleBarrier = "CircleBarrier"
        static let LineOfAttachment = "LineOfAttachment"
    }
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
     drop()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX - dropSize.width/2, y: gameView.bounds.midY - dropSize.height/2)
        let barrier = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        behaviors.addBarrier(barrier, name: DrawPath.CircleBarrier)
        gameView.drawBarrier(DrawPath.CircleBarrier, path: barrier)
        
    }
    
    @IBAction func panAttach(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView) //point out where the cursor.
        switch sender.state {
        case .Began :
            if let thingToAttach = lastDropThing {
            behaviors.attachment(thingToAttach, box2: gesturePoint)
                behaviors.attach!.action = { [unowned self]	in //when I run this code, "self" would be exist in the middle of the time
                let path = UIBezierPath()
                path.moveToPoint(self.behaviors.attach!.anchorPoint)
                path.addLineToPoint(thingToAttach.center)
                self.gameView.drawBarrier(DrawPath.LineOfAttachment, path: path)
                }
            }
            lastDropThing = nil
            
        case .Changed :
            behaviors.attach?.anchorPoint = gesturePoint

        case .Ended :
            behaviors.attach = nil
        default :
            behaviors.attach = nil
        }
        gameView.drawBarrier(DrawPath.LineOfAttachment, path: nil)
    }
    
    
    var dropSize:CGSize {
        let size = gameView.bounds.width / CGFloat(dropPerRow)
        return CGSize(width: size, height: size)
    }
    
    let dropPerRow:Int = 10
    
    var lastDropThing:UIView?
    
    func drop() {
        
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropPerRow) * dropSize.width
        let boxView = UIView(frame: frame) //this UIView init was successful because it is in the method
        boxView.backgroundColor = UIColor.random
        behaviors.addDrops(boxView)
        lastDropThing = boxView
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeBottomLine()
    }

    func removeBottomLine() {
        var removeDropsLine = [UIView]()
        var detectDropArea = CGRect(x: 0, y: gameView.bounds.maxY, width: dropSize.width, height: dropSize.height)
        repeat{
            var confirmedEachDrop = [UIView]()
            var makeSureEachDrop = true
            detectDropArea.origin.y -= dropSize.height
            detectDropArea.origin.x = 0
            for _ in 0 ..< dropPerRow {
                if let detectedDrop = gameView.hitTest(CGPoint(x: detectDropArea.midX, y: detectDropArea.midY), withEvent: nil) {
                    if detectedDrop.superview == gameView {
                        confirmedEachDrop.append(detectedDrop)
                    }else{
                       makeSureEachDrop = false
                  }
                }
                detectDropArea.origin.x += dropSize.width
            }
            if makeSureEachDrop {
                removeDropsLine += confirmedEachDrop
            }
        }while removeDropsLine.count == 0 && detectDropArea.origin.y > 0 // just make sure for some reason this will be negative
        
        for drop in removeDropsLine {
            behaviors.removeDrops(drop)
        }
    }
    //邏輯是 設定一個repeat while, 與bool 如果bool為true則 repeat while 為 flase 停止repeat 再來就是消除整行
    //repeat while for the row detect,在每次的repeat中都有一個for in 去推進x軸的detect(如果其中有一次detect失敗 則bool為false 繼續下一次repeat
}

extension CGFloat {
    private static func random(max:Int) -> CGFloat{
            let point = CGFloat(arc4random() % UInt32(max))
            return point
        }
}

extension UIColor {
    private static var random:UIColor {
            switch arc4random() % UInt32(5) {
            case 0 : return UIColor.greenColor()
            case 1 : return UIColor.blueColor()
            case 2 : return UIColor.orangeColor()
            case 3 : return UIColor.redColor()
            case 4 : return UIColor.yellowColor()
            default : return UIColor.blackColor()
        }
    }
}