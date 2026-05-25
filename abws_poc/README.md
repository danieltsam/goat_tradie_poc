# ABWS — A Better Weekly Structure

Tablet-first weekly planner POC (G.O.A.T Tradie).

## Platforms

Tracked in repo: **Android**, **web** (Chrome), **iOS** (optional iPad later). Desktop `linux/`, `windows/`, and `macos/` folders were removed.

## Run

```bash
flutter run -d chrome          # dev (author-tested)
flutter run                    # Android emulator / device
```

Wide window (≥600px) = tablet (sidebar + grid). Narrow = phone (+ button opens add dialog).

## Code map (4 files)

| File | Role |
|------|------|
| `lib/schedule_data.dart` | Categories, events, grid times, validation, progress bar math |
| `lib/schedule_home_page.dart` | Screen layout, header bar, tablet sidebar |
| `lib/add_event_form.dart` | Shared add-event form |
| `lib/week_grid_view.dart` | 7-day calendar grid |

## Review branch

Work targets `tablet-calendar` until merged to `main`.
