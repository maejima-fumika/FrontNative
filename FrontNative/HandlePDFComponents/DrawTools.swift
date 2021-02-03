//
//  DrawTools.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct DrawTools: View {
    @EnvironmentObject var selectedTool:SelectedTool
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                Capsule()
                    .fill(Color.white)
                    .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                HStack{
                    Button(action: {
                        selectedTool.tool = .eraser
                    }) {
                        Image(systemName: "circle.dashed")
                            .scaleEffect(1.5)
                            .foregroundColor(Color.black)
                            .frame(width: 60, height: 70)
                            .padding(.bottom, 7)
                    }
                    Button(action: {
                        selectedTool.tool = .pencil
                        selectedTool.color = .black
                    }) {
                        Image(systemName: "scribble.variable")
                            .scaleEffect(1.5)
                            .foregroundColor(Color.black)
                            .frame(width: 60, height: 70)
                            .padding(.bottom, 7)
                    }
                    Button(action: {
                        selectedTool.tool = .pencil
                        selectedTool.color = .red
                    }) {
                        Image(systemName: "scribble.variable")
                            .scaleEffect(1.5)
                            .foregroundColor(Color.red)
                            .frame(width: 60, height: 70)
                            .padding(.bottom, 7)
                    }
                    Button(action: {
                        selectedTool.tool = .highlighter
                        selectedTool.color = .yellow
                    }) {
                        Image(systemName: "highlighter")
                            .scaleEffect(1.5)
                            .foregroundColor(Color.yellow)
                            .frame(width: 60, height: 70)
                            .padding(.bottom, 7)
                    }
                }
            }
            
        }
    }
}

//struct DrawTools_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawTools()
//    }
//}
