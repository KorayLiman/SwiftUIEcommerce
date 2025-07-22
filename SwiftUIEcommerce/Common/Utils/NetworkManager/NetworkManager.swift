//
//  NetworkManager.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//

import Alamofire
import SwiftUI

final class NetworkManager {
    init(baseURL: String, httpHeaders: HTTPHeaders? = nil, loader: ECLoader, authStore: AuthStore, userDefaultsManager: UserDefaultsManager) {
        self.baseURL = baseURL
        self.httpHeaders = httpHeaders
        self.loader = loader
        self.authStore = authStore
        self.userDefaultsManager = userDefaultsManager
    }

    let baseURL: String
    let httpHeaders: HTTPHeaders?
    let loader: ECLoader
    let authStore: AuthStore
    let userDefaultsManager: UserDefaultsManager

    func request<T: Decodable>(_ type: T.Type = NullData.self, path: RequestPath, method: HTTPMethod = .get, parameters: Encodable? = nil, headers: HTTPHeaders? = nil) async -> BaseResponse<T> {
        let fullPath = baseURL + "/" + path.rawValue
        var mergedHeaders = HTTPHeaders()
        if let accessToken = try? userDefaultsManager.getObject(LoginResponseModel.self, forKey: .loginResponseModel)?.accessToken {
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

        if method == .get, let parameters = parameters {
            urlRequest = try! URLEncodedFormParameterEncoder.default.encode(parameters, into: urlRequest)

        } else {
            urlRequest.httpBody = try? JSONEncoder().encode(parameters!)
        }

        let response = await AF.request(urlRequest)
            .validate()
            .serializingDecodable(BaseResponse<T>.self).response

        switch response.result {
        case .success(let data):
            return BaseResponse(data: data.data, success: data.success, messages: data.messages, statusCode: data.statusCode, error: nil)
        case .failure(let error):
            if error.responseCode == 401 {
                authStore.authState = .unAuthenticated
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

    func requestWithLoader<T: Decodable>(_ type: T.Type = NullData.self, path: RequestPath, method: HTTPMethod = .get, parameters: Encodable? = nil, headers: HTTPHeaders? = nil) async -> BaseResponse<T> {
        loader.show()
        let response: BaseResponse<T> = await request(type, path: path, method: method, parameters: parameters, headers: headers)
        loader.hide()
        return response
    }
}

private struct NetworkManagerKey: EnvironmentKey {
    static let defaultValue = NetworkManager(baseURL: "", loader: ECLoader(), authStore: AuthStore(), userDefaultsManager: UserDefaultsManager())
}

extension EnvironmentValues {
    var networkManager: NetworkManager {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
}
