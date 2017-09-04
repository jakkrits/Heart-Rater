//
//  BatteryIcon.swift
//  PolarH7 Heart-Rater
//
//  Created by Jakkrits on 10/23/2558 BE.
//  Copyright © 2558 AppIllus. All rights reserved.
//

import UIKit

@IBDesignable
class BatteryIcon: UIView {
    
    var updateLayerValueForCompletedAnimation : Bool = false
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var layers : Dictionary<String, AnyObject> = [:]
    
    var startColor : UIColor!
    var caseStopColor : UIColor!
    var chargeStopColor : UIColor!
    var emptyChargeColor : UIColor!
    var caseReverseColor : UIColor!
    
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
        self.startColor         = ThemeColor.WhiteColor
        self.caseStopColor      = ThemeColor.GreenColor
        self.chargeStopColor    = ThemeColor.BrightGreen
        self.emptyChargeColor   = ThemeColor.RedColor
        self.caseReverseColor   = ThemeColor.WhiteColor
    }
    
    func setupLayers(){
        let batteryIcon = CALayer()
        self.layer.addSublayer(batteryIcon)
        layers["batteryIcon"] = batteryIcon
        let thirdChargePath = CAShapeLayer()
        batteryIcon.addSublayer(thirdChargePath)
        layers["thirdChargePath"] = thirdChargePath
        let secondChargePath = CAShapeLayer()
        batteryIcon.addSublayer(secondChargePath)
        layers["secondChargePath"] = secondChargePath
        let firstChargePath = CAShapeLayer()
        batteryIcon.addSublayer(firstChargePath)
        layers["firstChargePath"] = firstChargePath
        let plusChargePath = CAShapeLayer()
        batteryIcon.addSublayer(plusChargePath)
        layers["plusChargePath"] = plusChargePath
        let battCasePath = CAShapeLayer()
        batteryIcon.addSublayer(battCasePath)
        layers["battCasePath"] = battCasePath
        
        resetLayerPropertiesForLayerIdentifiers(nil)
        setupLayerFrames()
    }
    
    func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if layerIds == nil || layerIds.contains("thirdChargePath"){
            let thirdChargePath = layers["thirdChargePath"] as! CAShapeLayer
            thirdChargePath.fillColor = self.startColor.CGColor
            thirdChargePath.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("secondChargePath"){
            let secondChargePath = layers["secondChargePath"] as! CAShapeLayer
            secondChargePath.fillColor = self.startColor.CGColor
            secondChargePath.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("firstChargePath"){
            let firstChargePath = layers["firstChargePath"] as! CAShapeLayer
            firstChargePath.fillColor = self.startColor.CGColor
            firstChargePath.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("plusChargePath"){
            let plusChargePath = layers["plusChargePath"] as! CAShapeLayer
            plusChargePath.fillColor = self.startColor.CGColor
            plusChargePath.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("battCasePath"){
            let battCasePath = layers["battCasePath"] as! CAShapeLayer
            battCasePath.fillColor = self.startColor.CGColor
            battCasePath.lineWidth = 0
        }
        
        CATransaction.commit()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let batteryIcon : CALayer = layers["batteryIcon"] as? CALayer{
            batteryIcon.frame = CGRectMake(0.26758 * batteryIcon.superlayer!.bounds.width, 0.08498 * batteryIcon.superlayer!.bounds.height, 0.46484 * batteryIcon.superlayer!.bounds.width, 0.83004 * batteryIcon.superlayer!.bounds.height)
        }
        
        if let thirdChargePath : CAShapeLayer = layers["thirdChargePath"] as? CAShapeLayer{
            thirdChargePath.frame = CGRectMake(0.26363 * thirdChargePath.superlayer!.bounds.width, 0.43387 * thirdChargePath.superlayer!.bounds.height, 0.47273 * thirdChargePath.superlayer!.bounds.width, 0.09504 * thirdChargePath.superlayer!.bounds.height)
            thirdChargePath.path  = thirdChargePathPathWithBounds((layers["thirdChargePath"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let secondChargePath : CAShapeLayer = layers["secondChargePath"] as? CAShapeLayer{
            secondChargePath.frame = CGRectMake(0.26363 * secondChargePath.superlayer!.bounds.width, 0.5866 * secondChargePath.superlayer!.bounds.height, 0.47273 * secondChargePath.superlayer!.bounds.width, 0.09504 * secondChargePath.superlayer!.bounds.height)
            secondChargePath.path  = secondChargePathPathWithBounds((layers["secondChargePath"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let firstChargePath : CAShapeLayer = layers["firstChargePath"] as? CAShapeLayer{
            firstChargePath.frame = CGRectMake(0.26363 * firstChargePath.superlayer!.bounds.width, 0.73933 * firstChargePath.superlayer!.bounds.height, 0.47273 * firstChargePath.superlayer!.bounds.width, 0.09504 * firstChargePath.superlayer!.bounds.height)
            firstChargePath.path  = firstChargePathPathWithBounds((layers["firstChargePath"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let plusChargePath : CAShapeLayer = layers["plusChargePath"] as? CAShapeLayer{
            plusChargePath.frame = CGRectMake(0.34431 * plusChargePath.superlayer!.bounds.width, 0.2212 * plusChargePath.superlayer!.bounds.height, 0.31137 * plusChargePath.superlayer!.bounds.width, 0.17437 * plusChargePath.superlayer!.bounds.height)
            plusChargePath.path  = plusChargePathPathWithBounds((layers["plusChargePath"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let battCasePath : CAShapeLayer = layers["battCasePath"] as? CAShapeLayer{
            battCasePath.frame = CGRectMake(0, 0,  battCasePath.superlayer!.bounds.width,  battCasePath.superlayer!.bounds.height)
            battCasePath.path  = battCasePathPathWithBounds((layers["battCasePath"] as! CAShapeLayer).bounds).CGPath;
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addFullChargeAnimationAnimation(){
        addFullChargeAnimationAnimationCompletionBlock(nil)
    }
    
    func addFullChargeAnimationAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        addFullChargeAnimationAnimationReverse(false, completionBlock:completionBlock)
    }
    
    func addFullChargeAnimationAnimationReverse(reverseAnimation: Bool, completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 2.581
            completionAnim.delegate = self
            completionAnim.setValue("fullChargeAnimation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"fullChargeAnimation")
            if let anim = layer.animationForKey("fullChargeAnimation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = reverseAnimation ? kCAFillModeBoth : kCAFillModeForwards
        
        let totalDuration : CFTimeInterval = 2.581
        
        let thirdChargePath = layers["thirdChargePath"] as! CAShapeLayer
        
        ////ThirdChargePath animation
        let thirdChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        thirdChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        thirdChargePathTransformAnim.keyTimes  = [0, 1]
        thirdChargePathTransformAnim.duration  = 1
        thirdChargePathTransformAnim.beginTime = 0.442
        thirdChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let thirdChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        thirdChargePathFillColorAnim.values    = [self.startColor.CGColor,
            self.chargeStopColor.CGColor]
        thirdChargePathFillColorAnim.keyTimes  = [0, 1]
        thirdChargePathFillColorAnim.duration  = 1.15
        thirdChargePathFillColorAnim.beginTime = 1.22
        
        var thirdChargePathFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([thirdChargePathTransformAnim, thirdChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ thirdChargePathFullChargeAnimationAnim = QCMethod.reverseAnimation(thirdChargePathFullChargeAnimationAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        thirdChargePath.addAnimation(thirdChargePathFullChargeAnimationAnim, forKey:"thirdChargePathFullChargeAnimationAnim")
        
        let secondChargePath = layers["secondChargePath"] as! CAShapeLayer
        
        ////SecondChargePath animation
        let secondChargePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        secondChargePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        secondChargePathTransformAnim.keyTimes = [0, 1]
        secondChargePathTransformAnim.duration = 1
        secondChargePathTransformAnim.beginTime = 0.442
        secondChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let secondChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        secondChargePathFillColorAnim.values   = [self.startColor.CGColor,
            self.chargeStopColor.CGColor]
        secondChargePathFillColorAnim.keyTimes = [0, 1]
        secondChargePathFillColorAnim.duration = 1.01
        secondChargePathFillColorAnim.beginTime = 1.02
        
        var secondChargePathFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([secondChargePathTransformAnim, secondChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ secondChargePathFullChargeAnimationAnim = QCMethod.reverseAnimation(secondChargePathFullChargeAnimationAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        secondChargePath.addAnimation(secondChargePathFullChargeAnimationAnim, forKey:"secondChargePathFullChargeAnimationAnim")
        
        let firstChargePath = layers["firstChargePath"] as! CAShapeLayer
        
        ////FirstChargePath animation
        let firstChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        firstChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        firstChargePathTransformAnim.keyTimes  = [0, 1]
        firstChargePathTransformAnim.duration  = 1
        firstChargePathTransformAnim.beginTime = 0.442
        firstChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let firstChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        firstChargePathFillColorAnim.values    = [self.startColor.CGColor,
            self.emptyChargeColor.CGColor]
        firstChargePathFillColorAnim.keyTimes  = [0, 1]
        firstChargePathFillColorAnim.duration  = 0.841
        firstChargePathFillColorAnim.beginTime = 0.602
        
        var firstChargePathFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([firstChargePathTransformAnim, firstChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ firstChargePathFullChargeAnimationAnim = QCMethod.reverseAnimation(firstChargePathFullChargeAnimationAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        firstChargePath.addAnimation(firstChargePathFullChargeAnimationAnim, forKey:"firstChargePathFullChargeAnimationAnim")
        
        let plusChargePath = layers["plusChargePath"] as! CAShapeLayer
        
        ////PlusChargePath animation
        let plusChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        plusChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        plusChargePathTransformAnim.keyTimes  = [0, 1]
        plusChargePathTransformAnim.duration  = 1
        plusChargePathTransformAnim.beginTime = 0.442
        plusChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        plusChargePathFillColorAnim.values    = [self.startColor.CGColor,
            self.chargeStopColor.CGColor]
        plusChargePathFillColorAnim.keyTimes  = [0, 1]
        plusChargePathFillColorAnim.duration  = 1.06
        plusChargePathFillColorAnim.beginTime = 1.53
        plusChargePathFillColorAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        var plusChargePathFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([plusChargePathTransformAnim, plusChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ plusChargePathFullChargeAnimationAnim = QCMethod.reverseAnimation(plusChargePathFullChargeAnimationAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        plusChargePath.addAnimation(plusChargePathFullChargeAnimationAnim, forKey:"plusChargePathFullChargeAnimationAnim")
        
        let battCasePath = layers["battCasePath"] as! CAShapeLayer
        
        ////BattCasePath animation
        let battCasePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        battCasePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        battCasePathTransformAnim.keyTimes = [0, 1]
        battCasePathTransformAnim.duration = 0.766
        
        let battCasePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        battCasePathFillColorAnim.values    = [self.startColor.CGColor,
            self.caseStopColor.CGColor]
        battCasePathFillColorAnim.keyTimes  = [0, 1]
        battCasePathFillColorAnim.duration  = 2.14
        battCasePathFillColorAnim.beginTime = 0.444
        
        var battCasePathFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([battCasePathTransformAnim, battCasePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ battCasePathFullChargeAnimationAnim = QCMethod.reverseAnimation(battCasePathFullChargeAnimationAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        battCasePath.addAnimation(battCasePathFullChargeAnimationAnim, forKey:"battCasePathFullChargeAnimationAnim")
    }
    
    func addEmptyChargeAnimationAnimation(){
        addEmptyChargeAnimationAnimationCompletionBlock(nil)
    }
    
    func addEmptyChargeAnimationAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1
            completionAnim.delegate = self
            completionAnim.setValue("emptyChargeAnimation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"emptyChargeAnimation")
            if let anim = layer.animationForKey("emptyChargeAnimation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = kCAFillModeForwards
        
        let battCasePath = layers["battCasePath"] as! CAShapeLayer
        
        ////BattCasePath animation
        let battCasePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        battCasePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0.5, 0.5, 0.5)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        battCasePathTransformAnim.keyTimes = [0, 1]
        battCasePathTransformAnim.duration = 1
        
        let battCasePathOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
        battCasePathOpacityAnim.values   = [0, 1]
        battCasePathOpacityAnim.keyTimes = [0, 1]
        battCasePathOpacityAnim.duration = 1
        
        let battCasePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        battCasePathFillColorAnim.values   = [self.startColor.CGColor,
            self.caseStopColor.CGColor]
        battCasePathFillColorAnim.keyTimes = [0, 1]
        battCasePathFillColorAnim.duration = 1
        
        let battCasePathEmptyChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([battCasePathTransformAnim, battCasePathOpacityAnim, battCasePathFillColorAnim], fillMode:fillMode)
        battCasePath.addAnimation(battCasePathEmptyChargeAnimationAnim, forKey:"battCasePathEmptyChargeAnimationAnim")
    }
    
    func addLessFullChargeAnimationAnimation(){
        addLessFullChargeAnimationAnimationCompletionBlock(nil)
    }
    
    func addLessFullChargeAnimationAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 2.88
            completionAnim.delegate = self
            completionAnim.setValue("lessFullChargeAnimation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"lessFullChargeAnimation")
            if let anim = layer.animationForKey("lessFullChargeAnimation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = kCAFillModeForwards
        
        let thirdChargePath = layers["thirdChargePath"] as! CAShapeLayer
        
        ////ThirdChargePath animation
        let thirdChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        thirdChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        thirdChargePathTransformAnim.keyTimes  = [0, 1]
        thirdChargePathTransformAnim.duration  = 1
        thirdChargePathTransformAnim.beginTime = 0.442
        thirdChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let thirdChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        thirdChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        thirdChargePathFillColorAnim.keyTimes  = [0, 1]
        thirdChargePathFillColorAnim.duration  = 1.15
        thirdChargePathFillColorAnim.beginTime = 1.22
        
        let thirdChargePathLessFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([thirdChargePathTransformAnim, thirdChargePathFillColorAnim], fillMode:fillMode)
        thirdChargePath.addAnimation(thirdChargePathLessFullChargeAnimationAnim, forKey:"thirdChargePathLessFullChargeAnimationAnim")
        
        let secondChargePath = layers["secondChargePath"] as! CAShapeLayer
        
        ////SecondChargePath animation
        let secondChargePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        secondChargePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        secondChargePathTransformAnim.keyTimes = [0, 1]
        secondChargePathTransformAnim.duration = 1
        secondChargePathTransformAnim.beginTime = 0.442
        secondChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let secondChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        secondChargePathFillColorAnim.values   = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        secondChargePathFillColorAnim.keyTimes = [0, 1]
        secondChargePathFillColorAnim.duration = 1.01
        secondChargePathFillColorAnim.beginTime = 1.02
        
        let secondChargePathLessFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([secondChargePathTransformAnim, secondChargePathFillColorAnim], fillMode:fillMode)
        secondChargePath.addAnimation(secondChargePathLessFullChargeAnimationAnim, forKey:"secondChargePathLessFullChargeAnimationAnim")
        
        let firstChargePath = layers["firstChargePath"] as! CAShapeLayer
        
        ////FirstChargePath animation
        let firstChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        firstChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        firstChargePathTransformAnim.keyTimes  = [0, 1]
        firstChargePathTransformAnim.duration  = 1
        firstChargePathTransformAnim.beginTime = 0.442
        firstChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let firstChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        firstChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        firstChargePathFillColorAnim.keyTimes  = [0, 1]
        firstChargePathFillColorAnim.duration  = 0.841
        firstChargePathFillColorAnim.beginTime = 0.602
        
        let firstChargePathLessFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([firstChargePathTransformAnim, firstChargePathFillColorAnim], fillMode:fillMode)
        firstChargePath.addAnimation(firstChargePathLessFullChargeAnimationAnim, forKey:"firstChargePathLessFullChargeAnimationAnim")
        
        let plusChargePath = layers["plusChargePath"] as! CAShapeLayer
        
        ////PlusChargePath animation
        let plusChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        plusChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        plusChargePathTransformAnim.keyTimes  = [0, 1]
        plusChargePathTransformAnim.duration  = 1
        plusChargePathTransformAnim.beginTime = 0.442
        plusChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        plusChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        plusChargePathFillColorAnim.keyTimes  = [0, 1]
        plusChargePathFillColorAnim.duration  = 1.06
        plusChargePathFillColorAnim.beginTime = 1.53
        plusChargePathFillColorAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        plusChargePathPositionAnim.values    = [NSValue(CGPoint: CGPointMake(0.5 * plusChargePath.superlayer!.bounds.width, 0.30838 * plusChargePath.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.5 * plusChargePath.superlayer!.bounds.width, 2.30714 * plusChargePath.superlayer!.bounds.height))]
        plusChargePathPositionAnim.keyTimes  = [0, 1]
        plusChargePathPositionAnim.duration  = 0.358
        plusChargePathPositionAnim.beginTime = 2.52
        plusChargePathPositionAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        let plusChargePathHiddenAnim       = CAKeyframeAnimation(keyPath:"hidden")
        plusChargePathHiddenAnim.values    = [false, true]
        plusChargePathHiddenAnim.keyTimes  = [0, 1]
        plusChargePathHiddenAnim.duration  = 0.143
        plusChargePathHiddenAnim.beginTime = 2.74
        plusChargePathHiddenAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        
        let plusChargePathLessFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([plusChargePathTransformAnim, plusChargePathFillColorAnim, plusChargePathPositionAnim, plusChargePathHiddenAnim], fillMode:fillMode)
        plusChargePath.addAnimation(plusChargePathLessFullChargeAnimationAnim, forKey:"plusChargePathLessFullChargeAnimationAnim")
        
        let battCasePath = layers["battCasePath"] as! CAShapeLayer
        
        ////BattCasePath animation
        let battCasePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        battCasePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        battCasePathTransformAnim.keyTimes = [0, 1]
        battCasePathTransformAnim.duration = 0.766
        
        let battCasePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        battCasePathFillColorAnim.values    = [self.startColor.CGColor,
            self.caseStopColor.CGColor]
        battCasePathFillColorAnim.keyTimes  = [0, 1]
        battCasePathFillColorAnim.duration  = 2.46
        battCasePathFillColorAnim.beginTime = 0.42
        
        let battCasePathLessFullChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([battCasePathTransformAnim, battCasePathFillColorAnim], fillMode:fillMode)
        battCasePath.addAnimation(battCasePathLessFullChargeAnimationAnim, forKey:"battCasePathLessFullChargeAnimationAnim")
    }
    
    func addMidChargeAnimationAnimation(){
        addMidChargeAnimationAnimationCompletionBlock(nil)
    }
    
    func addMidChargeAnimationAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 3.137
            completionAnim.delegate = self
            completionAnim.setValue("midChargeAnimation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"midChargeAnimation")
            if let anim = layer.animationForKey("midChargeAnimation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = kCAFillModeForwards
        
        let thirdChargePath = layers["thirdChargePath"] as! CAShapeLayer
        
        ////ThirdChargePath animation
        let thirdChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        thirdChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        thirdChargePathTransformAnim.keyTimes  = [0, 1]
        thirdChargePathTransformAnim.duration  = 1
        thirdChargePathTransformAnim.beginTime = 0.442
        thirdChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let thirdChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        thirdChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        thirdChargePathFillColorAnim.keyTimes  = [0, 1]
        thirdChargePathFillColorAnim.duration  = 1.15
        thirdChargePathFillColorAnim.beginTime = 1.22
        
        let thirdChargePathPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        thirdChargePathPositionAnim.values    = [NSValue(CGPoint: CGPointMake(0.5 * thirdChargePath.superlayer!.bounds.width, 0.48139 * thirdChargePath.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.5 * thirdChargePath.superlayer!.bounds.width, 2.30714 * thirdChargePath.superlayer!.bounds.height))]
        thirdChargePathPositionAnim.keyTimes  = [0, 1]
        thirdChargePathPositionAnim.duration  = 0.323
        thirdChargePathPositionAnim.beginTime = 2.81
        
        let thirdChargePathMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([thirdChargePathTransformAnim, thirdChargePathFillColorAnim, thirdChargePathPositionAnim], fillMode:fillMode)
        thirdChargePath.addAnimation(thirdChargePathMidChargeAnimationAnim, forKey:"thirdChargePathMidChargeAnimationAnim")
        
        let secondChargePath = layers["secondChargePath"] as! CAShapeLayer
        
        ////SecondChargePath animation
        let secondChargePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        secondChargePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        secondChargePathTransformAnim.keyTimes = [0, 1]
        secondChargePathTransformAnim.duration = 1
        secondChargePathTransformAnim.beginTime = 0.442
        secondChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let secondChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        secondChargePathFillColorAnim.values   = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        secondChargePathFillColorAnim.keyTimes = [0, 1]
        secondChargePathFillColorAnim.duration = 1.01
        secondChargePathFillColorAnim.beginTime = 1.02
        
        let secondChargePathMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([secondChargePathTransformAnim, secondChargePathFillColorAnim], fillMode:fillMode)
        secondChargePath.addAnimation(secondChargePathMidChargeAnimationAnim, forKey:"secondChargePathMidChargeAnimationAnim")
        
        let firstChargePath = layers["firstChargePath"] as! CAShapeLayer
        
        ////FirstChargePath animation
        let firstChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        firstChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        firstChargePathTransformAnim.keyTimes  = [0, 1]
        firstChargePathTransformAnim.duration  = 1
        firstChargePathTransformAnim.beginTime = 0.442
        firstChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let firstChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        firstChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        firstChargePathFillColorAnim.keyTimes  = [0, 1]
        firstChargePathFillColorAnim.duration  = 0.841
        firstChargePathFillColorAnim.beginTime = 0.602
        
        let firstChargePathMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([firstChargePathTransformAnim, firstChargePathFillColorAnim], fillMode:fillMode)
        firstChargePath.addAnimation(firstChargePathMidChargeAnimationAnim, forKey:"firstChargePathMidChargeAnimationAnim")
        
        let plusChargePath = layers["plusChargePath"] as! CAShapeLayer
        
        ////PlusChargePath animation
        let plusChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        plusChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        plusChargePathTransformAnim.keyTimes  = [0, 1]
        plusChargePathTransformAnim.duration  = 1
        plusChargePathTransformAnim.beginTime = 0.442
        plusChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        plusChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        plusChargePathFillColorAnim.keyTimes  = [0, 1]
        plusChargePathFillColorAnim.duration  = 1.06
        plusChargePathFillColorAnim.beginTime = 1.53
        plusChargePathFillColorAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        plusChargePathPositionAnim.values    = [NSValue(CGPoint: CGPointMake(0.5 * plusChargePath.superlayer!.bounds.width, 0.30838 * plusChargePath.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.5 * plusChargePath.superlayer!.bounds.width, 2.30714 * plusChargePath.superlayer!.bounds.height))]
        plusChargePathPositionAnim.keyTimes  = [0, 1]
        plusChargePathPositionAnim.duration  = 0.358
        plusChargePathPositionAnim.beginTime = 2.52
        plusChargePathPositionAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        let plusChargePathHiddenAnim       = CAKeyframeAnimation(keyPath:"hidden")
        plusChargePathHiddenAnim.values    = [false, true]
        plusChargePathHiddenAnim.keyTimes  = [0, 1]
        plusChargePathHiddenAnim.duration  = 0.143
        plusChargePathHiddenAnim.beginTime = 2.74
        plusChargePathHiddenAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        
        let plusChargePathMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([plusChargePathTransformAnim, plusChargePathFillColorAnim, plusChargePathPositionAnim, plusChargePathHiddenAnim], fillMode:fillMode)
        plusChargePath.addAnimation(plusChargePathMidChargeAnimationAnim, forKey:"plusChargePathMidChargeAnimationAnim")
        
        let battCasePath = layers["battCasePath"] as! CAShapeLayer
        
        ////BattCasePath animation
        let battCasePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        battCasePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        battCasePathTransformAnim.keyTimes = [0, 1]
        battCasePathTransformAnim.duration = 0.766
        
        let battCasePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        battCasePathFillColorAnim.values    = [self.startColor.CGColor,
            self.caseStopColor.CGColor]
        battCasePathFillColorAnim.keyTimes  = [0, 1]
        battCasePathFillColorAnim.duration  = 2.61
        battCasePathFillColorAnim.beginTime = 0.442
        
        let battCasePathMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([battCasePathTransformAnim, battCasePathFillColorAnim], fillMode:fillMode)
        battCasePath.addAnimation(battCasePathMidChargeAnimationAnim, forKey:"battCasePathMidChargeAnimationAnim")
    }
    
    func addLessMidChargeAnimationAnimation(){
        addLessMidChargeAnimationAnimationCompletionBlock(nil)
    }
    
    func addLessMidChargeAnimationAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 3.386
            completionAnim.delegate = self
            completionAnim.setValue("lessMidChargeAnimation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"lessMidChargeAnimation")
            if let anim = layer.animationForKey("lessMidChargeAnimation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = kCAFillModeForwards
        
        let thirdChargePath = layers["thirdChargePath"] as! CAShapeLayer
        
        ////ThirdChargePath animation
        let thirdChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        thirdChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        thirdChargePathTransformAnim.keyTimes  = [0, 1]
        thirdChargePathTransformAnim.duration  = 1
        thirdChargePathTransformAnim.beginTime = 0.442
        thirdChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let thirdChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        thirdChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        thirdChargePathFillColorAnim.keyTimes  = [0, 1]
        thirdChargePathFillColorAnim.duration  = 1.15
        thirdChargePathFillColorAnim.beginTime = 1.22
        
        let thirdChargePathPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        thirdChargePathPositionAnim.values    = [NSValue(CGPoint: CGPointMake(0.5 * thirdChargePath.superlayer!.bounds.width, 0.48139 * thirdChargePath.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.5 * thirdChargePath.superlayer!.bounds.width, 2.30714 * thirdChargePath.superlayer!.bounds.height))]
        thirdChargePathPositionAnim.keyTimes  = [0, 1]
        thirdChargePathPositionAnim.duration  = 0.323
        thirdChargePathPositionAnim.beginTime = 2.81
        
        let thirdChargePathLessMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([thirdChargePathTransformAnim, thirdChargePathFillColorAnim, thirdChargePathPositionAnim], fillMode:fillMode)
        thirdChargePath.addAnimation(thirdChargePathLessMidChargeAnimationAnim, forKey:"thirdChargePathLessMidChargeAnimationAnim")
        
        let secondChargePath = layers["secondChargePath"] as! CAShapeLayer
        
        ////SecondChargePath animation
        let secondChargePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        secondChargePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        secondChargePathTransformAnim.keyTimes = [0, 1]
        secondChargePathTransformAnim.duration = 1
        secondChargePathTransformAnim.beginTime = 0.442
        secondChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let secondChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        secondChargePathFillColorAnim.values   = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        secondChargePathFillColorAnim.keyTimes = [0, 1]
        secondChargePathFillColorAnim.duration = 1.01
        secondChargePathFillColorAnim.beginTime = 1.02
        
        let secondChargePathPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        secondChargePathPositionAnim.values    = [NSValue(CGPoint: CGPointMake(0.5 * secondChargePath.superlayer!.bounds.width, 0.63412 * secondChargePath.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.5 * secondChargePath.superlayer!.bounds.width, 2.30714 * secondChargePath.superlayer!.bounds.height))]
        secondChargePathPositionAnim.keyTimes  = [0, 1]
        secondChargePathPositionAnim.duration  = 0.374
        secondChargePathPositionAnim.beginTime = 3.01
        
        let secondChargePathLessMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([secondChargePathTransformAnim, secondChargePathFillColorAnim, secondChargePathPositionAnim], fillMode:fillMode)
        secondChargePath.addAnimation(secondChargePathLessMidChargeAnimationAnim, forKey:"secondChargePathLessMidChargeAnimationAnim")
        
        let firstChargePath = layers["firstChargePath"] as! CAShapeLayer
        
        ////FirstChargePath animation
        let firstChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        firstChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        firstChargePathTransformAnim.keyTimes  = [0, 1]
        firstChargePathTransformAnim.duration  = 1
        firstChargePathTransformAnim.beginTime = 0.442
        firstChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let firstChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        firstChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:1, green: 0.256, blue:0.346, alpha:1).CGColor]
        firstChargePathFillColorAnim.keyTimes  = [0, 1]
        firstChargePathFillColorAnim.duration  = 2.37
        firstChargePathFillColorAnim.beginTime = 1.02
        
        let firstChargePathLessMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([firstChargePathTransformAnim, firstChargePathFillColorAnim], fillMode:fillMode)
        firstChargePath.addAnimation(firstChargePathLessMidChargeAnimationAnim, forKey:"firstChargePathLessMidChargeAnimationAnim")
        
        let plusChargePath = layers["plusChargePath"] as! CAShapeLayer
        
        ////PlusChargePath animation
        let plusChargePathTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
        plusChargePathTransformAnim.values    = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        plusChargePathTransformAnim.keyTimes  = [0, 1]
        plusChargePathTransformAnim.duration  = 1
        plusChargePathTransformAnim.beginTime = 0.442
        plusChargePathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        plusChargePathFillColorAnim.values    = [UIColor.whiteColor().CGColor,
            UIColor(red:0.27, green: 1, blue:0.319, alpha:1).CGColor]
        plusChargePathFillColorAnim.keyTimes  = [0, 1]
        plusChargePathFillColorAnim.duration  = 1.06
        plusChargePathFillColorAnim.beginTime = 1.53
        plusChargePathFillColorAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        let plusChargePathPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        plusChargePathPositionAnim.values    = [NSValue(CGPoint: CGPointMake(0.5 * plusChargePath.superlayer!.bounds.width, 0.30838 * plusChargePath.superlayer!.bounds.height)), NSValue(CGPoint: CGPointMake(0.5 * plusChargePath.superlayer!.bounds.width, 2.30714 * plusChargePath.superlayer!.bounds.height))]
        plusChargePathPositionAnim.keyTimes  = [0, 1]
        plusChargePathPositionAnim.duration  = 0.358
        plusChargePathPositionAnim.beginTime = 2.52
        plusChargePathPositionAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        let plusChargePathHiddenAnim       = CAKeyframeAnimation(keyPath:"hidden")
        plusChargePathHiddenAnim.values    = [false, true]
        plusChargePathHiddenAnim.keyTimes  = [0, 1]
        plusChargePathHiddenAnim.duration  = 0.143
        plusChargePathHiddenAnim.beginTime = 2.74
        plusChargePathHiddenAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        
        let plusChargePathLessMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([plusChargePathTransformAnim, plusChargePathFillColorAnim, plusChargePathPositionAnim, plusChargePathHiddenAnim], fillMode:fillMode)
        plusChargePath.addAnimation(plusChargePathLessMidChargeAnimationAnim, forKey:"plusChargePathLessMidChargeAnimationAnim")
        
        let battCasePath = layers["battCasePath"] as! CAShapeLayer
        
        ////BattCasePath animation
        let battCasePathTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
        battCasePathTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)),
            NSValue(CATransform3D: CATransform3DIdentity)]
        battCasePathTransformAnim.keyTimes = [0, 1]
        battCasePathTransformAnim.duration = 0.766
        
        let battCasePathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        battCasePathFillColorAnim.values    = [self.startColor.CGColor,
            self.caseStopColor.CGColor]
        battCasePathFillColorAnim.keyTimes  = [0, 1]
        battCasePathFillColorAnim.duration  = 2.85
        battCasePathFillColorAnim.beginTime = 0.442
        
        let battCasePathLessMidChargeAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([battCasePathTransformAnim, battCasePathFillColorAnim], fillMode:fillMode)
        battCasePath.addAnimation(battCasePathLessMidChargeAnimationAnim, forKey:"battCasePathLessMidChargeAnimationAnim")
    }
    
    func addReveseAnimateAnimation(){
        addReveseAnimateAnimationCompletionBlock(nil)
    }
    
    func addReveseAnimateAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        addReveseAnimateAnimationReverse(false, completionBlock:completionBlock)
    }
    
    func addReveseAnimateAnimationReverse(reverseAnimation: Bool, completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1
            completionAnim.delegate = self
            completionAnim.setValue("reveseAnimate", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"reveseAnimate")
            if let anim = layer.animationForKey("reveseAnimate"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = reverseAnimation ? kCAFillModeBoth : kCAFillModeForwards
        
        let totalDuration : CFTimeInterval = 1
        
        ////ThirdChargePath animation
        let thirdChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        thirdChargePathFillColorAnim.values   = [self.chargeStopColor.CGColor,
            self.startColor.CGColor]
        thirdChargePathFillColorAnim.keyTimes = [0, 1]
        thirdChargePathFillColorAnim.duration = 1
        
        var thirdChargePathReveseAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([thirdChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ thirdChargePathReveseAnimateAnim = QCMethod.reverseAnimation(thirdChargePathReveseAnimateAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        layers["thirdChargePath"]?.addAnimation(thirdChargePathReveseAnimateAnim, forKey:"thirdChargePathReveseAnimateAnim")
        
        ////SecondChargePath animation
        let secondChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        secondChargePathFillColorAnim.values   = [self.chargeStopColor.CGColor,
            self.startColor.CGColor]
        secondChargePathFillColorAnim.keyTimes = [0, 1]
        secondChargePathFillColorAnim.duration = 1
        
        var secondChargePathReveseAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([secondChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ secondChargePathReveseAnimateAnim = QCMethod.reverseAnimation(secondChargePathReveseAnimateAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        layers["secondChargePath"]?.addAnimation(secondChargePathReveseAnimateAnim, forKey:"secondChargePathReveseAnimateAnim")
        
        ////FirstChargePath animation
        let firstChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        firstChargePathFillColorAnim.values   = [self.caseStopColor.CGColor,
            self.startColor.CGColor]
        firstChargePathFillColorAnim.keyTimes = [0, 1]
        firstChargePathFillColorAnim.duration = 1
        
        var firstChargePathReveseAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([firstChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ firstChargePathReveseAnimateAnim = QCMethod.reverseAnimation(firstChargePathReveseAnimateAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        layers["firstChargePath"]?.addAnimation(firstChargePathReveseAnimateAnim, forKey:"firstChargePathReveseAnimateAnim")
        
        ////PlusChargePath animation
        let plusChargePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        plusChargePathFillColorAnim.values   = [self.chargeStopColor.CGColor,
            self.startColor.CGColor]
        plusChargePathFillColorAnim.keyTimes = [0, 1]
        plusChargePathFillColorAnim.duration = 1
        
        var plusChargePathReveseAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([plusChargePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ plusChargePathReveseAnimateAnim = QCMethod.reverseAnimation(plusChargePathReveseAnimateAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        layers["plusChargePath"]?.addAnimation(plusChargePathReveseAnimateAnim, forKey:"plusChargePathReveseAnimateAnim")
        
        ////BattCasePath animation
        let battCasePathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        battCasePathFillColorAnim.values   = [self.caseReverseColor.CGColor,
            self.startColor.CGColor]
        battCasePathFillColorAnim.keyTimes = [0, 1]
        battCasePathFillColorAnim.duration = 1
        
        var battCasePathReveseAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([battCasePathFillColorAnim], fillMode:fillMode)
        if (reverseAnimation){ battCasePathReveseAnimateAnim = QCMethod.reverseAnimation(battCasePathReveseAnimateAnim, totalDuration:totalDuration) as! CAAnimationGroup}
        layers["battCasePath"]?.addAnimation(battCasePathReveseAnimateAnim, forKey:"battCasePathReveseAnimateAnim")
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
        if identifier == "fullChargeAnimation"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["thirdChargePath"] as! CALayer).animationForKey("thirdChargePathFullChargeAnimationAnim"), theLayer:(layers["thirdChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["secondChargePath"] as! CALayer).animationForKey("secondChargePathFullChargeAnimationAnim"), theLayer:(layers["secondChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["firstChargePath"] as! CALayer).animationForKey("firstChargePathFullChargeAnimationAnim"), theLayer:(layers["firstChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["plusChargePath"] as! CALayer).animationForKey("plusChargePathFullChargeAnimationAnim"), theLayer:(layers["plusChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["battCasePath"] as! CALayer).animationForKey("battCasePathFullChargeAnimationAnim"), theLayer:(layers["battCasePath"] as! CALayer))
        }
        else if identifier == "emptyChargeAnimation"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["battCasePath"] as! CALayer).animationForKey("battCasePathEmptyChargeAnimationAnim"), theLayer:(layers["battCasePath"] as! CALayer))
        }
        else if identifier == "lessFullChargeAnimation"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["thirdChargePath"] as! CALayer).animationForKey("thirdChargePathLessFullChargeAnimationAnim"), theLayer:(layers["thirdChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["secondChargePath"] as! CALayer).animationForKey("secondChargePathLessFullChargeAnimationAnim"), theLayer:(layers["secondChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["firstChargePath"] as! CALayer).animationForKey("firstChargePathLessFullChargeAnimationAnim"), theLayer:(layers["firstChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["plusChargePath"] as! CALayer).animationForKey("plusChargePathLessFullChargeAnimationAnim"), theLayer:(layers["plusChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["battCasePath"] as! CALayer).animationForKey("battCasePathLessFullChargeAnimationAnim"), theLayer:(layers["battCasePath"] as! CALayer))
        }
        else if identifier == "midChargeAnimation"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["thirdChargePath"] as! CALayer).animationForKey("thirdChargePathMidChargeAnimationAnim"), theLayer:(layers["thirdChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["secondChargePath"] as! CALayer).animationForKey("secondChargePathMidChargeAnimationAnim"), theLayer:(layers["secondChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["firstChargePath"] as! CALayer).animationForKey("firstChargePathMidChargeAnimationAnim"), theLayer:(layers["firstChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["plusChargePath"] as! CALayer).animationForKey("plusChargePathMidChargeAnimationAnim"), theLayer:(layers["plusChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["battCasePath"] as! CALayer).animationForKey("battCasePathMidChargeAnimationAnim"), theLayer:(layers["battCasePath"] as! CALayer))
        }
        else if identifier == "lessMidChargeAnimation"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["thirdChargePath"] as! CALayer).animationForKey("thirdChargePathLessMidChargeAnimationAnim"), theLayer:(layers["thirdChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["secondChargePath"] as! CALayer).animationForKey("secondChargePathLessMidChargeAnimationAnim"), theLayer:(layers["secondChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["firstChargePath"] as! CALayer).animationForKey("firstChargePathLessMidChargeAnimationAnim"), theLayer:(layers["firstChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["plusChargePath"] as! CALayer).animationForKey("plusChargePathLessMidChargeAnimationAnim"), theLayer:(layers["plusChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["battCasePath"] as! CALayer).animationForKey("battCasePathLessMidChargeAnimationAnim"), theLayer:(layers["battCasePath"] as! CALayer))
        }
        else if identifier == "reveseAnimate"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["thirdChargePath"] as! CALayer).animationForKey("thirdChargePathReveseAnimateAnim"), theLayer:(layers["thirdChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["secondChargePath"] as! CALayer).animationForKey("secondChargePathReveseAnimateAnim"), theLayer:(layers["secondChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["firstChargePath"] as! CALayer).animationForKey("firstChargePathReveseAnimateAnim"), theLayer:(layers["firstChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["plusChargePath"] as! CALayer).animationForKey("plusChargePathReveseAnimateAnim"), theLayer:(layers["plusChargePath"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["battCasePath"] as! CALayer).animationForKey("battCasePathReveseAnimateAnim"), theLayer:(layers["battCasePath"] as! CALayer))
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String){
        if identifier == "fullChargeAnimation"{
            (layers["thirdChargePath"] as! CALayer).removeAnimationForKey("thirdChargePathFullChargeAnimationAnim")
            (layers["secondChargePath"] as! CALayer).removeAnimationForKey("secondChargePathFullChargeAnimationAnim")
            (layers["firstChargePath"] as! CALayer).removeAnimationForKey("firstChargePathFullChargeAnimationAnim")
            (layers["plusChargePath"] as! CALayer).removeAnimationForKey("plusChargePathFullChargeAnimationAnim")
            (layers["battCasePath"] as! CALayer).removeAnimationForKey("battCasePathFullChargeAnimationAnim")
        }
        else if identifier == "emptyChargeAnimation"{
            (layers["battCasePath"] as! CALayer).removeAnimationForKey("battCasePathEmptyChargeAnimationAnim")
        }
        else if identifier == "lessFullChargeAnimation"{
            (layers["thirdChargePath"] as! CALayer).removeAnimationForKey("thirdChargePathLessFullChargeAnimationAnim")
            (layers["secondChargePath"] as! CALayer).removeAnimationForKey("secondChargePathLessFullChargeAnimationAnim")
            (layers["firstChargePath"] as! CALayer).removeAnimationForKey("firstChargePathLessFullChargeAnimationAnim")
            (layers["plusChargePath"] as! CALayer).removeAnimationForKey("plusChargePathLessFullChargeAnimationAnim")
            (layers["battCasePath"] as! CALayer).removeAnimationForKey("battCasePathLessFullChargeAnimationAnim")
        }
        else if identifier == "midChargeAnimation"{
            (layers["thirdChargePath"] as! CALayer).removeAnimationForKey("thirdChargePathMidChargeAnimationAnim")
            (layers["secondChargePath"] as! CALayer).removeAnimationForKey("secondChargePathMidChargeAnimationAnim")
            (layers["firstChargePath"] as! CALayer).removeAnimationForKey("firstChargePathMidChargeAnimationAnim")
            (layers["plusChargePath"] as! CALayer).removeAnimationForKey("plusChargePathMidChargeAnimationAnim")
            (layers["battCasePath"] as! CALayer).removeAnimationForKey("battCasePathMidChargeAnimationAnim")
        }
        else if identifier == "lessMidChargeAnimation"{
            (layers["thirdChargePath"] as! CALayer).removeAnimationForKey("thirdChargePathLessMidChargeAnimationAnim")
            (layers["secondChargePath"] as! CALayer).removeAnimationForKey("secondChargePathLessMidChargeAnimationAnim")
            (layers["firstChargePath"] as! CALayer).removeAnimationForKey("firstChargePathLessMidChargeAnimationAnim")
            (layers["plusChargePath"] as! CALayer).removeAnimationForKey("plusChargePathLessMidChargeAnimationAnim")
            (layers["battCasePath"] as! CALayer).removeAnimationForKey("battCasePathLessMidChargeAnimationAnim")
        }
        else if identifier == "reveseAnimate"{
            (layers["thirdChargePath"] as! CALayer).removeAnimationForKey("thirdChargePathReveseAnimateAnim")
            (layers["secondChargePath"] as! CALayer).removeAnimationForKey("secondChargePathReveseAnimateAnim")
            (layers["firstChargePath"] as! CALayer).removeAnimationForKey("firstChargePathReveseAnimateAnim")
            (layers["plusChargePath"] as! CALayer).removeAnimationForKey("plusChargePathReveseAnimateAnim")
            (layers["battCasePath"] as! CALayer).removeAnimationForKey("battCasePathReveseAnimateAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func thirdChargePathPathWithBounds(bound: CGRect) -> UIBezierPath{
        let thirdChargePathPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        thirdChargePathPath.moveToPoint(CGPointMake(minX + 0.04808 * w, minY + h))
        thirdChargePathPath.addLineToPoint(CGPointMake(minX + 0.95192 * w, minY + h))
        thirdChargePathPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.86606 * h), controlPoint1:CGPointMake(minX + 0.97847 * w, minY + h), controlPoint2:CGPointMake(minX + w, minY + 0.94001 * h))
        thirdChargePathPath.addLineToPoint(CGPointMake(minX + w, minY + 0.13391 * h))
        thirdChargePathPath.addCurveToPoint(CGPointMake(minX + 0.95192 * w, minY), controlPoint1:CGPointMake(minX + w, minY + 0.05997 * h), controlPoint2:CGPointMake(minX + 0.97849 * w, minY))
        thirdChargePathPath.addLineToPoint(CGPointMake(minX + 0.04808 * w, minY))
        thirdChargePathPath.addCurveToPoint(CGPointMake(minX, minY + 0.13391 * h), controlPoint1:CGPointMake(minX + 0.02153 * w, minY), controlPoint2:CGPointMake(minX, minY + 0.05997 * h))
        thirdChargePathPath.addLineToPoint(CGPointMake(minX, minY + 0.86604 * h))
        thirdChargePathPath.addCurveToPoint(CGPointMake(minX + 0.04808 * w, minY + h), controlPoint1:CGPointMake(minX, minY + 0.94001 * h), controlPoint2:CGPointMake(minX + 0.02154 * w, minY + h))
        thirdChargePathPath.closePath()
        thirdChargePathPath.moveToPoint(CGPointMake(minX + 0.04808 * w, minY + h))
        
        return thirdChargePathPath;
    }
    
    func secondChargePathPathWithBounds(bound: CGRect) -> UIBezierPath{
        let secondChargePathPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        secondChargePathPath.moveToPoint(CGPointMake(minX + 0.04808 * w, minY + h))
        secondChargePathPath.addLineToPoint(CGPointMake(minX + 0.95192 * w, minY + h))
        secondChargePathPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.86606 * h), controlPoint1:CGPointMake(minX + 0.97847 * w, minY + h), controlPoint2:CGPointMake(minX + w, minY + 0.94006 * h))
        secondChargePathPath.addLineToPoint(CGPointMake(minX + w, minY + 0.13394 * h))
        secondChargePathPath.addCurveToPoint(CGPointMake(minX + 0.95192 * w, minY), controlPoint1:CGPointMake(minX + w, minY + 0.05999 * h), controlPoint2:CGPointMake(minX + 0.97849 * w, minY))
        secondChargePathPath.addLineToPoint(CGPointMake(minX + 0.04808 * w, minY))
        secondChargePathPath.addCurveToPoint(CGPointMake(minX, minY + 0.13394 * h), controlPoint1:CGPointMake(minX + 0.02153 * w, minY), controlPoint2:CGPointMake(minX, minY + 0.05997 * h))
        secondChargePathPath.addLineToPoint(CGPointMake(minX, minY + 0.86606 * h))
        secondChargePathPath.addCurveToPoint(CGPointMake(minX + 0.04808 * w, minY + h), controlPoint1:CGPointMake(minX, minY + 0.94003 * h), controlPoint2:CGPointMake(minX + 0.02154 * w, minY + h))
        secondChargePathPath.closePath()
        secondChargePathPath.moveToPoint(CGPointMake(minX + 0.04808 * w, minY + h))
        
        return secondChargePathPath;
    }
    
    func firstChargePathPathWithBounds(bound: CGRect) -> UIBezierPath{
        let firstChargePathPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        firstChargePathPath.moveToPoint(CGPointMake(minX + 0.04808 * w, minY + h))
        firstChargePathPath.addLineToPoint(CGPointMake(minX + 0.95192 * w, minY + h))
        firstChargePathPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.86602 * h), controlPoint1:CGPointMake(minX + 0.97847 * w, minY + h), controlPoint2:CGPointMake(minX + w, minY + 0.94001 * h))
        firstChargePathPath.addLineToPoint(CGPointMake(minX + w, minY + 0.13394 * h))
        firstChargePathPath.addCurveToPoint(CGPointMake(minX + 0.95192 * w, minY), controlPoint1:CGPointMake(minX + w, minY + 0.05999 * h), controlPoint2:CGPointMake(minX + 0.97849 * w, minY))
        firstChargePathPath.addLineToPoint(CGPointMake(minX + 0.04808 * w, minY))
        firstChargePathPath.addCurveToPoint(CGPointMake(minX, minY + 0.13394 * h), controlPoint1:CGPointMake(minX + 0.02153 * w, minY), controlPoint2:CGPointMake(minX, minY + 0.05997 * h))
        firstChargePathPath.addLineToPoint(CGPointMake(minX, minY + 0.86602 * h))
        firstChargePathPath.addCurveToPoint(CGPointMake(minX + 0.04808 * w, minY + h), controlPoint1:CGPointMake(minX, minY + 0.94001 * h), controlPoint2:CGPointMake(minX + 0.02154 * w, minY + h))
        firstChargePathPath.closePath()
        firstChargePathPath.moveToPoint(CGPointMake(minX + 0.04808 * w, minY + h))
        
        return firstChargePathPath;
    }
    
    func plusChargePathPathWithBounds(bound: CGRect) -> UIBezierPath{
        let plusChargePathPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        plusChargePathPath.moveToPoint(CGPointMake(minX + 0.073 * w, minY + 0.65912 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.34088 * w, minY + 0.65912 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.34088 * w, minY + 0.92701 * h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + 0.41388 * w, minY + h), controlPoint1:CGPointMake(minX + 0.34088 * w, minY + 0.96731 * h), controlPoint2:CGPointMake(minX + 0.37356 * w, minY + h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.58614 * w, minY + h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + 0.65914 * w, minY + 0.92701 * h), controlPoint1:CGPointMake(minX + 0.62644 * w, minY + h), controlPoint2:CGPointMake(minX + 0.65914 * w, minY + 0.96731 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.65914 * w, minY + 0.65912 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.927 * w, minY + 0.65912 * h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.58612 * h), controlPoint1:CGPointMake(minX + 0.9673 * w, minY + 0.65912 * h), controlPoint2:CGPointMake(minX + w, minY + 0.62643 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + w, minY + 0.41388 * h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + 0.927 * w, minY + 0.34088 * h), controlPoint1:CGPointMake(minX + w, minY + 0.37357 * h), controlPoint2:CGPointMake(minX + 0.96733 * w, minY + 0.34088 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.65914 * w, minY + 0.34088 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.65914 * w, minY + 0.07299 * h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + 0.58614 * w, minY), controlPoint1:CGPointMake(minX + 0.65914 * w, minY + 0.03269 * h), controlPoint2:CGPointMake(minX + 0.62647 * w, minY))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.41388 * w, minY))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + 0.34088 * w, minY + 0.07299 * h), controlPoint1:CGPointMake(minX + 0.37357 * w, minY), controlPoint2:CGPointMake(minX + 0.34088 * w, minY + 0.03267 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.34088 * w, minY + 0.34088 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX + 0.073 * w, minY + 0.34088 * h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX, minY + 0.41388 * h), controlPoint1:CGPointMake(minX + 0.03268 * w, minY + 0.34088 * h), controlPoint2:CGPointMake(minX, minY + 0.37355 * h))
        plusChargePathPath.addLineToPoint(CGPointMake(minX, minY + 0.58612 * h))
        plusChargePathPath.addCurveToPoint(CGPointMake(minX + 0.073 * w, minY + 0.65912 * h), controlPoint1:CGPointMake(minX + 0.00001 * w, minY + 0.62643 * h), controlPoint2:CGPointMake(minX + 0.0327 * w, minY + 0.65912 * h))
        plusChargePathPath.closePath()
        plusChargePathPath.moveToPoint(CGPointMake(minX + 0.073 * w, minY + 0.65912 * h))
        
        return plusChargePathPath;
    }
    
    func battCasePathPathWithBounds(bound: CGRect) -> UIBezierPath{
        let battCasePathPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        battCasePathPath.moveToPoint(CGPointMake(minX + 0.90909 * w, minY + 0.07852 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.68636 * w, minY + 0.07852 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.68636 * w, minY + 0.02546 * h))
        battCasePathPath.addCurveToPoint(CGPointMake(minX + 0.6409 * w, minY), controlPoint1:CGPointMake(minX + 0.68636 * w, minY + 0.0114 * h), controlPoint2:CGPointMake(minX + 0.66601 * w, minY))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.35909 * w, minY))
        battCasePathPath.addCurveToPoint(CGPointMake(minX + 0.31364 * w, minY + 0.02546 * h), controlPoint1:CGPointMake(minX + 0.33399 * w, minY), controlPoint2:CGPointMake(minX + 0.31364 * w, minY + 0.0114 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.31364 * w, minY + 0.07852 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.09091 * w, minY + 0.07852 * h))
        battCasePathPath.addCurveToPoint(CGPointMake(minX, minY + 0.12943 * h), controlPoint1:CGPointMake(minX + 0.0407 * w, minY + 0.07852 * h), controlPoint2:CGPointMake(minX, minY + 0.10132 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX, minY + 0.94909 * h))
        battCasePathPath.addCurveToPoint(CGPointMake(minX + 0.09091 * w, minY + h), controlPoint1:CGPointMake(minX, minY + 0.9772 * h), controlPoint2:CGPointMake(minX + 0.0407 * w, minY + h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.90909 * w, minY + h))
        battCasePathPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.94909 * h), controlPoint1:CGPointMake(minX + 0.9593 * w, minY + h), controlPoint2:CGPointMake(minX + w, minY + 0.9772 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + w, minY + 0.12943 * h))
        battCasePathPath.addCurveToPoint(CGPointMake(minX + 0.90909 * w, minY + 0.07852 * h), controlPoint1:CGPointMake(minX + 1 * w, minY + 0.10132 * h), controlPoint2:CGPointMake(minX + 0.9593 * w, minY + 0.07852 * h))
        battCasePathPath.closePath()
        battCasePathPath.moveToPoint(CGPointMake(minX + 0.81819 * w, minY + 0.89818 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.18182 * w, minY + 0.89818 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.18182 * w, minY + 0.18034 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.81819 * w, minY + 0.18034 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.81819 * w, minY + 0.89818 * h))
        battCasePathPath.addLineToPoint(CGPointMake(minX + 0.81819 * w, minY + 0.89818 * h))
        battCasePathPath.closePath()
        battCasePathPath.moveToPoint(CGPointMake(minX + 0.81819 * w, minY + 0.89818 * h))
        
        return battCasePathPath;
    }
    
    
}

