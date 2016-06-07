//
//  ExampleIntercativeViewDelegateCenter.swift
//  OMChartView
//
//  Created by HuangKun on 16/6/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class ExampleInteractiveDelegateCenter: NSObject, ExampleInteractiveViewDelegate {
    
    var delegates: [ExampleInteractiveViewDelegate]
    
    init(withDelegates: ExampleInteractiveViewDelegate...) {
        delegates = withDelegates
        super.init()
    }
    
    func exmapleInteractiveView(view: ExampleInteractiveView, didChangeSelectedIndex index: Int) {
        for delegate in delegates {
            delegate.exmapleInteractiveView(view, didChangeSelectedIndex: index)
        }
    }
    
    func append(delegate: ExampleInteractiveViewDelegate) {
        delegates.append(delegate)
    }
    
    func removeAtIndex(index: Int) {
        delegates.removeAtIndex(index)
    }
}
