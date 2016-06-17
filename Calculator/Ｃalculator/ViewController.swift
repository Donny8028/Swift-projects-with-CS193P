//
//  ViewController.swift
//  Ｃalculator
//
//  Created by 賢瑭 何 on 2016/1/31.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Labelnumber: UILabel!
    var letthenumberappend:Bool = false
    @IBAction func Digit(sender: UIButton) {
        let Number = sender.currentTitle!
        if letthenumberappend {
            Labelnumber.text = Labelnumber.text! + Number
        
        }
        else{
            Labelnumber.text = Number
            letthenumberappend = true
        }
        
    }
    
    var content = Array<Double>()
    
    var tag = Array<String>()

    @IBAction func operate(sender: UIButton) {
        let Operation = sender.currentTitle!
        content.append(displayValue)
        tag.append(Operation)
        print("\(tag)")
        letthenumberappend = false
        if content.count > 1{
            content.removeAtIndex(0)
        }
        print("\(content)")
    }

    @IBAction func equal() {
        letthenumberappend = false
        if tag.count == 1 {
            content.append(displayValue)
            print("\(content)")
            switch tag.removeLast() {
            case "+" :performance{$0 + $1 }
            case "−" :performance{$1 - $0 }
            case "×" :performance{$0 * $1 }
            case "÷" :performance{$1 / $0 }
            case "√" :performance2{sqrt($0)}
            default : break
            }
        
        }
            if content.count >= 2{
            content.removeAtIndex(0)
        }
        print("\(content)")

    }
    func performance(operation: (Double,Double) -> Double) {
        if content.count >= 2 {
            displayValue = operation(content.removeLast() , content.removeLast())
            content.append(displayValue)
        }
    }
    func performance2(operation: Double -> Double){
        if content.count >= 2 {
            displayValue = operation(content.removeLast())
            content.append(displayValue)
        }
    }


        var displayValue:Double {
            get{
                return NSNumberFormatter().numberFromString(Labelnumber.text!)!.doubleValue
            }
            set{
               Labelnumber.text = "\(newValue)"
               letthenumberappend = false
                
            }
        }
}

