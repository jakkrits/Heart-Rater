//
//  FireIcon.swift
//  HeartRater
//
//  Created by Jakkrits on 10/24/2558 BE.
//  Copyright © 2558 AppIllus. All rights reserved.
//

import UIKit

@IBDesignable
class FireIcon: UIView {
    
    var layers : Dictionary<String, AnyObject> = [:]
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var updateLayerValueForCompletedAnimation : Bool = false
    
    var startFillColor : UIColor!
    var startAnimateColor : UIColor!
    var stopAnimationColor : UIColor!
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
    }
    
    override var frame: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    override var bounds: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    func setupProperties(){
        self.startFillColor     = ThemeColor.WhiteColor
        self.startAnimateColor  = ThemeColor.GreenColor
        self.stopAnimationColor = ThemeColor.GreenColor
    }
    
    func setupLayers(){
        let firePathBack = CAShapeLayer()
        self.layer.addSublayer(firePathBack)
        layers["firePathBack"] = firePathBack
        
        let firePathFront = CAShapeLayer()
        self.layer.addSublayer(firePathFront)
        layers["firePathFront"] = firePathFront
        
        resetLayerPropertiesForLayerIdentifiers(nil)
        setupLayerFrames()
    }
    
    func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if layerIds == nil || layerIds.contains("firePathBack"){
            let firePathBack = layers["firePathBack"] as! CAShapeLayer
            firePathBack.fillColor = UIColor(red:1, green: 0.983, blue:0.963, alpha:1).CGColor
            firePathBack.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("firePathFront"){
            let firePathFront = layers["firePathFront"] as! CAShapeLayer
            firePathFront.fillColor = UIColor(red:0.946, green: 0.981, blue:1, alpha:1).CGColor
            firePathFront.lineWidth = 0
        }
        
        CATransaction.commit()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let firePathBack : CAShapeLayer = layers["firePathBack"] as? CAShapeLayer{
            firePathBack.frame = CGRectMake(0.11208 * firePathBack.superlayer!.bounds.width, 0.05322 * firePathBack.superlayer!.bounds.height, 0.77583 * firePathBack.superlayer!.bounds.width, 0.89357 * firePathBack.superlayer!.bounds.height)
            firePathBack.path  = firePathBackPathWithBounds((layers["firePathBack"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let firePathFront : CAShapeLayer = layers["firePathFront"] as? CAShapeLayer{
            firePathFront.frame = CGRectMake(0.12068 * firePathFront.superlayer!.bounds.width, 0.05322 * firePathFront.superlayer!.bounds.height, 0.77583 * firePathFront.superlayer!.bounds.width, 0.89357 * firePathFront.superlayer!.bounds.height)
            firePathFront.path  = firePathFrontPathWithBounds((layers["firePathFront"] as! CAShapeLayer).bounds).CGPath;
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addFireAnimateAnimation(){
        addFireAnimateAnimationCompletionBlock(nil)
    }
    
    func addFireAnimateAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        addFireAnimateAnimationReverse(false, completionBlock:completionBlock)
    }
    
    func addFireAnimateAnimationReverse(reverseAnimation: Bool, completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1.022
            completionAnim.delegate = self
            completionAnim.setValue("fireAnimate", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"fireAnimate")
            if let anim = layer.animationForKey("fireAnimate"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = reverseAnimation ? kCAFillModeBoth : kCAFillModeForwards
        
        let totalDuration : CFTimeInterval = 1.022
        
        ////FirePathFront animation
        let firePathFrontOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
        firePathFrontOpacityAnim.values   = [1, 0]
        firePathFrontOpacityAnim.keyTimes = [0, 1]
        firePathFrontOpacityAnim.duration = 0.695
        firePathFrontOpacityAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let firePathFront = layers["firePathFront"] as! CAShapeLayer
        
        let firePathFrontTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        firePathFrontTransformAnim.values    = [NSValue(CATransform3D: CATransform3DIdentity),
            NSValue(CATransform3D: CATransform3DMakeScale(5, 5, 5))]
        firePathFrontTransformAnim.keyTimes  = [0, 1]
        firePathFrontTransformAnim.duration  = 0.819
        firePathFrontTransformAnim.beginTime = 0.204
        firePathFrontTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let firePathFrontFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        firePathFrontFillColorAnim.values    = [self.startAnimateColor.CGColor,
            self.stopAnimationColor.CGColor]
        firePathFrontFillColorAnim.keyTimes  = [0, 1]
        firePathFrontFillColorAnim.duration  = 0.397
        firePathFrontFillColorAnim.beginTime = 0.122
        firePathFrontFillColorAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        var firePathFrontFireAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([firePathFrontOpacityAnim, firePathFrontTransformAnim, firePathFrontFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ firePathFrontFireAnimateAnim = QCMethod.reverseAnimation(firePathFrontFireAnimateAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        firePathFront.addAnimation(firePathFrontFireAnimateAnim, forKey:"firePathFrontFireAnimateAnim")
    }
    
    //MARK: - Animation Cleanup
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValueForKey(anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
                updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
                removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValuesForAnimationId(identifier: String){
        if identifier == "fireAnimate"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["firePathFront"] as! CALayer).animationForKey("firePathFrontFireAnimateAnim"), theLayer:(layers["firePathFront"] as! CALayer))
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String){
        if identifier == "fireAnimate"{
            (layers["firePathFront"] as! CALayer).removeAnimationForKey("firePathFrontFireAnimateAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func firePathBackPathWithBounds(bound: CGRect) -> UIBezierPath{
        let firePathBackPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        firePathBackPath.moveToPoint(CGPointMake(minX + 0.28151 * w, minY + h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.30463 * w, minY + 0.70699 * h), controlPoint1:CGPointMake(minX + 0.20475 * w, minY + 0.86132 * h), controlPoint2:CGPointMake(minX + 0.24563 * w, minY + 0.78186 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.38588 * w, minY + 0.54384 * h), controlPoint1:CGPointMake(minX + 0.36923 * w, minY + 0.625 * h), controlPoint2:CGPointMake(minX + 0.38588 * w, minY + 0.54384 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.41636 * w, minY + 0.69082 * h), controlPoint1:CGPointMake(minX + 0.38588 * w, minY + 0.54384 * h), controlPoint2:CGPointMake(minX + 0.43667 * w, minY + 0.60116 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.50946 * w, minY + 0.41302 * h), controlPoint1:CGPointMake(minX + 0.50608 * w, minY + 0.6041 * h), controlPoint2:CGPointMake(minX + 0.52301 * w, minY + 0.46594 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.68214 * w, minY + h), controlPoint1:CGPointMake(minX + 0.71227 * w, minY + 0.53608 * h), controlPoint2:CGPointMake(minX + 0.79895 * w, minY + 0.80253 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.75542 * w, minY + 0.18667 * h), controlPoint1:CGPointMake(minX + 1.30343 * w, minY + 0.69479 * h), controlPoint2:CGPointMake(minX + 0.83668 * w, minY + 0.23811 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.73293 * w, minY + 0.36746 * h), controlPoint1:CGPointMake(minX + 0.78251 * w, minY + 0.23811 * h), controlPoint2:CGPointMake(minX + 0.78765 * w, minY + 0.3252 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.41128 * w, minY), controlPoint1:CGPointMake(minX + 0.6403 * w, minY + 0.0625 * h), controlPoint2:CGPointMake(minX + 0.41128 * w, minY))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.19229 * w, minY + 0.45774 * h), controlPoint1:CGPointMake(minX + 0.43837 * w, minY + 0.15727 * h), controlPoint2:CGPointMake(minX + 0.31309 * w, minY + 0.32924 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.14556 * w, minY + 0.29175 * h), controlPoint1:CGPointMake(minX + 0.18805 * w, minY + 0.39503 * h), controlPoint2:CGPointMake(minX + 0.18354 * w, minY + 0.35176 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.0096 * w, minY + 0.61268 * h), controlPoint1:CGPointMake(minX + 0.13703 * w, minY + 0.40567 * h), controlPoint2:CGPointMake(minX + 0.03676 * w, minY + 0.49853 * h))
        firePathBackPath.addCurveToPoint(CGPointMake(minX + 0.28151 * w, minY + h), controlPoint1:CGPointMake(minX + -0.02718 * w, minY + 0.76725 * h), controlPoint2:CGPointMake(minX + 0.03716 * w, minY + 0.88043 * h))
        firePathBackPath.closePath()
        firePathBackPath.moveToPoint(CGPointMake(minX + 0.28151 * w, minY + h))
        
        return firePathBackPath;
    }
    
    func firePathFrontPathWithBounds(bound: CGRect) -> UIBezierPath{
        let firePathFrontPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        firePathFrontPath.moveToPoint(CGPointMake(minX + 0.28151 * w, minY + h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.30463 * w, minY + 0.70699 * h), controlPoint1:CGPointMake(minX + 0.20475 * w, minY + 0.86132 * h), controlPoint2:CGPointMake(minX + 0.24563 * w, minY + 0.78186 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.38588 * w, minY + 0.54384 * h), controlPoint1:CGPointMake(minX + 0.36923 * w, minY + 0.625 * h), controlPoint2:CGPointMake(minX + 0.38588 * w, minY + 0.54384 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.41636 * w, minY + 0.69082 * h), controlPoint1:CGPointMake(minX + 0.38588 * w, minY + 0.54384 * h), controlPoint2:CGPointMake(minX + 0.43667 * w, minY + 0.60116 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.50946 * w, minY + 0.41302 * h), controlPoint1:CGPointMake(minX + 0.50608 * w, minY + 0.6041 * h), controlPoint2:CGPointMake(minX + 0.52301 * w, minY + 0.46594 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.68214 * w, minY + h), controlPoint1:CGPointMake(minX + 0.71227 * w, minY + 0.53608 * h), controlPoint2:CGPointMake(minX + 0.79895 * w, minY + 0.80253 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.75542 * w, minY + 0.18667 * h), controlPoint1:CGPointMake(minX + 1.30343 * w, minY + 0.69479 * h), controlPoint2:CGPointMake(minX + 0.83668 * w, minY + 0.23811 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.73293 * w, minY + 0.36746 * h), controlPoint1:CGPointMake(minX + 0.78251 * w, minY + 0.23811 * h), controlPoint2:CGPointMake(minX + 0.78765 * w, minY + 0.3252 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.41128 * w, minY), controlPoint1:CGPointMake(minX + 0.6403 * w, minY + 0.0625 * h), controlPoint2:CGPointMake(minX + 0.41128 * w, minY))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.19229 * w, minY + 0.45774 * h), controlPoint1:CGPointMake(minX + 0.43837 * w, minY + 0.15727 * h), controlPoint2:CGPointMake(minX + 0.31309 * w, minY + 0.32924 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.14556 * w, minY + 0.29175 * h), controlPoint1:CGPointMake(minX + 0.18805 * w, minY + 0.39503 * h), controlPoint2:CGPointMake(minX + 0.18354 * w, minY + 0.35176 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.0096 * w, minY + 0.61268 * h), controlPoint1:CGPointMake(minX + 0.13703 * w, minY + 0.40567 * h), controlPoint2:CGPointMake(minX + 0.03676 * w, minY + 0.49853 * h))
        firePathFrontPath.addCurveToPoint(CGPointMake(minX + 0.28151 * w, minY + h), controlPoint1:CGPointMake(minX + -0.02718 * w, minY + 0.76725 * h), controlPoint2:CGPointMake(minX + 0.03716 * w, minY + 0.88043 * h))
        firePathFrontPath.closePath()
        firePathFrontPath.moveToPoint(CGPointMake(minX + 0.28151 * w, minY + h))
        
        return firePathFrontPath;
    }
    
    
}


