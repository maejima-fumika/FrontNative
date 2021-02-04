//
//  DrawTools.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/29.
//

import SwiftUI

struct DrawTools: View {
    @EnvironmentObject var selectedTool:SelectedTool
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Capsule()
                    //.fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .fill(Color.white)
                    .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                HStack{
//                    Button(action: {
//                        selectedTool.tool = .eraser
//                    }) {
//                        Image(systemName: "circle.dashed")
//                            .scaleEffect(1.5)
//                            .foregroundColor(Color.black)
//                            .frame(width: 60, height: 70)
//                            .padding(.bottom, 7)
//                    }
//                    Image(systemName: "circle.dashed")
//                                                .scaleEffect(1.5)
//                                                .foregroundColor(Color.black)
//                                                .frame(width: 60, height: 70)
//                                                .padding(.bottom, 7)
//                    Circle()
//                        .trim(from: 0, to: 1)
//                        .frame(width: 30, height: 30, alignment: .leading)
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
            .position(x: geometry.size.width/2 + position.width + dragOffset.width, y: geometry.size.height - 60 + position.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, transaction) in
                        state = value.translation
                    })
                    .onEnded({ (value) in
                        
                        self.position.height += value.translation.height
                        self.position.width += value.translation.width
                    })
            )
        }
    }
}

struct DrawTools_Previews: PreviewProvider {
    static var previews: some View {
        DrawTools()
    }
}
