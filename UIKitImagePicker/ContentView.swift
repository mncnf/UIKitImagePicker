//
//  ContentView.swift
//  UIKitImagePicker
//
//  Created by Development on 2025/05/22.
//

import SwiftUI

struct ContentView: View {
    @State var showingImagePicker = false

    var body: some View {
        Button(action: {
            showingImagePicker = true
        }) {
            Text("フォトライブラリー")
        }
        .sheet(isPresented: $showingImagePicker, content: {
            ImagePicker()
        })
    }
}

#Preview {
    ContentView()
}
