//
//  Face.swift
//  Happiness
//
//  Created by 賢瑭 何 on 2016/2/17.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

protocol FaceViewDateSource:class {
    
    func smilinessformhappiness (sender:Face) -> Double?
    
}

@IBDesignable
class Face: UIView {
    
    @IBInspectable
    var lineWidth:CGFloat = 3 { didSet {setNeedsDisplay()} }
    @IBInspectable
    var color:UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    @IBInspectable
    var scale:CGFloat = 0.90 { didSet {setNeedsDisplay() } }
    
    var faceRadius:CGFloat {
        return min(bounds.size.width , bounds.size.height) / 2 * scale
    }
    
    
    var  faceCenter:CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    weak var delegate:FaceViewDateSource?
    
    private struct Scaling {
        static let faceRadiustoEyeRadiusRatio:CGFloat = 10
        static let faceRadiustoEyeOffsetRatio:CGFloat = 3
        static let faceRadiustoEyeSeparationRatio:CGFloat = 1.5
        static let faceRadiustoMouthWidthRatio:CGFloat = 1
        static let faceRadiustoMouthHeightRatio:CGFloat = 3
        static let faceRadiustoMouthOffsetRatio:CGFloat = 3
    }
    
    enum Eye {
        case rightEye
        case leftEye
    }
    
    func bezierPathForEye (whichEye: Eye) -> UIBezierPath {
        var eyeCenter = faceCenter
        let eyeRadius = faceRadius / Scaling.faceRadiustoEyeRadiusRatio
        let eyeOffset = faceRadius / Scaling.faceRadiustoEyeOffsetRatio
        let eyeHorizenSeparation = faceRadius / Scaling.faceRadiustoEyeSeparationRatio
        
        eyeCenter.y -= eyeOffset
        
        switch whichEye {
        case .leftEye : eyeCenter.x -= eyeHorizenSeparation / 2
        case .rightEye : eyeCenter.x += eyeHorizenSeparation / 2
        }
        
        let eyePath = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        eyePath.lineWidth = lineWidth
        return eyePath
    }
    
    
    func beizierPathForMouth (fractionOfMaxSmile: Double) -> UIBezierPath {
        
        let mouthWidth = faceRadius / Scaling.faceRadiustoMouthWidthRatio
        let mouthOffset = faceRadius / Scaling.faceRadiustoMouthOffsetRatio
        let mouthHeight = faceRadius / Scaling.faceRadiustoMouthHeightRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1),-1)) * mouthHeight
        
        let start:CGPoint = CGPoint(x:faceCenter.x - mouthWidth / 2  ,y:faceCenter.y + mouthOffset)
        let end:CGPoint = CGPoint(x:faceCenter.x + mouthWidth / 2 , y:start.y)
        let cp1:CGPoint = CGPoint(x:faceCenter.x - mouthWidth / 3 , y:end.y + smileHeight)
        let cp2:CGPoint = CGPoint(x:faceCenter.x + mouthWidth / 3 , y:end.y + smileHeight)
        
        
        let MouthPath = UIBezierPath()
        MouthPath.moveToPoint(start)
        MouthPath.addCurveToPoint(end,controlPoint1:cp1, controlPoint2:cp2)
        MouthPath.lineWidth = lineWidth
        return MouthPath
    }
    
    
    
    func pinchable(gesture: UIPinchGestureRecognizer){
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
        
    }
    
    

    override func drawRect(rect: CGRect) {
        
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        bezierPathForEye(.rightEye).stroke()
        bezierPathForEye(.leftEye).stroke()
        
        let smileness = delegate?.smilinessformhappiness(self) ?? 0.0
        let smilePath = beizierPathForMouth(smileness)
        smilePath.stroke()
    
    
    }


}
