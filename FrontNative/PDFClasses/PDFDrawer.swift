//
//  PDFDrawer.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/04.
//

import Foundation
import PDFKit

enum DrawingTool: Int {
    case eraser = 0
    case pencil = 1
    case pen = 2
    case highlighter = 3
    
    var width: CGFloat {
        switch self {
        case .pencil:
            return 1
        case .pen:
            return 5
        case .highlighter:
            return 10
        default:
            return 0
        }
    }
    
    var alpha: CGFloat {
        switch self {
        case .highlighter:
            return 0.3 //0,5
        default:
            return 1
        }
    }
}

class PDFDrawer:DrawingGestureRecognizerDelegate {
    weak var pdfView: PDFView!
    private var path: UIBezierPath?
    private var currentAnnotation : DrawingAnnotation?
    private var currentPage: PDFPage?
    var color = UIColor.red // default color is red
    var drawingTool = DrawingTool.pen
    
    func gestureRecognizerBegan(_ location: CGPoint) {
        print("hello2")
        guard let page = pdfView.page(for: location, nearest: true) else { return }
        currentPage = page
        let convertedPoint = pdfView.convert(location, to: currentPage!)
        path = UIBezierPath()
        path?.move(to: convertedPoint)
    }
    func gestureRecognizerMoved(_ location: CGPoint) {
        guard let page = currentPage else { return }
        let convertedPoint = pdfView.convert(location, to: page)
        path?.addLine(to: convertedPoint)
        path?.move(to: convertedPoint)
        drawAnnotation(onPage: page)
    }
    func gestureRecognizerEnded(_ location: CGPoint) {
        guard let page = currentPage else { return }
        let convertedPoint = pdfView.convert(location, to: page)
        path?.addLine(to: convertedPoint)
        path?.move(to: convertedPoint)
        drawAnnotation(onPage: page)
        currentAnnotation = nil
    }
    private func createAnnotation(path: UIBezierPath, page: PDFPage) -> DrawingAnnotation {
        let border = PDFBorder()
        border.lineWidth = 5.0 // Set your line width here
        let annotation = DrawingAnnotation(bounds: page.bounds(for: pdfView.displayBox), forType: .ink, withProperties: nil)
        annotation.color = color.withAlphaComponent(drawingTool.alpha)
        annotation.border = border
        return annotation
    }
    private func drawAnnotation(onPage: PDFPage) {
        guard let path = path else { return }
        let annotation = createAnnotation(path: path, page: onPage)
        if let _ = currentAnnotation {
            currentAnnotation!.page?.removeAnnotation(currentAnnotation!)
        }
        currentAnnotation?.path = path
        //onPage.addAnnotation(annotation)
        currentAnnotation = annotation
    }
}

