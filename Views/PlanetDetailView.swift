//
//  PlanetDetailView.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet
    let filmsDict: [String: Film]
    @ObservedObject var viewModel: PlanetViewModel
    
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    InfoSectionViewComponent(infoData: [
                        ("Diameter", planet.diameter),
                        ("Climate", planet.climate),
                        ("Terrain", planet.terrain),
                        ("Population", planet.population),
                        ("Rotation Period", planet.rotation_period),
                        ("Orbital Period", planet.orbital_period),
                        ("Gravity", planet.gravity),
                        ("Surface Water", planet.surface_water)
                    ])
                    .accessibilityIdentifier("infoSectionView")
                    Divider()
                    FilmSectionViewComponent(planet: planet, filmsDict: filmsDict)
                        .accessibilityIdentifier("filmSectionView")
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .center){
                Button {
                    viewModel.toggleFavorite(planet: planet)
                } label: {
                    
                    Text(viewModel.favoriteButtonLabel(for: planet))
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(viewModel.backgroundButtonLabel(for: planet) ? Color.red : Color.green)
                }
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 30)
                .accessibilityIdentifier("favoriteButton")
                
            }
        }
        .navigationBarTitle(planet.name)
        .padding()
        .accessibilityIdentifier("planetDetailView")
    }
}

struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let planet = Planet(name: "Tatooine", rotation_period: "23", orbital_period: "304", diameter: "10465", climate: "Arid", gravity: "1 standard", terrain: "Desert", surface_water: "1", population: "200000", films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/3/"])
        let filmsDict = [
            "https://swapi.dev/api/films/1/": Film(title: "A New Hope"),
            "https://swapi.dev/api/films/3/": Film(title: "Return of the Jedi")
        ]
        
        let planetViewModel = PlanetViewModel()
        
        return PlanetDetailView(planet: planet, filmsDict: filmsDict, viewModel: planetViewModel)
    }
}

