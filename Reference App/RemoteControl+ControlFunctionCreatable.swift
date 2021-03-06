//
//  RemoteControl+ControlFunctionable.swift
//  Telematics App
//
//  Created by Mikk Rätsep on 09/07/2017.
//  Copyright © 2017 High-Mobility GmbH. All rights reserved.
//

import Car
import Foundation


extension RemoteControl: ControlFunctionable {

    var boolValue: (ControlFunction.Kind) -> Bool? {
        return { _ in nil }
    }

    var controlFunctions: [ControlFunction] {
        return [FullScreenControlFunction(kind: .remoteControl, iconName: "Remote", viewControllerID: "RemoteControlViewControllerID")]
    }

    var kinds: [ControlFunction.Kind] {
        return [.remoteControl]
    }

    var stringValue: (ControlFunction.Kind) -> String? {
        return {
            guard $0 == .remoteControl else {
                return nil
            }

            return "\(self.controlMode)"
        }
    }
}
