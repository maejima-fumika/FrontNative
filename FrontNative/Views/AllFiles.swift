//
//  AllFiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct AllFiles: View {
    let folder:ItemAttribute?
    @Binding var selectedFileName:String
    @State private var files = [ItemAttribute]()
    @State private var showSheet = false
    @State var selectedPushedItem:Int?
    @ObservedObject var sortItems = SortItems()
    
    init(folder:ItemAttribute?,selectedFileName:Binding<String>) {
        self.folder = folder
        
        let path = self.folder?.name
        let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(path ?? "")
        let ItemList = ListOfDirItems()
        ItemList.setItems(dirURL: dirURL!)
        _files = State(initialValue: ItemList.sortByDate())
        _selectedFileName = selectedFileName
        let id:Int? = self.files.filter({$0.name == (self.selectedFileName+".pdf")}).first?.id
        _selectedPushedItem = State(initialValue:id)
        self.selectedFileName = "nothing"
    }
    

    
    var body: some View {
        //NavigationView {
            ZStack {
                VStack {
                    Divider()
                    Picker("",selection:$sortItems.currentMode,content:{
                        Text("日付").tag(SortItems.SortMode.date)
                        Text("名前").tag(SortItems.SortMode.name)
                    })
                    .padding(.top)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)
                    List{
                        ForEach(self.sortItems.currentMode.sortedItems(items:files), id:\.self.id){ file in
                            NavigationLink(destination: HandlePDFfiles(showingView: "pdf",files: files, index: file.id),tag:file.id,selection:$selectedPushedItem){
                                FileListComponent(file:file) 
                            }
                            .padding([.top, .leading, .trailing], 15.0)
                        }
                        
                    }
                    Spacer()
                }
                .sheet(isPresented: $showSheet){
                    AddNewFile(showSheet: $showSheet,files:$files, selectedPushedItem:$selectedPushedItem, folderName: folder?.name ?? "nothing")
                }
                FloatingBtn(isOn:self.$showSheet)
            }
            .onAppear{
                let path = folder?.name
                let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(path ?? "")
                let ItemList = ListOfDirItems()
                ItemList.setItems(dirURL: dirURL!)
                files = ItemList.sortByDate()
            }
            .navigationBarTitle(Text(folder?.name ?? "ファイル一覧"))

            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("選択") {}
                }
            }
    }
}

//struct AllFiles_Previews: PreviewProvider {
//    static var previews: some View {
//        AllFiles()
//    }
//}
