//
//  Folder.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/28.
//

import SwiftUI

struct FolderListComponent: View {
    var body: some View {
        HStack{
            Image(systemName: "folder")
                .imageScale(.large)
                .scaleEffect(1.5)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .frame(width: 120, height: 60)
            VStack(alignment:.leading){
                Text("フォルダ名")
                    .font(.headline)
                    .fontWeight(.medium)
                Text("2020/12/28 22:44")
                    .font(.caption)
                    .padding(.leading, 10.0)
            }
            Spacer()
        }
    }
}

struct FolderListComponent_Previews: PreviewProvider {
    static var previews: some View {
        FolderListComponent()
            .previewLayout(.fixed(width: 800, height: 100))
    }
}
