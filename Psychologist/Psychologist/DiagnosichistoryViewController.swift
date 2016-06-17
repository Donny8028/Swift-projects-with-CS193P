//
//  DiagnosichistoryViewController.swift
//  Psychologist
//
//  Created by 賢瑭 何 on 2016/2/24.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class DiagnosichistoryViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    
    
    var text:String = "" {
        didSet{
            textView?.text = text
        }
    }
    
    override var preferredContentSize :CGSize {
        get{
            if textView.text != nil && presentingViewController != nil {
                 return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }
            else {
                return super.preferredContentSize
            }
            
        }
        set{
            super.preferredContentSize = newValue
        }
    

     }
}