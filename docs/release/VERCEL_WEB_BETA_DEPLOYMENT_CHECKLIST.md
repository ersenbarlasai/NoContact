# Vercel Web Beta Deployment Checklist

This document ensures the NoContact (Still) Flutter Web app is correctly built and served on Vercel.

## 1. Vercel Project Settings

If you see a **404 NOT FOUND** error or a 5-second "Ready" deployment, verify these settings in the Vercel Dashboard:

| Setting | Value |
| :--- | :--- |
| **Root Directory** | `app/mobile` |
| **Build Command** | `sh vercel-build.sh` |
| **Output Directory** | `build/web` |
| **Install Command** | (Leave empty or default) |

## 2. Environment Variables

Ensure these variables are added in Vercel **Project Settings > Environment Variables** for the build to succeed and connect to the backend:

- `SUPABASE_URL`: Your Supabase Project URL.
- `SUPABASE_ANON_KEY`: Your Supabase Anonymous Key.
- `BETA_FEEDBACK_FORM_URL`: (Optional) External feedback form URL.

## 3. Configuration Files

Ensure the following files are present in `app/mobile/`:

- **`vercel.json`**: Configures the build command, output directory, and SPA rewrites.
- **`vercel-build.sh`**: The script that installs Flutter and builds the web app.

## 4. Troubleshooting 404s

### "Deployment finished in 5-10 seconds"
- **Cause**: Vercel skipped the build or didn't find the `flutter` command.
- **Fix**: Ensure `buildCommand` is set to `sh vercel-build.sh` and the file is present in the repository.

### "404 on Refresh"
- **Cause**: Flutter is an SPA. Refreshing `/mood-journal` directly makes Vercel look for a folder named `mood-journal`.
- **Fix**: The `rewrites` block in `vercel.json` maps all paths back to `index.html`. Ensure `vercel.json` matches:
```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

### "Missing Supabase Config"
- **Cause**: Variables not passed at build time.
- **Fix**: Verify `dart-define` flags in `vercel-build.sh` match the Vercel Environment Variable keys.

## 5. Local Verification

Before pushing, verify you can build locally:
```powershell
cd app/mobile
flutter build web --release --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```
Check if `app/mobile/build/web/index.html` exists.
