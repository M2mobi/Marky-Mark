//
//  URL+addHTTPSIfSchemeIsMissing.swift
//  markymark-iOS12.1
//
//  Created by Jim van Zummeren on 23/01/2019.
//

import Foundation

extension URL {
    func addHTTPSIfSchemeIsMissing() -> URL {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        if urlComponents.scheme == nil {
            urlComponents.scheme = "https"
        }

        if let httpsURL = urlComponents.url {
            return httpsURL
        } else {
            return self
        }
    }
}
