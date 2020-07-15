//
//  BackgroundTaskManager.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/07.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import BackgroundTasks
import Domain
import Foundation

@available(iOS 13.0, *)
public final class BackgroundTaskManager {

    public static let shared = BackgroundTaskManager()

    private init() {}
}

// MARK: - Task
@available(iOS 13.0, *)
extension BackgroundTaskManager {

    enum Task: CaseIterable {
        case fetchBattleLog

        var refreshIdentifier: String {
            switch self {
            case .fetchBattleLog:
                return "com.royaleapp.battlelog.refresh"
            }
        }

        var refreshInterval: TimeInterval {
            switch self {
            case .fetchBattleLog:
                // Every 30 minutes
                return 30 * 60
            }
        }

        var operation: Operation {
            switch self {
            case .fetchBattleLog:
                return BattleLogFetchOperation()
            }
        }
    }
}

// MARK: - Function
@available(iOS 13.0, *)
extension BackgroundTaskManager {

    public func registerBackgroundTask() {
        for bgTask in Task.allCases {
            BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTask.refreshIdentifier, using: nil) { task in
                self.handleAppRefresh(task: task as! BGAppRefreshTask, operation: bgTask.operation)
            }
        }
    }

    private func handleAppRefresh(task: BGAppRefreshTask, operation: Operation) {

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1

        task.expirationHandler = {
            NotificationHelper.postLocalNotification(with: Message(body: "The process has not been completed"))
            queue.cancelAllOperations()
        }

        operation.completionBlock = {
            task.setTaskCompleted(success: operation.isFinished)
        }

        queue.addOperation(operation)

        self.scheduleAppRefresh()
    }

    public func scheduleAppRefresh() {
        for bgTask in Task.allCases {
            let request = BGAppRefreshTaskRequest(identifier: bgTask.refreshIdentifier)
            request.earliestBeginDate = Date(timeIntervalSinceNow: bgTask.refreshInterval)

            do {
                try BGTaskScheduler.shared.submit(request)
            } catch {
                print("bgTask = \(bgTask) couldn't app refresh error: \(error)")
            }
        }
    }
}

@available(iOS 13.0, *)
final class BattleLogFetchOperation: Operation {

    let realmBattleLogsUseCase = RealmBattleLogsUseCaseProvider.provide()
    let battleLogUseCase = BattleLogsUseCaseProvider.provide()

    override func main() {
        self.battleLogUseCase.get(playerTag: AppConfig.playerTag) { result in
            switch result {
            case .success(let battleLogModel):
                let latestBattleLogTime = self.realmBattleLogsUseCase.getLatest()?.battleDate ?? Date(timeIntervalSince1970: 0)
                let realmBattleLogs = battleLogModel.realmBattleLogs()
                let addBattleLogCount = realmBattleLogs.filter { $0.battleDate > latestBattleLogTime }.count
                self.realmBattleLogsUseCase.save(objects: realmBattleLogs)
                if addBattleLogCount > 0 {
                    NotificationHelper.postLocalNotification(with: Message(body: "Add BattleLog: \(addBattleLogCount) count"))
                }
            case .failure:
                // TODO: Error Handling
                break
            }
        }
    }
}
