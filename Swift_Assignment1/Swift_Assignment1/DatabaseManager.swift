//
//  DatabaseManager.swift
//  Swift_Assignment1
//
//  Created by Dev Tech on 2025/08/01.
//

import SQLite3
import Foundation

struct User {
    let id: Int
    let name: String
    let email: String
    let age: Int
}

class DatabaseManager {
    private var db: OpaquePointer?
    
    init(dbPath: String) {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("データベースが正常に開かれました")
        } else {
            print("データベースを開けませんでした")
        }
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    func createTable() {
        let createTableSQL = """
            CREATE TABLE IF NOT EXISTS Users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                email TEXT NOT NULL,
                age INTEGER
            );
        """
        
        if sqlite3_exec(db, createTableSQL, nil, nil, nil) == SQLITE_OK {
            print("テーブルが正常に作成されました")
        } else {
            print("テーブル作成に失敗しました")
        }
    }
    
    func insertUser(name: String, email: String, age: Int) -> Bool {
        let insertSQL = "INSERT INTO Users (name, email, age) VALUES (?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, name, -1, nil)
            sqlite3_bind_text(statement, 2, email, -1, nil)
            sqlite3_bind_int(statement, 3, Int32(age))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("ユーザーが正常に挿入されました")
                sqlite3_finalize(statement)
                return true
            } else {
                print("ユーザー挿入に失敗しました")
            }
        } else {
            print("INSERT文の準備に失敗しました")
        }
        
        sqlite3_finalize(statement)
        return false
    }
    
    func getAllUsers() -> [User] {
        let querySQL = "SELECT id, name, email, age FROM Users"
        var statement: OpaquePointer?
        var users: [User] = []
        
        if sqlite3_prepare_v2(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_int(statement, 0)
                let name = String(cString: sqlite3_column_text(statement, 1))
                let email = String(cString: sqlite3_column_text(statement, 2))
                let age = sqlite3_column_int(statement, 3)
                
                let user = User(id: Int(id), name: name, email: email, age: Int(age))
                users.append(user)
            }
        } else {
            print("SELECT文の準備に失敗しました")
        }
        
        sqlite3_finalize(statement)
        return users
    }
}
