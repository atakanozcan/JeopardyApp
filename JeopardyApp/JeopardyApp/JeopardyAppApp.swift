//
//  JeopardyAppApp.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

@main
struct JeopardyAppApp: App {
    @StateObject public var model = GameModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
