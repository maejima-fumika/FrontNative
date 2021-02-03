//
//  AllFiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct AllFiles: View {
    let folder:ItemAttribute?
    let selectedFileName:String
    @State private var files = [ItemAttribute]()
    @State private var showSheet = false
    @State var selectedPushedItem:Int?
    @EnvironmentObject var path:Path
    
    init(folder:ItemAttribute?,selectedFileName:String="nothing") {
        self.folder = folder
        self.selectedFileName = selectedFileName
    }
    

    
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
                    List{
                        ForEach(files, id:\.self.id){ file in
                            NavigationLink(destination: HandlePDFfiles(showView: "pdf",files: files, index: file.id),tag:file.id,selection:$selectedPushedItem){
                                FileListComponent(file:file) 
                            }
                            .padding([.top, .leading, .trailing], 15.0)
                        }
                        
                    }
                    Spacer()
                }
                .sheet(isPresented: $showSheet){
                    AddNewFile(showSheet: $showSheet,folders:$files, selectedPushedItem:$selectedPushedItem)
                }
            }
            .onAppear{
                let path = folder?.name
                //print(path)
                let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(path ?? "")
                let ItemList = ListOfDirItems()
                ItemList.setItems(dirURL: dirURL!)
                files = ItemList.sortByName()
                if selectedFileName != "nothing"{
                    selectedPushedItem = files.filter({$0.name == (selectedFileName+".pdf")}).first?.id 
                }
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
