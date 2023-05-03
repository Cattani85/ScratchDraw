//
//  WipeView.swift
//  ScratchDraw
//
//  Created by CaTTani on 03/05/2023.
//

import SwiftUI

struct WipeView: View {
    @ObservedObject var draw: Draw
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing:0) {
                Spacer()
                    .frame(height: 20)
                
                HStack(spacing:0) {
                    Spacer()
                        .frame(width: 20)
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.custom.main)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.draw.stopWipe()
                            self.show = false
                        }
                    
                    Spacer()
                }
                
                Spacer()
                
                if self.draw.state == .notWiped {
                    Color.custom.main
                        .cornerRadius(15)
                        .frame(height: 200)
                        .padding(.horizontal, 40)
                }
                else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.custom.main, lineWidth: 1)
                            .foregroundColor(.white)
                            .frame(height: 200)
                        
                        Text(self.draw.code)
                            .foregroundColor(Color.custom.main)
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                
                if self.draw.state == .notWiped {
                    ButtonView(title: "Zotrieť žreb") {
                        self.draw.wipe()
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}

struct WipeView_Previews: PreviewProvider {
    static var previews: some View {
        WipeView(draw: Draw(), show: .constant(false))
    }
}
