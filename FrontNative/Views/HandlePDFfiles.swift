//
//  HandlePDFfiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct HandlePDFfiles: View {
    @State var files = [ItemAttribute]()
    @State var index:Int = 0
    @State var showingView = "qrcode"
    @State var errorText = "error"
    @State private var showSheet = false
    @StateObject private var selectedTool = SelectedTool()
    @StateObject private var script = Javascript2() 
    
    init(showingView:String,files:[ItemAttribute],index:Int) {
        _showingView = State(initialValue: showingView)
        _index  = State(initialValue: index)
        _files = State(initialValue: files) 
    }
    
    var body: some View {
        let fileURLWithPath =  Bundle.main.path(forResource: "template2", ofType: "html")!
        ZStack {
            if showingView == "qrcode"{
                QRcodeView(showingView:$showingView,errorText:$errorText)
            }
            else if showingView == "waiting"{
                WaitingView(templatePath:fileURLWithPath, script:script, showingView:$showingView,files:$files,index:$index)  
            }
            else if showingView == "pdf"{
                Group {
                    PDFScrollView(files: files,index:$index,showingView: $showingView)
                    DrawTools()
                }
                .environmentObject(selectedTool)
            }
            else if showingView == "error"{
                QRcodeError(errorText: $errorText, showingView: $showingView)
            }
            else {
                Text("error")
            }
        }
        .environmentObject(script)
        .sheet(isPresented: $showSheet){
            ActivityView(
                activityItems: [files[index].url],
                        applicationActivities: nil
                    )
        }
        .navigationBarTitle(Text(self.showingView == "pdf" ? self.files[self.index].name : "QRコード読み取り"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                HStack(alignment:.bottom){
                                    if self.showingView == "pdf"{
                                        Button(action: {
                                            self.showSheet = true
                                        }) {
                                            Image(systemName:"square.and.arrow.up")
                                                .scaleEffect(1.3)
                                        }
                                        .padding(.trailing)
                                    }
                                    Button(action: {
                                        self.showingView = (self.showingView == "pdf") ? "qrcode":"pdf"
                                    }) {
                                        Image(systemName: self.showingView == "pdf" ? "camera":"square.and.pencil")
                                            .scaleEffect(1.3)
                                    }
                                    .padding(.trailing)
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
