//
//  LocalCache.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 04/07/25.
//

import Foundation

/// Generic protocol for local caching of Codable data.
protocol LocalCacheProtocol {
    associatedtype Object: Codable
    func save(_ objects: [Object])
    func load() -> [Object]
    func clear()
}

/// Thread-safe disk-based cache for Codable arrays.
final class LocalCache<T: Codable>: LocalCacheProtocol {
    typealias Object = T

    private let fileName: String
    private let queue = DispatchQueue(label: "LocalCacheQueue_\(UUID().uuidString)", qos: .background)

    init(fileName: String) {
        self.fileName = fileName
    }

    func save(_ objects: [T]) {
        queue.async {
            guard let url = self.fileURL() else { return }
            do {
                let data = try JSONEncoder().encode(objects)
                try data.write(to: url, options: [.atomic])
            } catch {
                print(Constants.Cache.failedToSave + error.localizedDescription)
            }
        }
    }

    func load() -> [T] {
        guard let url = fileURL(),
              let data = try? Data(contentsOf: url),
              let objects = try? JSONDecoder().decode([T].self, from: data) else {
            return []
        }
        return objects
    }

    func clear() {
        guard let url = fileURL() else { return }
        try? FileManager.default.removeItem(at: url)
    }

    private func fileURL() -> URL? {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        return directory?.appendingPathComponent(fileName + ".json")
    }
}
