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
    @EnvironmentObject var script: Javascript1
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "Some simulated data", completion: self.handleScan)
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
           switch result {
           case .success(let data):
               print("Success with \(data)")
            self.script.setupAnswer(answerString:data)
            self.showingView = "waiting"
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
