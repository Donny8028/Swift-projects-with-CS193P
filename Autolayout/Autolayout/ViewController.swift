//
//  ViewController.swift
//  Autolayout
//
//  Created by 賢瑭 何 on 2016/2/28.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LoginField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var company: UILabel!
    
    
    @IBOutlet weak var loginImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    var security = false { didSet { updateUI() }}
    var loginUser : User? { didSet { updateUI() }}
    

    func updateUI() {
        PasswordField.secureTextEntry = security
        PasswordLabel.text = security ? "Secured Password" : "Password"
        userName.text = loginUser?.name
        company.text = loginUser?.company
        image = loginUser?.image

    }
    
    @IBAction func changeSecurity() {
        security = !security
    }
    
    @IBAction func login() {
        loginUser = User.userLogin(LoginField.text! ?? "", passowrd: PasswordField.text! ?? "")
        PasswordField.resignFirstResponder()
    }
    
    var image:UIImage? {
        get {
            return loginImage.image
        }set {
            loginImage.image = newValue
            if let constraintedView = loginImage {
                if let newImage = newValue {
                    aspectRatioConstrain = NSLayoutConstraint(item: constraintedView, attribute: .Width, relatedBy: .Equal, toItem: constraintedView, attribute: .Height, multiplier: newImage.aspectratio, constant: 0)
                }
            }else {
            aspectRatioConstrain = nil
            }
        }
    }
    
    
    var aspectRatioConstrain:NSLayoutConstraint? {
        willSet{
            if let existconstraint = aspectRatioConstrain {
            loginImage.removeConstraint(existconstraint)
            }
            
        }
        
        didSet{
            if let newConstraint = aspectRatioConstrain {
            loginImage.addConstraint(newConstraint)
            }
            
        }
    }
    
    
}

extension User {
    var image:UIImage? {
        if let image = UIImage(named: login){
            return image
        }else{
        return UIImage(named: "o")
    }
    }
}

extension UIImage {
    var aspectratio:CGFloat {
        
        return size.height != 0 ? size.width / size.height : 0
    }
}





