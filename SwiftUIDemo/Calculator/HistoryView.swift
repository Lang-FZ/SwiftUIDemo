//
//  HistoryView.swift
//  SwiftUIDemo
//
//  Created by LFZ on 2020/1/30.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var model: CalculatorModel
    
    let action: () -> Void
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("关闭")
                    .font(.headline)
                    .padding([.top, .leading], 0)
                    .frame(minWidth: 50, minHeight: 50, alignment: .topLeading)
                    .onTapGesture {
                        self.action()
                }
                Spacer()
            }
            
            Spacer()
            
            if model.totalCount == 0 {
                Text("没有履历")
            } else {
                
                HStack {
                    Text("履历").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                
                Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
            }
            
            Spacer()
            
        }.padding()
    }
}
