//
//  eraser.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct Eraser: View {
    var body: some View {
        VStack {
            Image(systemName: "rectangle.roundedtop")
                .scaleEffect(2)
                .foregroundColor(.black)
            Image(systemName: "rectangle.fill")
                .scaleEffect(2.1)
                .foregroundColor(.black)
                .frame(width: 55, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }
        .frame(width: 60, height: 70, alignment: .center)
    }
}

struct eraser_Previews: PreviewProvider {
    static var previews: some View {
        Eraser()
    }
}
