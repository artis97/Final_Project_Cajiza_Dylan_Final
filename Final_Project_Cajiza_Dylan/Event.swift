//
//  Event.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/23/22.
//

import Foundation

var eventsList = [Event]()

class Event
{
    var id: Int!
    var name: String!
    var date: Date!
    
    func eventsForDate(date: Date) -> [Event]
    {
        var daysEvents = [Event]()
        for event in eventsList
        {
            if(Calendar.current.isDate(event.date, inSameDayAs:date))
            {
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
}
