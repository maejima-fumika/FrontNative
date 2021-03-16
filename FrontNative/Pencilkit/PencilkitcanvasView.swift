//
//  QuickLook.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/21.
//

import Foundation
import SwiftUI
import PencilKit
import PDFKit

struct PkcanvasViewView: UIViewRepresentable {
    let url =  Bundle.main.url(forResource: "Document", withExtension: "pdf")!
    typealias UIViewType = PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        let pkcView = PKCanvasView()
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pkcView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        pkcView.isOpaque = false
        //pkcView.backgroundColor = UIColor.red
        pkcView.addSubview(pdfView)
        pkcView.sendSubviewToBack(pdfView)
        
        return pkcView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
    
    
    
}




struct PkcanvasViewView_: View {
    var body: some View {
        PkcanvasViewView()
    }
}

struct PkcanvasViewView_Previews: PreviewProvider {
    static var previews: some View {
        PkcanvasViewView_()
            .edgesIgnoringSafeArea(.all)
    }
}

