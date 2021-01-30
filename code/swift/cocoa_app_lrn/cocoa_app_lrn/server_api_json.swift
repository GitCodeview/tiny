//
//  server_api_json.swift
//  cocoa_app_lrn
//
//  Created by stl on 2021/1/28.
//  Copyright © 2021 stl. All rights reserved.
//

import Foundation

struct ApiResponse: Decodable {
    let code: Int
    let subCode: String
    let message: String
    let bodyMessage: String
}

struct AccServerInfo: Decodable{
    let method: String
    let password: String
    let server: String
    let server_port: Int
}
