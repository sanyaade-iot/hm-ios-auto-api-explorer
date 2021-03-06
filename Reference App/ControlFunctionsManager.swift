//
//  ControlFunctionsManager.swift
//  Telematics App
//
//  Created by Mikk Rätsep on 09/06/2017.
//  Copyright © 2017 High-Mobility GmbH. All rights reserved.
//

import Car
import Foundation



class ControlFunctionsManager {

    static let shared: ControlFunctionsManager = ControlFunctionsManager()


    // MARK: Vars

    var externalControlFunctions: [ControlFunction] {
        // Currently ALL the capabilities are External
        return allControlFunctions
    }

    private(set) var allControlFunctions: [ControlFunction] = []


    // MARK: Methods

    func receivedCapabilities(for commands: [Command?]) {
        // - Find the non-nil Commands from all commands
        // - Find the ControlFunctionSettable ones from them
        // - Get the ControlFunctions from those
        // - Flatten the ControlFunction-arrays
        let functions = commands.flatMap { $0 }.flatMap { $0 as? ControlFunctionable }.map { $0.controlFunctions }.flatMap { $0 }

        // - Sort the ControlFunctions by name
        self.allControlFunctions = functions.sorted { $0.name < $1.name }
    }

    @discardableResult func updateControlFunctions(from command: Command) -> [ControlFunction]? {
        guard let thingy = command as? ControlFunctionable else {
            return nil
        }

        let functions = allControlFunctions.filter { thingy.kinds.contains($0.kind) }

        // Update the functions
        functions.forEach { $0.receivedUpdate(command) }

        return functions
    }


    private init() { }
}
