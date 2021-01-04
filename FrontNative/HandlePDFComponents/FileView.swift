import SwiftUI
import WebKit
import PDFKit

struct FileView: UIViewRepresentable {
    let url: URL
    let pdfDrawer:PDFDrawer
    
    init(url:URL) {
        self.url = url
        self.pdfDrawer = PDFDrawer()
    }
    
    func makeCoordinator() -> FileView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> PDFView {
        setupPDFView()
        return pdfDrawer.pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
    
    private func setupPDFView(){
        let pdfView = PDFView()
        pdfView.backgroundColor = UIColor.gray
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.document = PDFDocument(url: self.url)
        let pdfDrawingGestureRecognizer = DrawingGestureRecognizer()
        pdfDrawingGestureRecognizer.drawingDelegate = pdfDrawer
        pdfView.addGestureRecognizer(pdfDrawingGestureRecognizer)
        pdfDrawer.pdfView = pdfView
    }
    
    
    class Coordinator: NSObject{
        
        var parent: FileView
        
        init(_ parent: FileView) {
            self.parent = parent
        }
    }
    
}


struct writePDFView: View {
    @State var title: String = ""
    @State var error: Error? = nil
    
    var body: some View {
        let documentURL = Bundle.main.url(forResource: "Document", withExtension: "pdf")!
        FileView(url: documentURL)
    }
}

struct writePDF_Previews: PreviewProvider {
    static var previews: some View {
        writePDFView()
            .edgesIgnoringSafeArea(.all)
    }
}
