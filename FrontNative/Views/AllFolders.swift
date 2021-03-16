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
    @State private var showSelector = false
    @State var selectedFolders:Set<ItemAttribute> = []   //削除とか共有とかするフォルダー達
    @State var selectedURLs = [URL]()
    @State var selectedPushedItem:Int?
    @State var selectedFileName = "nothing"
    @ObservedObject var sortItems = SortItems()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    if !showSelector{
                        Picker("",selection:$sortItems.currentMode,content:{
                            Text("日付").tag(SortItems.SortMode.date)
                            Text("名前").tag(SortItems.SortMode.name)
                        })
                        .padding(.top)
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 300)
                    }
                    else{
                        ActionButtons(selectedItems: $selectedFolders, folders: $folders,showSheet:$showSheet, selectedURLs:$selectedURLs)
                            .padding(.top)
                        
                    }
                    
                    List(selection: $selectedFolders){
                        ForEach(self.sortItems.currentMode.sortedItems(items: folders), id:\.self){ folder in
                            NavigationLink(destination: AllFiles(folder:folder,selectedFileName:$selectedFileName),tag:folder.id,selection:$selectedPushedItem){
                                FolderListComponent(folder:folder)
                            }
                            .padding([.top, .leading, .trailing], 15.0)
                        }
                    }
                    .environment(\.editMode, .constant(self.showSelector ? .active : .inactive))
                    Spacer()
                }
                .sheet(isPresented: $showSheet){
                    if self.showSelector{
                        ActivityView(
                            activityItems: self.selectedURLs, 
                            applicationActivities: nil
                        )
                    }
                    else {
                        AddNewFolder(showSheet: $showSheet,folders:$folders, selectedPushedItem:$selectedPushedItem,selectedFileName:$selectedFileName)
                    }
                }
                .navigationTitle("健診一覧")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(!self.showSelector ? "選択" : "キャンセル") {
                            self.showSelector = !self.showSelector
                        }
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
