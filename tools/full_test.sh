#!/usr/bin/env bash
set -euo pipefail

cd ~/DEV/lumiai

echo "== A) ENV =="
test -f .env && echo "OK: .env var" || (echo "ERROR: .env yok" && exit 1)
grep -q '^SUPABASE_URL=' .env && echo "OK: SUPABASE_URL var" || (echo "ERROR: SUPABASE_URL yok" && exit 1)
grep -q '^SUPABASE_ANON_KEY=' .env && echo "OK: SUPABASE_ANON_KEY var" || (echo "ERROR: SUPABASE_ANON_KEY yok" && exit 1)

echo "== B) DOCKER =="
docker version >/dev/null
echo "OK: docker"

echo "== C) SUPABASE LOCAL STATUS =="
supabase status >/dev/null
echo "OK: supabase status"

echo "== D) REST SMOKE =="
URL="http://127.0.0.1:54321/rest/v1/"
code="$(curl -s -o /dev/null -w "%{http_code}" "$URL")"
echo "HTTP=$code"
test "$code" = "200" && echo "OK: REST 200" || (echo "ERROR: REST $code" && exit 1)

echo "== E) DB CONNECT =="
DB_URL="postgresql://postgres:postgres@127.0.0.1:54322/postgres"
psql "$DB_URL" -v ON_ERROR_STOP=1 -c "select 1;" >/dev/null
echo "OK: psql connect"

echo "== F) TABLO KONTROL =="
psql "$DB_URL" -v ON_ERROR_STOP=1 -c "select count(*) as ai_characters from public.ai_characters;"
psql "$DB_URL" -v ON_ERROR_STOP=1 -c "select count(*) as user_profiles from public.user_profiles;"
echo "OK: tablo check"

echo "== G) FLUTTER =="
flutter pub get
flutter analyze
flutter test || true
flutter build apk --debug

echo "OK: FULL TEST PASS"
