//
//  User.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 31/03/2024.
//

import Foundation

struct User: Codable {
    let id: String
    let fullName: String
    let email: String
    let joined: TimeInterval
}
