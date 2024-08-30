//
//  ContentView.swift
//  todo
//
//  Created by student-2 on 19/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var isShowMethod: Bool = false
    var body: some View {
        
        VStack{
            
            
            DashBoard(isShowMethod:$isShowMethod)
                .padding(EdgeInsets(top: isShowMethod ? 150 : 0, leading: 0, bottom: 0, trailing: 0))
                
        }
        .background(isShowMethod ? Color.white : Color.clear)
        .ignoresSafeArea()
        }
    }


#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
