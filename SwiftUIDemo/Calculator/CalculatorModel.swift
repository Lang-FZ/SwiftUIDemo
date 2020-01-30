//
//  CalculatorModel.swift
//  SwiftUIDemo
//
//  Created by LFZ on 2020/1/29.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI
import Combine

class CalculatorModel: ObservableObject {

    @Published var brain: CalculatorBrain = .left("0")
    @Published var history: [CalculatorButtonItem] = [] 
    
    var historyOnlyDigit: Bool {
        var temp = true
        history.forEach { (item) in
            switch item {
            case .op, .command:
                temp = false
                return
            case .digit, .dot:
                break
            }
        }
        return temp
    }
    var historyContainDigit: Bool {
        var temp = false
        history.forEach { (item) in
            switch item {
            case .op, .command, .dot:
                break
            case .digit:
                temp = true
                return
            }
        }
        return temp
    }
    
    func apply(_ item: CalculatorButtonItem) {
        
        brain = brain.apply(item: item)
        history.append(item)
        
        if item.description == CalculatorButtonItem.Command.clear.rawValue {

            temporaryKept.removeAll()
            history.removeAll()
            slidingIndex = Float(totalCount)
            
        } else {
            
            temporaryKept.removeAll()
            slidingIndex = Float(totalCount)
        }
    }
    
    var historyDetail: String {
        history.map { $0.description }.joined()
    }
    
    var temporaryKept: [CalculatorButtonItem] = []
    
    var totalCount: Int {
        history.count + temporaryKept.count
    }
    
    var slidingIndex:Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index.")
        
        let total = history + temporaryKept
        
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        brain = history.reduce(CalculatorBrain.left("0")) { result, item in
            result.apply(item: item)
        }
    }
}
