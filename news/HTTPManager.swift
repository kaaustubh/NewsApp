//
//  HTTPManager.swift
//  news
//
//  Created by Kaustubh on 05/03/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation

enum HTTPMethod: String{
    case get = "GET",
    post = "POST",
    put = "PUT",
    patch = "PATCH"
}

class HTTPManager: NSObject
{
    static let sharedInstance = HTTPManager()
    var urlSessionConfig: URLSessionConfiguration!
    var urlSession: URLSession!
    
    private override init() {
        urlSessionConfig = URLSessionConfiguration.default
        urlSession = URLSession(configuration: urlSessionConfig)
    }
    
    func request(urlPath: String, headers: [String: String], completionHandler: @escaping (Data?, URLResponse?, Error?) ->(), httpMethod: HTTPMethod)
    {
        let url = URL(string: urlPath)!
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        add(headers: headers, toRequest: urlRequest)
        let task = urlSession.dataTask(with: urlRequest as URLRequest, completionHandler: {data, response, error -> Void in
            DispatchQueue.main.async{
                if (data != nil){
                    completionHandler(data, response, error)
                }
            }
        })
        task.resume()
    }
    
    private func add(headers: [String:String], toRequest request: NSMutableURLRequest)
    {
        for header in headers
        {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
}
