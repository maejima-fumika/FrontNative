//
//  ListOfDirItems.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/19.
//
import Foundation

class ListOfDirItems {
    var items = [ItemAttribute]()
    
    
    func setItems(dirURL:URL){
        //print(dirName)
        let fileManager = FileManager.default
        var n = 0
        
        do {
            //let fileNames = try fileManager.contentsOfDirectory(atPath: dirURL.path)
            let fileNames = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil,options: [.skipsHiddenFiles])
            for fileName in fileNames {
                let fileURL = dirURL.appendingPathComponent(fileName.lastPathComponent)
                let fileAttribute = try fileManager.attributesOfItem(atPath: fileURL.path)
                let filecreationDate = fileAttribute[FileAttributeKey.creationDate] as! Date
                let itemAttribute = ItemAttribute(id:n, name:fileName.lastPathComponent, date:filecreationDate,url: fileURL)
                items.append(itemAttribute)
                n += 1
            }
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    
    func sortByDate()->[ItemAttribute]{
        var sortedItems = items.sorted(by: { lItem, rItem -> Bool in
            return lItem.date < rItem.date
        })
        for i in 0..<sortedItems.count {
            sortedItems[i].id = i
        }
        return sortedItems
    }
    
}

class SortItems: ObservableObject {
    enum SortMode:String, Identifiable, CaseIterable {
        case date = "日付"
        case name = "名前"
        
        var id: String { self.rawValue }
        
        func sortedItems(items:[ItemAttribute])->[ItemAttribute]{
            switch self {
            case .date:
                let sortedItems = items.sorted(by: { lItem, rItem -> Bool in
                    return lItem.date > rItem.date
                })
                return sortedItems
            case .name:
                let sortedItems = items.sorted(by: { lItem, rItem -> Bool in
                    return lItem.name < rItem.name
                })
                return sortedItems
//            default:
//                return items
            }
        }
    }
   
    @Published var currentMode:SortMode = .date
    
}

struct ItemAttribute:Hashable {
    var id:Int
    var name:String
    var date:Date
    var url:URL
}

