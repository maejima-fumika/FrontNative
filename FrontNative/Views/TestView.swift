//
//  TestView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/21.
//

import SwiftUI

struct TestView: View {
    
        @State private var index: Int = 0
        @State private var offset: CGFloat = 0
    let url = Bundle.main.url(forResource: "Document", withExtension: "pdf")!
    @StateObject private var selectedTool = SelectedTool()

        var body: some View {
            GeometryReader { geometry in // 1. offset(scroll位置)を操作するため、GeometryReaderを利用
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<3) {_ in
                            
                            PDFDrawerView(fileURL:url)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .environmentObject(selectedTool)
                        }
                    }
                }
                .content.offset(x: self.offset) // 2. self.offsetとscrollViewのoffsetをバインディング
                .frame(width: geometry.size.width, height: nil, alignment: .leading)
                .gesture(DragGesture()
                    .onChanged({ value in  // 3. Dragを監視。Dragに合わせて、スクロールする。
                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                    })
                    .onEnded({ value in // 4. Dragが完了したら、Drag量に応じて、indexを更新
                        let scrollThreshold = geometry.size.width / 2
                        if value.predictedEndTranslation.width < -scrollThreshold {
                            self.index = min(self.index + 1, 2)
                        } else if value.predictedEndTranslation.width > scrollThreshold {
                            self.index = max(self.index - 1, 0)
                        }

                        withAnimation { // 5. 更新したindexの画像をアニメーションしながら表示する。
                            self.offset = -geometry.size.width * CGFloat(self.index)
                        }
                    })
                )
            }
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
