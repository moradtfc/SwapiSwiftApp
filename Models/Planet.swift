//
//  Planet.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import Foundation

struct Planet: Codable, Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let films: [String]
    
}

struct PlanetResponse: Codable {
    
    let next: String?
    let results: [Planet]
    
}

struct Film: Codable {
    
    let title: String
    
}
