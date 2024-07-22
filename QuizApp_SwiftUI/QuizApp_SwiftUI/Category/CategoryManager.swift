//
//  CategoryManager.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation

class CategoryManager {
    
    func getCategory(completion: @escaping(Result<[Category]?, DownloaderError>) -> Void) {
        
        guard let url = URL(string: "https://opentdb.com/api_category.php") else {
            return completion(.failure(.wrongUrl))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let categoryResult = try? JSONDecoder().decode(CategoryData.self, from: data) else {
                return completion(.failure(.dataNotProcessed))
            }
            completion(.success(categoryResult.trivia_categories))
        }.resume()
    }
}

enum DownloaderError: Error {
    case wrongUrl
    case noData
    case dataNotProcessed
}
