//
//  LightTheme.swift

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

struct LightTheme: Theme {
    var name = ThemeName.light
    
    var currentImageSet: ThemeManager.ImageSet = .light
    var statusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }
    
    var keyboardAppearance: UIKeyboardAppearance = .light
    
    var backgroundColor = UIColor.white
    
    var barBackgroundColor = UIColor.nearlyWhiteLight
    var barTintColor = UIColor.nearlyBlackLight
    
    var navigationBarTitleColor = UIColor.nearlyBlackLight
    var navigationBarTintColor = UIColor.cornflowerBlue
    
    var tintOnBlurColor = UIColor.white
    
    var searchBarBackgroundColor = UIColor.lightGreyish
    var centeredSearchBarBackgroundColor = UIColor.white
    var searchBarTextColor = UIColor.nearlyBlackLight
    var searchBarTextPlaceholderColor = UIColor.greyish3
    var searchBarTextDeemphasisColor = UIColor.greyish3
    var searchBarBorderColor = UIColor.lightGreyish
    var searchBarClearTextIconColor = UIColor.greyish2
    
    var progressBarGradientDarkColor = UIColor.cornflowerBlue
    var progressBarGradientLightColor = UIColor.skyBlueLight

    var autocompleteCellAccessoryColor = UIColor.darkGreyish
    
    var tableCellBackgroundColor = UIColor.white
    var tableCellSelectedColor = UIColor.mercury
    var tableCellSeparatorColor = UIColor.mercury
    var tableCellTextColor = UIColor.darkGreyish
    var tableCellAccessoryTextColor = UIColor.greyish3
    var tableCellAccessoryColor = UIColor.greyish
    var tableCellHighlightedBackgroundColor = UIColor.mercury
    var tableHeaderTextColor = UIColor.greyish3
    
    var tabSwitcherCellBackgroundColor = UIColor.white
    var tabSwitcherCellBorderColor = UIColor.cornflowerBlue
    var tabSwitcherCellTextColor = UIColor.black
    
    var iconCellBorderColor = UIColor.darkGreyish

    var buttonTintColor = UIColor.cornflowerBlue
    var placeholderColor = UIColor.greyish3
    
    var textFieldBackgroundColor = UIColor.white
    var textFieldFontColor = UIColor.nearlyBlackLight
    
    var homeRowPrimaryTextColor = UIColor.nearlyBlackLight
    var homeRowSecondaryTextColor = UIColor.greyishBrown2
    var homeRowBackgroundColor = UIColor.nearlyWhiteLight
    
    var homePrivacyCellTextColor = UIColor.charcoalGrey
    var homePrivacyCellSecondaryTextColor = UIColor.greyish3
    
    var aboutScreenTextColor = UIColor.charcoalGrey
    var aboutScreenButtonColor = UIColor.cornflowerBlue
    
    var favoritesPlusTintColor = UIColor.greyish3
    var favoritesPlusBackgroundColor = UIColor.lightMercury
    
    var faviconBackgroundColor = UIColor.white
    var favoriteTextColor = UIColor.darkGreyish
    
    var feedbackPrimaryTextColor = UIColor.nearlyBlackLight
    var feedbackSecondaryTextColor = UIColor.nearlyBlackLight
    var feedbackSentimentButtonBackgroundColor = UIColor.white
    
    var privacyReportCellBackgroundColor = UIColor.white
    
    var activityStyle: UIActivityIndicatorView.Style = .gray
    
    var destructiveColor: UIColor = UIColor.destructive
    
    var ddgTextTintColor: UIColor = UIColor.nearlyBlackLight
    
    var daxDialogBackgroundColor: UIColor = UIColor.white
    var daxDialogTextColor: UIColor = UIColor.darkGreyish
}
