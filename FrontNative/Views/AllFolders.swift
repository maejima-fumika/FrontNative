//
//  allFolders.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/28.
//

import SwiftUI

struct AllFolders: View {
    @EnvironmentObject var path:Path
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Header()
                    Divider()
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        Text("日付").tag(1)
                        Text("名前").tag(2)
                    }
                    .padding(.top)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)
                    List(0..<8){_ in
                        NavigationLink(destination: AllFiles()){
                            FolderListComponent()
                        }
                        .padding([.top, .leading, .trailing], 15.0)
                        .onAppear{
                            path.folderName = ""
                            path.fileName = ""
                        }
                        .onDisappear{
                            path.folderName = "フォルダー名だよ"
                        }
                    }
                    Spacer()
                }
                .navigationBarHidden(true)
                .navigationTitle("健診一覧")
                
                FloatingBtn()
            }
            //.navigationTitle("健診一覧")
            //.navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AllFolders_Previews: PreviewProvider {
    static var previews: some View {
        AllFolders()
    }
}
