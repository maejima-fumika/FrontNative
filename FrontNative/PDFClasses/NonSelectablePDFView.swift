//
//  NonSelectablePDFView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/04.
//

import PDFKit

import PDFKit

class NonSelectablePDFView: PDFView {
    
    // Disable selection
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer is UILongPressGestureRecognizer {
            gestureRecognizer.isEnabled = false
        }
        
        super.addGestureRecognizer(gestureRecognizer)
    }
}
