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

### 1. Determine the scope (what to quiz on)

Figure out what was actually implemented, in this order:
1. **Current session** — the work you built in this conversation. Prefer this.
2. **Current git branch** — if session context is thin, inspect the branch's own changes: `git diff <base>...HEAD`, `git log <base>..HEAD --oneline`, and the changed files. (`<base>` is usually `main`/`master` or the branch's fork point.)

Pick the few real **decisions** and **concepts** worth testing. If the scope is large or ambiguous, tell the user in one line what you'll quiz on and let them narrow it. Don't quiz on code you didn't write or touch (unless the user asks).

### 2. Build the question bank (internally — don't show it)

Extract two kinds of material from the scope:
- **Terms & concepts** (recall): the named techniques, data structures, libraries, protocols, and what they do — e.g. "token bucket", "idempotency key", "optimistic locking".
- **Decisions & tradeoffs** (reasoning): each design choice you made, the alternatives you rejected, and *why*. These are the high-value questions.

Aim for ~5–8 questions, **mostly reasoning**. Order them easy → hard.

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
- Quizzing on code from outside this session/branch → stay in scope.
- Quizzing in the wrong language → match the conversation.
- Revealing the reasoning before the user has attempted the answer → wait for their shot first.

## Common Mistakes

- **No scorecard.** The takeaways are where the learning compounds — never skip step 5.
- **Too hard, too fast.** Ramp difficulty; an unpassable exam teaches nothing.
- **All recall, no tradeoffs.** Knowing the term ≠ understanding the decision. Test the decision.
