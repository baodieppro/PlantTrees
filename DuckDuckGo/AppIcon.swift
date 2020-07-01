//
//  AppIcon.swift

//
//  Copyright © 2020All rights reserved.
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

enum AppIcon: String, CaseIterable {
    case green
    case orange
    case black
    case blue
    case purple
    case yellow

    static var defaultAppIcon: AppIcon {
        return .green
    }

    var smallImage: UIImage? {
        var image: UIImage?
        switch self {
        case .green: image = UIImage(named: "AppIconGreen29x29")
        case .orange: image = UIImage(named: "AppIconOrange29x29")
        case .black: image = UIImage(named: "AppIconBlack29x29")
        case .blue: image = UIImage(named: "AppIconBlue29x29")
        case .purple: image = UIImage(named: "AppIconPurple29x29")
        case .yellow: image = UIImage(named: "AppIconYellow29x29")
        }
        return image
    }

    var mediumImage: UIImage? {
        var image: UIImage?
        switch self {
        case .green: image = UIImage(named: "AppIconGreen60x60")
        case .orange: image = UIImage(named: "AppIconOrange60x60")
        case .black: image = UIImage(named: "AppIconBlack60x60")
        case .blue: image = UIImage(named: "AppIconBlue60x60")
        case .purple: image = UIImage(named: "AppIconPurple60x60")
        case .yellow: image = UIImage(named: "AppIconYellow60x60")
        }
        return image
    }

}
