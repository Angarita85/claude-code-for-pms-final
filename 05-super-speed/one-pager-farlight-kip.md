# When a responder goes quiet

**For:** Helen · **From:** Dispatch PM · **Draft, 26 Oct 2026**

## 1. Executive overview

We want to build two things: a phone screen that tells responders like Farlight when they missed a call and how to get back, and a console warning that shows handlers like Kip when someone has gone quiet. Under that, we propose new scoring rules so nobody gets stuck at zero, and a small timer fix only after we check whether calls reached the phones.

*Our data ends on 6 September. Anything after that date, like "Farlight has had no calls for two months," is a guess until Marcus sends new numbers.*

## 2. Decisions we need from Helen

| Decision | Our suggestion |
|---|---|
| Agree the order: delivery check first, then the timer, then the reset | Yes. Marcus sends delivery receipts by **Wed 28 Oct**. If they're late, it comes back to you. |
| If calls *were* delivered: put the timer back to 90 seconds as a short-term fix? | Yes. It's easy to undo, and it isn't the real fix. |
| If calls were *not* delivered: leave the timer alone and fix delivery first? | Yes. A longer timer won't help a phone that never rings. |
| Reset the four quiet responders to 0.5 points, once, by hand, after the delivery check? | Yes. Without the new rules below, they could slide back down. |
| Set a date to decide the new scoring rules | **Fri 6 Nov 2026** |

## 3. Open items: decisions we need from other teams

Wen's 2019 question: should a missed call cost as much as a "no"? We say no. Wen checks our numbers; Wen doesn't have to write them.

| What happens | Today | We propose |
|---|---|---|
| Takes the call | +0.08 | +0.08 |
| Says no | −0.12 | −0.12 |
| Misses a call that reached the phone | −0.12 | −0.04 |
| Misses a call we can't confirm arrived | −0.12 | 0 |
| Gets no calls for a while | stays put forever | slowly moves back toward 0.5 (about +0.02 a day) |

| Decision | Team |
|---|---|
| Check the numbers above | Engineering (Wen) |
| When Kip's warning should appear | Engineering (Marcus) and Product |

## 4. The problem we're solving and why now

Responders who miss a few calls drop down the list, stop getting calls, and have no way back, and nobody tells them why. It matters now because Farlight and Meteor Mite have gone almost silent while The Gale is worn out, and handlers have nothing to tell them.

**Kip today:** Kip has two cards side by side on the console. Mite's card is quiet and Mite keeps texting to ask if something is broken. The Gale's card never stops. The screen doesn't say why, so all Kip can say is "hang in there."

**Farlight today:** Farlight's phone just stopped buzzing in late August. Nothing said a call was missed, that it counted against them, or what to do.

## 5. Ideal state and plan to get there

Nobody gets stuck at zero, responders know what happened to their calls, and handlers can spot someone going quiet and help in one tap.

**Kip after:** Mite's card shows a yellow flag: "4 calls this week, usually 11. 2 recent calls ran out." Kip taps it and sends Mite the next Eastgate call. The Gale's card shows they're getting Mite's share.

**Farlight after:** Farlight's phone says, "You missed a call at 9:14, and it went to someone else." If we can't confirm the call arrived, it says "a call may not have reached you" instead, and it doesn't count against Farlight. An "I'm available" button puts Farlight back in line.

| Step | What we do | Who notices |
|---|---|---|
| 1 | Check whether calls reached phones (by 28 Oct) | Nobody yet |
| 2 | Short-term fix: timer back to 90s, or fix delivery | Fewer missed calls |
| 3 | One-time reset of the four quiet responders | Farlight and Mite get calls again |
| 4 | New scoring rules (decide by 6 Nov) | Nobody gets stuck at zero |
| 5 | New phone screen and console warning | Farlight and Kip |

*A rough clickable version of both screens is coming next. It isn't attached yet.*

## 6. Supporting data

Calls per week (the date each week starts):

| | 3 Aug | 10 Aug | 17 Aug | 24 Aug | 31 Aug |
|---|---|---|---|---|---|
| Farlight | 12 | 10 | 3 | 1 | 0 |
| Meteor Mite | 11 | 10 | 4 | 2 | 1 |
| The Gale | 13 | 15 | 17 | 20 | 21 |

| How we'll know it worked | Today | Target |
|---|---|---|
| Farlight's calls per week | 0 | about 12 |
| Meteor Mite's calls per week | 1 | about 11 |
| Calls nobody answered in time | 18 out of 100 | about 2 out of 100 |

## 7. Open questions with owners

| Question | Owner |
|---|---|
| Did the calls reach the phones? (by 28 Oct) | Marcus (engineering manager) |
| What are the numbers since 6 September? | Marcus |
| Was counting a missed call like a "no" done on purpose? | Wen (staff engineer) |
| Can handlers already send a call to someone by hand? | Wen |
| What has Linda Pruitt, Farlight's handler, seen? She has 12 open complaints. | PM (next interview) |
| How does Farlight feel about this? | PM |

*Sources: Rook database, 29 Jun–6 Sep 2026 (query saved in `weekly-pings.sql`), and Kip's interview on 4 Sep. The scenes are our best picture, not quotes, except Kip's "hang in there."*
