//
//  OMKeyFrameAnimation.Function.swift
//  OMFlowingDrawer
//
//  Created by HuangKun on 15/12/4.
//  Copyright © 2015年 HuangKun. All rights reserved.
//

import UIKit

typealias AnimationFunc = (t: CGFloat) -> CGFloat

struct OMAnimationFuntion {
  
  /// Modeled after the line y = x
  static var Liner: AnimationFunc = { t in t }
  
  /// Modeled after the parabola y = x^2
  static var QuadraticEaseIn: AnimationFunc = { t in t * t }
  
  /// Modeled after the parabola y = -x^2 + 2x
  static var QuadraticEaseOut: AnimationFunc = { t in -(t * (t - 2)) }
  
  /// Modeled after the piecewise quadratic
  /// y = (1/2)((2x)^2)            ;  [0, 0.5)
  /// y = -(1/2)((2x-1)*(2x-3) - 1);  [0.5, 1]
  static var QuadraticEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 2 * t * t
    }else {
      return -2 * t * t + 4 * t - 1
    }
  }
  
  /// Modeled after the cubic y = x^3
  static var CubicEaseIn: AnimationFunc = { t in t * t * t }
  
  /// Modeled after the cubic y = (x - 1)^3 + 1
  static var CubicEaseOut: AnimationFunc = { t in
    let delta = t - 1
    return delta * delta * delta + 1
  }
  
  /// Modeled after the piecewise cubic
  /// y = (1/2)((2x)^3)      ;  [0, 0.5)
  /// y = (1/2)((2x-2)^3 + 2);  [0.5, 1]
  static var CubicEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 4 * t * t * t
    }else {
      let delta = ((2 * t) - 2)
      return 0.5 * t * t * t + 1
    }
  }
  
  /// Modeled after the quartic x^4
  static var QuarticEaseIn: AnimationFunc = { t in t * t * t * t }
  
  /// Modeled after the quartic y = 1 - (x - 1)^4
  static var QuarticEaseOut: AnimationFunc = { t in
    let delta = t - 1
    return delta * delta * delta * (1 - t) + 1
  }
  
  /// Modeled after the piecewise quartic
  /// y = (1/2)((2x)^4)       ;  [0, 0.5)
  /// y = -(1/2)((2x-2)^4 - 2);  [0.5, 1]
  static var QuarticEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 8 * t * t * t * t
    }else {
      let delta = t - 1
      return -8 * delta * delta * delta * delta + 1
    }
  }
  
  /// Modeled after the quintic y = x^5
  static var QuinticEaseIn: AnimationFunc = { t in t * t * t * t * t }
  
  // Modeled after the quintic y = (x - 1)^5 + 1
  static var QuinticEaseOut: AnimationFunc = { t in
    let delta = t - 1
    return delta * delta * delta * delta * delta + 1
  }
  
  /// Modeled after the piecewise quintic
  /// y = (1/2)((2x)^5)      ;  [0, 0.5)
  /// y = (1/2)((2x-2)^5 + 2);  [0.5, 1]
  static var QuinticEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 16 * t * t * t * t * t
    }else {
      let delta = ((2 * t) - 2)
      return 0.5 * t * t * t * t * t + 1
    }
  }
  
  /// Modeled after quarter-cycle of sine wave
  static var SineEaseIn: AnimationFunc = { t in sin((t - 1) * CGFloat(M_PI_2)) + 1 }
  
  /// Modeled after quarter-cycle of sine wave (different phase)
  static var SineEaseOut: AnimationFunc = { t in sin(t * CGFloat(M_PI_2)) }
  
  /// Modeled after half sine wave
  static var SineEaseInOut: AnimationFunc = { t in 0.5 * (1 - cos(t * CGFloat(M_PI_2))) }
  
  /// Modeled after shifted quadrant IV of unit circle
  static var CircularEaseIn: AnimationFunc = { t in 1 - sqrt(1 - (t * t)) }
  
  /// Modeled after shifted quadrant II of unit circle
  static var CircularEaseOut: AnimationFunc = { t in sqrt((2 - t) * t) }
  
  /// Modeled after the piecewise circular function
  /// y = (1/2)(1 - sqrt(1 - 4x^2))          ;  [0, 0.5)
  /// y = (1/2)(sqrt(-(2x - 3)*(2x - 1)) + 1);  [0.5, 1]
  static var CircularEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 0.5 * (1 - sqrt(1 - 4 * (t * t)))
    }else {
      return 0.5 * (sqrt(-((2 * t) - 3) * ((2 * t) - 1)) + 1)
    }
  }
  
  /// Modeled after the exponential function y = 2^(10(x - 1))
  static var ExponentialEaseIn: AnimationFunc = { t in t == 0.0 ? t : pow(2, 10 * (t - 1)) }
  
  /// Modeled after the exponential function y = -2^(-10x) + 1
  static var ExponentialEaseOut: AnimationFunc = { t in t == 1.0 ? t : pow(2, -10 * t) }
  
  /// Modeled after the piecewise exponential
  /// y = (1/2)2^(10(2x - 1))        ;  [0, 0.5)
  /// y = -(1/2)*2^(-10(2x - 1))) + 1;  [0.5, 1]
  static var ExponentialEaseInOut: AnimationFunc = { t in
    if t == 0.0 || t == 1.0 {
      return t
    }
    
    if t < 0.5 {
      return 0.5 * pow(2, 20 * t - 10)
    }else {
      return -0.5 * pow(2, (-20 * t) + 10)  + 1
    }
  }
  
  /// Modeled after the damped sine wave y = sin(13pi/2*x)*pow(2, 10 * (x - 1))
  static var ElasticEaseIn: AnimationFunc = { t in
    sin(13 * CGFloat(M_PI_2) * t) * pow(2, 10 * (t - 1))
  }
  
  /// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
  static var ElasticEaseOut: AnimationFunc = { t in
    sin(-13 * CGFloat(M_PI_2) * (t + 1)) * pow(2, -10 * t) + 1
  }
  
  /// Modeled after the piecewise exponentially-damped sine wave:
  /// y = (1/2)*sin(13pi/2*(2*x))*pow(2, 10 * ((2*x) - 1))     ;  [0, 0.5)
  /// y = (1/2)*(sin(-13pi/2*((2x-1)+1))*pow(2,-10(2*x-1)) + 2);  [0.5, 1]
  static var ElasticEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 0.5 * sin(13 * CGFloat(M_PI_2) * 2 * t) * pow(2, 10 * ((2 * t) - 1))
    }else {
      return 0.5 * (sin(-13 * CGFloat(M_PI_2) * ((2 * t - 1) + 1)) * pow(2, -10 * (2 * t - 1)) + 2)
    }
  }
  
  /// Modeled after the overshooting cubic y = x^3-x*sin(x*pi)
  static var BackEaseIn: AnimationFunc = { t in t * t * t - t * sin(t * CGFloat(M_PI)) }
  
  /// Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*sin((1-x)*pi))
  static var BackEaseOut: AnimationFunc = { t in
    let delta = 1 - t
    return 1 - (delta * delta * delta - delta * sin(delta * CGFloat(M_PI)))
  }
  
  /// Modeled after the piecewise overshooting cubic function:
  /// y = (1/2)*((2x)^3-(2x)*sin(2*x*pi))          ;  [0, 0.5)
  /// y = (1/2)*(1-((1-x)^3-(1-x)*sin((1-x)*pi))+1);  [0.5, 1]
  static var BackEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      let delta = 2 * t
      return 0.5 * (delta * delta * delta - delta * sin(delta * CGFloat(M_PI)))
    }else {
      let delta = 1 - (2 * t - 1)
      let temp1 = delta * delta * delta
      let temp2 = sin(delta * CGFloat(M_PI))
      return 0.5 * (1 - (temp1 - delta * temp2)) + 0.5
    }
  }
  
  static var BounceEaseOut: AnimationFunc = { t in
    if t < 4/11.0 {
      return (121 * t * t)/16.0
    }else if t < 8/11.0 {
      return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0
    }else if t < 9/10.0 {
      return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0
    }else {
      return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
    }
  }
  
  static var BounceEaseIn: AnimationFunc = { t in 1 - OMAnimationFuntion.BounceEaseOut(t: t) }
  
  static var BounceEaseInOut: AnimationFunc = { t in
    if t < 0.5 {
      return 0.5 * OMAnimationFuntion.BounceEaseIn(t: t * 2)
    }else {
      return 0.5 * OMAnimationFuntion.BounceEaseOut(t: t * 2 - 1) + 0.5
    }
  }
}
