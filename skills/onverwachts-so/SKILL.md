---
name: onverwachts-so
description: Use when the user wants to be quizzed, tested, or "overhoord" on code that was just implemented for them — to check they genuinely understand the concepts, terms, and design tradeoffs of the current session's work or the current git branch. Triggers include "quiz me", "overhoor me", "test my understanding", "do I actually get this", "pop quiz on what you built".
---

# Onverwachts SO (Surprise Pop Quiz)

## Overview

After an agent implements something, this skill flips the roles: **the agent springs a surprise oral exam on the user** about the work that was just built — the concepts, the terms, and above all the design tradeoffs behind each decision. Named after the dreaded Dutch high-school *onverwachtse schriftelijke overhoring* (SO): the surprise test the teacher gives to find out who actually did the reading.

**Core principle:** You don't understand a decision until you can explain why the rejected alternatives are worse. The quiz targets the **why**, not just the **what** — so the user learns the tradeoffs and makes better calls next time.

## When to Use

- The user asks to be quizzed / tested / "overhoord" on what was just built.
- After implementing a non-trivial feature, to cement understanding before moving on.
- The user wants to learn the tradeoffs behind the choices so future decisions improve.

**When NOT to use:**
- Trivial or mechanical changes (renames, formatting, version bumps) — nothing to learn.
- The user wants the work *explained*, not *tested* → just explain it; don't quiz.

## Workflow

### 1. Gather the material — silently, before you ask anything

The quiz is only as good as what you pull together first. Work these sources **richest-first**:

**A. This conversation — your richest source.** You built it, so you remember not just *what* shipped but *what you rejected and why*. The diff only shows the code that survived; the alternatives you weighed and the tradeoffs you accepted live only here. Recall, from this session:
- Each non-trivial decision and the options you compared.
- Libraries, algorithms, and patterns you chose — **and the ones you considered and dropped**.
- Anything you called a tradeoff, risk, assumption, or "we could also…".

**B. The git changes — for scope, for exact facts, and for work not in this session.** Use the branch to bound the quiz, to verify specifics (exact values, names, signatures — *memory is for the why, the code is the source of truth for the what*), and to reconstruct when the conversation is thin (fresh session, someone else's branch):
```bash
git merge-base HEAD main          # find <base> (try main/master)
git diff --stat <base>..HEAD      # what changed, and how much
git log  <base>..HEAD --oneline   # the story, in commit messages
git diff <base>..HEAD             # the actual change
```
Read the changed files where the diff alone doesn't explain the choice. Mine commit messages and any linked PR/issue for stated rationale.

**C. Rationale already written down.** `why`-comments, ADRs, design docs, TODOs — each is a decision record; turn it into a question.

If the change set is large, **don't cover all of it** — pick the 3–5 most decision-rich areas.

### 2. Turn it into an answer key — then announce the SO

Before asking anything, draft (silently) one line per decision you'll test:

> **concept/term · the choice made · the alternatives rejected · the tradeoff that decided it · what breaks if it's wrong**

That line *is* your grading key, and it writes the question for you — mostly *"why X over Y"*, not trivia. Aim for ~5–8, ordered easy → hard.

Then announce the SO in one line — name the **topics, not the questions** — and start:

> "📝 Onverwachtse SO over de rate limiter — algoritme, opslag, en gedrag bij uitval. Pen klaar? Vraag 1…"

### 3. Run the quiz — one question at a time

- Ask **ONE** question, then wait for the answer. Never reveal the answer inside the question, and don't offer multiple-choice options that give it away.
- Open with an easy warm-up, then ramp toward the tradeoff questions that separate "followed the tutorial" from "actually gets it".
- Conduct the quiz in the **user's language** (match the conversation).

### 4. Grade each answer honestly

After each answer:
- **Verdict** — correct / partially / missed it. Don't soften a wrong answer into "sort of right"; honest grading is the whole point.
- **Fill the gap** — state the correct, complete answer.
- **Reveal the why** — name the alternatives you rejected and the tradeoff that decided it. *This is the payload:* the user walks away with the decision framework, not just a fact.
- **Probe once** if the answer was shallow or surprisingly sharp — "…and when would that choice flip?"

Then move to the next question.

### 5. Final scorecard

Close the SO with:
- A **score / overall verdict**.
- **Strengths** — what they clearly understand.
- **Gaps** — concepts or tradeoffs to revisit.
- **Decisions to remember** — 1–3 tradeoffs worth carrying into future calls.

## Question Design

| Type | Weak (avoid) | Strong (use) |
|------|--------------|--------------|
| Recall | "What's a token bucket?" | Fine, but only as a warm-up |
| Closed | "Did we use Redis?" (yes/no leaks the answer) | "Why store bucket state in Redis instead of in-process memory — and when would in-process be the better call?" |
| Tradeoff | — | "We picked token bucket over a sliding-window-log. What does the log buy you, and why wasn't it worth it here?" |
| Failure mode | — | "What happens to the limiter if Redis goes down — and was that an acceptable tradeoff to make?" |

At least half the questions must be **"why X over Y"** tradeoff questions.

## Red Flags — STOP if you catch yourself

- Listing several questions at once → ask **one** at a time.
- Hinting the answer inside the question (yes/no phrasing, handing over options) → make the user produce it.
- Grading a wrong answer as "kind of right" to be nice → be honest; calibration is the point.
- Only asking "what is X" recall questions → at least half must be tradeoff questions.
- Building the quiz from the diff alone → the *why* and the rejected alternatives live in the conversation, not the code. Mine it first.
- Quizzing on code from outside this session/branch → stay in scope.
- Quizzing in the wrong language → match the conversation.
- Revealing the reasoning before the user has attempted the answer → wait for their shot first.

## Common Mistakes

- **No scorecard.** The takeaways are where the learning compounds — never skip step 5.
- **Too hard, too fast.** Ramp difficulty; an unpassable exam teaches nothing.
- **All recall, no tradeoffs.** Knowing the term ≠ understanding the decision. Test the decision.
