//
//  ViewController.swift
//  Cassini
//
//  Created by 賢瑭 何 on 2016/3/1.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dt = segue.destinationViewController as? ImageViewController {
            if let identity = segue.identifier{
            switch identity {
                case "Show Earth" :
                    dt.imageURL = DemoImage.NASA.Earth
                    dt.title = "Earth"
                case "Show Cassini" :
                    dt.imageURL = DemoImage.NASA.Cassini
                    dt.title = "Cassini"
                case "Show Saturn" :
                    dt.imageURL = DemoImage.NASA.Saturn
                    dt.title = "Saturn"
                default : break
                }
            }
        }
    }
  
}

