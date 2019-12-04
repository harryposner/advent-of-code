#!/usr/bin/env python3.8

import re
from collections import Counter, defaultdict
from dataclasses import dataclass
from datetime import datetime


@dataclass(order=True)
class Event:
    timestamp: datetime
    id: int
    type: str


events = []
timestamp_format = "%Y-%m-%d %H:%M"
guard_id = None
with open("day_4_input.txt", "r") as infile:
    for line in infile:
        raw_timestamp = re.match(r"\[(.+)\]", line).group(1)
        timestamp = datetime.strptime(raw_timestamp, timestamp_format)
        event_type = " ".join(line.split()[-2:])
        if event_type == "begins shift":
            guard_id = int(re.search(r"#(\d+)", line).group(1))
        else:
            guard_id = None
        events.append(Event(timestamp, guard_id, event_type))

events.sort()

guard_id = None
for event in events:
    if event.id is None:
        event.id = guard_id
    else:
        guard_id = event.id

sleep_by_minute = defaultdict(Counter)
for event, next_event in zip(events[:-1], events[1:]):
    if event.type == "falls asleep":
        assert next_event.type == "wakes up"
        time_range = event.timestamp.minute, next_event.timestamp.minute
        sleep_by_minute[event.id].update(range(*time_range))

sleepiest_id, sleepiest_count = max(sleep_by_minute.items(),
                                    key=lambda x: sum(x[1].values()))
sleepiest_minute = sleepiest_count.most_common()[0][0]

print("Part 1:", sleepiest_id * sleepiest_minute)


sleepiest_minutes = [(guard, count.most_common()[0])
                     for guard, count in sleep_by_minute.items()]
sleepiest_id, (sleepiest_minute, __) = max(sleepiest_minutes, key=lambda x: x[1][1])

print("Part 2:", sleepiest_id * sleepiest_minute)
