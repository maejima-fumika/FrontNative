//
//  HandlePDFfiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct HandlePDFfiles: View {
    @State private var codeText = "no text"
    @State private var showingView = "qrcode"
    var body: some View {
        let fileURLWithPath =  Bundle.main.path(forResource: "template1", ofType: "html")!
//        let answerString = """
//                {
//                    "eid": "T123456",
//                    "uid": "bc7nshrde4",
//                    "n":"%E5%89%8D%E5%B3%B6%E3%81%B5%E3%81%BF%E3%81%8B",
//                    "a":"%E8%B1%8A%E5%B3%B6%E5%8C%BA%E9%A7%92%E8%BE%BC6-5-1-403",
//                    "g":"%E5%A5%B3%E6%80%A7",
//                    "b":"2018-05-16",
//                    "c":"%E6%9D%B1%E4%BA%AC%E3%83%A1%E3%83%87%E3%82%A3%E3%82%AB%E3%83%AB%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9",
//                    "cn":"123456",
//                    "d":"1?0?0?0?0?0?0?0?0?0?0?1%E7%94%9F%E3%81%AE%E9%B6%8F%E5%8D%B5?1%E3%82%A4%E3%83%B3%E3%83%95%E3%83%AB%E3%82%A8%E3%83%B3%E3%82%B6%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE?0?0?0?"
//                }
//    """
//        let script = Javascript1(answerString:answerString)
        ZStack {
            if showingView == "pdf"{
                let script = Javascript1(answerString:codeText
                )
                FileView(fileURLWithPath:fileURLWithPath,script: script.mkScript())
                DrawTools()
            }
            else if showingView == "qrcode"{
                ReadQRcode(codeText:$codeText, showingView:$showingView)
            }
            else {
                Text(codeText)
            }
            NextBackBtn()
        }
        .navigationBarTitle(Text("ファイル名"))

        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HandlePDFfiles_Previews: PreviewProvider {
    static var previews: some View {
        HandlePDFfiles()
    }
}
