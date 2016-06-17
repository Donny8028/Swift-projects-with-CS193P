//
//  test.swift
//  Psychologist
//
//  Created by 賢瑭 何 on 2016/2/26.
//  Copyright © 2016年 Donny. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login:String , passowrd: String ) -> User? {
        if let user = abc[login] {
            if user.password == passowrd {
                return user
            }
        }
        return nil
    }
    
     static let abc: Dictionary<String , User>  = {
        var abcd = Dictionary<String , User>()
        for h in [
            User(name: "Donny", company: "ho", login: "aaa", password: "5566") ,
            User(name: "Mary", company: "ho", login: "sss", password: "5566"),
            User(name: "Lisa", company:"ho", login: "bbb" , password: "5566")
            ]{
                abcd[h.login] = h
        }
        return abcd
    }()

}