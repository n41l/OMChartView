//
//  OMSimplePopoverLayer.swift
//  OMChartView
//
//  Created by HuangKun on 16/6/5.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

enum OMSimplePopoverDirection {
    case Up
    case Down
}

class OMSimplePopoverView: UIView {
    var direction: OMSimplePopoverDirection = .Up
    var isInteractive: Bool = true
    var cornerRadius: CGFloat = 5
    var arrowSize: CGSize = CGSize(width: 12, height: 8)
    var bgColor: UIColor = UIColor.whiteColor()
    
    private var _arrowPosition: CGPoint = CGPointZero
    private var _fromView: UIView!
    private var _contentView: UIView!
    private var _contentLayer: CALayer?
    private var _popoverLayer: CALayer!
    private var _firstDraw: Bool = true
    
    private var setupFinished: Bool = false
    
    func setup(view: UIView, _ fromView: UIView, _ atPosition: CGPoint) -> OMSimplePopoverView {
        _contentView = view
        _fromView = fromView
        _arrowPosition = atPosition
        
        //To handle interactive
        
        let popoverRect = CGRect(x: 0, y: 0, width: _contentView.bounds.width, height: _contentView.bounds.height + arrowSize.height)
        let popoverAnchorPoint = anchorPoint()
        
        let roundRectanglePath = CGPathCreateMutable()
        CGPathAddRoundedRect(roundRectanglePath, nil, _contentView.bounds, cornerRadius, cornerRadius)
        
        let arrowPath = CGPathCreateMutable()
        CGPathMoveToPoint(arrowPath, nil, popoverRect.width * popoverAnchorPoint.x, popoverRect.height * popoverAnchorPoint.y)
        CGPathAddLineToPoint(arrowPath, nil, CGPathGetCurrentPoint(arrowPath).x + arrowSize.width/2, CGPathGetCurrentPoint(arrowPath).y - arrowSize.height)
        CGPathAddLineToPoint(arrowPath, nil, CGPathGetCurrentPoint(arrowPath).x - arrowSize.width, CGPathGetCurrentPoint(arrowPath).y)
        CGPathCloseSubpath(arrowPath)
        CGPathAddPath(roundRectanglePath, nil, arrowPath)
        
        let popoverFill = CAShapeLayer()
        popoverFill.frame = popoverRect
        popoverFill.path = roundRectanglePath
        popoverFill.fillColor = bgColor.CGColor
        popoverFill.strokeColor = bgColor.CGColor
        
        _popoverLayer = popoverFill
        
        self.frame = popoverFill.bounds
        self.layer.anchorPoint = popoverAnchorPoint
        self.layer.position = atPosition
        
        setupFinished = true
        
        return self
    }
    
    func showWithAnimation() {
        guard setupFinished else { fatalError("setup your popover first") }
        
        if _firstDraw {
            self.layer.addSublayer(_popoverLayer)
            self.addSubview(_contentView)
            _fromView.addSubview(self)
            _firstDraw = false
        }
        
        self.transform = CGAffineTransformMakeScale(0.3, 0.3)
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .CurveEaseIn, animations: { 
            self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    func showWithInterativeParameter(delta: CGFloat) {
        guard setupFinished else { fatalError("setup your popover first") }
        if _firstDraw {
            self.layer.addSublayer(_popoverLayer)
            self.addSubview(_contentView)
            _fromView.addSubview(self)
            _firstDraw = false
        }
        
        self.transform = CGAffineTransformMakeScale(min(max(0, delta), 1), min(max(0, delta), 1))

    }
    
    private func anchorPoint() -> CGPoint {
        var x: CGFloat = 0
        var y: CGFloat = 0
        let fSize = _fromView.bounds.size
        let cSize = _contentView.bounds.size
        
        func xOffset(value: CGFloat) -> CGFloat {
            if value < cSize.width/2 {
                return value / cSize.width
            }else {
                return 0.5
            }
        }
        
        if _arrowPosition.x < fSize.width/2 {
            x = xOffset(_arrowPosition.x)
        }else if _arrowPosition.x > fSize.width/2 {
            x = 1 - xOffset(fSize.width - _arrowPosition.x)
        }else {
            x = 0.5
        }
        
        switch direction {
        case .Up:
            y = 1
        case .Down:
            y = 0
        }
        
        return CGPoint(x: x, y: y)
    }
}
