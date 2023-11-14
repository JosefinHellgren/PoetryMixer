//
//  ContentView.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-19.
//

import SwiftUI

struct ContentView: View {
    @State private var poem : PoemResponse?
    @State private var selectedPoem = ""
    @State private var isLoading = true
    @State private var isShowingRemixSheet = false
    @State private var isShowingCreationView = false
    @State private var isShowingYourPage = false
    
    var body: some View {
        
        NavigationStack{
            VStack {
                HStack{
                    Spacer()
                    Button {
                        isShowingYourPage = true
                        } label: {
                        Image(systemName: "person.fill").font(.title)
                                .foregroundColor(Color.black)
                    }
                    
                }.padding(.horizontal)
                
                if isLoading {
                    Text("Loading poem")}
                else if let poem = poem {
                    PoemView(poem: poem)
                    
                } else {
                    Text("No poem")
                }
                HStack {
                    Button {
                        poem?.shuffleLines()
                        
                    } label: {
                        Text("↻")
                    }
                    .buttonStyle(BlackBackgroundButtonStyle())
                    Button {
                        isShowingRemixSheet = true
                        
                    } label: {
                        Text("Remix")
                    }
                    .buttonStyle(BlackBackgroundButtonStyle())
                    Button {
                        isShowingCreationView = true
                        
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .buttonStyle(BlackBackgroundButtonStyle())
                    Button {
                        getPoem()
                    } label: {
                        Text(" Random poem")
                    }
                    .buttonStyle(BlackBackgroundButtonStyle())
                    
                }
                .navigationDestination(
                    isPresented: $isShowingYourPage) {
                        YourPage()
                        Text("")
                            .hidden()
                    }
                    .sheet(isPresented: $isShowingRemixSheet, content: {
                        RemixSheet(isShowingSheet: $isShowingRemixSheet, selectedPoem: $selectedPoem)
                    })
                    .sheet(isPresented: $isShowingCreationView, content: {
                        PoemCreationView(isShowingCreationView: $isShowingCreationView)
                    })
                    .onAppear{
                        if poem == nil {
                            getPoem()
                        }
                    }
                    .onChange(of: selectedPoem, perform: { newValue in
                        print(newValue)
                        PoetryDj.mixPoems(userPoem: selectedPoem,poem: &poem)
                        
                    })
                    .padding()
            }
        }
    }
    
    private func getPoem() {
        Task {
            
            do { poem = try await NetworkManager.getRandomPoem()
                isLoading = false
            } catch {
                print("Error fetching poem: \(error)")
                
            }
            
        }
        
    }
    
 
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
