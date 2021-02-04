//
//  QRcodeView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/18.
//

import SwiftUI
import CodeScanner

struct QRcodeView: View {
    @Binding var showingView:String
    @Binding var errorText:String
    @EnvironmentObject var script: Javascript1
    @State private var offset: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
        CodeScannerView(codeTypes: [.qr], simulatedData: "Some simulated data", completion: self.handleScan)
            .gesture(DragGesture()
                        .onChanged({ value in
                            self.offset = value.translation.width - geometry.size.width
                        })
                        .onEnded({ value in
                            let scrollThreshold = geometry.size.width / 2
                            if value.predictedEndTranslation.width > scrollThreshold {
                                self.showingView = "pdf"
                            }
                        })
            )
        }
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
           switch result {
           case .success(let data):
               print("Success with \(data)")
            self.script.setupAnswer(answerString:data)
            if self.script.saveURL == nil {
                self.errorText = "不適切なQRコードです。"
                self.showingView = "error"
            }
            else{
                self.showingView = "waiting"
            }
           case .failure(let error):
               print("Scanning failed \(error)")
            self.showingView = "text"
           }
        }
}

//struct QRcodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        QRcodeView()
//    }
//}
