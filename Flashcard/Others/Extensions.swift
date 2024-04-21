//
//  Extensions.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 01/04/2024.
//

import Foundation
import SwiftUI

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

extension Color {
    func toHex() -> Color {
        let components = self.cgColor?.components
        let r = components?[0] ?? 0
        let g = components?[1] ?? 0
        let b = components?[2] ?? 0
        
        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}
