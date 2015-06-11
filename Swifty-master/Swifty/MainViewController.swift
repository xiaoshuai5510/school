
//
//  MainViewController.swift
//  Swifty
//
//  Created by libs on 15/6/9.
//  Copyright (c) 2015年 Flowers Designs. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire


class MainViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, PZPullToRefreshDelegate {
    
    //var items = ["Evernote"]
    var news:[New]=[]
 
    @IBOutlet weak var tableView: UITableView!
    
    var refreshHeaderView: PZPullToRefreshView?
    
    override func viewDidLoad() {
        //获取网络接口数据
         getData();
       
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        if refreshHeaderView == nil {
            var view = PZPullToRefreshView(frame: CGRectMake(0, 0 - tableView.bounds.size.height, tableView.bounds.size.width, tableView.bounds.size.height))
            view.delegate = self
            self.tableView.addSubview(view)
            refreshHeaderView = view
        }
    }
    
    //获取服务器数据
    func getData()
    {
        //self.news.removeAll(keepCapacity: false)
        let NewsListUrl="http://101.200.174.99:8080/school/system.do"
        let parameters=["action":"queryByCondition","funcId":"s11111","uesrname":"jz_20151101001","password":"123456"]
        Alamofire.request(.POST, NewsListUrl, parameters: parameters)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                }
                else {
                    println(request)
                    var json = JSON(json!)
                    println(json)
                    var success:Bool=json["success"].bool!
                    if success
                    {
                        var jsonarray=json["data"].array!
                        var count=jsonarray.count
                        self.news.removeAll(keepCapacity: false)
                        for(var i=0;i<count;i++)
                        {
                            var jsonx=jsonarray[i]
                            var time=jsonx["time"].string!
                            var content=jsonx["content"].string!
                            var title=jsonx["title"].string!
                            var new=New()
                            new.setContent(content)
                            new.setTime(time)
                            new.setTitle(title)
                            println(new.getTitle())
                            self.news.append(new);
                            //self.news[i]=new
                        }
                        var newcount=self.news.count
                        for(var i=0;i<newcount;i++)
                        {
                            var new=self.news[i]
                            println(new.getTitle())
                        }
                      

                    }
                    else
                    {
                        println("获取了网络数据，但是结果失败！");
                    }
                }
        }
            }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return items.count
        return news.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        //cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.text = news[indexPath.row].getTitle()
        return cell
    }
    
    // MARK:UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
      
        refreshHeaderView?.refreshScrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshHeaderView?.refreshScrollViewDidEndDragging(scrollView)
    }
    
    // MARK:PZPullToRefreshDelegate
    
    func pullToRefreshDidTrigger(view: PZPullToRefreshView) -> () {
        refreshHeaderView?.isLoading = true
        getData()
        self.tableView.reloadData()
        //let delay = 3.0 * Double(NSEC_PER_SEC)
        let delay = 0
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            println("Complete loading!")
            self.refreshHeaderView?.isLoading = false
            self.refreshHeaderView?.refreshScrollViewDataSourceDidFinishedLoading(self.tableView)
        })
    }
    
    // Optional method
    
    func pullToRefreshLastUpdated(view: PZPullToRefreshView) -> NSDate {
        return NSDate()
    }
    
}
