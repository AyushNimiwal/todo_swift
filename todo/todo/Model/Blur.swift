//
//  Blur.swift
//  todo
//
//  Created by student-2 on 20/08/24.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var removeAllFilters: Bool = false
    var color: UIColor = .clear
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context){
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                }else {
                    backdropLayer.filters?.removeAll(where: {
                        filter in String( describing: filter) != "gaussianBlur"
                    })
                }
            }
            uiView.backgroundColor = color
        }
    }
}

#Preview {
    Blur()
}
