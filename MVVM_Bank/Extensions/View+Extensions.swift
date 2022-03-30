//
//  View+Extensions.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
}
