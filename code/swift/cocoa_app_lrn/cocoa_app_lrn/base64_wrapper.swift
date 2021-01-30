//
//  base64_wrapper.swift
//  cocoa_app_lrn
//
//  Created by stl on 2021/1/27.
//  Copyright © 2021 stl. All rights reserved.
//

import Foundation


extension String {
    /// Encode a String to Base64
    func toBase64String() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64String() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    func fromBase64() -> Array<UInt8>? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return data.bytes
    }
}
