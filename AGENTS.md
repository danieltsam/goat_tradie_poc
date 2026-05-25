## Learned User Preferences

- **Start from `main`**, not `tablet-calendar` / `tablet-layout-simple` (those branches are archived).
- Mobile-first; legend in the app bar + drawer sidebar; footer ? / + / → buttons; add-event bottom sheet.
- Keep code simple for student developers; prefer `lib/pages/` and `lib/scheduleWidgets/` layout from `main`.
- Target ~500 LOC in `abws_poc/lib/` where practical.

## Learned Workspace Facts

- Flutter app: `abws_poc/`.
- **Active branch:** `mobile-schedule` (branched from `main`).
- **Archived:** `tablet-calendar`, `tablet-layout-simple` — reference only.
- Run: `cd abws_poc && flutter run -d chrome` (phone width ~390px).
- **Files:** `lib/main.dart` → `lib/pages/schedulehome.dart`; `lib/scheduleWidgets/schedulewidgets.dart` (grid); `lib/scheduleWidgets/category_legend.dart` (legend + drawer); `lib/schedule_data.dart`; `lib/add_event_sheet.dart`.
