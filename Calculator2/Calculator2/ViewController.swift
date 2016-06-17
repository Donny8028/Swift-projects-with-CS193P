//
//  ViewController.swift
//  Calculator2
//
//  Created by 賢瑭 何 on 2016/2/5.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var display: UILabel!
    
    
    var userinthemiddleoftyping = false
    
    var brain = CalculatorBrain()
    
    @IBAction func AppendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userinthemiddleoftyping {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userinthemiddleoftyping = true
        }
        
    }
    
    
    @IBAction func operation(sender: UIButton) {
        let operators = sender.currentTitle!
        if userinthemiddleoftyping {
            enter()
        }
        if let result = brain.pushOperation(operators){
            displayValue = result 
        }
        else{
            displayValue = nil
        }
        

    }
    

    
    
    @IBAction func enter() {
        userinthemiddleoftyping = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }
        else{
            displayValue = nil
        }
        
        
    }
    
    var displayValue:Double! {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userinthemiddleoftyping = false
        }
    }
    

}










