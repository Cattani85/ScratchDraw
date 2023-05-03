//
//  Button.swift
//  ScratchDraw
//
//  Created by CaTTani on 03/05/2023.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let action: (()->Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.custom.main
                    .frame(height: 60)
                    .cornerRadius(15)
                
                Text(self.title)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "test") {
            
        }
    }
}
