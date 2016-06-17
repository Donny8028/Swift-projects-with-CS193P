//
//  ImageViewController.swift
//  Cassini
//
//  Created by 賢瑭 何 on 2016/3/1.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController , UIScrollViewDelegate{
    
    var imageURL:NSURL? {
        didSet {
            image = nil
            if view.window != nil{
            fetchImage()
            } //view.window is the property to determine whether the users are "on screen" or not.
              //When the user are "on screen" , the view is adding / loading to window, viewdidload was activated
        }
    }
    
    func fetchImage() {
        if let url = imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            let quque = dispatch_get_global_queue(qos, 0)
            dispatch_async(quque) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if url == self.imageURL { //check the user currently want
                        if imageData != nil {
                            self.image = UIImage(data: imageData!)
                        }else{
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 2.0
        }
    }
    
    var imageView = UIImageView()                                 //can also create this view with storyboard
    
    var image:UIImage? {
        get {
        return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            activityIndicator?.stopAnimating()
            let upperLeft:CGRect = CGRect(x: 0.0, y: 0.0, width: imageView.frame.width, height: imageView.frame.height)
            scrollView?.zoomToRect(upperLeft, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView) //final step to create imageview.
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        if image == nil {
            fetchImage()           // means the user come back to screen and we start fetch.
        }
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


