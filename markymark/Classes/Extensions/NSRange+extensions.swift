//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

extension NSRange {

    func getLocationEnd() -> Int {
        return self.location + self.length
    }

    func isDirectlyConnectTo(_ range:NSRange) -> Bool {
        return (self.getLocationEnd() + 1) == range.location
    }
}
