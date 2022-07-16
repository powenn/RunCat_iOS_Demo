//
//  InfoView.swift
//  RunCat_iOS_Demo
//
//  Created by 蕭博文 on 2022/7/16.
//

import SwiftUI

struct InfoView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    var body: some View {
        Form {
            Section(header: Text("version")){
                Text("\(appVersion!).\(buildVersion!)")
            }
            Section(header: Text("source code")){
                Link(destination: URL(string: "https://github.com/powenn/RunCat_iOS_Demo")!, label: {
                    HStack{
                        Text("View on Github")
                        Spacer()
                        Image("GithubIcon")
                            .resizable()
                            .frame(width: 32.0, height: 32.0, alignment: .leading)
                    }
                })
            }
            Section(footer: Text("This is a demo of iOS ported RunCat\nCodes reference from\nhttps://github.com/Kyome22/menubar_runcat"), content: {})
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
