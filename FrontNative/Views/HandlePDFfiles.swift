//
//  HandlePDFfiles.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct HandlePDFfiles: View {
    var body: some View {
        let documentURL = Bundle.main.url(forResource: "Document", withExtension: "pdf")!
        ZStack {
            FileView(url: documentURL)
            DrawTools()
            NextBackBtn()
        }
        .navigationBarTitle(Text("ファイル名"))

        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HandlePDFfiles_Previews: PreviewProvider {
    static var previews: some View {
        HandlePDFfiles()
    }
}
