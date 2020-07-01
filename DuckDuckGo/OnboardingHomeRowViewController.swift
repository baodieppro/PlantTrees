//
//  OnboardingHomeRowViewController.swift
//  Copyright © 2019All rights reserved.
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

import UIKit
import Core
import AVKit

class OnboardingHomeRowViewController: OnboardingContentViewController {
    private var userInteracted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var header: String {
        return UserText.homeRowOnboardingHeader
    }
    
    override var continueButtonTitle: String {
        return UserText.onboardingNext
    }
        
    override func onContinuePressed(navigationHandler: @escaping () -> Void) {
        navigationHandler()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
