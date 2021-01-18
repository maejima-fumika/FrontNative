//
//  Path.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/15.
//

import Foundation

class Path:ObservableObject  {
    @Published var folderName:String?
    @Published var fileName:String?
    @Published var fileIndex:Int = 0
    @Published var URLs = [URL]()
}


