//
//  PoemCreationView.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-27.
//

import SwiftUI

struct PoemCreationView: View {
    @Binding var isShowingCreationView: Bool
    @State private var poemText = ""
    @State private var isSaved = false
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $poemText)
                    .padding()
                    .font(.largeTitle)
                Button(action: {
                    Archive.writeYourOwnPoem(poem: poemText)
                    isShowingCreationView = false
                }) {
                    Text("Save Poem")
                }
                .buttonStyle(BlackBackgroundButtonStyle())
                .disabled(poemText.isEmpty)
            }
            .navigationBarTitle("Write", displayMode: .inline)
        }
    }
    
}
struct PoemCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PoemCreationView(isShowingCreationView: Binding<Bool>(
            get: { true },
            set: { _ in }
        ))
    }
}
