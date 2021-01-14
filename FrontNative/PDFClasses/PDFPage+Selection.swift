//
//  PDFPage+Selection.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/04.
//

import SwiftUI
import PDFKit

extension PDFPage {
    func annotationWithHitTest(at: CGPoint) -> PDFAnnotation? {
        for annotation in annotations {
                if annotation.contains(point: at) {
                return annotation
            }
        }
        return nil
    }
}
