//
//  YourPage.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-27.
//

import SwiftUI

struct YourPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var userPoems: [String:String] = [:]
    @State private var favouritePoems : [PoemResponse] = []
    var body: some View {
        NavigationStack {
            VStack {
                List {
                UserPoemListView(userPoems: userPoems)
                FavouritePoemListView(favouritePoems: favouritePoems)
            }
                
            }
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.self.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.black)
            }))
        .onChange(of: favouritePoems, perform: { newValue in
            print("changes")
            favouritePoems = Archive.loadFavouritePoems()
        })
        .onAppear{ if favouritePoems.isEmpty && userPoems.isEmpty {
            userPoems = Archive.loadPoems()
            favouritePoems = Archive.loadFavouritePoems()
        }
        }
    }
}
struct UserPoemListView: View {
    var userPoems: [String: String]

    var body: some View {
       Text("Your poems:")
            .font(.title)
            ForEach(Array(userPoems.keys), id: \.self) { title in
                NavigationLink(destination: Text(" \(userPoems[title] ?? "")").fontDesign(.serif)
                ) {
                    Text("\(title)" ?? "no poem")
                }
            }
        
    }
}

struct FavouritePoemListView: View {
    var favouritePoems: [PoemResponse]

    var body: some View {
       Text("Your saved poems:")
            .font(.title)
            ForEach(favouritePoems) { poem in
                NavigationLink(destination: PoemView(poem: poem)) {
                           Text(poem.title)
                       }
            }
        
    }
}


struct YourPage_Previews: PreviewProvider {
    static var previews: some View {
        YourPage()
    }
}
