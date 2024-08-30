//
//  DashBoard.swift
//  todo
//
//  Created by student-2 on 23/08/24.
//

import SwiftUI

struct DashBoard: View {
    @Binding var isShowMethod: Bool 
    @State var animate : Bool = true
    @State var isShowMenu : Bool = false
    @State var selectedCategory : String? = "All"
    @StateObject private var viewModel = TodoViewModel()
    @State private var filteredTodo: [TaskCategory] = []
    let colors = generateColorArray()
    var body: some View {
        NavigationView {
            ZStack{
                Circle()
                    .foregroundStyle(Color("Skin"))
                    .frame(width: 250)
                    .offset(x : animate ? 40 : -10, y: animate ? -200 : -100)
                    .animation(.easeIn(duration: 3).repeatForever(), value: animate)
                    .blur(radius: 100)
                Circle()
                    .frame(width: 250)
                    .foregroundStyle(Color("Sky"))
                    .offset(x : animate ? 50 : 10, y: animate ? 200 : 100)
                    .animation(.easeIn(duration: 3).repeatForever(), value: animate)
                    .blur(radius: 100)
                    .onAppear {
                        animate = false
                    }
                VStack{
                    HStack{
                        Text("My \nTodos")
                            .frame(alignment: .leading)
                            .font(.system(size: 55, weight: .semibold))
                            .foregroundColor(Color("Skin"))
                            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                        Button(action: {
                            withAnimation{
                                isShowMethod.toggle()
                            }
                        }, label: {
                            HStack{
                                Image(systemName: "person.fill")
                                    .imageScale(.large)
                                    .scaleEffect(1.5)
                                    .foregroundColor(Color("Skin"))
                                    .padding(EdgeInsets(top: 20, leading: 18, bottom: 20, trailing: 18))
                            }
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(100)
                        })
                        .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 10))
                        
                    }
                    .frame(maxWidth:.infinity, alignment: .topLeading)
                    .padding(EdgeInsets(top: 25, leading: 15, bottom: 10, trailing: 10))
                    
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            Button(action: {
                                selectedCategory = "All"
                                updateFilteredTodos()
                            }) {
                                Text("All")
                                    .font(.title2)
                                    .foregroundColor(selectedCategory == "All" ? Color("Skin") : Color.white)
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .background(selectedCategory == "All" ? Color.black.opacity(0.6) : Color.black.opacity(0.4))
                                    .cornerRadius(30)
                                    .overlay(
                                        selectedCategory == "All" ?
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color("Skin"), lineWidth: 2)
                                            .padding(1)
                                        : nil
                                    )
                            }
                            ForEach(viewModel.categories, id:\.self){
                                cat in
                                HStack{
                                    Text("\(cat)")
                                        .font(.title2)
                                        .foregroundColor(Color("Skin"))
                                }
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.black.opacity(0.4))
                                .cornerRadius(30)
                                .overlay(
                                    selectedCategory == cat ?
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color("Skin"), lineWidth:2)
                                        .padding(1)
                                    : nil
                                )
                                .onTapGesture {
                                    selectedCategory = cat
                                    updateFilteredTodos()
                                }
                                
                            }
                        }
                        
                    }
                    .padding()
                    
                    ZStack{
                        VStack{
                            
                            ScrollView(.vertical,showsIndicators: false) {
                                ForEach(filteredTodo.indices, id:\.self){ index in
                                    VStack {
                                        HStack {
                                            if index * 3  < filteredTodo.count {
                                                TodoCard(task: $filteredTodo[index * 3 ], viewModel: viewModel, colors: colors[(index * 3 ) % colors.count])
                                            }
                                            if index * 3 + 1 < filteredTodo.count {
                                                TodoCard(task: $filteredTodo[index * 3 + 1], viewModel: viewModel, colors: colors[(index * 3 + 1) % colors.count])
                                            }
                                        }
                                        if index * 3 + 2 < filteredTodo.count {
                                            TodoCard(task: $filteredTodo[index * 3 + 2], viewModel: viewModel, colors: colors[(index * 3 + 2) % colors.count])
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                        
                        
                        
                        //MARK: ADD or MIC
                        HStack{
                            HStack{
                                NavigationLink(destination: AddTodo(viewModel: viewModel)){
                                    HStack{
                                        Image(systemName: "plus")
                                            .imageScale(.large)
                                            .scaleEffect(1.4)
                                            .foregroundColor(Color("Skin"))
                                    }
                                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                    .background(Blur(color: UIColor.black.withAlphaComponent(0.6)))
                                    .cornerRadius(100)
                                }
                                
                                HStack{
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "mic")
                                            .imageScale(.large)
                                            .scaleEffect(1.4)
                                            .foregroundColor(isShowMethod ? Color.yellow : Color("LimeGreen"))
                                    })
                                }
                                .padding(EdgeInsets(top: 16, leading: 20, bottom: 20, trailing: 20))
                                .background(isShowMethod ? Blur(color: UIColor.black.withAlphaComponent(0.4))
                                            : Blur(color: UIColor.white.withAlphaComponent(0.4))
                                )
                                .cornerRadius(100)
                            }
                            
                            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                            .background(isShowMethod ? Blur(color: UIColor.black.withAlphaComponent(0.2))
                                        : Blur(color: UIColor.white.withAlphaComponent(0.2)))
                            .cornerRadius(50)
                            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottom)
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        
                    }
                    
                    
                    
                }
                
                .onAppear(perform: {
                    updateFilteredTodos()
                })
                .cornerRadius(isShowMethod ? 30 : 0)
                
                
                
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
            .cornerRadius(60)
            .background( Color.clear)
            .ignoresSafeArea()
            
        }
        
    }
    private func updateFilteredTodos() {
        if selectedCategory == "All" {
            filteredTodo = viewModel.todos
        }
        else {
            filteredTodo = viewModel.todos.filter { $0.category == selectedCategory }
        }
    }
    func resetUserDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        print("UserDefaults cleared")
    }
    
}


struct DashBoard_Preview: PreviewProvider {
    @State static var isShowMethod: Bool = false
    static var previews: some View {
        
        DashBoard(isShowMethod:$isShowMethod)
    }
}
