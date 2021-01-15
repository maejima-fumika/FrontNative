//
//  ReadQRcode.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/14.
//

import SwiftUI
import CodeScanner

struct ReadQRcode: View {
    @Binding var codeText:String
    @Binding var showingView:String
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "Some simulated data", completion: self.handleScan)
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
           switch result {
           case .success(let data):
               print("Success with \(data)")
            self.codeText = data
            self.showingView = "pdf"
           case .failure(let error):
               print("Scanning failed \(error)")
            self.codeText = "failed"
            self.showingView = "text"
           }
        }
}

//struct ReadQRcode_Previews: PreviewProvider {
//    static var previews: some View {
//        let codeText = "no text"
//        ReadQRcode(codeText: codeText)
//    }
//}
