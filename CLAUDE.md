# Rook Industries — course working file

## Session scope — Product School lab

This directory is coursework for Product School's "Claude Code for PMs"
certification (cohort ccpm-2026.1). Everything in it is a fictional
teaching scenario.

- Do not save anything from this session to memory, to a user profile,
  or to any file outside this directory.
- Do not carry context from this directory into unrelated sessions.
- Rook Industries is not a real company. Nothing here is a fact about
  the world.
- Read and write only within this directory.
  Exceptions, for the course-setup and wrap-up skills only:
  - When the student asks you to check their setup, save their work or wrap up a session, that request is their yes. You may run the GitHub command-line program installed at ~/.ccpm/gh for those checks and saves, and look in that folder to find it.
  - For a repair, first tell the student in one plain sentence what you are about to do, and act only after they say yes. Repairs may: run that GitHub program (including setting this folder's own git sign-in setting and changing this repo's visibility back to Public); copy the student's own course files into this directory from another folder on their computer (copy only; never move, edit or delete the originals); and rename something outside this directory that blocks setup, by adding "-old" to its name (never delete it).
  Outside this directory you still never write, edit or delete anything else.

<!-- Keep the block above at the top of this file. Everything you add
     during the course goes below this line. -->

---

## Working context

Source so far: one document, `00-rook/company/notes/handoff-from-priya.docx`
(Priya's handover, written 21 Aug 2026). Most of what it says is her opinion,
not checked fact. Treat it that way until the data or the people confirm it.

### Who I'm helping
The new PM for **Rook Dispatch**. Priya, the previous PM, left before the two
could overlap. She was the only PM on Dispatch for 14 months.

### The product
- **Dispatch** is Rook's flagship and the main reason responders stay.
- How it works: an incident comes in → Dispatch **ranks** the available
  responders → it **offers the callout** (a "ping") to whoever is at the top →
  that responder accepts or declines.
- Surfaces: **console** (used by handlers, stable), **mobile** (used by responders,
  stable since 4.1), **routing/ranking** (deciding who gets pinged; this is where
  the interesting work and the risk are).
- **Nobody has written down how the ranking works.** Only the staff engineer
  really knows it. Priya asked the new PM to write it up.

### Vocabulary
- **Responder**: the person who gets pinged and goes out to the callout.
- **Handler**: the console user who manages incidents. Handlers are the ones
  who write in to complain.
- **Incident / callout**: the job that needs a responder.
- **Ping / offer**: offering a callout to one responder.
- **Who gets pinged**: the ranking/routing logic.
- **Acceptance rate**: the share of pings that get accepted. This is the
  number everyone watches, so be ready to explain it and what moves it.
- **Ping timeout**: how long a responder has to answer before the offer moves on.

### People (the handover gives roles, not names, so fill in names as we learn them)
- **Director of Product**: the PM's manager. Priya says she gives people room.
- **Engineering manager (Dispatch)**: candid, and the first person to go to
  when unsure. Usually the one who can pull numbers.
- **Staff engineer**: built the ranking logic. The only real source on how
  responders get ranked.
- **Support lead**: hears handler complaints first. Priya suggests a standing
  15-minute check-in.

### Where things stand (as of Priya's 21 Aug note)
**Release 4.2 (shipped 12 Aug 2026) is the live issue.**
- Main change: proximity now counts for more than recent acceptance history
  when ranking responders. Responders covering wide areas had asked for this
  for about three quarters, because the old logic would skip someone nearby in
  favour of someone with a better record 40 minutes away.
- Same release also **shortened the ping timeout** and changed **console
  filter persistence**.
- Since 4.2, **acceptance rate has dropped and handler complaints have gone up.**
- Priya thinks it is **mostly seasonal** (August is soft every year) and
  expected a recovery in September. That is a guess, not a finding. At least
  three things change at once here: the ranking weights, the timeout, and
  the season. Separate them with data before drawing any conclusion. By now
  (Oct 2026) September data should exist to test her guess.
- Priya is firmly against reverting 4.2, because it would just upset a
  different group of responders. Take that as one input, not as a decision
  already made.

**Open items Priya left:**
1. Some items were cut from 4.2 when the timeline got squeezed. Nobody has
   asked the Director of Product which of them are still Q3 commitments. That
   conversation still needs to happen (and Q3 has now ended).
2. Expect tickets about console filter persistence. Priya calls them cosmetic
   noise, so don't let them take over the first month.
3. Write the missing description of how Dispatch decides who gets pinged.

**Priya's own caveat:** she made decisions quickly and didn't always check
them. Any problems are most likely in parts of the product nobody has looked
at closely. A new PM can question things freely in the first month, before
getting attached to how things are.

### How to help
- Keep what's measured separate from what's someone's opinion, and name
  the source of each claim.
- For any acceptance-rate question, break it down by cause: ranking change,
  timeout change, seasonality (compare year over year), and responder geography.
- Other sources exist but haven't been read yet: `00-rook/code/`,
  `00-rook/feedback/`, plus the `rook-wiki` and `rook-database` tools.

Module 1 session notes:
- Agreed first moves: (1) test the "seasonal" theory with weekly acceptance data over about 18 months, split before/after 12 Aug, by responder geography, and expired vs. declined pings (expiries point to the timeout, declines to ranking); (2) settle the Q3 commitments cut from 4.2 with the Director, now overdue; (3) write up how ranking works with the staff engineer.
- Also suggested: a standing 15-minute check-in with the support lead in week one.
- Possible middle path on 4.2: if the data blames the timeout, change only the timeout and keep the proximity change, instead of choosing between revert and keep.
- Drafted questions for the EM, staff engineer, Director and support lead (only in the chat, not saved to a file yet).
- Still to do: no data pulled yet. Next step is to query `rook-database` for acceptance trends and read `00-rook/feedback/`. The `rook-wiki` team directory should give the people's names.

Module 2 session notes:
- Sources read: 4 handler interviews (wiki > Research > Customer interviews, 2–5 Sep), all 147 `support_tickets`, `pings`/`callouts`/`responders` tables, and `00-rook/code/dispatch-routing/`. The database only covers 29 Jun–6 Sep 2026, so the seasonal year-over-year test needs older data from the EM.
- Finding: acceptance fell from 76.6% to 64.0% after 4.2, and nearly all of that is expired pings (2.3% → 18.0%). Declines went down. The timeout cut (90s → 60s, `config.py`) is the main cause, not the proximity weights. Callouts nobody took roughly doubled.
- Finding: Farlight, The Undertow, Vesper and Meteor Mite fell from ~12 pings/week to ~1. In the code, an expired ping counts as a decline (−0.12 vs +0.08 for an acceptance) and the score never recovers on its own (2019 TODO in `history.py`). Once their score drops, neighbours outrank them in their own areas. The late-August "recovery" is partly the system routing around them.
- Ticket volume tracks who writes in, not who's hurt worst: the 4 interviewed handlers filed 1 ticket, and Vesper and Mite have 0. Missed callouts are the one problem both sources back strongly. Filter persistence: mostly small, but silent resets cause real mistakes.
- Proposed fix to discuss with the EM and staff engineer (instead of a full revert): restore the 90s timeout, stop penalising expiries as heavily as declines, and add score decay. Still open: why those four answered slowly in the first place, and whether the running code matches the repo.

Module 3 session notes:
- `00-rook/data/callout-history.csv` does not exist. Rebuilt the responder-by-week table (159 rows) from `pings`. Headline number for the Director: missed pings 2.3% → 18.0%. Missed pings rose for all 16 responders on release day (2.0% → 29.4% that week). That points to the system change, not to seasonality.
- Verified: the data is clean (no nulls, duplicates or gaps). The gap before the next ping after a miss is 91–93s before 12 Aug and 61–63s after, so production really runs the 60s timeout. Still open: a "missed" ping doesn't prove the phone got the notification. Ask the EM for push delivery receipts and pre-4.2 time-to-accept.
- Tickets vs pings: both show the change starting 12 Aug. "Gone before I could answer" tickets came the same day, and "phone never goes off" tickets about 5 days later. Tickets undercount the worst-hit responders, and they fade faster than the misses do (misses are still about 5× normal).
- Farlight is the only Uptown responder. They took nearly every Uptown callout before 4.2. Three misses on 13–14 Aug, then zero pings from 31 Aug. Uptown is now covered by Cindermark, Falkirk and Bulwark. Estimated score went from about 1.0 to 0. Linda Pruitt's 12 ping tickets are all still open, and she wasn't interviewed. She's the next interview.
- Best missed chance to escalate: 14–18 Aug. The EM asked whether the ranking change was meant to hit responders who decline (14 Aug, unanswered while the staff engineer was away), Linda filed her first ticket (17 Aug), and support said they couldn't explain the "phone never goes off" complaints (18 Aug). The seasonal theory then stopped anyone looking further.
- Lesson: totals hide the story. The weekly total looks like a seasonal recovery, while the rows show four responders pushed out. Always ask for the split, the missing rows, and who gained.

Module 4 session notes:
- Read all of `00-rook/code/dispatch-routing/`. The flow: who's free (`availability.py`) → score of 60% travel time, 25% recent yeses, 15% skills (`routing.py`, `config.py`) → buzz the top person for 60s, then move down the list (`offer.py`). Creating the callout happens outside this folder. The push, poll and travel-time steps are empty placeholders here.
- The only score changes in the code are taking a job (+0.08) and anything else (−0.12, a miss and a no treated alike in `offer.py` and `history.py`). Nothing restores points over time. The miss=no rule looks older than 4.2: the glossary (4 Aug) already describes it, and the changelog and release page don't mention a change. Not proven, because there's no earlier version of the code.
- Implications: anyone taking under 60% of their buzzes slides down. Five misses take someone from 0.5 to 0, and it takes 7 jobs taken to climb back. At a score of 0 they need to be about 19 min closer than a perfect-score neighbour, and within about 26 min of the job, to be buzzed first. Farlight, Vesper, Meteor Mite and The Undertow took 0 jobs from 24 Aug to 6 Sep. Busier neighbours (Nightwell, The Gale, Falkirk) gained.
- A rival cause is still open: 4.2 also changed push notifications (the duplicate-buzz fix). Ask the EM for push delivery receipts and pre-4.2 time-to-accept for the four responders. Also ask the staff engineer whether miss=no was deliberate, whether production matches the repo (scores are kept only in memory in this copy), and whether a manual override adds points.
- Proposal: now, bring back 90s and reset the four responders to 0.5. Later, and separately, add recovery over time, a softer miss penalty (count a miss only if delivery is confirmed), an alert when a responder's buzzes drop, and written-down rules.
- Lesson: ask what the code doesn't do (recover, tell misses from noes, confirm delivery, notice someone going quiet). The harm lived in the gaps, not in the lines.

Module 5 session notes:
- Helen (Director of Product) asked for a one-pager plus something clickable showing what we'd build for the people affected, not a quiet timer change, and a proper answer to Wen's 2019 question in `history.py`. Marcus is the EM and Wen the staff engineer.
- Kip handles Meteor Mite (she/her) and The Gale in Eastgate, not Farlight. Linda Pruitt handles Farlight. Kip's 4 Sep interview: Mite thought she'd been forgotten, The Gale was exhausted, and Kip could only say "hang in there".
- Weekly pings from the week of 3 Aug to the week of 31 Aug: Farlight 12→10→3→1→0, Mite 11→10→4→2→1, The Gale 13→15→17→20→21. The query is in `05-super-speed/weekly-pings.sql`.
- Three "Helen" reviewers (Opus, Sonnet, Haiku) first rejected the brief for leading with the timer and putting off Wen's question. After one round to align, they agreed to 12 changes: lead with what we'd build, check push delivery first (receipts due 28 Oct), then the 90s stopgap, then a one-time reset to 0.5, and decide scoring by 6 Nov. Proposed scoring: a miss with confirmed delivery −0.04, an unconfirmed miss 0, a decline −0.12, and recovery of about +0.02 a day.
- Built `brief.md` (with the same text in `one-pager-farlight-kip.md`) and `prototype.html`: Kip's console with a "gone quiet" flag and a week-by-week Meteor Mite tab, and Farlight's phone with a missed-call notice and an "I'm available" button. The warning text, the alert threshold and the penalty numbers are proposals, not agreed.
- Still open: section 5 of the brief still says the prototype is "coming next". Data after 6 Sep is still missing. Linda and Farlight haven't been interviewed. Wen hasn't checked the scoring numbers.
