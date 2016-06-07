//
//  StatisticWeekXView.swift
//  OMChartView
//
//  Created by HuangKun on 16/6/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class StatisticXView: UIView, ExampleInteractiveViewDelegate {
    var currentIndex: Int {
        didSet {
            if currentIndex != oldValue {
                lastIndex = oldValue
                blink()
            }
        }
    }
    var lastIndex: Int
    
    private var _allXOffsets: [CGFloat] = []
    private var _allLabels: [UILabel] = []
    private var _allTitles: [String] = []
    private let _count: Int
    
    init(frame: CGRect, andTitles: [String]) {
        _count = andTitles.count
        _allTitles = andTitles
        currentIndex = _count / 2
        lastIndex = currentIndex
        super.init(frame: frame)
        
        setupLabels()
        blink()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        _count = 0
        currentIndex = 0
        lastIndex = 0
        super.init(coder: aDecoder)
    }
    
    private func setupLabels() {
        let xFragment = self.frame.width / CGFloat(_count + 1)
        for i in 1..._count {
            _allXOffsets.append(CGFloat(i) * xFragment)
            let label = UILabel()
            label.text = _allTitles[i - 1]
            label.font = UIFont.boldSystemFontOfSize(10)
            label.textColor = UIColor.whiteColor()
            label.alpha = 0.5
            label.sizeToFit()
            label.layer.anchorPoint = CGPoint(x: 0.5, y: 0.3)
            label.layer.position = CGPoint(x: _allXOffsets[i - 1], y: self.bounds.height / 2)
            self.addSubview(label)
            _allLabels.append(label)
        }
    }
    
    func blink() {
        _allLabels[lastIndex].alpha = 0.5
        _allLabels[currentIndex].alpha = 1.0
    }
    
    func exmapleInteractiveView(view: ExampleInteractiveView, didChangeSelectedIndex index: Int) {
        self.currentIndex = index
    }
}
