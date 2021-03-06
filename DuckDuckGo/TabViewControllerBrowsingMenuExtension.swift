//
//  TabViewControllerBrowsingMenuExtension.swift

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

extension TabViewController {
    
    func buildBrowsingMenu() -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.overrideUserInterfaceStyle()
        alert.addAction(title: UserText.actionNewTab) { [weak self] in
            self?.onNewTabAction()
        }
        
        if let link = link, !isError {
            let action = UIAlertAction(title: UserText.actionShare, style: .default) { [weak self] (action) in
               guard let self = self else { return }
               self.onShareAction(forLink: link, printFormatter: self.webView.viewPrintFormatter())
            }
//            action.setValue(<#T##value: Any?##Any?#>, forKey: "image")
            alert.addAction(action)
            
            if let action = buildSaveBookmarkAction(forLink: link) {
                alert.addAction(action)
            }
            
            if let action = buildSaveFavoriteAction(forLink: link) {
                alert.addAction(action)
            }
            
            if let action = buildCopyAddressAction(forLink: link) {
                alert.addAction(action)
            }
            
            if let action = buildFindInPageAction(forLink: link) {
                alert.addAction(action)
            }

            if let action = buildKeepSignInAction(forLink: link) {
                alert.addAction(action)
            }
            let toggleTitle = tabModel.isDesktop ? UserText.actionRequestMobileSite : UserText.actionRequestDesktopSite
            let toggleAction = UIAlertAction(title: toggleTitle, style: .default, handler: { [weak self] (action) in
                self?.onToggleDesktopSiteAction(forUrl: link.url)
            })
            alert.addAction(toggleAction)
        }
        
        if let domain = siteRating?.domain {
            alert.addAction(buildWhitelistAction(forDomain: domain))
        }
        
        alert.addAction(title: UserText.actionReportBrokenSite) { [weak self] in
            self?.onReportBrokenSiteAction()
        }
        let action = UIAlertAction(title: UserText.actionSettings, style: .default) { [weak self] (action) in
            self?.onBrowsingSettingsAction()
        }
        alert.addAction(action)
        
        let cancelAction = UIAlertAction(title: UserText.actionCancel, style: .cancel, handler: nil)
        cancelAction.setValue(ThemeManager.shared.currentTheme.buttonTintColor, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        return alert
    }
    
    private func buildKeepSignInAction(forLink link: Link) -> UIAlertAction? {
        guard #available(iOS 13, *) else { return nil }
        guard let domain = link.url.host, !appUrls.isDuckDuckGo(url: link.url) else { return nil }
        guard !PreserveLogins.shared.isAllowed(cookieDomain: domain) else { return nil }
        return UIAlertAction(title: UserText.preserveLoginsFireproofConfirm, style: .default) { [weak self] _ in
            self?.fireproofWebsite(domain: domain)
        }
    }
    
    private func onNewTabAction() {
        Pixel.fire(pixel: .browsingMenuNewTab)
        delegate?.tabDidRequestNewTab(self)
    }
    
    private func buildCopyAddressAction(forLink link: Link) -> UIAlertAction? {
        return UIAlertAction(title: UserText.copyAddress, style: .default) { _ in
            UIPasteboard.general.string = link.url.absoluteString
        }
    }
    
    private func buildFindInPageAction(forLink link: Link) -> UIAlertAction? {
        return UIAlertAction(title: UserText.findInPage, style: .default) { [weak self] _ in
            Pixel.fire(pixel: .browsingMenuFindInPage)
            self?.requestFindInPage()
        }
    }
    
    private func buildSaveBookmarkAction(forLink link: Link) -> UIAlertAction? {
        let bookmarksManager = BookmarksManager()
        guard !bookmarksManager.contains(url: link.url) else { return nil }
        
        return UIAlertAction(title: UserText.actionSaveBookmark, style: .default) { [weak self] _ in
            Pixel.fire(pixel: .browsingMenuAddToBookmarks)
            bookmarksManager.save(bookmark: link)
            self?.view.showBottomToast(UserText.webSaveBookmarkDone)
        }
    }
    
    private func buildSaveFavoriteAction(forLink link: Link, homePageSettings: HomePageSettings = DefaultHomePageSettings()) -> UIAlertAction? {
        guard homePageSettings.favorites else { return nil }
        
        let bookmarksManager = BookmarksManager()
        guard !bookmarksManager.contains(url: link.url) else { return nil }

        return UIAlertAction(title: UserText.actionSaveFavorite, style: .default) { [weak self] _ in
            Pixel.fire(pixel: .browsingMenuAddToFavorites)
            bookmarksManager.save(favorite: link)
            self?.view.showBottomToast(UserText.webSaveFavoriteDone)
        }
    }

    private func onShareAction(forLink link: Link, printFormatter: UIPrintFormatter) {
        Pixel.fire(pixel: .browsingMenuShare)
        guard let menu = chromeDelegate?.omniBar.menuButton else { return }
        let url = appUrls.removeATBAndSource(fromUrl: link.url)
        presentShareSheet(withItems: [ url, link, printFormatter ], fromView: menu)
    }
    
    private func onToggleDesktopSiteAction(forUrl url: URL) {
        Pixel.fire(pixel: .browsingMenuToggleBrowsingMode)
        tabModel.toggleDesktopMode()
        updateContentMode()
        tabModel.isDesktop ? load(url: url.toDesktopUrl()) : reload(scripts: false)
    }
    
    private func onReportBrokenSiteAction() {
        Pixel.fire(pixel: .browsingMenuReportBrokenSite)
        delegate?.tabDidRequestReportBrokenSite(tab: self)
    }
    
    private func onBrowsingSettingsAction() {
        Pixel.fire(pixel: .browsingMenuSettings)
        delegate?.tabDidRequestSettings(tab: self)
    }
    
    private func buildWhitelistAction(forDomain domain: String) -> UIAlertAction {
        let whitelistManager = WhitelistManager()
        let whitelisted = whitelistManager.isWhitelisted(domain: domain)
        let title = whitelisted ? UserText.actionRemoveFromWhitelist : UserText.actionAddToWhitelist
        let operation = whitelisted ? whitelistManager.remove : whitelistManager.add
        
        return UIAlertAction(title: title, style: .default) { _ in
            Pixel.fire(pixel: whitelisted ?.browsingMenuWhitelistRemove : .browsingMenuWhitelistAdd)
            operation(domain)
        }
    }
}
