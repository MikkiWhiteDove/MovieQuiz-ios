//
//  MoviesLoadingProtocol.swift
//  MovieQuiz
//
//  Created by Mishana on 10.08.2023.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
} 
