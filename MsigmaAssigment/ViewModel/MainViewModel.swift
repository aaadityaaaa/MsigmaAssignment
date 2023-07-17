//
//  MainViewModel.swift
//  MsigmaAssigment
//
//  Created by Aaditya Singh on 16/07/23.
//

import Foundation

final class MainViewModel {
    
    var episodes: [Video] = []
    
    func fetchData() {
        episodes = fetchRemoteVideos()
    }
    
    private func fetchRemoteVideos() -> [Video] {
      return readJSON(fileName: "RemoteVideos")
    }
    
    private func readJSON<T: Decodable>(fileName: String) -> [T] {
      if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
          let data = try Data(contentsOf: url)
          return try JSONDecoder().decode([T].self, from: data)
        } catch {
          print("Failed decoding JSON file: \(fileName).")
          return []
        }
      }
      return []
    }
}
