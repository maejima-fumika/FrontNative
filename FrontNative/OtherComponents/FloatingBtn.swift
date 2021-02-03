//
//  FloatingBtn.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct FloatingBtn: View {
    @Binding var isOn:Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isOn = true
                }, label: {
                    Text("+")
                        .font(.system(.largeTitle))
                        .frame(width: 77, height: 70)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                })
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding([.bottom, .trailing], 40.0)
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
        }
    }
}

//struct FloatingBtn_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingBtn()
//    }
//}
