//
//  PDFDrawerView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/18.
//

import SwiftUI
import WebKit
import PDFKit

struct PDFDrawerView: UIViewRepresentable {
    var fileURL:URL
    @EnvironmentObject var selectedTool: SelectedTool
    var pdfView: PDFView!
    private var path: UIBezierPath?
    private var currentAnnotation : DrawingAnnotation?
    private var currentPage: PDFPage?
    
    init(fileURL:URL) {
        self.fileURL = fileURL
        self.pdfView = PDFView()
    }
    
    func makeCoordinator() -> PDFDrawerView.Coordinator {
        return Coordinator(parent:self)
    }
    
    func makeUIView(context: Context) -> PDFView {
        pdfView.backgroundColor = UIColor.gray
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        let pdfDrawingGestureRecognizer = DrawingGestureRecognizer()
        pdfDrawingGestureRecognizer.drawingDelegate = context.coordinator
        pdfView.addGestureRecognizer(pdfDrawingGestureRecognizer)
        pdfView.document = PDFDocument(url: fileURL)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
    
    class Coordinator: NSObject, DrawingGestureRecognizerDelegate {
        var parent: PDFDrawerView
        
        init(parent:PDFDrawerView) {
            self.parent = parent
        }
        
        func gestureRecognizerBegan(_ location: CGPoint) {
            guard let page = parent.pdfView.page(for: location, nearest: true) else { return }
            parent.currentPage = page
            let convertedPoint = parent.pdfView.convert(location, to: parent.currentPage!)
            parent.path = UIBezierPath()
            parent.path?.move(to: convertedPoint)
        }
        
        func gestureRecognizerMoved(_ location: CGPoint) {
            guard let page = parent.currentPage else { return }
            let convertedPoint = parent.pdfView.convert(location, to: page)
            
            if parent.selectedTool.tool == .eraser {
                removeAnnotationAtPoint(point: convertedPoint, page: page)
                return
            }
            
            parent.path?.addLine(to: convertedPoint)
            parent.path?.move(to: convertedPoint)
            drawAnnotation(onPage: page)
        }
        
        func gestureRecognizerEnded(_ location: CGPoint) {
            guard let page = parent.currentPage else { return }
            let convertedPoint = parent.pdfView.convert(location, to: page)
            
            // Erasing
            if parent.selectedTool.tool == .eraser {
                removeAnnotationAtPoint(point: convertedPoint, page: page)
                return
            }
            
            // Drawing
            guard let _ = parent.currentAnnotation else { return }
            
            parent.path?.addLine(to: convertedPoint)
            parent.path?.move(to: convertedPoint)
            
            // Final annotation
            page.removeAnnotation(parent.currentAnnotation!)
            let finalAnnoattion = createFinalAnnotation(path: parent.path!, page: page)
            parent.pdfView.document?.write(to: parent.fileURL) 
            parent.currentAnnotation = nil
        }
        private func createAnnotation(path: UIBezierPath, page: PDFPage) -> DrawingAnnotation {
            let border = PDFBorder()
            border.lineWidth = parent.selectedTool.tool.width
            
            let annotation = DrawingAnnotation(bounds: page.bounds(for: parent.pdfView.displayBox), forType: .ink, withProperties: nil)
            annotation.color = parent.selectedTool.color.withAlphaComponent(parent.selectedTool.tool.alpha)
            annotation.border = border
            return annotation
        }
        
        private func drawAnnotation(onPage: PDFPage) {
            guard let path = parent.path else { return }
            
            if parent.currentAnnotation == nil {
                parent.currentAnnotation = createAnnotation(path: path, page: onPage)
            }
            
            parent.currentAnnotation?.path = path
            forceRedraw(annotation: parent.currentAnnotation!, onPage: onPage)
        }
        
        private func createFinalAnnotation(path: UIBezierPath, page: PDFPage) -> PDFAnnotation {
            let border = PDFBorder()
            border.lineWidth = parent.selectedTool.tool.width
            
            let bounds = CGRect(x: path.bounds.origin.x - 5,
                                y: path.bounds.origin.y - 5,
                                width: path.bounds.size.width + 10,
                                height: path.bounds.size.height + 10)
            var signingPathCentered = UIBezierPath()
            signingPathCentered.cgPath = path.cgPath
            signingPathCentered.moveCenter(to: bounds.center)
            
            let annotation = PDFAnnotation(bounds: bounds, forType: .ink, withProperties: nil)
            annotation.color = parent.selectedTool.color.withAlphaComponent(parent.selectedTool.tool.alpha)
            annotation.border = border
            annotation.add(signingPathCentered)
            page.addAnnotation(annotation)
            
            return annotation
        }
        
        private func removeAnnotationAtPoint(point: CGPoint, page: PDFPage) {
            if let selectedAnnotation = page.annotationWithHitTest(at: point) {
                selectedAnnotation.page?.removeAnnotation(selectedAnnotation)
            }
        }
        
        private func forceRedraw(annotation: PDFAnnotation, onPage: PDFPage) {
            onPage.removeAnnotation(annotation)
            onPage.addAnnotation(annotation)
        }
        
        
    }
}


struct PDFDrawerView_: View {
    
    var body: some View {
        let fileURLWithPath =  Bundle.main.path(forResource: "template1", ofType: "html")!
        //        let answerString = """
        //                {
        //                    "eid": "T123456",
        //                    "uid": "bc7nshrde4",
        //                    "n":"%E5%89%8D%E5%B3%B6%E3%81%B5%E3%81%BF%E3%81%8B",
        //                    "a":"%E8%B1%8A%E5%B3%B6%E5%8C%BA%E9%A7%92%E8%BE%BC6-5-1-403",
        //                    "g":"%E5%A5%B3%E6%80%A7",
        //                    "b":"2018-05-16",
        //                    "c":"%E6%9D%B1%E4%BA%AC%E3%83%A1%E3%83%87%E3%82%A3%E3%82%AB%E3%83%AB%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9",
        //                    "cn":"123456",
        //                    "d":"1?0?0?0?0?0?0?0?0?0?0?1%E7%94%9F%E3%81%AE%E9%B6%8F%E5%8D%B5?1%E3%82%A4%E3%83%B3%E3%83%95%E3%83%AB%E3%82%A8%E3%83%B3%E3%82%B6%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE?0?0?0?"
        //                }
        //    """
        //let script = Javascript1(answerString:answerString)
        //        PDFDrawerView(fileURLWithPath:fileURLWithPath,script: script.mkScript())
    }
}

//struct PDFDrawerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFDrawerView(fileURL: <#Binding<URL>#>) 
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//
