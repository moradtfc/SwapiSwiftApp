//
//  PlanetViewModelTests.swift
//  SwapiSwiftAppTests
//
//  Created by Jesus Mora on 13/6/23.
//

import XCTest
@testable import SwapiSwiftApp

final class PlanetViewModelTests: XCTestCase {
    
    func testFetchPlanets() {
        // Crear una expectativa para esperar la finalización de la solicitud
        let expectation = XCTestExpectation(description: "Fetch Planets")
        
        // Crear una instancia de PlanetViewModel
        let viewModel = PlanetViewModel()
        
        // Ejecutar el método fetchPlanets()
        viewModel.fetchPlanets()
        
        // Esperar un tiempo suficiente para que se complete la solicitud
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Verificar que el array de planetas no esté vacío
            XCTAssertFalse(viewModel.planets.isEmpty, "Planets array should not be empty")
            
            // Cumplir con la expectativa
            expectation.fulfill()
        }
        
        // Esperar hasta que se cumpla la expectativa o haya pasado un tiempo límite
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchFilm() {
        
        let expectation = XCTestExpectation(description: "Fetch Film")

        let viewModel = PlanetViewModel()

        let filmURL = "https://swapi.dev/api/films/1/"

        viewModel.fetchFilm(urlString: filmURL)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(viewModel.filmsDict[filmURL], "Film should not be nil")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchMorePlanets() {

        let expectation = XCTestExpectation(description: "Fetch More Planets")

        let viewModel = PlanetViewModel()
        
        viewModel.nextPageURL = "https://swapi.dev/api/planets/?page=2"
        
        viewModel.fetchMorePlanets()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {

            XCTAssertGreaterThan(viewModel.planets.count, 0, "Planets array should not be empty")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testToggleFavorite() {

        let viewModel = PlanetViewModel()
        let planet1 = Planet(name: "Planet 1", rotation_period: "24", orbital_period: "365", diameter: "5000", climate: "Temperate", gravity: "1 standard", terrain: "Grasslands", surface_water: "40", population: "1000", films: [])
        let planet2 = Planet(name: "Planet 2", rotation_period: "18", orbital_period: "200", diameter: "3000", climate: "Arid", gravity: "0.9 standard", terrain: "Desert", surface_water: "5", population: "500", films: [])
        
        // Verificar que el array de planetas favoritos esté vacío inicialmente
        XCTAssertTrue(viewModel.favoritePlanets.isEmpty, "Favorite planets array should be empty")
        
        // Agregar el primer planeta como favorito
        viewModel.toggleFavorite(planet: planet1)
        
        // Verificar que el primer planeta se haya agregado como favorito
        XCTAssertTrue(viewModel.favoritePlanets.contains(planet1), "Planet 1 should be added as a favorite")
        
        // Agregar el segundo planeta como favorito
        viewModel.toggleFavorite(planet: planet2)
        
        // Verificar que el segundo planeta se haya agregado como favorito
        XCTAssertTrue(viewModel.favoritePlanets.contains(planet2), "Planet 2 should be added as a favorite")
        
        // Quitar el primer planeta de favoritos
        viewModel.toggleFavorite(planet: planet1)
        
        // Verificar que el primer planeta se haya eliminado de favoritos
        XCTAssertFalse(viewModel.favoritePlanets.contains(planet1), "Planet 1 should be removed from favorites")
        
        // Quitar el segundo planeta de favoritos
        viewModel.toggleFavorite(planet: planet2)
        
        // Verificar que el segundo planeta se haya eliminado de favoritos
        XCTAssertFalse(viewModel.favoritePlanets.contains(planet2), "Planet 2 should be removed from favorites")
    }
    
    func testFavoriteButtonLabel() {
 
        let viewModel = PlanetViewModel()
        let planet = Planet(name: "Test Planet", rotation_period: "", orbital_period: "", diameter: "", climate: "", gravity: "", terrain: "", surface_water: "", population: "", films: [])
        
        // Verificar que el planeta no esté en la lista de favoritos
        XCTAssertFalse(viewModel.favoritePlanets.contains { $0.name == planet.name }, "Planet should not be in favorites initially")
        
        // Obtener el título del botón para el planeta
        let buttonLabel = viewModel.favoriteButtonLabel(for: planet)
        
        // Verificar que el título del botón sea "Add to Favorites"
        XCTAssertEqual(buttonLabel, "Add to Favorites", "Button label should be 'Add to Favorites'")
        
        // Agregar el planeta a la lista de favoritos
        viewModel.toggleFavorite(planet: planet)
        
        // Verificar que el planeta esté en la lista de favoritos
        XCTAssertTrue(viewModel.favoritePlanets.contains { $0.name == planet.name }, "Planet should be in favorites")
        
        // Obtener el nuevo título del botón para el planeta
        let updatedButtonLabel = viewModel.favoriteButtonLabel(for: planet)
        
        // Verificar que el nuevo título del botón sea "Remove from Favorites"
        XCTAssertEqual(updatedButtonLabel, "Remove from Favorites", "Button label should be 'Remove from Favorites'")
    }
    
    func testLoadFavoritePlanets() {

        let viewModel = PlanetViewModel()
        let planets: [Planet] = [
            Planet(name: "Planet A", rotation_period: "", orbital_period: "", diameter: "", climate: "", gravity: "", terrain: "", surface_water: "", population: "", films: []),
            Planet(name: "Planet B", rotation_period: "", orbital_period: "", diameter: "", climate: "", gravity: "", terrain: "", surface_water: "", population: "", films: []),
            Planet(name: "Planet C", rotation_period: "", orbital_period: "", diameter: "", climate: "", gravity: "", terrain: "", surface_water: "", population: "", films: [])
        ]

        viewModel.planets = planets
        
        // Se agrega el Planeta A
        UserDefaults.standard.set(["Planet A"], forKey: "FavoritePlanets")
        viewModel.loadFavoritePlanets()
        
        // Verificar que el planeta favorito esté en la lista de favoritos del viewModel
        XCTAssertTrue(viewModel.favoritePlanets.contains { $0.name == "Planet A" }, "Favorite planet should be in favorites")
        
        // Verificar que los otros planetas no estén en la lista de favoritos del viewModel
        XCTAssertFalse(viewModel.favoritePlanets.contains { $0.name == "Planet B" }, "Non-favorite planet should not be in favorites")
        XCTAssertFalse(viewModel.favoritePlanets.contains { $0.name == "Planet C" }, "Non-favorite planet should not be in favorites")
    }
    
    
}
