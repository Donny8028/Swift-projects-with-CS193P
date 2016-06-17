//
//  DropBehavior.swift
//  Dropit
//
//  Created by 賢瑭 何 on 2016/3/16.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class DropBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()
    
    var collider:UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        return collision
    }()
    
    var attach : UIAttachmentBehavior? {
        willSet{
            if attach != nil {
            removeChildBehavior(attach!)
            }
        }
        didSet{
            if attach != nil {
                addChildBehavior(attach!)
                attach?.length = 0.0
            }
        }
    }
    
    
    func attachment(box:UIView,box2:CGPoint) {
        attach = UIAttachmentBehavior(item: box, attachedToAnchor: box2)
    }
    
    lazy var itemBehaviors:UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = true
        return behavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehaviors)
    }
    
    func addBarrier(path:UIBezierPath , name:String) {
        collider.removeBoundaryWithIdentifier(name) // remove old barrier that call this name
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func addDrops(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        itemBehaviors.addItem(drop)
    }
    func removeDrops(drop:UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        itemBehaviors.removeItem(drop)
        drop.removeFromSuperview()
    }
}
