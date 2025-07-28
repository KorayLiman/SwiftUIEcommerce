//
//  NetworkManager.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//

import Alamofire
import SwiftUI

final class NetworkManager {
    init(baseURL: String, httpHeaders: HTTPHeaders? = nil) {
        self.baseURL = baseURL
        self.httpHeaders = httpHeaders
    }

    let baseURL: String
    let httpHeaders: HTTPHeaders?
    var loader: ECLoader {
        DIContainer.shared.synchronizedResolver.resolve(ECLoader.self)!
    }

    var authRepository: IAuthRepository {
        DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
    }

    var userDefaultsManager: IUserDefaultsManager {
        DIContainer.shared.synchronizedResolver.resolve(IUserDefaultsManager.self)!
    }

    func request<T: Decodable>(_ type: T.Type = NullData.self, path: RequestPath, method: HTTPMethod = .get, parameters: Encodable? = nil, headers: HTTPHeaders? = nil) async -> BaseResponse<T> {
        let fullPath = baseURL + "/" + path.rawValue
        var mergedHeaders = HTTPHeaders()
        if let accessToken = userDefaultsManager.getObject(LoginResponseModel.self, forKey: .loginResponseModel)?.accessToken {
            let authorizationHeader = HTTPHeader.authorization(bearerToken: accessToken)
            mergedHeaders.add(authorizationHeader)
        }

        if let httpHeaders = httpHeaders {
            for header in httpHeaders {
                mergedHeaders.add(name: header.name, value: header.value)
            }
        }
        if let headers = headers {
            for header in headers {
                mergedHeaders.update(name: header.name, value: header.value)
            }
        }
        var urlRequest = URLRequest(url: URL(string: fullPath)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = mergedHeaders
        urlRequest.timeoutInterval = 30
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let params = parameters {
            if method == .get {
                urlRequest = try! URLEncodedFormParameterEncoder.default.encode(params, into: urlRequest)

            } else {
                urlRequest.httpBody = try? JSONEncoder().encode(params)
            }
        }

        let response = await AF.request(urlRequest)
            .validate()
            .serializingDecodable(BaseResponse<T>.self).response

        switch response.result {
        case .success(let data):
            return BaseResponse(data: data.data, success: data.success, messages: data.messages, statusCode: data.statusCode, error: nil)
        case .failure(let error):
            if error.responseCode == 401 {
                authRepository.authStateStream.send(.unAuthenticated)
            }
            var messages: [String]?
            if let data = response.data {
                let responseMessages = try? JSONDecoder().decode(BaseResponse<T>.self, from: data).messages
                if let responseMessages = responseMessages {
                    messages = responseMessages
                }
            }

            return BaseResponse(data: nil, success: false, messages: messages, statusCode: error.responseCode, error: error)
        }
    }
}
