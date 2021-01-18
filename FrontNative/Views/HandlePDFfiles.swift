//
//  HandlePDFfiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct HandlePDFfiles: View {
    @State private var showingView = "qrcode"
    @State private var pdfFileURL:URL = URL(fileURLWithPath: "error")
    @StateObject private var selectedTool = SelectedTool()
    @StateObject private var script = Javascript1() 
    @EnvironmentObject var path:Path
    
    var body: some View {
        let fileURLWithPath =  Bundle.main.path(forResource: "template1", ofType: "html")!
        ZStack {
            if showingView == "qrcode"{
                QRcodeView(showingView:$showingView)
            }
            else if showingView == "waiting"{
                WaitingView(templatePath:fileURLWithPath, script:script, showingView:$showingView,fileURL:$pdfFileURL)
            }
            else if showingView == "pdf"{
                Group {
                    PDFDrawerView(fileURL:$pdfFileURL)
                    DrawTools()
                }
                .environmentObject(selectedTool)
            }
            else {
                
            }
            NextBackBtn()
        }
        .environmentObject(script)
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
