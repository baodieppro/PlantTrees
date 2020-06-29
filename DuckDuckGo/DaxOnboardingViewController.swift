//
//  DaxOnboardingViewController.swift
//  DuckDuckGo
//
//  Copyright © 2020 DuckDuckGo. All rights reserved.
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

class DaxOnboardingViewController: UIViewController, Onboarding {
    @IBOutlet weak var pointerView: UIView!
    
    struct Constants {
        
        static let animationDelay = 1.4
        static let animationDuration = 0.4
        
    }
    
    weak var delegate: OnboardingDelegate?
    weak var daxDialog: DaxDialogViewController?
    
    @IBOutlet weak var daxDialogContainer: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return isPad ? super.supportedInterfaceOrientations : [ .portrait ]
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return isPad ? super.preferredInterfaceOrientationForPresentation : .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        daxDialog?.message = UserText.daxDialogOnboardingMessage
        daxDialog?.theme = LightTheme()
        daxDialog?.reset()
        
        applyPointerRotation()
    }
    
    private func applyPointerRotation() {
        let width = pointerView.frame.size.width
        let height = pointerView.frame.size.height
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x:width/2, y: 0))
        path.addLine(to: CGPoint(x:width, y:height))
        path.addLine(to: CGPoint(x:0, y:height))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor(white: 1, alpha: 0.8).cgColor

        pointerView.layer.insertSublayer(shape, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !view.isHidden else { return }
        self.transitionFromOnboarding()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        
        if let controller = segue.destination as? DaxDialogViewController {
            self.daxDialog = controller
        } else if let controller = segue.destination as? DaxOnboardingPadViewController {
            controller.delegate = self
        } else if let controller = segue.destination as? OnboardingViewController {
            controller.delegate = self
            controller.updateForDaxOnboarding()
        } else if segue.identifier == "embed" {
            segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }

    func transitionFromOnboarding() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0.0
        }, completion: { _ in
            self.transitionToDaxDialog()
        })

    }

    func transitionToDaxDialog() {
        self.showDaxDialog {
            self.daxDialog?.start()
        }
    }
    
    @IBAction func onTapButton() {
        let segue = isPad ? "AddToHomeRow-iPad" : "AddToHomeRow"
        performSegue(withIdentifier: segue, sender: self)
    }
    
    func showDaxDialog(completion: @escaping () -> Void) {
        daxDialogContainer.alpha = 0.0
        daxDialogContainer.isHidden = false
        
        button.alpha = 0.0
        button.isHidden = false
        
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.daxDialogContainer.alpha = 1.0
            self.button.alpha = 1.0
        }, completion: { _ in
            completion()
        })
    }
    
}

extension DaxOnboardingViewController: OnboardingDelegate {
    func onboardingCompleted(controller: UIViewController) {
        self.view.isHidden = true
        controller.dismiss(animated: true)
        self.delegate?.onboardingCompleted(controller: self)
    }
}

extension OnboardingViewController {
    
    func updateForDaxOnboarding() {
        controllerNames = ["onboardingHomeRow"]
    }
    
}
