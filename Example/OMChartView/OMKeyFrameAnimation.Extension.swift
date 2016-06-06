//
//  OMKeyFrameAnimation.swift
//  OMFlowingDrawer
//
//  Created by HuangKun on 15/12/2.
//  Copyright © 2015年 HuangKun. All rights reserved.
//

import UIKit

let kDefaultFrameCount: Int = 60

extension CAKeyframeAnimation {
  
  /// Generate a key frame animation object base on the choosen easing func, specifying the key path of the property that you want to animate on the layer.
  ///
  /// - parameter path: The property you want to animate
  /// - parameter f: The choosen easing function
  /// - parameter v1: fromValue
  /// - parameter v2: toValue
  /// - parameter frameCount: key frame count
  private class func animationWithKeyPath(path: String, function f: AnimationFunc, fromValue v1: CGFloat, toValue v2: CGFloat, keyframeCount count: Int) -> CAAnimation {
    var keyFrame = [AnyObject]()
    
    var t: CGFloat = 0.0
    let dt: CGFloat = 1.0 / CGFloat(count - 1)
    
    for _ in 0..<count {
      let value = v1 + f(t: t) * (v2 - v1)
      
      keyFrame.append(NSNumber(float: Float(value)))
      t += dt
    }
    
    let animation = CAKeyframeAnimation(keyPath: path)
    animation.values = keyFrame
    
    return animation
  }
  
  
  /// Generate a key frame animation object base on the choosen easing func, specifying the key path of the property that you want to animate on the layer.
  ///
  /// - parameter path: The property you want to animate
  /// - parameter f: The choosen easing function
  /// - parameter v1: fromValue
  /// - parameter v2: toValue
  class func animationWithKeyPath(path: String, function f: AnimationFunc, fromValue v1: CGFloat, toValue v2: CGFloat) -> CAAnimation {
    return self.animationWithKeyPath(path, function: f, fromValue: v1, toValue: v2)
  }
  
  class func animationWithKeyPath(path: String, function f: AnimationFunc, fromPoint p1: CGPoint, toPoint p2: CGPoint, keyframeCount count: Int) -> CAAnimation {
    
    var keyFrame = [AnyObject]()
    
    var t: CGFloat = 0.0
    let dt: CGFloat = 1.0 / CGFloat(count - 1)
    
    for _ in 0..<count {
      let x: CGFloat = p1.x + f(t: t) * (p2.x - p1.x)
      let y: CGFloat = p1.y + f(t: t) * (p2.y - p2.y)
      
      keyFrame.append(NSValue(CGPoint: CGPoint(x: x, y: y)))
      t += dt
    }
    
    let animation = CAKeyframeAnimation(keyPath: path)
    animation.values = keyFrame
    
    return animation
  }
  
  class func animationWithKeyPath(path: String, function f: AnimationFunc, fromPoint p1: CGPoint, toPoint p2: CGPoint) -> CAAnimation {
    return self.animationWithKeyPath(path, function: f, fromPoint: p1, toPoint: p2, keyframeCount: kDefaultFrameCount)
  }
}
