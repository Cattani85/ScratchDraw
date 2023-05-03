//
//  HomeView.swift
//  ScratchDraw
//
//  Created by CaTTani on 03/05/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var draw = Draw()
    
    @State var showWipe = false
    @State var showActivation = false
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                Spacer()
                    .frame(height: 20)
                
                Spacer()
                
                Text("Stav žrebu:  ")
                    .foregroundColor(Color.custom.main) +
                Text(self.draw.state.rawValue)
                    .foregroundColor(.green)
                
                Spacer()
                
                if self.draw.state == .notWiped {
                    ButtonView(title: "Zotrieť žreb") {
                        self.showWipe = true
                    }
                }
                else if self.draw.state == .wiped {
                    ButtonView(title: "Aktivovať žreb") {
                        self.showActivation = true
                    }
                }
                else {
                    ButtonView(title: "Reset") {
                        self.draw.reset()
                    }
                }

                
                Spacer()
                    .frame(height: 50)
            }
            .padding(.horizontal, 40)
            
            if self.showWipe {
                WipeView(draw: self.draw, show: self.$showWipe)
            }
            
            if self.showActivation {
                ActivationView(draw: self.draw, show: self.$showActivation)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
