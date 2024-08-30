//
//  TaskCategory.swift
//  todo
//
//  Created by student-2 on 19/08/24.
//

import SwiftUI






struct TaskCategory:Codable, Identifiable {
    var id: UUID
    var title: String
    var category: String
    var contents: String
    var isliked: Bool = false
    var createdTime: Date
}


func generateVibrantColor() -> Color {
    let hue = Double.random(in: 0...1) 
    let saturation = Double.random(in: 0.6...1)
    let brightness = Double.random(in: 0.6...1)
    
    return Color(hue: hue, saturation: saturation, brightness: brightness)
}

func generateColorArray() -> [Color] {
    return (0..<10).map { _ in generateVibrantColor() }
}

