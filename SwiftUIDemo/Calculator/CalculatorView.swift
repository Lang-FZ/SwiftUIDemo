//
//  CalculatorView.swift
//  SwiftUIDemo
//
//  Created by LFZ on 2020/1/7.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

let scale: CGFloat = UIScreen.main.bounds.width / 414

struct CalculatorView: View {
    
    var body: some View {
         
        VStack(spacing: 12) {
            
            Spacer()
                
            Text("0")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 24)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            CalculatorButtonPad()
                .padding(.bottom)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
            .previewDisplayName("iPhone XR")
    }
}


struct CalculatorButtonPad: View {
    
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
    
        VStack(spacing: 8) {
        
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        
        HStack {
            
            ForEach(row, id: \.self) { item in
                
                CalculatorButton(
                    title: item.title,
                    foregroundColor: item.textColor,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName) {
                        
                        print("Button: \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButton: View {
    
    let fontSize: CGFloat = 38
    let title: String
    let foregroundColor: Color
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
        
            ZStack {
                
                Text("")
                    .frame(width: size.width*scale, height: size.height*scale)
                    .background(Color(backgroundColorName))
//                    .cornerRadius(size.height/2)
                    .clipShape(Capsule())
                
                Text(title)
                    .font(.system(size: fontSize*scale))
                    .foregroundColor(foregroundColor)
            }
        }
    }
}
