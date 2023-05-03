//
//  Api.swift
//  ScratchDraw
//
//  Created by CaTTani on 03/05/2023.
//

import Foundation
import Combine

class AError: Error {
    
}

class Api: ObservableObject {
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    /**
     Function for activation code from scratch draw
     - parameters: code - code from scratch draw
     
     */
    func activate(code: String) -> AnyPublisher<Result<Bool, AError>, Never> {
        return self.call(for: "version?code=\(code)", method: "GET", parameters: nil)
                    .decode(type: Responses.Activation.self, decoder: JSONDecoder())
                    .map { response  in
                        if Double(response.ios ?? "") ?? 0.0 > 6.1 {
                            return .success(true)
                        }
                        else {
                            return .success(false)
                        }
                    }
                    .mapError { error in
                        print("e: \(error)")
                        if let error = error as? AError {
                            return error
                        }
                        else {
                            return AError()
                        }
                    }
                    .catch { Just(.failure($0)) }
                    .eraseToAnyPublisher()
    }
    
    
    /**
     General function for API call
     - parameters: endpoint - name of service
                   method - HTTP request method (GET, POST, DELETE, PUT, ...)
                   parameters - json with post parameters
     
     */
    private func call(for endpoint: String, method: String, parameters: [String:Any]?) -> AnyPublisher<Data, AError>{
        guard let url = URL(string: Constants.api.url + endpoint) else {
            return Fail(error: AError()).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = method
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { (data, response) -> Data in
                        guard let httpResponse = response as? HTTPURLResponse else {
                            throw AError()
                        }
                        
                        switch httpResponse.statusCode {
                            case 200:
                                return data
                            default:
                                throw AError()
                        }
                    }
                    .mapError { error in
                        AError()
                    }
                    .eraseToAnyPublisher()
    }
    
}
