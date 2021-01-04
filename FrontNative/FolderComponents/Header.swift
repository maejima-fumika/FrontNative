//
//  header.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/28.
//

import SwiftUI

struct Header: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text("健診一覧")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
            }
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("選択")
                        .font(.title2)
                        .padding(.trailing)
                }
                .padding()
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewLayout(.fixed(width: 900, height: 70))
    }
}
