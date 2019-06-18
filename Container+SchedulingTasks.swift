//
//  Container+SchedulingTasks.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/06/2019.
//

import Foundation
import Schedule

extension Container {
	public func schedule(in interval: Interval, repeating: Interval? = nil, queue: DispatchQueue, handler: @escaping () -> Void) {
		let plan = repeating != nil ? Plan.after(interval, repeating: repeating!) : Plan.after(interval)
		plan.do(queue: queue) { handler() }
	}
	
	public func schedule<T>(type: T.Type, in interval: Interval, repeating: Interval? = nil, queue: DispatchQueue, handler: @escaping (T?) -> Void) {
		let plan = repeating != nil ? Plan.after(interval, repeating: repeating!) : Plan.after(interval)
		plan.do(queue: queue) { [weak self] in
			guard let strongSelf = self else { return handler(nil) }
			handler(try? strongSelf.resolve(type))
		}
	}
}
