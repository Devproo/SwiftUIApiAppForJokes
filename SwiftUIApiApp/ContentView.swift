//
//  ContentView.swift
//  SwiftUIApiApp
//
//  Created by ipeerless on 10/02/2024.
//

import SwiftUI

struct Joke: Codable, Identifiable {
    var id = UUID().uuidString
    let value: String
    
}

struct ContentView: View {
    @State private var newJoke = ""
    @State var jokes:[Joke] = []
    var body: some View {
        VStack {
            List {
                ForEach(jokes, id: \.id) { joke in
                    Text(joke.value)
                }
                
                TextField("Enter a new joke", text: $newJoke)
                    .padding()
                
                HStack {
                    Button("Fetch ") {
                        fetchJoke()
                    }
                    Button("Add") {
                        addJoke()
                    }
                    Button("Remove") {
                        removeJokes()
                    }
                    
                }
                .padding()
                
            }
        }
      
    }
    func fetchJoke() {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random")!)
                let decodedResponse = try JSONDecoder().decode(Joke.self, from: data)
                jokes.append(decodedResponse)
                
            } catch {
                print("Error fetching joke: \(error)")
            }
        }
        
    }
    
    func addJoke() {
        if !newJoke.isEmpty {
            jokes.append(Joke(id: "", value: newJoke))
            newJoke = ""
        }
    }
    func removeJokes() {
        jokes.removeAll()
    }
}

#Preview {
    ContentView()
}
