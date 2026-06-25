---
name: pop-quiz
description: Use when the user wants to be quizzed, tested, or "overhoord" on work that was just built for them. Triggers include "quiz me", "overhoor me", "test my understanding", "give me an SO", "do I actually get this", "pop quiz on what you built", "test me on this branch". Not for explaining or re-teaching the work — only when they want to be tested on it.
---

# Pop Quiz (Onverwachtse SO)

## Overview

After an agent implements something, this skill flips the roles: **the agent springs an oral exam on the user** about the work just built — the concepts, the terms, and above all the design tradeoffs behind each decision. Named after the dreaded Dutch *onverwachtse schriftelijke overhoring* (SO). The user asked for it, so the surprise isn't *that* there's an exam — it's **which decisions get probed, and how deep the "why" goes**.

**Core principle:** You don't understand a decision until you can explain why the rejected alternatives are worse. Target the **why**, not the **what** — and grade the *answer*, never the person. The goal is sharper calls next time, not a humbling.

## When to use

The user asks to be quizzed/tested on work that was just built. **Not** when they want it *explained* — that's a walkthrough, not an exam. For trivial/mechanical work (renames, formatting, version bumps) there's little to learn; if the user insists anyway, don't refuse or pad a typo into a fake exam — say there's not much decision-content here and offer to quiz the one judgment call, the surrounding code, or skip it.

## Non-negotiables

Every run must (1) make the user **reason about at least one rejected alternative**, and (2) **grade honestly** — at least one "partial/missed" when an answer earns it. If you can't name a single alternative you rejected for this work, you're quizzing on too little: widen scope before asking — never fall back to pure recall.

## Workflow

### 1. Gather the material — silently, before you ask

**Honor an explicit focus first.** If the user named a topic or file ("quiz me on the caching layer"), *that* is the scope — even if other areas are richer. If it wasn't touched this session, say so and ask whether to quiz it from the code as-is or take the actual changes.

Otherwise gather richest-first:
- **A — This session (if you built it).** You remember not just what shipped but **what you rejected and why**; the diff only shows surviving code. Recall each decision, the options you compared, and anything you flagged as a tradeoff or risk. *Fresh session / someone else's branch?* You have no such memory — say so, skip A, and build from B/C. Don't fabricate "alternatives we rejected" you have no record of.
- **B — Git, for scope and exact facts** (*memory is for the why; the code is the truth for the what*). Find the base defensively: `git merge-base HEAD main`, else `master`, else `git symbolic-ref refs/remotes/origin/HEAD`; then `git diff <base>..HEAD` and `git log <base>..HEAD --oneline`. No base resolves? Use uncommitted work (`git diff HEAD`, `--staged`). No repo at all? Rely on the conversation.
- **C — Rationale already written down**: why-comments, ADRs, design docs, linked PRs/issues.

Stop once you have **5–8 decisions with a known why** — don't read the whole branch. Spanning several unrelated changes? Drop the mechanical ones and **tell the user which areas you picked and skipped**. If both the conversation and git are empty, don't invent a quiz — say there's nothing to test and ask them to point you at it.

**Warm-up from last time:** if a lessons file (step 6) holds unresolved items more than a few days old, open with one as a spaced re-test before the new material.

### 2. Build the answer key — then announce

Draft (silently) one line per decision:

> **concept/term · the choice made · the alternatives rejected · the deciding tradeoff · what breaks if it's wrong**

That line is your grading key *and* it writes the question. Aim for **5–8 (never fewer than 5)**, ordered easy → hard — a default order, not a script (step 3 adapts it). If building the key surfaces a likely bug in your *own* implementation, flag it before starting rather than quizzing around it.

Announce the SO in one line — **topics, not questions** — and start. If the user only has time for a couple, pick the highest-value tradeoff questions and skip the warm-ups.

> Example (Dutch session): "📝 Onverwachtse SO over de rate limiter — algoritme, opslag, en gedrag bij uitval. Pen klaar? Vraag 1…"

### 3. Run the quiz — one question at a time, adapt live

