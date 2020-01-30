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
    
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false
    @State private var showingResult = false
    
    var body: some View {
         
        VStack(spacing: 12) {
            
            Spacer()
            
            Button("操作履历: \(model.history.count)") {
                self.editingHistory = true
            }.sheet(isPresented: self.$editingHistory) {
                HistoryView(model: self.model) {
                    self.editingHistory = false
                }
            }
                
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 24)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                    
                    self.showingResult = true
                
                    if !self.model.historyOnlyDigit &&
                        self.model.historyContainDigit &&
                        self.model.history.last?.description ?? "" != CalculatorButtonItem.Op.equal.rawValue {
                        
                        self.model.apply(.op(.equal))
                    }
                }
            
            CalculatorButtonPad()
                .padding(.bottom)
        }
        .alert(isPresented: self.$showingResult) {
            return Alert(
                title: Text(self.model.historyDetail),
                message: Text(self.model.brain.output),
                primaryButton: Alert.Button.cancel(Text("取消")),
                secondaryButton: Alert.Button.default(Text("复制"), action: {
                    UIPasteboard.general.string = self.model.brain.output
                })
            )
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
    
    @EnvironmentObject var model: CalculatorModel
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        
        HStack {
            
            ForEach(row, id: \.self) { item in
                
                CalculatorButton(
                    title: item.title,
                    foregroundColor: item.textColor,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName) {
                        
                        self.model.apply(item)
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
