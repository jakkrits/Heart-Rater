//
//  WatchIcon.swift
//  PolarH7 Heart-Rater
//
//  Created by Jakkrits on 10/23/2558 BE.
//  Copyright © 2558 AppIllus. All rights reserved.


import UIKit

@IBDesignable
class WatchIcon: UIView {
    
    var layers : Dictionary<String, AnyObject> = [:]
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var updateLayerValueForCompletedAnimation : Bool = false
    
    var fillColor : UIColor!
    var startFillColor : UIColor!
    var finishColor : UIColor!
    
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
        self.fillColor      = ThemeColor.WhiteColor
        self.startFillColor = ThemeColor.WhiteColor
        self.finishColor    = ThemeColor.GreenColor
    }
    
    func setupLayers(){
        let watchPath = CAShapeLayer()
        self.layer.addSublayer(watchPath)
        layers["watchPath"] = watchPath
        
        resetLayerPropertiesForLayerIdentifiers(nil)
        setupLayerFrames()
    }
    
    func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if layerIds == nil || layerIds.contains("watchPath"){
            let watchPath = layers["watchPath"] as! CAShapeLayer
            watchPath.fillColor   = self.startFillColor.CGColor
            watchPath.strokeColor = UIColor.blackColor().CGColor
            watchPath.lineWidth   = 0.8
        }
        
        CATransaction.commit()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let watchPath : CAShapeLayer = layers["watchPath"] as? CAShapeLayer{
            watchPath.frame = CGRectMake(0.12253 * watchPath.superlayer!.bounds.width, 0.12253 * watchPath.superlayer!.bounds.height, 0.75493 * watchPath.superlayer!.bounds.width, 0.75493 * watchPath.superlayer!.bounds.height)
            watchPath.path  = watchPathPathWithBounds((layers["watchPath"] as! CAShapeLayer).bounds).CGPath;
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addConnectingAnimationAnimation(){
        addConnectingAnimationAnimationCompletionBlock(nil)
    }
    
    func addConnectingAnimationAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1.776
            completionAnim.delegate = self
            completionAnim.setValue("connectingAnimation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"connectingAnimation")
            if let anim = layer.animationForKey("connectingAnimation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = kCAFillModeForwards
        
        ////WatchPath animation
        let watchPathStrokeColorAnim      = CAKeyframeAnimation(keyPath:"strokeColor")
        watchPathStrokeColorAnim.values   = [self.startFillColor.CGColor,
            self.finishColor.CGColor]
        watchPathStrokeColorAnim.keyTimes = [0, 1]
        watchPathStrokeColorAnim.duration = 1
        watchPathStrokeColorAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        let watchPathFillColorAnim       = CAKeyframeAnimation(keyPath:"fillColor")
        watchPathFillColorAnim.values    = [UIColor(red:0.724, green: 0.85, blue:0.964, alpha:1).CGColor,
            self.finishColor.CGColor]
        watchPathFillColorAnim.keyTimes  = [0, 1]
        watchPathFillColorAnim.duration  = 1.34
        watchPathFillColorAnim.beginTime = 0.439
        
        let watchPathStrokeEndAnim      = CAKeyframeAnimation(keyPath:"strokeEnd")
        watchPathStrokeEndAnim.values   = [1, 0]
        watchPathStrokeEndAnim.keyTimes = [0, 1]
        watchPathStrokeEndAnim.duration = 1
        
        let watchPathConnectingAnimationAnim : CAAnimationGroup = QCMethod.groupAnimations([watchPathStrokeColorAnim, watchPathFillColorAnim, watchPathStrokeEndAnim], fillMode:fillMode)
        layers["watchPath"]?.addAnimation(watchPathConnectingAnimationAnim, forKey:"watchPathConnectingAnimationAnim")
    }
    
    func addReveseAnimateAnimation(){
        addReveseAnimateAnimationCompletionBlock(nil)
    }
    
    func addReveseAnimateAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
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
        
        let fillMode : String = kCAFillModeForwards
        
        ////WatchPath animation
        let watchPathStrokeEndAnim      = CAKeyframeAnimation(keyPath:"strokeEnd")
        watchPathStrokeEndAnim.values   = [1, 0]
        watchPathStrokeEndAnim.keyTimes = [0, 1]
        watchPathStrokeEndAnim.duration = 1
        
        let watchPathFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        watchPathFillColorAnim.values   = [self.finishColor.CGColor,
            self.startFillColor.CGColor]
        watchPathFillColorAnim.keyTimes = [0, 1]
        watchPathFillColorAnim.duration = 1
        
        let watchPathReveseAnimateAnim : CAAnimationGroup = QCMethod.groupAnimations([watchPathStrokeEndAnim, watchPathFillColorAnim], fillMode:fillMode)
        layers["watchPath"]?.addAnimation(watchPathReveseAnimateAnim, forKey:"watchPathReveseAnimateAnim")
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
        if identifier == "connectingAnimation"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["watchPath"] as! CALayer).animationForKey("watchPathConnectingAnimationAnim"), theLayer:(layers["watchPath"] as! CALayer))
        }
        else if identifier == "reveseAnimate"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["watchPath"] as! CALayer).animationForKey("watchPathReveseAnimateAnim"), theLayer:(layers["watchPath"] as! CALayer))
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String){
        if identifier == "connectingAnimation"{
            (layers["watchPath"] as! CALayer).removeAnimationForKey("watchPathConnectingAnimationAnim")
        }
        else if identifier == "reveseAnimate"{
            (layers["watchPath"] as! CALayer).removeAnimationForKey("watchPathReveseAnimateAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func watchPathPathWithBounds(bound: CGRect) -> UIBezierPath{
        let watchPathPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        watchPathPath.moveToPoint(CGPointMake(minX + 0.65176 * w, minY + 0.34824 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.34824 * w, minY + 0.34824 * h), controlPoint1:CGPointMake(minX + 0.56794 * w, minY + 0.26443 * h), controlPoint2:CGPointMake(minX + 0.43205 * w, minY + 0.26443 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.34824 * w, minY + 0.65175 * h), controlPoint1:CGPointMake(minX + 0.26443 * w, minY + 0.43205 * h), controlPoint2:CGPointMake(minX + 0.26443 * w, minY + 0.56794 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.65176 * w, minY + 0.65175 * h), controlPoint1:CGPointMake(minX + 0.43205 * w, minY + 0.73557 * h), controlPoint2:CGPointMake(minX + 0.56794 * w, minY + 0.73557 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.65176 * w, minY + 0.34824 * h), controlPoint1:CGPointMake(minX + 0.73557 * w, minY + 0.56794 * h), controlPoint2:CGPointMake(minX + 0.73557 * w, minY + 0.43206 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.57556 * w, minY + 0.39864 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.60507 * w, minY + 0.36913 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.63087 * w, minY + 0.36913 * h), controlPoint1:CGPointMake(minX + 0.61219 * w, minY + 0.362 * h), controlPoint2:CGPointMake(minX + 0.62376 * w, minY + 0.362 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.63087 * w, minY + 0.39493 * h), controlPoint1:CGPointMake(minX + 0.638 * w, minY + 0.37626 * h), controlPoint2:CGPointMake(minX + 0.638 * w, minY + 0.38781 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.60136 * w, minY + 0.42444 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.58846 * w, minY + 0.42979 * h), controlPoint1:CGPointMake(minX + 0.5978 * w, minY + 0.42801 * h), controlPoint2:CGPointMake(minX + 0.59312 * w, minY + 0.42979 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.57556 * w, minY + 0.42444 * h), controlPoint1:CGPointMake(minX + 0.58379 * w, minY + 0.42979 * h), controlPoint2:CGPointMake(minX + 0.57911 * w, minY + 0.428 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.57556 * w, minY + 0.39864 * h), controlPoint1:CGPointMake(minX + 0.56843 * w, minY + 0.41732 * h), controlPoint2:CGPointMake(minX + 0.56843 * w, minY + 0.40577 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.42445 * w, minY + 0.60136 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.39493 * w, minY + 0.63087 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.38203 * w, minY + 0.63622 * h), controlPoint1:CGPointMake(minX + 0.39137 * w, minY + 0.63444 * h), controlPoint2:CGPointMake(minX + 0.3867 * w, minY + 0.63622 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.36913 * w, minY + 0.63087 * h), controlPoint1:CGPointMake(minX + 0.37736 * w, minY + 0.63622 * h), controlPoint2:CGPointMake(minX + 0.37269 * w, minY + 0.63443 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.36913 * w, minY + 0.60507 * h), controlPoint1:CGPointMake(minX + 0.362 * w, minY + 0.62374 * h), controlPoint2:CGPointMake(minX + 0.362 * w, minY + 0.61219 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.39864 * w, minY + 0.57556 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.42445 * w, minY + 0.57556 * h), controlPoint1:CGPointMake(minX + 0.40577 * w, minY + 0.56843 * h), controlPoint2:CGPointMake(minX + 0.41733 * w, minY + 0.56843 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.42445 * w, minY + 0.60136 * h), controlPoint1:CGPointMake(minX + 0.43157 * w, minY + 0.58268 * h), controlPoint2:CGPointMake(minX + 0.43157 * w, minY + 0.59423 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.42445 * w, minY + 0.42445 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.41155 * w, minY + 0.42979 * h), controlPoint1:CGPointMake(minX + 0.42089 * w, minY + 0.42801 * h), controlPoint2:CGPointMake(minX + 0.41621 * w, minY + 0.42979 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.39864 * w, minY + 0.42445 * h), controlPoint1:CGPointMake(minX + 0.40688 * w, minY + 0.42979 * h), controlPoint2:CGPointMake(minX + 0.4022 * w, minY + 0.42801 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.36913 * w, minY + 0.39494 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.36913 * w, minY + 0.36913 * h), controlPoint1:CGPointMake(minX + 0.362 * w, minY + 0.38781 * h), controlPoint2:CGPointMake(minX + 0.362 * w, minY + 0.37626 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.39493 * w, minY + 0.36913 * h), controlPoint1:CGPointMake(minX + 0.37625 * w, minY + 0.362 * h), controlPoint2:CGPointMake(minX + 0.38782 * w, minY + 0.362 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.42445 * w, minY + 0.39864 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.42445 * w, minY + 0.42445 * h), controlPoint1:CGPointMake(minX + 0.43157 * w, minY + 0.40577 * h), controlPoint2:CGPointMake(minX + 0.43157 * w, minY + 0.41732 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.63087 * w, minY + 0.63087 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.61797 * w, minY + 0.63621 * h), controlPoint1:CGPointMake(minX + 0.62731 * w, minY + 0.63443 * h), controlPoint2:CGPointMake(minX + 0.62264 * w, minY + 0.63621 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.60507 * w, minY + 0.63087 * h), controlPoint1:CGPointMake(minX + 0.6133 * w, minY + 0.63621 * h), controlPoint2:CGPointMake(minX + 0.60863 * w, minY + 0.63443 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.57556 * w, minY + 0.60136 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.57556 * w, minY + 0.57555 * h), controlPoint1:CGPointMake(minX + 0.56843 * w, minY + 0.59423 * h), controlPoint2:CGPointMake(minX + 0.56843 * w, minY + 0.58268 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.60136 * w, minY + 0.57555 * h), controlPoint1:CGPointMake(minX + 0.58268 * w, minY + 0.56843 * h), controlPoint2:CGPointMake(minX + 0.59424 * w, minY + 0.56843 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.63087 * w, minY + 0.60506 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.63087 * w, minY + 0.63087 * h), controlPoint1:CGPointMake(minX + 0.638 * w, minY + 0.61219 * h), controlPoint2:CGPointMake(minX + 0.638 * w, minY + 0.62374 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.66445 * w, minY + 0.50066 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.53185 * w, minY + 0.51493 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.52496 * w, minY + 0.52496 * h), controlPoint1:CGPointMake(minX + 0.53022 * w, minY + 0.51856 * h), controlPoint2:CGPointMake(minX + 0.52795 * w, minY + 0.52198 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.47717 * w, minY + 0.52496 * h), controlPoint1:CGPointMake(minX + 0.51176 * w, minY + 0.53816 * h), controlPoint2:CGPointMake(minX + 0.49036 * w, minY + 0.53816 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.47717 * w, minY + 0.47716 * h), controlPoint1:CGPointMake(minX + 0.46396 * w, minY + 0.51176 * h), controlPoint2:CGPointMake(minX + 0.46396 * w, minY + 0.49036 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.4781 * w, minY + 0.47632 * h), controlPoint1:CGPointMake(minX + 0.47747 * w, minY + 0.47686 * h), controlPoint2:CGPointMake(minX + 0.47779 * w, minY + 0.4766 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.464 * w, minY + 0.37981 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.47942 * w, minY + 0.35911 * h), controlPoint1:CGPointMake(minX + 0.46254 * w, minY + 0.36984 * h), controlPoint2:CGPointMake(minX + 0.46944 * w, minY + 0.36057 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.50011 * w, minY + 0.37453 * h), controlPoint1:CGPointMake(minX + 0.48936 * w, minY + 0.35766 * h), controlPoint2:CGPointMake(minX + 0.49866 * w, minY + 0.36456 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.51404 * w, minY + 0.46986 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.52496 * w, minY + 0.47716 * h), controlPoint1:CGPointMake(minX + 0.51801 * w, minY + 0.47151 * h), controlPoint2:CGPointMake(minX + 0.52173 * w, minY + 0.47393 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.52645 * w, minY + 0.4788 * h), controlPoint1:CGPointMake(minX + 0.52549 * w, minY + 0.47769 * h), controlPoint2:CGPointMake(minX + 0.52596 * w, minY + 0.47825 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.66055 * w, minY + 0.46437 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.68065 * w, minY + 0.48056 * h), controlPoint1:CGPointMake(minX + 0.67061 * w, minY + 0.46331 * h), controlPoint2:CGPointMake(minX + 0.67957 * w, minY + 0.47055 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.66445 * w, minY + 0.50066 * h), controlPoint1:CGPointMake(minX + 0.68172 * w, minY + 0.49058 * h), controlPoint2:CGPointMake(minX + 0.67447 * w, minY + 0.49958 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.989 * w, minY + 0.15405 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.84596 * w, minY + 0.01101 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.79855 * w, minY + 0.00631 * h), controlPoint1:CGPointMake(minX + 0.83329 * w, minY + -0.00166 * h), controlPoint2:CGPointMake(minX + 0.81345 * w, minY + -0.00362 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.613 * w, minY + 0.13001 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.60728 * w, minY + 0.18783 * h), controlPoint1:CGPointMake(minX + 0.59328 * w, minY + 0.14316 * h), controlPoint2:CGPointMake(minX + 0.59051 * w, minY + 0.17107 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.60836 * w, minY + 0.18892 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.56978 * w, minY + 0.22751 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.5039 * w, minY + 0.21968 * h), controlPoint1:CGPointMake(minX + 0.54848 * w, minY + 0.22237 * h), controlPoint2:CGPointMake(minX + 0.52641 * w, minY + 0.21968 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.30317 * w, minY + 0.30316 * h), controlPoint1:CGPointMake(minX + 0.42829 * w, minY + 0.21968 * h), controlPoint2:CGPointMake(minX + 0.357 * w, minY + 0.24933 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.22763 * w, minY + 0.56965 * h), controlPoint1:CGPointMake(minX + 0.23069 * w, minY + 0.37564 * h), controlPoint2:CGPointMake(minX + 0.20543 * w, minY + 0.47752 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.18892 * w, minY + 0.60836 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.18783 * w, minY + 0.60728 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.13001 * w, minY + 0.613 * h), controlPoint1:CGPointMake(minX + 0.17107 * w, minY + 0.59051 * h), controlPoint2:CGPointMake(minX + 0.14316 * w, minY + 0.59328 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.00631 * w, minY + 0.79855 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.01101 * w, minY + 0.84595 * h), controlPoint1:CGPointMake(minX + -0.00362 * w, minY + 0.81345 * h), controlPoint2:CGPointMake(minX + -0.00166 * w, minY + 0.83329 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.15405 * w, minY + 0.98899 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.20145 * w, minY + 0.99369 * h), controlPoint1:CGPointMake(minX + 0.16671 * w, minY + 1.00166 * h), controlPoint2:CGPointMake(minX + 0.18655 * w, minY + 1.00362 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.387 * w, minY + 0.86999 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.39272 * w, minY + 0.81217 * h), controlPoint1:CGPointMake(minX + 0.40672 * w, minY + 0.85684 * h), controlPoint2:CGPointMake(minX + 0.40949 * w, minY + 0.82893 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.39164 * w, minY + 0.81108 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.43023 * w, minY + 0.7725 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.49611 * w, minY + 0.78032 * h), controlPoint1:CGPointMake(minX + 0.45152 * w, minY + 0.77764 * h), controlPoint2:CGPointMake(minX + 0.4736 * w, minY + 0.78032 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.69684 * w, minY + 0.69684 * h), controlPoint1:CGPointMake(minX + 0.57172 * w, minY + 0.78032 * h), controlPoint2:CGPointMake(minX + 0.64301 * w, minY + 0.75067 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.77238 * w, minY + 0.43035 * h), controlPoint1:CGPointMake(minX + 0.76932 * w, minY + 0.62436 * h), controlPoint2:CGPointMake(minX + 0.79457 * w, minY + 0.52248 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.81109 * w, minY + 0.39164 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.81217 * w, minY + 0.39273 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.87 * w, minY + 0.387 * h), controlPoint1:CGPointMake(minX + 0.82894 * w, minY + 0.40949 * h), controlPoint2:CGPointMake(minX + 0.85684 * w, minY + 0.40673 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.99369 * w, minY + 0.20146 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.989 * w, minY + 0.15405 * h), controlPoint1:CGPointMake(minX + 1.00362 * w, minY + 0.18655 * h), controlPoint2:CGPointMake(minX + 1.00166 * w, minY + 0.16671 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.36583 * w, minY + 0.78527 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.21473 * w, minY + 0.63417 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.24018 * w, minY + 0.60871 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.30042 * w, minY + 0.69958 * h), controlPoint1:CGPointMake(minX + 0.25361 * w, minY + 0.64184 * h), controlPoint2:CGPointMake(minX + 0.27366 * w, minY + 0.67282 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.39118 * w, minY + 0.75993 * h), controlPoint1:CGPointMake(minX + 0.32676 * w, minY + 0.72592 * h), controlPoint2:CGPointMake(minX + 0.35758 * w, minY + 0.74625 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.36583 * w, minY + 0.78527 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.67103 * w, minY + 0.67103 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.49611 * w, minY + 0.74382 * h), controlPoint1:CGPointMake(minX + 0.62409 * w, minY + 0.71797 * h), controlPoint2:CGPointMake(minX + 0.56197 * w, minY + 0.74382 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.32622 * w, minY + 0.67378 * h), controlPoint1:CGPointMake(minX + 0.43173 * w, minY + 0.74382 * h), controlPoint2:CGPointMake(minX + 0.37139 * w, minY + 0.71895 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.32897 * w, minY + 0.32897 * h), controlPoint1:CGPointMake(minX + 0.23192 * w, minY + 0.57947 * h), controlPoint2:CGPointMake(minX + 0.23315 * w, minY + 0.42479 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.5039 * w, minY + 0.25618 * h), controlPoint1:CGPointMake(minX + 0.37591 * w, minY + 0.28203 * h), controlPoint2:CGPointMake(minX + 0.43803 * w, minY + 0.25618 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.67378 * w, minY + 0.32622 * h), controlPoint1:CGPointMake(minX + 0.56827 * w, minY + 0.25618 * h), controlPoint2:CGPointMake(minX + 0.62861 * w, minY + 0.28106 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.67103 * w, minY + 0.67103 * h), controlPoint1:CGPointMake(minX + 0.76808 * w, minY + 0.42053 * h), controlPoint2:CGPointMake(minX + 0.76685 * w, minY + 0.57521 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.75982 * w, minY + 0.39129 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.69958 * w, minY + 0.30042 * h), controlPoint1:CGPointMake(minX + 0.74639 * w, minY + 0.35816 * h), controlPoint2:CGPointMake(minX + 0.72634 * w, minY + 0.32718 * h))
        watchPathPath.addCurveToPoint(CGPointMake(minX + 0.60882 * w, minY + 0.24007 * h), controlPoint1:CGPointMake(minX + 0.67324 * w, minY + 0.27408 * h), controlPoint2:CGPointMake(minX + 0.64243 * w, minY + 0.25375 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.63417 * w, minY + 0.21472 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.78528 * w, minY + 0.36583 * h))
        watchPathPath.addLineToPoint(CGPointMake(minX + 0.75982 * w, minY + 0.39129 * h))
        watchPathPath.closePath()
        watchPathPath.moveToPoint(CGPointMake(minX + 0.75982 * w, minY + 0.39129 * h))
        
        return watchPathPath;
    }
    
    
}
