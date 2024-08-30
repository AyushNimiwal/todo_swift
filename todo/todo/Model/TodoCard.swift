//
//  todoCard.swift
//  todo
//
//  Created by student-2 on 22/08/24.
//

import SwiftUI

struct TodoCard: View {
    @Binding var task : TaskCategory
    @ObservedObject var viewModel: TodoViewModel
    var colors : Color
    var body: some View {
        VStack{
            VStack{
                Rectangle()
                    .frame(width: 30,height: 2)
                    .cornerRadius(50)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: -7, trailing: 0))
                Rectangle()
                    .frame(width: 15,height: 2)
                    .cornerRadius(50)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            }
            HStack{
                Text(task.title)
                    .frame(width: 80)
                    .font(.title3)
                    .foregroundColor(.white)
                Spacer()
                HStack{
                    task.isliked ?
                        Image(systemName: "heart.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white.opacity(0.3))
                    :
                        Image(systemName: "heart")
                            .imageScale(.large)
                            .foregroundColor(Color.white.opacity(0.3))
                }
                .padding(EdgeInsets(top: 17, leading: 15, bottom: 17, trailing: 15))
                .background(task.isliked ? Color.white.opacity(0.1) : Color.white.opacity(0.2) )
                .cornerRadius(100)
                .onTapGesture {
                    withAnimation {
                        task.isliked.toggle()
                        viewModel.updateTodoLikedStatus(task, isLiked: task.isliked)
                        viewModel.saveTodos()
                    }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment:.topLeading)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 2, trailing: 8))
            Text("updated \(formatTimeAgo(task.createdTime))")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.6))
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 4, trailing: 0))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
        }
        .padding(5)
        .frame(maxWidth: .infinity)
        .background(colors.opacity(0.6))
        .clipShape(UnevenRoundedRectangle(
            topLeadingRadius: 0,
            bottomLeadingRadius: 20,
            bottomTrailingRadius: 20,
            topTrailingRadius: 20
        ))
    }
    
    func formatTimeAgo(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct TodoCard_Previews: PreviewProvider {
    @State static var task = TaskCategory(id: UUID(), title: "Sample Task", category: "Work", contents: "This is a sample task", createdTime: Date())
    static let colors = generateColorArray()
    static var previews: some View {
        let viewModel = TodoViewModel()
        TodoCard(task: $task, viewModel: viewModel,colors: colors[0])
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
