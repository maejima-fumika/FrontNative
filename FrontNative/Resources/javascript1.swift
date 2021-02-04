//
//  javascript.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/11.
//

import Foundation

class Javascript1: ObservableObject {
    var answerString:String?
    @Published var saveURL:URL?
    private var decodedAnswer:DecodedAnswer?
    
    private struct Answer:Decodable { 
        let eid:String
        let uid:String
        let n:String
        let a:String
        let g:String
        let b:String
        let c:String
        let cn:String
        let d:String
    }
    
    func setupAnswer(answerString:String){
        self.answerString = answerString
        decodeAnswer()
        mkSaveURL()
    }
    
    private struct DecodedAnswer {
        var eid:String
        var uid:String
        var name:String
        var address:String
        var gender:String
        var birth:String
        var company:String
        var companyName:String
        var details:[detail]
    }
    
    private struct detail {
        var id:Int
        var radio:Bool
        var memo:String
    }

    private func decodeAnswer(){
        guard let jsonData = answerString?.data(using: .utf8)! else {
            return
        }
        let decoder = JSONDecoder()
        guard let objs = try? decoder.decode(Answer.self, from: jsonData) else {
            return
        }
        var details = [detail]()
        //var arr = objs.d.removingPercentEncoding
        let arr = objs.d.split(separator: "?")
        for i in 0..<arr.count {
            let radio = arr[i].prefix(1)=="1"
            let memo = String(arr[i].suffix(arr[i].count - 1).removingPercentEncoding ?? "NaN")
            let dt=detail(id:i+1,radio: radio, memo:memo)
            details.append(dt)
        }
        decodedAnswer = DecodedAnswer(
            eid:objs.eid,
            uid: objs.uid,
            name:objs.n.removingPercentEncoding ?? "NaN",
            address:objs.a.removingPercentEncoding ?? "NaN",
            gender:objs.g.removingPercentEncoding ?? "NaN",
            birth:objs.b.removingPercentEncoding ?? "NaN",
            company:objs.c.removingPercentEncoding ?? "NaN",
            companyName:objs.cn.removingPercentEncoding ?? "NaN",
            details:details
        )
    }
    
    func mkScript() -> String? {
        guard let da = decodedAnswer else {
            return nil
        }
        var javascript = """
            document.getElementById("answer_name").innerHTML = "\(da.name)";
            document.getElementById("answer_address").innerHTML = "\(da.address)";
            document.getElementById("answer_birth").innerHTML = "\(da.birth)";
        """
        for i in 0..<da.details.count {
            javascript += """
                    document.getElementById("answer_\(String(da.details[i].id))_\(String(da.details[i].radio))").innerHTML = "✔︎";
                """
            javascript += """
                    document.getElementById("answer_\(String(da.details[i].id))_memo").innerHTML = "\(da.details[i].memo)";
                """
            
        }
        return javascript
    }
    
    private func mkSaveURL(){
            guard let da = decodedAnswer else{
                return
            }
            let folderName = da.eid
            let fileName = da.uid + "_" + da.name
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
        path.fileName = da.uid + "_" + da.name
        path.folderName = da.eid
        return
    }
    
    func mkFileName() -> String? {
        guard let da = decodedAnswer else{
            return nil
        }
        return da.uid + "_" + da.name
    }
    
    func folderName() -> String? {//addNewFolderでつかってる
        guard let da = decodedAnswer else{
            return nil
        }
        return da.eid
    }
}

