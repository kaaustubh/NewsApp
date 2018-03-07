//
//  ViewController.swift
//  news
//
//  Created by Kaustubh on 05/03/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var newss = uiRealm.objects(News.self)
    var currentIndex = 5
    @IBOutlet weak var tableView: UITableView!
    
    func configureCell(cell: NewsCell, index: Int)
    {
        let news = newss[index]
        cell.lblTitle.text = news.title
        cell.lblDescription.text = news.n_description
        cell.imgPhoto.downloadFrom(link: news.urlToImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if newss.count < currentIndex
        {
            currentIndex = newss.count
        }
        NewsManager.sharedInstance.updateLatestNewsFeed(completionHandler: {[weak self]success in
                if success
                {
                    self!.tableView.reloadData()
            }
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        configureCell(cell: cell, index: indexPath.row)
        return cell
    }
}

extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath)
    {
        let news = newss[indexPath.row]
        if UIApplication.shared.canOpenURL(URL(string: news.url)!)
        {
            UIApplication.shared.open(URL(string : news.url)!, options: [:], completionHandler: { (status) in
                
            })
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == currentIndex-1 && !(currentIndex == newss.count)
        {
            currentIndex += 5
            if newss.count < currentIndex
            {
                currentIndex = newss.count
            }
            tableView.reloadData()
        }
    }
}
