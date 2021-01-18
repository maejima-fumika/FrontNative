//
//  javascript.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/11.
//

import Foundation

class Javascript1: NSObject {
    let answerString:String
    
    init(answerString:String) {
        self.answerString = answerString
    }
    
    struct Answer:Decodable {
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
    
    struct DecodedAnswer {
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
    
    struct detail {
        var id:Int
        var radio:Bool
        var memo:String
    }

    func decodeAnswer() -> DecodedAnswer?{
        let jsonData = answerString.data(using: .utf8)!
        let decoder = JSONDecoder()
        guard let objs = try? decoder.decode(Answer.self, from: jsonData) else {
            return nil
        }
        print("hello")
        print(objs)
        var details = [detail]()
        //var arr = objs.d.removingPercentEncoding
        let arr = objs.d.split(separator: "?")
        for i in 0..<arr.count {
            let radio = arr[i].prefix(1)=="1"
            let memo = String(arr[i].suffix(arr[i].count - 1).removingPercentEncoding ?? "NaN")
            let dt=detail(id:i+1,radio: radio, memo:memo)
            details.append(dt)
        }
        return DecodedAnswer(
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
    
    func mkScript() -> String {
        guard let da = decodeAnswer() else{
            return "'no javascript'"
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
    
    func mkFilePath(path:Path){
        guard let da = decodeAnswer() else{
            return
        }
        path.fileName = da.uid + "_" + da.name
        //path.fileName = da.uid
        path.folderName = da.eid
        return
    }

    
}

