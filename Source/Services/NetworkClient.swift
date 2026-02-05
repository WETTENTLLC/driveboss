import Foundation

final class NetworkClient {
    static let shared = NetworkClient()

    private init() {}

    func get<T: Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, resp, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Network", code: -1, userInfo: nil)))
                return
            }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
