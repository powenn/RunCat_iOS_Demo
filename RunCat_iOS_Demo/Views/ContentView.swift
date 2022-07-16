//
//  ContentView.swift
//  RunCat_iOS_Demo
//
//  Created by 蕭博文 on 2022/7/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            CatView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("RunCat_iOS_Demo")
                .toolbar(content: {
                    NavigationLink(destination: {
                        InfoView()
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