- Ask **ONE** question, then wait. Never reveal the answer in the question; no giveaway multiple-choice. Match the user's language.
- **Mix the question types:** mostly *"why X over Y"*, plus at least one **transfer** ("same design, but now \<new constraint\> — what gives, and what would you reach for?") and one **prediction** ("predict where this breaks under \<stress\> — then I'll show you"). Recall only warms up.
- **Read confidence** before grading: *"how sure — gut feeling, low / medium / high?"*
- **Adapt the difficulty** (the drafted order is a default; aim for ~70% right):
  - Two weak answers in a row → step **down**: scaffold ("forget the tradeoff — what does this do on each request?"), rebuild a win, then resume. An exam they're failing teaches nothing.
  - Two sharp answers in a row → skip the warm-ups; jump to the hardest tradeoff or a transfer question.
- **Stuck or done?** "I don't know" / "just tell me" → don't probe; answer plainly, mark it unanswered, move on. "Stop" → go straight to the scorecard for what's covered. A repeated wipeout (a beginner who didn't follow the build) → switch from exam to guided walk-through: explain, then ask.

### 4. Grade each answer — honest, never about the person

- **Verdict** — correct / partial / missed. Don't soften a wrong answer into "sort of right" — but grade the *answer* ("that's not it"), never the learner ("you don't get this"). A miss is a useful **find**, not a failing; keep the SO framing warm.
- **Make them generate first.** If the answer's incomplete, don't hand over the rest — nudge them to reach for it ("you've got the *what*; take a shot at the *why* — what would the alternative have cost?"). A reveal they struggled toward sticks; one they read doesn't.
- **Then reveal the why** — the rejected alternatives and the deciding tradeoff (the payload). If they were *sure* and wrong, say so plainly ("you were confident — and it's the other way round; that's the one to burn in"). If *unsure* and right, tell them they know it better than they think.
- **The key is a draft, not gospel.** Credit a different-but-sound answer. If they dispute a grade, re-check the actual code instead of defending the key — and own it if *you* (or your implementation) were wrong.
- **Probe to the edge, then stop.** Close? Nudge until *they* close it (a couple of turns is fine). Lost? Give it cleanly and move on.

### 5. Scorecard — lead with the plan, not the grade

Close with, in this order:
- **Decisions to remember** — 1–3 tradeoffs to carry into future calls.
- **Gaps to revisit** — what to study next.
- **Strengths** — what's solid.

A score is optional and goes **last** — a snapshot ("solid on the *what*, shakier on failure modes"), never a grade on them. Always give the scorecard for whatever was actually answered, even a 2-question run.

### 6. Offer to save the lessons — ask first

Don't write anything silently. Ask: *"Want me to save these takeaways so they stick? — Zal ik deze lessen bewaren?"* Only on **yes**, append a dated, **re-testable** entry to an existing notes file (or `LEARNINGS.md`, or the working dir if there's no repo):

> `- [ ] 2026-06-18 · rate limiter · Q: "Why token bucket over a sliding-window-log?" · A: the log stores a timestamp per request — memory grows with traffic`

Storing the *question* (not just the note) lets a later SO re-test it (step 1). On no, save nothing.

## Question Design

| Type | Weak (avoid) | Strong (use) |
|------|--------------|--------------|
| Recall | "What's a token bucket?" | Fine — but only as a warm-up |
| Closed | "Did we use Redis?" (yes/no leaks the answer) | "Why store bucket state in Redis instead of in-process — and when would in-process win?" |
| Tradeoff | — | "We picked token bucket over a sliding-window-log. What does the log buy you, and why wasn't it worth it?" |
| Transfer | — | "Same limiter, but now per-tenant with 10k mostly-idle tenants. Does Redis-per-bucket still hold? What gives first?" |
| Prediction | — | "Predict what happens under a retry storm — where does this bend, where does it break?" |
| Failure mode | — | "If Redis goes down, what happens — and was that an acceptable tradeoff?" |

## Red Flags — STOP if you catch yourself

- Listing several questions at once → ask **one**, then wait.
- Leaking the answer in the question (yes/no, handing over options), or revealing the why before they've attempted it → make them reach first.
- Building the quiz off the diff alone, or falling back to recall because "no alternatives came up" → mine the conversation; widen scope until you have a real tradeoff.
- Softening a wrong answer to be nice → honest verdict, warm frame; calibration is the point.
- Grading the *person* instead of the *answer*, or stacking blunt "missed it"s → a miss is a find; keep it safe or they disengage.
- Defending your answer key against a sound answer or a caught bug → the key is a draft; re-check and own it.
- Force-marching a stuck or out-of-time user → offer a hint, the answer, or the scorecard.
- Saving a lessons file unprompted, or quizzing in the wrong language → offer first; match the conversation.
