//
//  QRcodeError.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/02/04.
//

import SwiftUI

struct QRcodeError: View {
    @Binding var errorText:String
    @Binding var showingView:String
    var body: some View {
        VStack{
            Text("エラー：\(errorText)")
                .foregroundColor(.red)
            Button(action: {
                showingView = "qrcode"
            }, label: {                    
                Text("戻る")
                    .frame(width: 250, height: 70)
                    .foregroundColor(Color.blue)
                    .padding()
            })
//            .background(Color.blue)
//            .cornerRadius(38.5)
//            .padding([.bottom, .trailing], 40.0)
        }
    }
}

//struct QRcodeError_Previews: PreviewProvider {
//    static var previews: some View {
//        QRcodeError()
//    }
//}
