//
//  ShieldConfigurationExtension.swift
//  ShieldConfig
//
//  Created by Kei Fujikawa on 2023/08/21.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.dark,
            backgroundColor: UIColor.black,
            icon: UIImage(named: "icon2"),
            title: ShieldConfiguration.Label(
                text: "Restrito",
                color: .white
            ),
            subtitle: ShieldConfiguration.Label(
                text: "Foque",
                color: .white
            ),
            primaryButtonLabel: ShieldConfiguration.Label(
                text: "SOk",
                color: .black
            ),
            primaryButtonBackgroundColor: .yellow
        )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}
