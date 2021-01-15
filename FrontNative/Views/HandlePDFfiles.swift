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
    @State private var drawingTool = DrawingTool.pencil
    @State private var drawingColor = UIColor.black
    
    var body: some View {
        let fileURLWithPath =  Bundle.main.path(forResource: "template1", ofType: "html")!
        ZStack {
            if showingView == "pdf"{
                let script = Javascript1(answerString:codeText
                )
                Group {
                    FileView(fileURLWithPath:fileURLWithPath,script: script.mkScript())
                    DrawTools()
                }
                .environmentObject(SelectedTool())
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
