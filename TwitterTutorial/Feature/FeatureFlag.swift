//
//  FeatureFlag.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 28/09/2024.
//

import Foundation


struct FeatureFlag {
  var isShowingLoginButton: Bool
}

// Create an instance of FeatureFlag based on the build configuration
let featureFlag: FeatureFlag = {
#if DEV
  return FeatureFlag(isShowingLoginButton: true)
#elseif PROD
  return FeatureFlag(isShowingLoginButton: true)
#endif
}()
