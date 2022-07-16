//
//  Environment.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import Foundation

class Environment {

    enum ConfigurationServer: String {
        case debug = "Debug"
        case release = "Release"
    }

    // MARK: Shared instance
    private static var manager: Environment?
    static let shared: Environment = {
        if manager == nil {
            manager = Environment()
        }
        return manager!
    }()

    // MARK: Properties

    private let configurationKey = "Configuration"
    private let configurationDictionaryName = "Configuration"
    private let backendUrlKey = "backendUrl"
    private let activeEnvironment: ConfigurationServer
    private let activeEnvironmentDictionary: NSDictionary

    // MARK: LiveCycle
    init () {
        let bundle = Bundle(for: Environment.self)
        guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String,
            let activeEnvironment = ConfigurationServer(rawValue: rawConfiguration),
            let configurationDictionaryPath = bundle.path(forResource: configurationDictionaryName, ofType: "plist"),
            let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath),
            let activeEnvironmentDictionary = configurationDictionary[activeEnvironment.rawValue] as? NSDictionary
            else {
                fatalError("Configuration Error")
        }
        self.activeEnvironment = activeEnvironment
        self.activeEnvironmentDictionary = activeEnvironmentDictionary
    }

    // MARK: Methods
    private func getActiveVariableValue<V>(forKey key: String?) -> V {
        guard let finalKey = key else {
            fatalError("No value for key")
        }

        guard let value = activeEnvironmentDictionary[finalKey] as?  V else {
            fatalError("No value satysfying requirements")
        }
        return value
    }

    func isRunning(in configuration: ConfigurationServer) -> Bool {
        return activeEnvironment == configuration
    }

    func getBackendUrl() -> URL {
        let backendUrlString: String = getActiveVariableValue(forKey: backendUrlKey)
        guard let url = URL(string: backendUrlString) else {
            fatalError("backEnd Url not found")
        }
        return url
    }
}
