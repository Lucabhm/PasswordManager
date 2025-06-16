//
//  Structs.swift
//  Password Manager
//
//  Created by Luca Böhm on 15.06.25.
//

import Foundation

struct PasswordEntry: Identifiable, Codable {
    let id: UUID
    var title: String
    var username: String
    var password: String
    var url: String

    init(id: UUID = UUID(), title: String, username: String, password: String, url: String) {
        self.id = id
        self.title = title
        self.username = username
        self.password = password
        self.url = url
    }
}
