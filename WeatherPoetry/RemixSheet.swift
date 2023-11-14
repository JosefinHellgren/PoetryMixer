//
//  RemixSheet.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-27.
//

import SwiftUI

struct RemixSheet: View {
    
    @Binding var isShowingSheet: Bool
    @Binding var selectedPoem: String
    @State private var yourPoems: [String: String] = [:]
    var body: some View {
        VStack {
            
            Text("Select your poem to mix with")
            
            Picker("Pick your poem", selection: $selectedPoem){
                ForEach(Array(yourPoems.keys), id: \.self) { title in
                    Text(title).tag(title)
                    
                }
                
                
            }.pickerStyle(.segmented)
            Button(action: {
                print(selectedPoem)
                isShowingSheet = false
            }) {
                Text("Remix")
            }.buttonStyle(BlackBackgroundButtonStyle())
        }
        .onAppear {
            yourPoems = Archive.loadPoems()
        }
        
    }
}

struct RemixSheet_Previews: PreviewProvider {
    @State static var isShowingSheet = Binding.constant(true)  
    @State static var selectedPoem = Binding.constant("Some Initial Value")

    static var previews: some View {
        RemixSheet(isShowingSheet: isShowingSheet, selectedPoem: selectedPoem)
    }
}
