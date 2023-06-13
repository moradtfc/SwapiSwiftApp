//
//  ListPlanetView.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import SwiftUI

struct ListPlanetView: View {
    @ObservedObject var viewModel = PlanetViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.planets, id: \.name) { planet in
                NavigationLink(destination: PlanetDetailView(planet: planet, filmsDict: viewModel.filmsDict, viewModel: viewModel)) {
                    VStack(alignment: .leading) {
                        Text(planet.name)
                            .padding(.bottom, 8)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.brown)
                        FilmSectionViewComponent(planet: planet, filmsDict: viewModel.filmsDict)
                    }
                }
                .onAppear {
                    if viewModel.planets.last == planet {
                        viewModel.fetchMorePlanets()
                    }
                }
            }
            .navigationBarTitle("Starwars Planets")
        }
        .accessibilityIdentifier("planetsTable")
    }
}

struct ListPlanetView_Previews: PreviewProvider {
    static var previews: some View {
        ListPlanetView()
    }
}
