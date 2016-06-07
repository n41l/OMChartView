//
//  ExampleInteractiveView.swift
//  OMChartView
//
//  Created by HuangKun on 16/6/3.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import OMChartView

protocol ExampleInteractiveViewDelegate {
    func exmapleInteractiveView(view: ExampleInteractiveView, didChangeSelectedIndex index: Int)
}

class ExampleInteractiveView: OMChartInteractiveView {
    var indicatorLine: CALayer?
    var indicatorPoints: [CALayer] = []
    var statisticPopover: OMSimplePopoverView = OMSimplePopoverView()
    var canResponedToGesture: Bool = true
    
    var displayLink: CADisplayLink?
    var addedX: CGFloat = 0
    var remainingDistance: CGFloat = 0
    var currentXOffset: CGFloat = 0
    
    var delegate: ExampleInteractiveViewDelegate?
    
    var popoverPosition: CGPoint = CGPointZero {
        willSet {
            self.statisticPopover.transform = CGAffineTransformIdentity
            
            if newValue != popoverPosition {
//                guard let popoverContentView = popoverContentView else { return }
                statisticPopover.setup(newValue)
            }
        }
    }
    
    lazy var snappingPositionsWithOffset: [CGPoint] = {
        return self.snappingPositions.map { CGPoint(x: $0.x, y: $0.y - 10) }
    }()
    
    private lazy var indicatorImage: UIImage? = {
        return UIImage(named: "statistic_indicator_point")
    }()
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        tap(snappingPositionsWithOffset[(snappingPositionsWithOffset.count - 1) / 2], 0)
    }
    
    override func tap(withLocation: CGPoint, _ count: Int) {
        
        if abs(withLocation.x - popoverPosition.x) < xFragment * 0.5 { return }
        
        var index = Int(round(withLocation.x / xFragment))
        
        
        if index == 0 {
            index = 1
        }
        
        if index == snappingPositionsWithOffset.count {
            index -= 1
        }
        
        popoverPosition = snappingPositionsWithOffset[index - 1]
        currentIndicatroLineLayer(currentOffsets(popoverPosition.x))
        currentIndicatorPointLayers(currentOffsets(popoverPosition.x))
        
        delegate?.exmapleInteractiveView(self, didChangeSelectedIndex: index - 1)
        
        statisticPopover.alpha = 1
        statisticPopover.showWithAnimation()
        
    }
    
    override func panBegan(location: CGPoint, _ velocity: CGPoint, _ currentOffsets: [CGPoint]) {
        
        if popoverPosition == CGPointZero { return }
        
        if abs(location.x - popoverPosition.x) < 30 {
            canResponedToGesture = true
        }else {
            canResponedToGesture = false
        }

    }
    
    override func panChanged(location: CGPoint, _ velocity: CGPoint, _ currentOffsets: [CGPoint]) {
        guard canResponedToGesture else { return }
        
        currentIndicatroLineLayer(currentOffsets)
        currentIndicatorPointLayers(currentOffsets)
        
        if abs(velocity.x) > 500 {
            statisticPopover.transform = CGAffineTransformMakeScale(0.1, 0.1)
            statisticPopover.alpha = 0
            return
        }
        
        let index = Int(round(location.x / xFragment))
        
        guard index != 0 else { return }
        guard index != snappingPositionsWithOffset.count else { return }
        
        popoverPosition = snappingPositionsWithOffset[index - 1]
        
        delegate?.exmapleInteractiveView(self, didChangeSelectedIndex: index - 1)
        
        let distance = abs(location.x - popoverPosition.x)
        
        if distance / xFragment > 0.4 {
            self.statisticPopover.transform = CGAffineTransformMakeScale(0.1, 0.1)
            self.statisticPopover.alpha = 0
            return
        }
        
        let delta = min(max(0, 1 - abs(location.x - popoverPosition.x)/(xFragment)), 1)
        statisticPopover.alpha = delta
        statisticPopover.showWithInterativeParameter(delta)
    }
    
    override func panEnded(location: CGPoint, _ velocity: CGPoint, _ currentOffsets: [CGPoint]) {
        
        guard canResponedToGesture else { return }
        
        if displayLink != nil {
            displayLink?.invalidate()
            displayLink = nil
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(ExampleInteractiveView.drawNewIndicator(_: )))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        addedX = 0
        remainingDistance = 0
        currentXOffset = 0
        
        
        var index = Int(round(location.x / xFragment))
        
        
        if index == 0 {
            index = 1
        }
        
        if index == snappingPositionsWithOffset.count {
            index -= 1
        }
        
        popoverPosition = snappingPositionsWithOffset[index - 1]
        remainingDistance = location.x - popoverPosition.x
        addedX = remainingDistance / 15
        currentXOffset = location.x
        
        delegate?.exmapleInteractiveView(self, didChangeSelectedIndex: index - 1)

        
        if statisticPopover.alpha != 0 {
            self.statisticPopover.transform = CGAffineTransformIdentity
            self.statisticPopover.alpha = 1
            return
        }
        
        statisticPopover.alpha = 1
        statisticPopover.showWithAnimation()
        
        
    }
    
    func drawNewIndicator(sender: CADisplayLink) {
        guard remainingDistance != 0 else { return }
        
        currentIndicatroLineLayer(currentOffsets(currentXOffset))
        currentIndicatorPointLayers(currentOffsets(currentXOffset))
        
        if remainingDistance == 0.1 {
            displayLink?.invalidate()
            displayLink = nil
            return
        }
        
        if abs(remainingDistance) <= abs(addedX) {
            remainingDistance = 0.1
            currentXOffset = popoverPosition.x
            
        }else {
            remainingDistance -= addedX
            currentXOffset -= addedX
        }
        
    }
    
    
    
    private func currentIndicatroLineLayer(withCurrentOffsets: [CGPoint]) {
        
        indicatorLine?.removeFromSuperlayer()
        indicatorLine = nil

        let path = CGPathCreateMutable()
        
        for (index, offset) in withCurrentOffsets.enumerate() {
            if index == 0 {
                CGPathMoveToPoint(path, nil, offset.x, offset.y)
            }else {
                CGPathAddLineToPoint(path, nil, offset.x, offset.y)
            }
        }
        
        let layer = CAShapeLayer()
        layer.path = path
        layer.strokeColor = UIColor(white: 1, alpha: 0.58).CGColor
        layer.lineWidth = 2
        
        indicatorLine = layer
        
        self.layer.addSublayer(indicatorLine!)
        
    }
    
    private func currentIndicatorPointLayers(withCurrentOffsets: [CGPoint]) {
        
        guard let image = indicatorImage else { return }
        
        for point in indicatorPoints {
            point.removeFromSuperlayer()
        }
        indicatorPoints.removeAll()
        
        for item in withCurrentOffsets {
            let layer = CALayer()
            layer.frame = CGRect(origin: CGPointZero, size: image.size)
            layer.position = item
            layer.contents = image.CGImage
            layer.zPosition = 10
            self.indicatorPoints.append(layer)
            self.layer.addSublayer(layer)
        }
    }
    
    private func snapIndicator() {
//        snappingPositions
    }
    
}
