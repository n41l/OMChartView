//
//  StatisticContentView.swift
//  OMChartView
//
//  Created by HuangKun on 16/6/6.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class StatisticContentView: UIView {
    let gridCount: UILabel = UILabel()
    let gridTitle: UILabel = UILabel()
    
    let characterCount: UILabel = UILabel()
    let characterTitle: UILabel = UILabel()
    
    var allGridsAndCharacters: [[CGFloat]] = []
    
    var currentIndex: Int {        
        didSet {
            if currentIndex != oldValue {
                redraw()
            }
        }
    }
    
    var allLabels: [UILabel]
    
    init(withAllGridsAndCharacters: [[CGFloat]]) {
        
        allGridsAndCharacters = withAllGridsAndCharacters
        currentIndex = Int(allGridsAndCharacters.count / 2)
        
        
        gridCount.text = String(allGridsAndCharacters.first![currentIndex])
        characterCount.text = String(allGridsAndCharacters.last![currentIndex])
        
        gridTitle.text = "Grids"
        characterTitle.text = "Characters"
        
        allLabels = [gridCount, characterCount, gridTitle, characterTitle]
        
        super.init(frame: CGRect(x: 0, y: 0, width: 90, height: 80))
        
        setupLabels()

    }
    
    required init?(coder aDecoder: NSCoder) {
        allLabels = [gridCount, characterCount, gridTitle, characterTitle]
        currentIndex = 0
        super.init(coder: aDecoder)
    }
    
    private func setupLabels() {
        
        let fragment: CGFloat = 1
        
        for label in [gridCount, characterCount] {
            label.font = UIFont.systemFontOfSize(18)
            label.textColor = UIColor(red:0.27, green:0.82, blue:0.79, alpha:1)
            label.sizeToFit()
        }
        
        for label in [gridTitle, characterTitle] {
            label.font = UIFont.systemFontOfSize(10)
            label.textColor = UIColor(red:0.831, green:0.831, blue:0.831, alpha:1)
            label.sizeToFit()
        }
        
        let contenHeight = allLabels.reduce(0) { (initial, label) -> CGFloat in
            return initial + label.bounds.height + fragment / 2
        }
        
        let leading: CGFloat = 25
        
        let top = (self.bounds.height - contenHeight) / 2
        
        gridCount.frame.origin = CGPoint(x: leading, y: top)
        gridTitle.frame.origin = CGPoint(x: leading, y: CGRectGetMaxY(gridCount.frame))
        
        characterCount.frame.origin = CGPoint(x: leading, y: CGRectGetMaxY(gridTitle.frame) + fragment * 2)
        characterTitle.frame.origin = CGPoint(x: leading, y: CGRectGetMaxY(characterCount.frame))
        
        for label in allLabels {
            self.addSubview(label)
        }
    }
    
    private func redraw() {
        gridCount.text = String(Int(allGridsAndCharacters.first![currentIndex]))
        characterCount.text = String(Int(allGridsAndCharacters.last![currentIndex]))
        
        gridCount.sizeToFit()
        characterCount.sizeToFit()
    }

}

extension StatisticContentView: ExampleInteractiveViewDelegate {
    func exmapleInteractiveView(view: ExampleInteractiveView, didChangeSelectedIndex index: Int) {
        currentIndex = index + 1
    }
}
