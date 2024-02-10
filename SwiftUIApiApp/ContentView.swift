//
//  ContentView.swift
//  SwiftUIApiApp
//
//  Created by ipeerless on 10/02/2024.
//

import SwiftUI

struct Joke: Codable {
    let value: String
}

struct ContentView: View {
    @State private var joke = ""
    
    var body: some View {
        VStack {
            Text(joke)
            
            Button  {
                Task {
                    let (data, _ ) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random")!)
                    
                    let decodeResponse = try? JSONDecoder().decode(Joke.self, from: data)
                    
                    joke = decodeResponse?.value ?? ""
                }
                
                
            } label: {
                Text("Fetch Joke")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
