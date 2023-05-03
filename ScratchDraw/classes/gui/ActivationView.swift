//
//  ActivationView.swift
//  ScratchDraw
//
//  Created by CaTTani on 03/05/2023.
//

import SwiftUI

struct ActivationView: View {
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
                            self.show = false
                        }
                    
                    Spacer()
                }
                
                Spacer()
                
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
                
                Spacer()
                
                if self.draw.state == .wiped {
                    ButtonView(title: "Aktivovať žreb") {
                        self.draw.activate {
                            self.show = false
                        }
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}

struct ActivationView_Previews: PreviewProvider {
    static var previews: some View {
        ActivationView(draw: Draw(), show: .constant(false))
    }
}
