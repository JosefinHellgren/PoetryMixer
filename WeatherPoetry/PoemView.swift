//
//  PoemView.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-11-13.
//

import Foundation
import SwiftUI


struct PoemView: View {
   @State private var isFavourite = false
    var poem: PoemResponse
    var body: some View {
        ScrollView {
            HStack {
                Text(poem.title)
                    .font(.largeTitle)
                Image(systemName: "heart")
                    .onTapGesture {
                        Archive.saveFavouritePoem(poem: poem)
                    }
            } .padding()
            Text("Author: \(poem.author)")
            
                .padding()
            ForEach(poem.lines.indices, id: \.self) { index in
                Text(poem.lines[index])
            }
        }
        .fontDesign(.serif)
    }
}
