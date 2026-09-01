# 🥊 Reminder Randall

**Randall blasts you when you miss a meeting — nothing else.**

Not another assistant. Randall doesn't organize your inbox, take notes, or send email for you, and **he never joins your calls as a bot.** He does one job: when a meeting on your calendar starts and you haven't joined, he escalates — iMessage → WhatsApp → phone call → email — until you reply **IN**.

## How it works

1. You give Randall the secret `.ics` URL of your calendar (Google, Outlook, Apple — all export one).
2. Every 10 min Randall syncs upcoming meetings that have a Meet/Zoom/Teams/Whereby link.
3. At `start + grace` (default 2 min) he checks whether you're in. If not, he starts blasting down your channel list, waiting `escalate_after_seconds` between each.
4. The instant you reply **IN**, tap the magic link, or (for meetings you host) show up in the participant list, he stops.

Everything is a toggle: pick which channels, their order, the grace window, an optional heads-up before start, or a gentler *"you joined right?"* first ping instead of a hard blast.

**No in-room bot.** For meetings *you host*, Randall can read the provider's participant API to auto-detect that you joined (opt-in, keys required). For everything else he asks and you ack — zero surveillance, zero agents sitting in your calls.

## Stack

Plain Rails 8. SQLite + Solid Queue — no Redis, no extra services. iMessage via [LoopMessage](https://loopmessage.com); WhatsApp + Call via [Twilio](https://twilio.com); Email via any SMTP.

## Run it

```bash
bin/setup                 # installs gems, prepares the DB
cp .env.example .env      # fill in your calendar URL + channel keys
bin/rails db:seed         # creates your user from RANDALL_* env vars
bin/dev                   # web + job worker (Procfile.dev)
```

Open http://localhost:3000, confirm your settings, and you're covered. To run only the channels you want, uncheck the rest in Settings.

### Inbound "IN" replies

Point your provider webhooks at:

- LoopMessage → `POST /hooks/loopmessage`
- Twilio SMS/WhatsApp → `POST /hooks/twilio`

## Deploy

Ships with a Dockerfile and Kamal. `kamal setup` to a $5 box, set the env vars, done. The Solid Queue worker (`bin/jobs`) runs the recurring calendar sync and every escalation.

## Roadmap

- Google/Zoom participant auto-detect adapters (interface is stubbed in `app/models/provider.rb`)
- Multi-user + real auth (currently single self-host user via `User.current`)
- Channel reordering UI and quiet hours

MIT licensed. PRs welcome — if you miss meetings too, this is for you.
