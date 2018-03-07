//
//  NewsManager.swift
//  news
//
//  Created by Kaustubh on 05/03/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation
import RealmSwift

let uiRealm = try! Realm()

class NewsManager: NSObject {
    static let sharedInstance = NewsManager()
    var newss = uiRealm.objects(News.self)
    
    let newsUrl = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=a8fabd9ff4234c82aad08eaaa4ea17a0"
    
    func updateLatestNewsFeed(completionHandler:@escaping (_ succes: Bool) -> ())
    {
        let httpManager = HTTPManager.sharedInstance
        httpManager.request(urlPath: newsUrl, headers: [:], completionHandler: { data , response ,error in
            if error != nil || data == nil
            {
                completionHandler(false)
            }
            else
            {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String:Any] {
                        let articlesJson = json["articles"] as! NSArray
                        for article in articlesJson
                        {
                            let news = News(dictionary: article as! NSDictionary)
                            let searchResult = uiRealm.object(ofType: News.self, forPrimaryKey: news.url)
                            if searchResult == nil
                            {
                                try! uiRealm.write{
                                 uiRealm.add(news)
                                }
                            }
                        }
                        completionHandler(true)
                    }
                } catch let err{
                    print(err.localizedDescription)
                    completionHandler(false)
                }
                
            }
        }, httpMethod: .get)
        
    }
    
    func getNews(index: Int) -> [News]
    {
        var arr = [News]()
        for i in index..<(index+5)
        {
            arr.append(newss[i])
        }
        return arr
    }
    
}
