//
//  HandlePDFfiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct HandlePDFfiles: View {
    let showView:String
    @State var files = [ItemAttribute]()
    @State var index:Int = 0
    @State var showingView = "qrcode"
    //@State var pdfFileURL:URL = URL(fileURLWithPath: "error")
    @StateObject private var selectedTool = SelectedTool()
    @StateObject private var script = Javascript1() 
    @EnvironmentObject var path:Path
    
    init(showView:String,files:[ItemAttribute],index:Int) {
        self.showView = showView
        //self.files = files
        _index  = State(initialValue: index)
        _files = State(initialValue: files) 
    }
    
    var body: some View {
        let fileURLWithPath =  Bundle.main.path(forResource: "template1", ofType: "html")!
        ZStack {
            if showingView == "qrcode"{
                QRcodeView(showingView:$showingView)
            }
            else if showingView == "waiting"{
                WaitingView(templatePath:fileURLWithPath, script:script, showingView:$showingView,files:$files,index:$index)  
            }
            else if showingView == "pdf"{
                Group {
                    PDFScrollView(files: files,index:$index)
                    DrawTools()
                }
                .environmentObject(selectedTool)
            }
            else {
                Text("error")
            }
        }
        .onAppear{
            showingView = showView
        }
        .environmentObject(script)
        .navigationBarTitle(Text(self.showingView == "pdf" ? self.files[self.index].name : "QRコード読み取り"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.showingView = (self.showingView == "pdf") ? "qrcode":"pdf"
                                }) {
                                    Image(systemName: self.showingView == "pdf" ? "camera":"square.and.pencil")
                                        .scaleEffect(1.2)
                                }
        )
    }
}

class SelectedTool:ObservableObject  {
    @Published var tool:DrawingTool = .pencil
    @Published var color:UIColor = .black
}


//struct HandlePDFfiles_Previews: PreviewProvider {
//    static var previews: some View {
//        HandlePDFfiles()
//    }
//}
