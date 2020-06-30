//
//  FireAnimation.swift
//  DuckDuckGo
//
//  Copyright © 2017 DuckDuckGo. All rights reserved.
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
import Lottie

extension FireAnimation: NibLoading {}

class FireAnimation: UIView {

    struct Constants {
        static let animationDuration = 2.0
        static let endDelayDuration = animationDuration + 0.2
        static let endAnimationDuration = 0.2
    }

    static func animate(completion: @escaping () -> Void) {

        guard let window = UIApplication.shared.keyWindow else {
            completion()
            return
        }

        let anim = FireAnimation.load(nibName: "FireAnimation")
//        anim.image.animationImages = animatedImages
//        anim.image.contentMode = window.frame.width > anim.image.animationImages![0].size.width ? .scaleAspectFill : .center
//        anim.image.startAnimating()
        let image = LOTAnimationView(name: "leaf-animation")
        

        anim.frame = window.frame
        image.frame = window.frame
        window.addSubview(anim)
        window.addSubview(image)
        
        image.play()

        UIView.animate(withDuration: Constants.animationDuration, delay: 0, options: .curveEaseOut, animations: {
            
        }, completion: { _ in
            completion()
        })

        UIView.animate(withDuration: Constants.endAnimationDuration, delay: Constants.endDelayDuration, options: .curveEaseOut, animations: {
            anim.alpha = 0
        }, completion: { _ in
            anim.removeFromSuperview()
            image.removeFromSuperview()
        })

    }

}
