//
//  allFolders.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/28.
//

import SwiftUI

struct AllFolders: View {
    @State private var folders = [ItemAttribute]()
    @State private var showSheet = false
    @State var selectedPushedItem:Int?
    @State var selectedFileName = "nothing"
    @ObservedObject var sortItems = SortItems()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    //                    Header()
                    //                    Divider()
                    Picker("",selection:$sortItems.currentMode,content:{
                        Text("日付").tag(SortItems.SortMode.date)
                        Text("名前").tag(SortItems.SortMode.name)
                    })
                    .padding(.top)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)
                    List{
                        ForEach(self.sortItems.currentMode.sortedItems(items: folders), id:\.self){ folder in
                            NavigationLink(destination: AllFiles(folder:folder,selectedFileName:$selectedFileName),tag:folder.id,selection:$selectedPushedItem){
                                FolderListComponent(folder:folder)
                            }
                            .padding([.top, .leading, .trailing], 15.0)
                        }
                    }
                    Spacer()
                }
                .sheet(isPresented: $showSheet){
                    AddNewFolder(showSheet: $showSheet,folders:$folders, selectedPushedItem:$selectedPushedItem,selectedFileName:$selectedFileName)
                }
                //.navigationBarHidden(true)
                .navigationTitle("健診一覧")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("選択") {}
                    }
                }
                
                FloatingBtn(isOn:self.$showSheet)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let ItemList = ListOfDirItems()
            ItemList.setItems(dirURL: dirURL!)
            folders = ItemList.sortByDate()
        }
    }
}

struct AllFolders_Previews: PreviewProvider {
    static var previews: some View {
        AllFolders()
    }
}
