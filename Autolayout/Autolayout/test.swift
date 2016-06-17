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
    
    static func userLogin(login:String , passowrd: String ) -> User? {
        if let user = abc[login] {
            if user.password == passowrd {
                return user
            }
        }
        return nil
    }
    
    static let abc: Dictionary<String , User> = {
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
//struct's properties if it is declared let and has initial value, then it always being a immutable value.
//所以當他是被定義的常數之後 而且擁有初始值 則可以在此struct自動生成member wise initializer中被忽略（因為已經賦值了)
//反之 如果定義為 var 則代表他可以被更改 所以在初始時能需要填入值
