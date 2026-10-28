# Practice Mastery: starter app

A Rails 7.2 API-only app for a math practice product. You'll be asked to extend it during the session.

Bring whatever AI coding tools you normally use, configured the way you like.

## Setup

Requirements: Ruby 3.3+, PostgreSQL (local, or `docker compose up -d db` then `export DB_USER=postgres`).

```sh
bin/setup              # bundle, create + migrate + seed dev DB, load test DB
bundle exec rspec      # should be green
bin/rails server       # http://localhost:3000, health check at /up
```

Please make sure `bin/setup` and `bundle exec rspec` pass **before** the session.

## What's here

| Table | Notes |
|---|---|
| `users` | `role` is `student` or `teacher`; `time_zone` is the user's own zone |
| `classrooms` | belong to a teacher |
| `enrollments` | students in classrooms (unique per pair) |
| `skills` | e.g. "Multiplication facts" |
| `questions` | belong to a skill; `correct_answer` is a string |

Seeds create 5 skills x 20 questions, 2 teachers, 10 students and 2 classrooms. `bin/rails db:seed` prints user ids.

## Authentication

Authentication is stubbed. Send the caller's user id in a header; `current_user` is available in controllers.

```sh
curl -H "X-User-Id: 3" localhost:3000/some/endpoint
```

Missing or unknown ids return `401`. **Authorization is not implemented.**

## Testing

RSpec and FactoryBot are set up. Factories are in `spec/factories`; request specs get an `auth_headers(user)` helper.
