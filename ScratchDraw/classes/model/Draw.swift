//
//  Draw.swift
//  ScratchDraw
//
//  Created by CaTTani on 03/05/2023.
//

import Foundation
import UserNotifications
import Combine

enum DrawState: String {
    case notWiped = "Nezotretý"
    case wiped = "Zotretý"
    case activated = "Aktivovaný"
}

class Draw: ObservableObject{
    
    var code = UUID().uuidString
    @Published var state: DrawState = .notWiped
    
    private var wiping = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    /**
     Function for wipe draw
     */
    func wipe() {
        self.wiping = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            if self.wiping {
                self.state = .wiped
                self.wiping = false
            }
        }
    }
    
    /**
     Function for stop wiping draw . Used when user start wipe and click on back button.
     */
    func stopWipe() {
        if self.wiping {
            self.wiping = false
        }
    }
    
    /**
     Function for activation code from scratch draw.
     */
    func activate(_ activated: @escaping (()->Void)) {
        Api().activate(code: self.code)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveValue: { value in
                    switch value {
                        case .success(let value):
                            if value {
                                self.state = .activated
                                activated()
                            }
                            else {
                                self.showError()
                            }
                        case .failure:
                            self.showError()
                    }
                })
            .store(in: &cancellableSet)
    }
    
    /**
     Function for show error in system notification center.
     */
    private func showError() {
        let content = UNMutableNotificationContent()
        content.title = "Chyba"
        content.subtitle = "Žreb sa nepodarilo aktivovať."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    /**
     Function for reset draw. Scratch will have new code and will be not wiped
     */
    func reset() {
        self.code = UUID().uuidString
        self.state = .notWiped
    }
    
}
