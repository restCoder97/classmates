//
//  NetWork.swift
//  ECampus
//
//  Created by Bill Chen on 9/5/20.
//  Copyright © 2020 Youxing Chen. All rights reserved.
//

import Foundation
import AuthenticationServices;
import MessageUI
class socket{
    let session = URLSession.shared
    var strUrl:String?;
    var url :URL?
    var jsonArrary:[Any]? ;

    init(string:String) {
        strUrl = string;
        url = URL(string: strUrl!);
    }
    func downloadJSONFromURl(){
        //用于读取并解析服务端发来的消息
            URLSession.shared.dataTask(with: self.url!) { data, response, error in
                     if let data = data {
                        _ = String(data: data, encoding: .utf8)!
                        self.jsonArrary = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [Any]
                      }
                  }.resume()
    }
    
    
}
