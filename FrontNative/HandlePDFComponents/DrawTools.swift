//
//  DrawTools.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct DrawTools: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment:.bottom){
                Button(action: {}) {
                    Eraser()
                }
                .frame(width: 60, height: 55)
                Button(action: {}) {
                    Image(systemName: "pencil.tip")
                        .scaleEffect(3)
                        .foregroundColor(.blue)
                }
                .frame(width: 45, height: 55)
                //.padding(.bottom)
                Button(action: {}) {
                    Image(systemName: "pencil.tip")
                        .scaleEffect(3)
                        .foregroundColor(.red)
                }
                .frame(width: 45, height: 55)
                .padding(.bottom, 10.0)
                Button(action: {}) {
                    Image(systemName: "pencil.tip")
                        .scaleEffect(3)
                        .foregroundColor(.black)
                }
                .frame(width: 45, height: 55)
            }
        }
    }
}

struct DrawTools_Previews: PreviewProvider {
    static var previews: some View {
        DrawTools()
    }
}
