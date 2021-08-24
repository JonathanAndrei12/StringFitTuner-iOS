//
//  MobGuitarTunerApp.swift
//  MobGuitarTuner
//
//  Created by Jonathan Andrei on 24/08/21.
//

import SwiftUI

@main
struct MobGuitarTunerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
