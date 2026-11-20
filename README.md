# Practice Room

A piano practice app for MusicXML pieces, played on a MIDI keyboard.

- **Library**: import MusicXML (.mxl / .musicxml), group pieces into collections, tag, search and track scores.
- **Practice mode**: the cursor waits until you play the right notes.
- **Play mode**: count-in, real-time scoring, stars for full runs at tempo.
- Sampled grand piano, woodblock / hi-hat metronome, live 88-key display.
- Optional MIDI file per piece: import it alongside the score (matching file name) or attach it from Edit, and the app plays that performance for “Hear my part” / “Hear other hand”.

Open the site in a browser with Web MIDI support (on iPad, a Web MIDI browser app) and connect a Bluetooth or USB MIDI keyboard.
Your library is stored in that browser on that device — use **Settings → Save backup** now and then.

## Sync across devices (Supabase)

1. Create a free project at [supabase.com](https://supabase.com).
2. **SQL Editor → New query**: paste `supabase-setup.sql` from this repo and press **Run**.
3. **Authentication → Sign In / Providers → Email**: turn off **Confirm email** (so the account works straight away).
4. **Project Settings → API**: copy the **Project URL** and the **anon / publishable key**.
5. In the app: tap **Sign in to sync** → paste URL and key → enter an email and password → **Create account**.
6. Afterwards, under **Authentication → Sign In / Providers**, turn off **Allow new users to sign up** so nobody else can create an account.

On another device: open the account sheet on the first device, copy the **setup code**, paste it on the new device and sign in with the same email and password.
The project URL and key are stored only on your devices, never in this repo.
