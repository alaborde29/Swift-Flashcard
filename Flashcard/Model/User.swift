//
//  User.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 31/03/2024.
//

import Foundation

class User: Codable {
    let id: String
    let fullName: String
    let mail: String
    let joined: Date
}
