//
//  News.swift
//  workf
//
//  Created by 周子康 on 2021/5/28.
//

import Foundation

class News:NSObject, Codable
{
    var title:String = ""
    var path:String = ""
    var passtime:String = ""
    var image:String = ""
    
    private enum CodingKeys: String, CodingKey{
        case title
        case path
        case passtime
        case image
    }
    override init() {
        
    }
    init(title:String,path:String,passtime:String,image:String)
    {
        self.title = title
        self.path = path
        self.passtime = passtime
        self.image = image
    }
    
    override var description: String {
        return "title:\(title),path:\(path),passtime:\(passtime),image:\(image)"
    }
}

class NewsResponse:NSObject, Codable
{
    var code:Int=0
    var result:[News] = []
    var message:String = ""
   
    private enum CodingKeys: String, CodingKey{
        case code
        case result
        case message
    }
}
