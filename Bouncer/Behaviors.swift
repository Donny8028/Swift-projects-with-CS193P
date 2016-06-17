//
//  Behaviors.swift
//  Bouncer
//
//  Created by 賢瑭 何 on 2016/3/22.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class Behaviors: UIDynamicBehavior {
    var gravity:UIGravityBehavior = UIGravityBehavior()
    
     var collision:UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    
     var Item: UIDynamicItemBehavior = {
        let ItemBehavior = UIDynamicItemBehavior()
        ItemBehavior.elasticity = 0.85
        ItemBehavior.allowsRotation = false
        return ItemBehavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collision)
        addChildBehavior(Item)
    }
    
    func addItemToBehavior(drop:UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collision.addItem(drop)
        Item.addItem(drop)
    }
    
    func removeItemFromBehavior(drop:UIView) {
        gravity.removeItem(drop)
        collision.removeItem(drop)
        drop.removeFromSuperview()
    }
    
    
}
