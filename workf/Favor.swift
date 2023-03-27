//
//  Favor.swift
//  workf
//
//  Created by NICOLAS ENRICO. on 2021/6/7.
//

import Foundation
class Favor{
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        /*
        if !sqlite.openDB(){
            return
        }*/
        sqlite.openDB()

        let createSql = "CREATE TABLE IF NOT EXISTS favor1('title' TEXT PRIMARY KEY NOT NULL, " + "'path' TEXT, 'passtime' TEXT, 'image' TEXT);"
        if !sqlite.execNoneQuerySQL(sql: createSql){sqlite.closeDB();return}
    
        
        sqlite.closeDB()
    }
    //查询所有收藏的新闻
    static func GetFavor()->[[String:AnyObject]]{
        let sqlite = SQLiteManager.sharedInstance
        /*
        do{
            try sqlite.openDB()
        }catch{
            print(error)
        }*/
        
        sqlite.openDB()
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM favor1")
        sqlite.closeDB();
        
        if queryResult?.count == 0{
            exit(0)
        }else{
            return queryResult!
        }
        
        /*
        print(queryResult!)
        
        for row in queryResult!{
            print(row["name"]!)
        }*/
        
    }
    
    //根据标题搜索收藏新闻
    static func SearchFavor(title:String)->[[String:AnyObject]]
    {
        let sqlite = SQLiteManager.sharedInstance
        /*
        if !sqlite.openDB(){
            return
        }*/
        sqlite.openDB()
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM favor1 WHERE title like '%\(title)%'")
        /*
        print(queryResult!)
        
        for row in queryResult!{
            print(row["name"]!)
        }*/
        sqlite.closeDB();
        return queryResult!
    }
    //删除新闻
    static func Delete(title:String)
    {
        let sqlite = SQLiteManager.sharedInstance
        /*
        if !sqlite.openDB(){
            return
        }*/
        sqlite.openDB()
        sqlite.execNoneQuerySQL(sql: "DELETE FROM favor1 WHERE title = '\(title)'")
        /*
        print(queryResult!)
        
        for row in queryResult!{
            print(row["id"]!)
        }*/
        sqlite.closeDB();
    }
    //收藏新闻
    static func AddFavor(news:News)
    {
        let sqlite = SQLiteManager.sharedInstance
        /*
        if !sqlite.openDB(){
            return
        }*/
        sqlite.openDB()
        sqlite.execNoneQuerySQL(sql: "INSERT INTO favor1(title,path,passtime,image)  VALUES('\(news.title)','\(news.path)','\(news.passtime)','\(news.image)');")
        
        /*
        for row in queryResult!{
            print(row["id"]!)
        }*/
        sqlite.closeDB();
    }
    
}
