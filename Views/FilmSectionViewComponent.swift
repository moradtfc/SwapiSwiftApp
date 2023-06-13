//
//  FilmSectionViewComponent.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import SwiftUI

struct FilmSectionViewComponent: View {
    
    let planet: Planet
    let filmsDict: [String: Film]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !planet.films.isEmpty && containsAvailableFilms {
                Text("Films List:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.brown)
            }
            
            ForEach(planet.films, id: \.self) { filmURL in
                if let film = filmsDict[filmURL] {
                    HStack{
                        Image(systemName: "film")
                        Text("\(film.title)")
                    }
                }
            }
        }
    }
    
    var containsAvailableFilms: Bool {
        for filmURL in planet.films {
            if filmsDict[filmURL] != nil {
                return true
            }
        }
        return false
    }
}

