//
//  NetworkRoutingProtocol.swift
//  MovieQuiz
//
//  Created by Mishana on 10.08.2023.
//

import Foundation

protocol NetworkRouting {
    func fetch(
        url: URL,
        handler: @escaping (Result<Data, Error>) -> Void
    )
}
