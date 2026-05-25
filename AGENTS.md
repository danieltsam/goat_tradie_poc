## Learned User Preferences

- Build tablet-first; tablet is the primary target platform before mobile polish.
- Use one Flutter codebase with adaptive layouts (breakpoint-based variants), not fully separate mobile and tablet app trees.
- Keep implementations simple enough for student developers to extend (shared forms, platform `showTimePicker`, clear file roles; see `abws_poc/ARCHITECTURE.md`).
- Chrome with DevTools tablet sizing is fine for daily layout work; use an Android emulator closer to release for real device behavior.
- Keep feature work on the `tablet-calendar` branch until explicitly approved to merge back to `main`.
- Header category progress bars should fill proportionally to each category's recommended hours, not jump to full width after one event.
- Category text legend lives in the sidebar; the header progress strip is color segments only (no duplicated labels).

## Learned Workspace Facts

- The Flutter app lives in `abws_poc/` (ABWS = "A Better Weekly Structure", G.O.A.T Tradie weekly scheduler POC).
- Active development branch is `tablet-calendar`.
- Tablet layout applies at width ≥ 600px (`lib/schedule/schedule_layout.dart`); phone uses a FAB + dialog without a fixed sidebar.
- `lib/pages/schedulehome.dart` owns the event list and picks tablet vs phone layout.
- Run locally with `cd abws_poc && flutter run -d chrome` (resize wide for tablet, narrow for phone).
- Week grid uses 4AM / 12PM / 10PM markers; event validation is centralized in `lib/schedule/schedule_event_builder.dart`.
- Shared add-event UI is `lib/widgets/add_event_form.dart` (tablet sidebar and phone dialog both use it).
- Guided flow is 12 steps starting with Health (`lib/schedule/guided_steps.dart`); category hours drive the header bar (`lib/schedule/category_hours.dart`).
