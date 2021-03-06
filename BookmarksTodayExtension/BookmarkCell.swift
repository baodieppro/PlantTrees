//
//  BookmarkCell.swift

//
//  Copyright © 2018All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import Core
import Kingfisher

class BookmarkCell: UITableViewCell {
    
    static let reuseIdentifier = "Bookmark"
    static let placeholderFavicon = #imageLiteral(resourceName: "GlobeSmall")
    
    @IBOutlet weak var favicon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func update(withBookmark bookmark: Link) {
        title.text = bookmark.title
        configureFavicon(forDomain: bookmark.url.host)
    }
    
    private func configureFavicon(forDomain domain: String?) {
        favicon.image = BookmarkCell.placeholderFavicon
        if let domain = domain {
            let faviconUrl = AppUrls().faviconUrl(forDomain: domain)
            favicon.kf.setImage(with: faviconUrl, placeholder: BookmarkCell.placeholderFavicon)
        }
    }
}
