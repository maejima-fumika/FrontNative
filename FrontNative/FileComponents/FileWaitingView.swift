//
//  FileWaitingView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/02/03.
//
//addNewFolderから新規ファイルを作るときに使う
//基本的にはWaitingViewと同じ
import SwiftUI
import WebKit
import PDFKit

struct FileWaitingView: UIViewRepresentable {
    @EnvironmentObject var script: Javascript1
    var templatePath:String
    var folderName:String
    var webView:WKWebView
    @Binding var showingView:String
    @Binding var errorText:String
    @Binding var showSheet:Bool
    @Binding var files:[ItemAttribute]
    @Binding var selectedPushedItem:Int?
    
    
    init(templatePath:String,folderName:String, script:Javascript1, showingView:Binding<String>,errorText:Binding<String>,showSheet:Binding<Bool>, files:Binding<[ItemAttribute]>, selectedPushedItem:Binding<Int?>) {
        self.templatePath = templatePath
        self.folderName = folderName
        _showingView = showingView
        _errorText = errorText
        _showSheet = showSheet
        _files = files
        _selectedPushedItem = selectedPushedItem
        let webConfig = WKWebViewConfiguration()
        let userController = WKUserContentController()
        userController.addUserScript(WKUserScript(source: script.mkScript() ?? "'no script'", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true))
        webConfig.userContentController = userController
        self.webView = WKWebView(frame: .zero,configuration: webConfig)
    }
    
    func makeCoordinator() -> FileWaitingView.Coordinator {
        Coordinator(parent:self, showingView:$showingView, errorText:$errorText,showSheet:$showSheet, files:$files, selectedPushedItem:$selectedPushedItem)
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        self.webView.navigationDelegate = context.coordinator
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        webView.load(URLRequest(url: URL(fileURLWithPath: templatePath)))
    }
    
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: FileWaitingView
        @Binding var showingView:String
        @Binding var errorText:String
        @Binding var showSheet:Bool
        @Binding var files:[ItemAttribute]
        @Binding var selectedPushedItem:Int?
        
        
        init(parent: FileWaitingView, showingView:Binding<String>,errorText:Binding<String>,showSheet:Binding<Bool>,files:Binding<[ItemAttribute]>, selectedPushedItem:Binding<Int?>) {
            self.parent = parent
            _showingView = showingView
            _errorText = errorText
            _showSheet = showSheet
            _files = files
            _selectedPushedItem = selectedPushedItem
        }
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if parent.script.folderName() != parent.folderName {
                    errorText = "健診名が違います。健診一覧からQRコードを読み込んでください。"
                    showingView = "error"
            }
            else {
            
            let pdfView = PDFView()
            pdfView.document = PDFDocument(data: createPDFpage())
            pdfView.document?.write(to:parent.script.saveURL!)
            
            let path = parent.script.folderName()
            let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(path ?? "")
            //let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let ItemList = ListOfDirItems()
            ItemList.setItems(dirURL: dirURL!)
            files = ItemList.sortByDate()
            selectedPushedItem = files.filter({$0.name == (parent.script.mkFileName() ?? "nothing")+".pdf"}).first?.id
            showSheet = false
            }
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



struct FileWaitingView_: View {
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
        //        WaitingView(fileURLWithPath:fileURLWithPath,script: script.mkScript())
    }
}

//struct WaitingView_Previews: PreviewProvider {
//    static var previews: some View {
//        writePDFView()
//            .edgesIgnoringSafeArea(.all)
//    }
//}

