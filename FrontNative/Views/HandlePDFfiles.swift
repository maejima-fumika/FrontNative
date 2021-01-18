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
    //private var selectedTool = SelectedTool()
    @StateObject private var selectedTool = SelectedTool()
    @EnvironmentObject var path:Path
    
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
                .environmentObject(selectedTool)
                .onAppear{
                    script.mkFilePath(path:path)
                }
            }
            else if showingView == "qrcode"{
                ReadQRcode(codeText:$codeText, showingView:$showingView)
                    .onAppear{
                        path.fileName = "QRコード読み取り"
                    }
            }
            else {
                Text(codeText)
            }
            NextBackBtn()
        }
        .navigationBarTitle(Text(path.fileName ?? ""))
        .navigationBarTitleDisplayMode(.inline)
    }
}

class SelectedTool:ObservableObject  {
    @Published var tool:DrawingTool = .pencil
    @Published var color:UIColor = .black
}


struct HandlePDFfiles_Previews: PreviewProvider {
    static var previews: some View {
        HandlePDFfiles()
    }
}
