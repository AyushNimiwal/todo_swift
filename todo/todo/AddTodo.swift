//
//  menu.swift
//  todo
//
//  Created by student-2 on 20/08/24.
//

import SwiftUI

struct AddTodo: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var category: String = ""
    @State private var contents: String = ""
    @ObservedObject var  viewModel : TodoViewModel
    var body: some View {
        VStack{
            HStack{
                Button(action: {presentationMode.wrappedValue.dismiss()}) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.headline)
                            }
                            .padding(EdgeInsets(top: 16, leading: 18, bottom: 16, trailing: 18))
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                Spacer()
                HStack{
                    HStack{
                        HStack{
                            ZStack{
                                
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                            .background(Blur(color: UIColor.gray.withAlphaComponent(0.3)))
                        }
                        .frame(width: 60,height: 60)
                        .cornerRadius(100)
                        .offset(x:48)
                        .overlay{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("Skin"), lineWidth:3)
                                .padding(1)
                                .offset(x:48)
                        }
                        
                        HStack{
                            ZStack{
                                
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                            .background(Blur(color: UIColor.gray.withAlphaComponent(0.3)))
                            
                        }
                        .frame(width: 60,height: 60)
                        .cornerRadius(100)
                        .offset(x:24)
                        .overlay{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("Skin"), lineWidth:3)
                                .padding(1)
                                .offset(x:24)
                        }
                        
                        HStack{
                            ZStack{
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                            .background(Blur(color: UIColor.gray.withAlphaComponent(0.3)))
                        }
                        .frame(width: 60,height: 60)
                        .cornerRadius(100)
                        .overlay{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("Skin"), lineWidth:3)
                                .padding(1)
                        }

                        
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .trailing)
                }
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .topLeading)
            .padding(EdgeInsets(top: 40, leading: 10, bottom: 10, trailing: 10))
            
            ZStack{
                contents.isEmpty ? nil :
                VStack{
                    HStack{
                        Image(systemName: "checkmark")
                            .font(.system(size: 30))
                            .foregroundColor(Color.limeGreen)
                    }
                    .frame(width: 60,height: 60)
                    .background()
                    .cornerRadius(100)
                    .shadow(color:.black.opacity(0.3),radius: 5,x:0,y:5)
                    .onTapGesture {
                        
                        if(!title.isEmpty && !category.isEmpty && !contents.isEmpty){
                            let formattedCategory = category.prefix(1).capitalized + category.dropFirst().lowercased()
                            let newTask = TaskCategory(id: UUID(), title: title, category: formattedCategory, contents: contents,createdTime: Date())
                            
                            viewModel.todos.insert(newTask,at: 0)
                            
                            if let existingIndex = viewModel.categories.firstIndex(of: formattedCategory) {
                                
                                viewModel.categories.remove(at: existingIndex)
                                
                                viewModel.categories.insert(formattedCategory, at: 0)
                            } else {
                                
                                viewModel.categories.insert(formattedCategory, at: 0)
                            }
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity,alignment: .bottomTrailing)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 40))
                .zIndex(3)
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack {
                        Section(header:
                                    Text("Title")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        ) {
                            TextField("Enter title", text: $title)
                                .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .topLeading)
                        Section(header: Text("Category")
                            .font(.title2)) {
                            TextField("Enter category", text: $category)
                                    .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                        }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .topLeading)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Section(header: Text(""), content: {
                            ZStack(alignment: .topLeading) {
                               if contents.isEmpty {
                                   Text("Enter your note here...")
                                       .foregroundColor(Color.gray)
                                       .padding(.leading, 4)
                                       .padding(.top, 8)
                                       .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                               }
                                
                                TextEditor(text: $contents)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,minHeight: 500)
                                    .scrollContentBackground(.hidden)
                                    .fixedSize(horizontal: false, vertical: true)
                           }
                                
                        })
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .topLeading)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity,alignment: .topLeading)
                    .background(Color.clear)
                    .padding()
                }
                .defaultScrollAnchor(.bottom)
            }
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity,alignment: .topLeading)
        .background(Color("Skin"))
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct AddTodo_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TodoViewModel()
        AddTodo(viewModel: viewModel)
    }
}
