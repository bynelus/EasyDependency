//
//  Container+SchedulingTasks.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/06/2019.
//

import Foundation
import Schedule

public extension Container {
	private func plan(for interval: Interval, repeating: Interval?) -> Plan {
		guard let repeating = repeating else { return Plan.after(interval) }
		return Plan.after(interval, repeating: repeating)
	}
	
	func schedule(in interval: Interval, repeating: Interval? = nil, queue: DispatchQueue, handler: @escaping () -> Void) {
		plan(for: interval, repeating: repeating).do(queue: queue) { handler() }
	}
	
	func schedule<T>(type: T.Type, in interval: Interval, repeating: Interval? = nil, queue: DispatchQueue, handler: @escaping (T?) -> Void) {
		plan(for: interval, repeating: repeating).do(queue: queue) { [weak self] in
			guard let strongSelf = self else { return handler(nil) }
			handler(try? strongSelf.resolve(type))
		}
	}
}
