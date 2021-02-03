//
//  PDFScrollView.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/21.
//

import SwiftUI

struct PDFScrollView: View {
    @State private var offset: CGFloat = 0
    @EnvironmentObject var path:Path
    var files : [ItemAttribute]
    @Binding var index:Int
    //let url = Bundle.main.url(forResource: "Document", withExtension: "pdf")!
//    init(files:[ItemAttribute],index:Int) {
//        self.files = files
//        self.index = index
//        print("PDFScrollView")
//    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(files, id:\.self){ file in
                        PDFDrawerView(fileURL:file.url)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, height: nil, alignment: .leading)
            .onAppear{
                self.offset = -geometry.size.width * CGFloat(index)
            }
            .gesture(DragGesture()
                        .onChanged({ value in
                            self.offset = value.translation.width - geometry.size.width * CGFloat(index)
                        })
                        .onEnded({ value in
                            let scrollThreshold = geometry.size.width / 2
                            if value.predictedEndTranslation.width < -scrollThreshold {
                                index = min(index + 1, files.count-1)
                            } else if value.predictedEndTranslation.width > scrollThreshold {
                                index = max(index - 1, 0)
                            }
                            
                            withAnimation {
                                self.offset = -geometry.size.width * CGFloat(index)
                            }
                        })
            )
        }
    }
}

//struct PDFScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFScrollView()
//    }
//}