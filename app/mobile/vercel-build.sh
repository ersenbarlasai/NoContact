#!/bin/bash

# Exit on error
set -e

echo "--- Starting Flutter Web Build for Vercel ---"

# 1. Install Flutter SDK
# We use the stable channel. Shallow clone to save time.
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
else
  echo "Flutter SDK already exists, skipping clone."
fi

# 2. Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# 3. Enable Web support
echo "Enabling Flutter Web..."
flutter config --enable-web

# 4. Verify Flutter installation
flutter --version

# 5. Get dependencies
echo "Getting dependencies..."
flutter pub get

# 6. Build Flutter Web
# Using --dart-define to pass Supabase and Feedback URL secrets from Vercel Env Vars
echo "Building Flutter Web..."
flutter build web --release \
  --dart-define=SUPABASE_URL=$SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY \
  --dart-define=BETA_FEEDBACK_FORM_URL=$BETA_FEEDBACK_FORM_URL

echo "--- Build Complete ---"
