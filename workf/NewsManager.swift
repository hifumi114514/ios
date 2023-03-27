//
//  NewsManager.swift
//  workf
//
//  Created by 周子康 on 2021/5/28.
//

import Foundation

class NewsManager
{
    static let shared:NewsManager = NewsManager(filename: "News")
    
    var news:[News] = []
    var curPage:Int = 1
    var pageSize = 10
    
    var Url : URL
    init(filename:String) {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            Url = path.appendingPathComponent(filename)
        }
    func Save(){
            let encoder = JSONEncoder()
            
            do{
                let encodeData: Data? = try encoder.encode(news)
                try encodeData!.write(to: Url, options: .atomic)
            }
            catch{
                print(error)
            }
        }
        
        func Load(){
            do{
                if let encodeData = try? Data.init(contentsOf: Url){
                    let decoder = JSONDecoder()
                    news = try decoder.decode([News].self,from: encodeData)
                }
            }
            catch{
                print(error)
            }
        }
    
    func fetchMore( complete:@escaping ()->Void) {
        curPage += 1
        fetchData(complete: complete)
    }
    
    func refresh( complete:@escaping  ()->Void)  {
        news.removeAll()
        curPage = 1
        fetchData(complete: complete)
    }
    
    private func fetchData(complete: @escaping ()->Void)
    {
        let url = URL(string: "http://zy.whu.edu.cn/news/api/news/getList?page=\(curPage)&count=\(pageSize)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let moreNews = try? JSONDecoder().decode(NewsResponse.self, from:data)
                {
                    moreNews.result.forEach{self.news.append($0)}
                    //print(moreNews.result)
                    //Thread.sleep(forTimeInterval: 5)
                    complete()
            }
        }
        task.resume()
    }
}
