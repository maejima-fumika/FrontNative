import SwiftUI
import PDFKit


struct testFunc: UIViewRepresentable {
    let url = Bundle.main.url(forResource: "Document", withExtension: "pdf")!
    func makeUIView(context: Context) -> PDFView {
        // 戻り値をWKWebViewとし、返却する
        
        let pdfView = PDFView()
        pdfView.backgroundColor = UIColor.gray
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}

struct testFuncView: View {
    
    var body: some View {
    
        testFunc()
    }
}

struct testFunc_Previews: PreviewProvider {
    static var previews: some View {
        testFuncView()
    }
}

