//
//  CalculatorButtonItem.swift
//  SwiftUIDemo
//
//  Created by LFZ on 2020/1/7.
//  Copyright © 2020 LFZ. All rights reserved.
//

import UIKit
import SwiftUI

enum CalculatorButtonItem {

    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multiply = "x"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem {
    
    var title:String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }
    
    var size: CGSize {
        if case .digit(let value) = self, value == 0 {
            return CGSize(width: 88*2 + 8, height: 88)
        }
        return CGSize(width: 88, height: 88)
    }
    
    var backgroundColorName: String {
        switch self {
        case .digit, .dot: return "digitBackground"
        case .op: return "operatorBackground"
        case .command: return "commandBackground"
        }
    }
    
    var textColor: Color {
        if case .command(_) = self {
            return Color("commandText")
        }
        return Color.white
    }
}

extension CalculatorButtonItem: Hashable {}
