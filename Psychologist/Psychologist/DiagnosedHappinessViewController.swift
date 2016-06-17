//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by 賢瑭 何 on 2016/2/24.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController:HappinessViewController,UIPopoverPresentationControllerDelegate {
    
    override var happiness:Int {
        didSet{
            history += [happiness]
        }
    }
    
    struct Storyboard {
    static let UserSaveHistory = "History"
    static let SegueIdentifier = "Show diagnosishistory"
    }
    
    var df = NSUserDefaults.standardUserDefaults()
    
    
    var history: [Int] {
        get {
            return df.objectForKey(Storyboard.UserSaveHistory) as? [Int] ?? []
        }
        set{
            df.setObject(newValue, forKey: Storyboard.UserSaveHistory)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Storyboard.SegueIdentifier:
            if let vc = segue.destinationViewController as? DiagnosichistoryViewController {
                if let ppc = vc.popoverPresentationController {
                    //don't want it just in popover,even in other presentation still works, coz in iphone, we use modal, so use if let
                    ppc.delegate = self
                }
                vc.text = "\(history)"
                
            }
        default :break
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
