//
//  ViewController.swift
//  Psychologist
//
//  Created by 賢瑭 何 on 2016/2/24.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class PsychologisyViewController: UIViewController {
    
    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("Show nothing", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination1 = segue.destinationViewController as UIViewController
            
        if let navCon = destination1 as? UINavigationController {
            destination1 = navCon.visibleViewController!
        }
        
        if let destination = destination1 as? HappinessViewController {
            switch segue.identifier! {
            case "Show happy" :
                destination.happiness = 100
            case "Show sad" :
                destination.happiness = 0
            case "Show meh" :
                destination.happiness = 50
            case "Show nothing" :
                destination.happiness = 25
            default :
                destination.happiness = 50
            }
        }
    }



}

