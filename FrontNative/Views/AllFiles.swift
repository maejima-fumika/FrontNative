//
//  AllFiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct AllFiles: View {
    var body: some View {
        //NavigationView {
            ZStack {
                VStack {
                    Divider()
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        Text("日付").tag(1)
                        Text("名前").tag(2)
                    }
                    .padding(.top)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)
                    List(0..<8){_ in
                        NavigationLink(destination: HandlePDFfiles()){
                            FileListComponent()
                        }
                        .padding([.top, .leading, .trailing], 15.0)
                    }
                    Spacer()
                }
                FloatingBtn()
            }
            .navigationBarTitle(Text("フォルダー名"))

            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("選択") {}
                }
                /// ボトムバー
                //                ToolbarItem(placement: .bottomBar) {
                //                    Button(action: {}) {
                //                        Label("送信", systemImage: "paperplane")
                //                    }
                //                }
            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AllFiles_Previews: PreviewProvider {
    static var previews: some View {
        AllFiles()
    }
}
