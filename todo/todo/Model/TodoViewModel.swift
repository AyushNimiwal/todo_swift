//
//  TodoViewModel.swift
//  todo
//
//  Created by student-2 on 23/08/24.
//

import SwiftUI
import Combine

class TodoViewModel: ObservableObject {
    @Published var todos: [TaskCategory] = [] {
        didSet {
            saveTodos()
        }
    }
    
    @Published var categories: [String] = [] {
        didSet {
            saveCategories()
        }
    }
    
    init() {
        loadTodos()
        loadCategories()
    }
    
    @Published var selectedCategory: String? = "All"
    
    var filteredTodos: [TaskCategory] {
        if let category = selectedCategory {
            return todos.filter { $0.category == category }
        }
        return todos
    }
    
    func saveTodos() {
            if let encoded = try? JSONEncoder().encode(todos) {
                UserDefaults.standard.set(encoded, forKey: "todos")
            }
    }
    
    func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: "todos"),
           let decoded = try? JSONDecoder().decode([TaskCategory].self, from: data) {
            todos = decoded
        }
    }
    
    func saveCategories() {
        UserDefaults.standard.set(categories, forKey: "categories")
    }
    
    func loadCategories() {
        if let savedCategories = UserDefaults.standard.stringArray(forKey: "categories") {
            categories = savedCategories
        }
    }
    
    func updateTodoLikedStatus(_ todo: TaskCategory, isLiked: Bool) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isliked = isLiked
        }
    }
}
