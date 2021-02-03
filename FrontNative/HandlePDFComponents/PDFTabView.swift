//
//  PDFTabView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/02/01.
//

import SwiftUI

struct PDFTabView: View {
    @State private var offset: CGFloat = 0
    @EnvironmentObject var path:Path
    var files : [ItemAttribute]
    @Binding var index:Int
    @State private var id = 0
    
    var body: some View {
        TabView(selection:$index){
            ForEach(files, id:\.self.id){ file in
                PDFDrawerView(fileURL:file.url)
                    .tag(file.id)
//                Text(file.name)
//                    .tag(file.id)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

//struct PDFTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFTabView()
//    }
//}
