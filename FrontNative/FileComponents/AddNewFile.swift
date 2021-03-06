//
//  AddNewFile.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/02/03.
//

//QRcodeを読み込んで、ファイルを作成する。QRcodeが条件に合わなければ、エラー画面を表示する。
//構造はAddNewFolderとほぼ同じ。


import SwiftUI

struct AddNewFile: View {
    @Binding var showSheet: Bool
    @Binding var files:[ItemAttribute]
    @Binding var selectedPushedItem:Int?
    @State private var showingView = "qrcode"
    @State private var errorText = "error"
    @StateObject private var script = Javascript2()
    var folderName:String
    
    var body: some View {
        NavigationView {
            let templatePath =  Bundle.main.path(forResource: "template2", ofType: "html")!
            VStack{
                if showingView == "qrcode"{
                    QRcodeView(showingView:$showingView,errorText: $errorText)
                }
                else if showingView == "waiting"{
                    FileWaitingView(templatePath: templatePath, folderName: folderName, script: script, showingView: $showingView, errorText: $errorText,showSheet:$showSheet,files:$files, selectedPushedItem:$selectedPushedItem)
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

