# ABWS app structure (for developers)

Tablet-first weekly planner. One list of events lives on the home screen; layout changes by screen width.

## Run

```bash
cd abws_poc
flutter run -d chrome   # resize wide (≥600px) for tablet, narrow for phone
```

## Folder map

| Path | What it does |
|------|----------------|
| `lib/main.dart` | App entry, theme |
| `lib/pages/schedulehome.dart` | **Start here** — owns `_events`, picks tablet vs phone layout |
| `lib/schedule/schedule_layout.dart` | `tabletBreakpoint` (600px), `isTabletLayout()` |
| `lib/schedule/schedule_constants.dart` | Day names, 4AM–10PM grid math |
| `lib/schedule/schedule_categories.dart` | Life areas (Health, Friends, …) and colors |
| `lib/schedule/schedule_event_builder.dart` | Validate times + build `ScheduleEvent` |
| `lib/models/schedule_event.dart` | Event data class |
| `lib/widgets/add_event_form.dart` | **Shared form** — day, start/end (platform time picker), Add button |
| `lib/widgets/time_picker_button.dart` | Opens `showTimePicker` |
| `lib/widgets/category_progress_bar.dart` | Header step badge + coloured bar + legend |
| `lib/schedule/category_hours.dart` | Sum hours per category from events |
| `lib/widgets/tablet_sidebar.dart` | Tablet-only left panel |
| `lib/widgets/add_event_dialog.dart` | Phone: dialog around `AddEventForm` |
| `lib/scheduleWidgets/week_grid_view.dart` | 7-day calendar grid |

## Tablet vs phone

- **Width ≥ 600:** sidebar + week grid. Add events in the sidebar form.
- **Width &lt; 600:** week grid only. Tap **+** FAB → same form in a dialog.

## Common tasks

1. **Change breakpoint** → `schedule_layout.dart`
2. **Add a category** → `schedule_categories.dart`
3. **Change grid hours (4AM / 10PM)** → `schedule_constants.dart` + validation in `schedule_event_builder.dart`
4. **Change add-event fields** → `add_event_form.dart` (both layouts use it)
5. **Advance guided steps** → `tablet_sidebar.dart` → `currentStepIndex`

## Data flow

```
ScheduleHomePage (_events)
    ├─ tablet: TabletSidebar → AddEventForm → onEventAdded
    ├─ phone: FAB → showAddEventDialog → AddEventForm → onEventAdded
    └─ WeekGridView (read-only display, tap to delete)
```

Do not duplicate validation — use `validateScheduleEventInput` and `buildScheduleEvent` in `schedule_event_builder.dart`.
