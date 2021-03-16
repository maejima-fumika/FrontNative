//
//  ActionButtons.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/02/04.
//

import SwiftUI
import Zip

struct ActionButtons: View {
    @Binding var selectedItems:Set<ItemAttribute>
    @Binding var folders:[ItemAttribute]
    @Binding var showSheet:Bool
    @Binding var selectedURLs:[URL]
    
    
    var body: some View {
        HStack(alignment:.center){
            Spacer()
            VStack{
                Button(action: {
                    for item in selectedItems{
                        do {
                            let fileURLs = getDirItems(dirURL: item.url)
                            let zipFilePath = try Zip.quickZipFiles(fileURLs, fileName: item.name)  // Zip
                            selectedURLs.append(zipFilePath)
                        }
                        catch {
                          print("Something went wrong")
                        }

                    }
                    self.showSheet = true
                }) {
                    Image(systemName:"square.and.arrow.up")
                        .scaleEffect(1.3)
                }
                Text("共有")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 5.0)
            }
            Spacer()
            VStack{
                Button(action: {
                    
                }) {
                    Image(systemName:"trash")
                        .scaleEffect(1.3)
                        .foregroundColor(.red)
                }
                
                Text("削除")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.top, 5.0)
            }
            Spacer()
        }
    }
    
    func getDirItems(dirURL:URL) -> [URL] {
        let fileManager = FileManager.default
        var urls = [URL]()
        do {
            let fileNames = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil,options: [.skipsHiddenFiles])
            for fileName in fileNames {
                let fileURL = dirURL.appendingPathComponent(fileName.lastPathComponent)
                urls.append(fileURL)
            }
        } catch {
            print("Error: \(error)")
        }
        return urls
    }
}

//struct ActionButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionButtons()
//    }
//}
