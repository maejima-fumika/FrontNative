//
//  AddNewFolder.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/02/03.
//
//QRcodeを読み込んで、新しいフォルダーとファイルを作成する。QRcodeが条件に合わなければ、エラー画面を表示する。
//構造はHandlePDFfilesと似ている。

import SwiftUI

struct AddNewFolder: View {
    @Binding var showSheet: Bool
    @Binding var folders:[ItemAttribute]
    @Binding var selectedPushedItem:Int?
    @Binding var selectedFileName:String
    @State private var showingView = "qrcode"
    @State private var errorText = "error"
    //@State private var onNavigation = false
    @StateObject private var script = Javascript1() 
    
    var body: some View {
        NavigationView {
            let templatePath =  Bundle.main.path(forResource: "template1", ofType: "html")!
            VStack{
                if showingView == "qrcode"{
                    QRcodeView(showingView:$showingView,errorText:$errorText)
                }
                else if showingView == "waiting"{
                    DirWaitingView(templatePath: templatePath, script: script, showingView: $showingView, errorText: $errorText,showSheet:$showSheet,folders:$folders, selectedPushedItem:$selectedPushedItem,selectedFileName:$selectedFileName)
                }
                else{
                    QRcodeError(errorText: $errorText, showingView: $showingView)
                }
            }
            .environmentObject(script)
            .navigationBarTitle(Text("QRcode読み取り"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = false
            }) {
                Text("キャンセル")
            })
            
        }
    }
}

//struct AddNewFolder_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewFolder()
//    }
//}
