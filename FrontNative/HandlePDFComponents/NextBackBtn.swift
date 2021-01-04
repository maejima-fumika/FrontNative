//
//  NextBackBtn.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct NextBackBtn: View {
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "chevron.backward")
                        .scaleEffect(1.5)
                        .frame(width: 77, height: 70)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                })
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
                .scaleEffect(0.8)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "camera")
                        .scaleEffect(1.5)
                        .frame(width: 77, height: 70)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                })
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
                .scaleEffect(0.8)
            }
        }
    }
}

struct NextBackBtn_Previews: PreviewProvider {
    static var previews: some View {
        NextBackBtn()
    }
}
