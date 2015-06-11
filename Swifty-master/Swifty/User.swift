//
//  User.swift
//  Swifty
//
//  Created by libs on 15/6/9.
//  Copyright (c) 2015年 Flowers Designs. All rights reserved.
//

import Foundation

class User {
    var username:String=""
    var password:String=""
    var id:Int=0
    func getUsername()->String
    {
        return username
    }
    func getPassword()->String
    {
        return password
    }
    func getId()->Int
    {
        return id
    }
    func setUsername(username: String)
    {
        self.username=username
    }
    func setPassword(passwd: String)
    {
        self.password=passwd
    }
    func setId(id: Int)
    {
        self.id=id
    }}