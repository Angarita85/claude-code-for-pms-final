---
name: review-checklist
description: Reviews a product brief against four checks — it names who owns it, says how we'll know it worked, keeps the same scope from start to finish, and explains the problem before the fix. Use it when the student says "review this brief", "run the review checklist", "check my brief", "is this brief ready?", or points at a brief, one-pager or proposal file and asks whether it holds up. Read-only: it reports, it doesn't edit.
---

# Review checklist

The student is pointing you at a brief (usually a Markdown file such as `05-super-speed/brief.md`) and wants to know if it's ready to send. Start right away with one plain sentence such as "Reviewing brief.md against the four checks now."

## 1. Find the brief

- Use the file the student named or pasted.
- If they didn't name one, look for `brief*.md` or `one-pager*.md` in the module folder they're working in. If there's exactly one, use it and say which. If there are several or none, ask one short question: "Which brief should I review?"
- Read the whole file before judging anything. Don't edit it.

## 2. Run the four checks

For each check, give a verdict — **Pass**, **Partly** or **Fail** — and back it with the brief's own words: quote the line (short) and give the section or line number. If you can't point to text, it isn't there.

### Check 1 — Names who owns it

Pass when a named person (not just a role or "we") is accountable for the brief as a whole, and every decision, open question and next step has an owner and, where it matters, a date.

- **Partly:** owners are roles only ("Dispatch PM", "Engineering"), or some rows have an owner and others don't.
- **Fail:** no owner for the brief, or most actions have no owner.
- List each item with no owner or no date.

### Check 2 — Says how we'll know it worked

Pass when the brief names at least one measure, with today's value, a target, and when it will be checked. The measure should match the problem the brief describes (if the problem is people being pushed out, a total average alone isn't enough).

- **Partly:** a measure exists but is missing a baseline, a target, a check date, or doesn't match the stated problem.
- **Fail:** success is only described in words ("things improve", "handlers are happier").
- Note whether the baseline's source and date are given, and whether it's measured or someone's opinion.

### Check 3 — Keeps the same scope start to finish

Pass when the summary, the plan, the decisions asked for and the success measures all describe the same piece of work.

- Compare what the opening says we'll do with what the plan, decision tables and measures actually cover. Look for:
  - things promised up top that never appear in the plan, or that have no measure;
  - things in the plan or decisions that the opening never mentioned;
  - the same thing described differently in two places (a different number, date, owner or order of steps).
- **Partly:** one or two small drifts. **Fail:** the opening and the plan describe different projects.
- List each mismatch as "Section X says … / Section Y says …".

### Check 4 — Explains the problem before the fix

Pass when a reader meets who is hurt, how we know, and why now before they meet the proposed solution.

- Note the section where the problem is first explained and the section where the fix first appears. If the fix comes first, that's at best **Partly** — even a one-line problem statement at the top is enough to pass.
- **Fail** when the problem is never stated, or is stated only as the absence of the fix ("we don't have a warning screen").
- Check the problem is backed by evidence (data, a ticket, an interview) and say which.

## 3. Report

Keep it short and plain. Use this shape:

```
Review of <file> — <n> of 4 pass

| Check | Verdict | Why |
|---|---|---|
| Names who owns it | Pass / Partly / Fail | one line |
| Says how we'll know it worked | … | … |
| Same scope start to finish | … | … |
| Problem before the fix | … | … |
```

Then, for every check that isn't a Pass, a short section with:
- the evidence (quotes with section or line numbers);
- one concrete fix the student could make, in a sentence or two.

End with the single most important fix if they only have time for one.

## Rules

- Judge only the four checks. Don't rewrite the brief, comment on tone or style, or add other checks unless the student asks.
- Don't edit the file. If the student then asks you to make the fixes, that's a separate request — confirm which ones first.
- If the brief cites a fact you know is out of date or unchecked from earlier work in this course, you may mention it in one line at the end, labelled "Outside the checklist".
