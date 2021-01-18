//
//  FrontNativeApp.swift
//  FrontNative
//
//  Created by 前島文香 on 2020/12/28.
//

import SwiftUI

@main
struct FrontNativeApp: App {
    @StateObject private var path = Path()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(path)
        }
    }
}
