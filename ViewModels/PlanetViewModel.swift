//
//  PlanetViewModel.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import Foundation
import Combine

class PlanetViewModel: ObservableObject {
    
    @Published var planets: [Planet] = []
    @Published var filmsDict: [String: Film] = [:]
    @Published var favoritePlanets: [Planet] = []
    
    private var cancellables = Set<AnyCancellable>()
    var nextPageURL: String?
    
    init() {
        fetchPlanets()
        loadFavoritePlanets()
    }
    
    func fetchPlanets() {
        guard let url = URL(string: "https://swapi.dev/api/planets") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PlanetResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.planets = response.results
                self?.nextPageURL = response.next
                
                for planet in response.results {
                    for filmURL in planet.films {
                        self?.fetchFilm(urlString: filmURL)
                    }
                }
                
                self?.loadFavoritePlanets()
                
            }
            .store(in: &cancellables)
    }
    
    func fetchFilm(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Film.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] film in
                self?.filmsDict[urlString] = film
            }
            .store(in: &cancellables)
    }
    
    func fetchMorePlanets() {
        guard let nextPageURL = nextPageURL, let url = URL(string: nextPageURL) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PlanetResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.planets.append(contentsOf: response.results)
                self?.nextPageURL = response.next
                
                for planet in response.results {
                    for filmURL in planet.films {
                        self?.fetchFilm(urlString: filmURL)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(planet: Planet) {
        if favoritePlanets.contains(where: { $0.name == planet.name }) {
            favoritePlanets.removeAll(where: { $0.name == planet.name })
            UserDefaults.standard.set(favoritePlanets.map { $0.name }, forKey: "FavoritePlanets")
            
        } else {
            favoritePlanets.append(planet)
            UserDefaults.standard.set(favoritePlanets.map { $0.name }, forKey: "FavoritePlanets")
            
        }
    }
    
    func favoriteButtonLabel(for planet: Planet) -> String {
        return favoritePlanets.contains { $0.name == planet.name } ? "Remove from Favorites" : "Add to Favorites"
    }
    
    func backgroundButtonLabel(for planet: Planet) -> Bool {
        
        return favoritePlanets.contains { $0.name == planet.name } ? true : false
        
    }
    
    func loadFavoritePlanets() {
        let favoritedPlanetNames = UserDefaults.standard.array(forKey: "FavoritePlanets") as? [String] ?? []
        
        favoritePlanets = planets.filter { planet in
            favoritedPlanetNames.contains(planet.name)
        }
    }
    
    
}

