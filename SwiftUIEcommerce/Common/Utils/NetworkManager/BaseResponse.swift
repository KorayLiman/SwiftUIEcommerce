//
//  BaseResponse.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//


struct BaseResponse<T: Decodable>: Decodable {
    let data: T?
    let success: Bool?
    let messages: [String]?
    let statusCode: Int?
    let error: Error?
        
    var isSuccess: Bool { success ?? false }
    var isFailure: Bool { !isSuccess }
    
    init(data: T?, success: Bool?, messages: [String]?, statusCode: Int?, error: Error?) {
        self.data = data
        self.success = success
        self.messages = messages
        self.statusCode = statusCode
        self.error = error
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(T.self, forKey: .data)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
        messages = try container.decodeIfPresent([String].self, forKey: .messages)
        statusCode = nil
        error = nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case data, success, messages
    }
}
