//
//  CatView.swift
//  RunCat_iOS_Demo
//
//  Created by 蕭博文 on 2022/7/16.
//

import SwiftUI

struct CatView: View {
    @StateObject var cat:Cat = .shared
            
    var body: some View {
        VStack{
            VStack{
                cat.CurrentFrame
                Text(cat.CurrentCPU_UsageTitle)
            }.padding()
            
            VStack{
                Toggle(String("Show CPU Usage"), isOn: cat.$showUsage)
                Toggle(String("Custom Speed"), isOn: cat.$useCustomSpeed)
                Slider(value: cat.$CurrentCustomSpeed, in: 0.0 ... 100.0, label: {
                    Text("Custom Speed")
                }, minimumValueLabel: {
                    Text("0")
                }, maximumValueLabel: {
                    Text("100")
                })
                Text("Custom Speed: \(Int(cat.CurrentCustomSpeed))").padding()
                Button(action: {
                    cat.Apply()
                }, label: {
                    Text("Apply")
                })
            }.padding()            
        }.padding()
        .onAppear(perform: {
            cat.afterAppear()
        })
        .onDisappear(perform: {
            cat.afterDisapper()
        })
    }
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}
