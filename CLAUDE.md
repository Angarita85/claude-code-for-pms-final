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
