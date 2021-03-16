//
//  QuickLook.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/21.
//

import Foundation
import SwiftUI
import QuickLook

struct QuickLookView: UIViewControllerRepresentable {
    let urls:[URL] = [Bundle.main.url(forResource: "template2", withExtension: "html")!,Bundle.main.url(forResource: "Document", withExtension: "pdf")!]
    
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        controller.delegate = context.coordinator
        controller.currentPreviewItemIndex = 1
        controller.setEditing(true, animated: true)
        
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIViewController(
        _ uiViewController: QLPreviewController, context: Context) {
        print(uiViewController.isEditing)
    }
    
    
    class Coordinator:NSObject, QLPreviewControllerDataSource,QLPreviewControllerDelegate {
        
        let parent: QuickLookView
        
        init(parent: QuickLookView) {
            self.parent = parent
        }
        
        func numberOfPreviewItems(
            in controller: QLPreviewController
        ) -> Int {
            return parent.urls.count
        }
        
        func previewController(
            _ controller: QLPreviewController, previewItemAt index: Int
        ) -> QLPreviewItem {
            return parent.urls[index] as NSURL
        }
        
        func previewController(_ controller: QLPreviewController, editingModeFor previewItem: QLPreviewItem) -> QLPreviewItemEditingMode {
            
            return .updateContents
        }
        
        func previewController(_ controller: QLPreviewController, didUpdateContentsOf previewItem: QLPreviewItem) {
        }
        
    }
}




struct QuickLookView_: View {
    var body: some View {
        QuickLookView()
    }
}

struct QuickLookView_Previews: PreviewProvider {
    static var previews: some View {
        QuickLookView_()
            .edgesIgnoringSafeArea(.all)
    }
}

