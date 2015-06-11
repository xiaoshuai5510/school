//
//  New.swift
//  Swifty
//
//  Created by libs on 15/6/10.
//  Copyright (c) 2015年 Flowers Designs. All rights reserved.
//

import Foundation

class New
{    var c_id:Int=0
    var time:String=""
    var id:Int=0
    var content:String=""
    var title:String=""
    
    func getTime()->String
    {
        return time
    }
    func getContent()->String
    {
        return content
    }
    func getTitle()->String
    {
        return title
    }
    func setTime(time:String)
    {
        self.time=time
    }
    func setContent(content:String)
    {
        self.content=content
    }
    func setTitle(title:String)
    {
        self.title=title
    }
}