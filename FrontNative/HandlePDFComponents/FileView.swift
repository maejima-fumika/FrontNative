import SwiftUI
import WebKit
import PDFKit

struct FileView: UIViewRepresentable {
    var fileURLWithPath:String
    var script: String
    var webView:WKWebView
    let pdfDrawer:PDFDrawer
    var selectedTool: SelectedTool
    
    init(fileURLWithPath:String, script:String, selectedTool:SelectedTool) {
        self.fileURLWithPath = fileURLWithPath
        self.script = script
        print(self.script)
        
        let webConfig = WKWebViewConfiguration()
        let userController = WKUserContentController()
        userController.addUserScript(WKUserScript(source: script, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true))
        
        webConfig.userContentController = userController
        
        self.webView = WKWebView(frame: .zero,configuration: webConfig)
        self.selectedTool = selectedTool
        self.pdfDrawer = PDFDrawer()
    }
    
    func makeCoordinator() -> FileView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> PDFView {
        self.webView.navigationDelegate = context.coordinator
        setupPDFView()
        return pdfDrawer.pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        webView.load(URLRequest(url: URL(fileURLWithPath: fileURLWithPath)))
    }
    
    private func setupPDFView(){
        let pdfView = PDFView()
        pdfView.backgroundColor = UIColor.gray
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        let url = Bundle.main.url(forResource: "Document", withExtension: "pdf")!
        pdfView.document = PDFDocument(url: url)
        let pdfDrawingGestureRecognizer = DrawingGestureRecognizer()
        pdfDrawingGestureRecognizer.drawingDelegate = pdfDrawer
        pdfView.addGestureRecognizer(pdfDrawingGestureRecognizer)
        pdfDrawer.pdfView = pdfView
        pdfDrawer.selectedTool = selectedTool
    }
    
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: FileView
        
        init(_ parent: FileView) {
            self.parent = parent
        }
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.pdfDrawer.pdfView.document = PDFDocument(data: createPDFpage())
        }
        
        func createPDFpage() -> Data {
            let fmt = parent.webView.viewPrintFormatter()
            
            // 2. Assign print formatter to UIPrintPageRenderer
            let render = UIPrintPageRenderer()
            render.addPrintFormatter(fmt, startingAtPageAt: 0)
            
            // 3. Assign paperRect and printableRect
            let page = CGRect(x: 0, y: 0, width: 570, height: 841.8) // A4, 72 dpi
            render.setValue(page, forKey: "paperRect")
            render.setValue(page, forKey: "printableRect")
            
            // 4. Create PDF context and draw
            let pdfData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
            
            for i in 0..<render.numberOfPages {
                UIGraphicsBeginPDFPage();
                render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
            }
            
            UIGraphicsEndPDFContext();
            return pdfData as Data
        }
    }
    
}


struct writePDFView: View {
    @State var title: String = ""
    @State var error: Error? = nil
    
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
//        FileView(fileURLWithPath:fileURLWithPath,script: script.mkScript())
    }
}

struct writePDF_Previews: PreviewProvider {
    static var previews: some View {
        writePDFView()
            .edgesIgnoringSafeArea(.all)
    }
}
