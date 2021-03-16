//
//  javascript.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/11.
//

import Foundation

class Javascript2: ObservableObject {
    var answerString:String?
    @Published var saveURL:URL?
    private var decodedAnswer:Answer?
    
    private struct Answer:Decodable {
        let eid:String
        let uid:String
        let n:String
        let a:String
        let g:String
        let q:[Int]
    }
    
    func setupAnswer(answerString:String){
        self.answerString = answerString
        decodeAnswer()
        mkSaveURL()
    }
    
//    private struct DecodedAnswer {
//        var eid:String
//        var uid:String
//        var name:String
//        var age:String
//        var gender:String
//        var questions:[Int]
//    }
    private func decodeAnswer(){
        guard let jsonData = answerString?.data(using: .utf8)! else {
            return
        }
        let decoder = JSONDecoder()
        guard let objs = try? decoder.decode(Answer.self, from: jsonData) else {
            return
        }
        decodedAnswer = objs
        print(decodedAnswer as Any)
        
    }
    
    func mkScript() -> String? {
        guard let da = decodedAnswer else {
            return nil
        }
        var javascript = """
            document.getElementById("n").innerHTML = "\(da.n)";
            document.getElementById("a").innerHTML = "\(da.a)";
            document.getElementById("g").innerHTML = "\(da.g)";
        """
        for i in 0..<da.q.count {
            if i != 25 {
                let add_id = "q" + String(i+1) + "_a" + String(da.q[i]+1)
                javascript += """
                    document.getElementById("\(add_id)").className = "yes";
                    """
            }
        }
        return javascript
    }
    
    private func mkSaveURL(){
            guard let da = decodedAnswer else{
                return
            }
            let folderName = da.eid
            let fileName = da.uid + "_" + da.n
            let path = folderName + "/" + fileName + ".pdf"
            //Directoryを作成する。存在する場合は作られない
            guard let directoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(folderName) else { return }
            do {
                try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
                print("Directory created at:",directoryUrl)
            } catch let error as NSError {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
            //ファイル保存用のURLを作成する。ちなみに、Pathの作成はjavascriptの中の.mkFilePathで行っている。
            guard let url = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(path) else { return }
            saveURL = url
            return
        }
    
    func mkFilePath(path:Path){
        guard let da = decodedAnswer else{
            return
        }
        path.fileName = da.uid + "_" + da.n
        path.folderName = da.eid
        return
    }
    
    func mkFileName() -> String? {
        guard let da = decodedAnswer else{
            return nil
        }
        return da.uid + "_" + da.n
    }
    
    func folderName() -> String? {//addNewFolderでつかってる
        guard let da = decodedAnswer else{
            return nil
        }
        return da.eid
    }
}

