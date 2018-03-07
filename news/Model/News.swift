//
//  News.swift
//  news
//
//  Created by Kaustubh on 05/03/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class News: Object {
    @objc dynamic var title = ""
    @objc dynamic var n_description = ""
    @objc dynamic var urlToImage = ""
    @objc dynamic var url = ""
  @objc dynamic var n_id = UUID().uuidString
   
//    public required init() {
//        super.init()
//    }
    
    convenience init(dictionary: NSDictionary)
    {
        self.init()
        if let ltitle = dictionary["title"]
        {
            title = ltitle as! String
        }
        
        if let ltitle = dictionary["description"]
        {
            if !(ltitle is NSNull)
            {
                n_description = ltitle as! String
            }
        }
        if let ltitle = dictionary["urlToImage"]
        {
            if !(ltitle is NSNull)
            {
                urlToImage = ltitle as! String
            }
        }
        if let ltitle = dictionary["url"]
        {
            if !(ltitle is NSNull)
            {
                url = ltitle as! String
            }
        }
    }
    
    override static func primaryKey() -> String? {
        return "url"
    }
    
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }
    //
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }

    
    //    private enum CodingKeys : String, CodingKey {
//        case title, news_description = "description", urlToImage, url
//    }
}
