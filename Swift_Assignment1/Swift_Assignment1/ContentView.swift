//
//  ContentView.swift
//  Swift_Assignment1
//
//  Created by Dev Tech on 2025/08/01.
//
import SwiftUI

struct ContentView: View {
    @State private var statusMessage = "データベースを初期化中..."
    @State private var users: [User] = []
    private let dbManager: DatabaseManager
    
    init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbPath = documentsPath + "/database.sqlite"
        self.dbManager = DatabaseManager(dbPath: dbPath)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(statusMessage)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                
                Button("データベースをテスト") {
                    testDatabase()
                }
                .buttonStyle(.borderedProminent)
                
                if !users.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("登録済みユーザー:")
                            .font(.headline)
                        
                        ForEach(users, id: \.id) { user in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("ID: \(user.id) - \(user.name)")
                                    .font(.body)
                                Text("メール: \(user.email)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("年齢: \(user.age)歳")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("SQLite テスト")
        }
        .onAppear {
            initializeDatabase()
        }
    }
    
    private func initializeDatabase() {
        DispatchQueue.global(qos: .background).async {
            // テーブル作成
            dbManager.createTable()
            
            DispatchQueue.main.async {
                statusMessage = "データベース初期化完了"
            }
        }
    }
    
    private func testDatabase() {
        DispatchQueue.global(qos: .background).async {
            // テストデータを挿入
            let success1 = dbManager.insertUser(name: "James", email: "james@example.com", age: 25)
            let success2 = dbManager.insertUser(name: "Sophia", email: "sophia@example.com", age: 30)
            let success3 = dbManager.insertUser(name: "John", email: "john@example.com", age: 28)
            
            // データを取得
            let fetchedUsers = dbManager.getAllUsers()
            
            DispatchQueue.main.async {
                if success1 && success2 && success3 {
                    statusMessage = "データベーステスト成功！\(fetchedUsers.count)人のユーザーが登録されました"
                    users = fetchedUsers
                } else {
                    statusMessage = "データベーステストでエラーが発生しました"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
