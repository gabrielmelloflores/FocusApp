import Foundation
import FamilyControls
import DeviceActivity
import Combine
import ManagedSettings

class FamilyControlModel: ObservableObject {
    static let shared = FamilyControlModel()
    private var monitoringTimer: AnyCancellable?
    private let store = ManagedSettingsStore()
    private let center = DeviceActivityCenter()
    private init() {}

    @Published var selectedApps: FamilyActivitySelection = FamilyActivitySelection()
    
    var selectionToDiscourage = FamilyActivitySelection() {
        willSet {
            self.selectedApps = newValue
        }
    }
    
    func authorize() async throws {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
    }

    func initiateMonitoring() {
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 0, minute: 2),
            repeats: false,
            warningTime: nil
        )
        
        do {
            try center.startMonitoring(.daily, during: schedule)
        } catch {
            print("Could not start monitoring \(error)")
        }
        
        store.dateAndTime.requireAutomaticDateAndTime = true
        store.account.lockAccounts = true
        store.passcode.lockPasscode = true
        store.siri.denySiri = true
        store.appStore.denyInAppPurchases = true
        store.appStore.maximumRating = 200
        store.appStore.requirePasswordForPurchases = true
        store.media.denyExplicitContent = true
        store.gameCenter.denyMultiplayerGaming = true
        store.media.denyMusicService = false
    }
    
    func stopMonitoring() {
        center.stopMonitoring()
    }
    
    func encourageAll() {
        store.shield.applications = []
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific([])
        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific([])
    }
    
    func applyBlockSelection() {
        let applications = selectedApps.applicationTokens
        let categories = selectedApps.categoryTokens
        
        store.shield.applications = applications.isEmpty ? nil : applications
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories)
        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories)
    }
    
    func scheduleBlocking(startingFrom startDate: Date, endingAt endDate: Date) {
        monitoringTimer?.cancel()
        
        monitoringTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                let now = Date()
                if now >= startDate && now <= endDate {
                    self?.initiateMonitoring()
                    self?.applyBlockSelection()
                } else if now > endDate {
                    self?.encourageAll()
                    self?.monitoringTimer?.cancel()
                }
            })
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}
