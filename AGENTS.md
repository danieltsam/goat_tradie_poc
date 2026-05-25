## Learned User Preferences

- Build tablet-first; tablet is the primary target platform before mobile polish.
- Use one Flutter codebase with adaptive layouts (breakpoint-based variants), not fully separate mobile and tablet app trees.
- Keep implementations simple enough for student developers to extend.
- Chrome with DevTools tablet sizing is fine for daily layout work; use an Android emulator closer to release for real device behavior.
- Keep feature work on the `tablet-calendar` branch until explicitly approved to merge back to `main`.
- Header category progress bars should fill proportionally to each category's recommended hours, not jump to full width after one event.
- Category text legend lives in the sidebar; the header progress strip is colour segments only (no duplicated labels).

## Learned Workspace Facts

- The Flutter app lives in `abws_poc/` (ABWS weekly scheduler POC).
- Active development branch is `tablet-calendar`.
- Tablet layout at width ≥ 600px; `lib/schedule_home_page.dart` owns the event list.
- Run: `cd abws_poc && flutter run -d chrome`.
- Core code is four files under `lib/`: `schedule_data.dart`, `schedule_home_page.dart`, `add_event_form.dart`, `week_grid_view.dart`.
