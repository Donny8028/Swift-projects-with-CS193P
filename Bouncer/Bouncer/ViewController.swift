//
//  ViewController.swift
//  Bouncer
//
//  Created by 賢瑭 何 on 2016/3/21.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    
    let behavior = Behaviors()
    
    lazy var animator:UIDynamicAnimator = {
       let animation = UIDynamicAnimator(referenceView: self.gameView)
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(behavior)
    }
    
    let boxRatio = 10
    
    var boxSize:CGSize {
        let size = gameView.bounds.width / CGFloat(boxRatio)
        return CGSize(width: size, height: size)
    }
    
    let manager = AppDelegate.Motion.Manager
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addBox()
        if manager.accelerometerAvailable {
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data, error) -> Void in
                self.behavior.gravity.gravityDirection = CGVector(dx: data!.acceleration.x, dy: -data!.acceleration.y)
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        manager.stopAccelerometerUpdates()
    }
    
    
    func addBox(){
        let frame = CGRect(origin: CGPointZero, size: boxSize)
        let box = UIView(frame:frame)
        box.center = CGPoint(x: gameView.bounds.midX, y: gameView.bounds.midY)
        box.backgroundColor = UIColor.redColor()
        behavior.addItemToBehavior(box)
    }
    

}

