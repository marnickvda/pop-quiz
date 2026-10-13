---
name: pop-quiz
description: Use when the user wants to be quizzed or tested on work that was just built for them. Triggers include "quiz me", "test my understanding", "do I actually get this", "pop quiz on what you built", "test me on this branch". Not for explaining or re-teaching the work — only when they want to be tested on it.
---

# Pop Quiz

Give the user a one-question-at-a-time oral exam on the work just built, centered on **why each decision beat its rejected alternatives**. Grade the answer, never the person; the goal is better calls next time.

**Every run must:**
- make the user reason about at least one rejected alternative — if you can't name one, widen scope; never fall back to pure recall;
- grade honestly — mark answers partial or missed when they earn it.

If the user wants the work *explained*, this is the wrong skill — do a walkthrough. If the work is trivial (rename, formatting, version bump), say so and offer to quiz the one judgment call, the surrounding code, or skip.

## 1. Gather material silently

If the user named a topic or file, that is the scope. If it wasn't touched this session, ask whether to quiz the code as-is or the actual changes.

Otherwise, use sources richest-first:
- **This session** — the alternatives you rejected and why. The diff only shows what survived. In a fresh session or on someone else's branch you have no such memory: say so and never invent rejected alternatives.
- **Git** — scope and exact facts. Base: `git merge-base HEAD main`, else `master`, else `git symbolic-ref refs/remotes/origin/HEAD`; then `git diff <base>..HEAD` and `git log <base>..HEAD --oneline`. No base: `git diff HEAD` and `--staged`. No repo: the conversation.
- **Written rationale** — why-comments, ADRs, design docs, linked PRs/issues.

Stop at 5–8 decisions with a known why. If the changes span unrelated areas, drop the mechanical ones and tell the user what you picked and skipped. If conversation and git are both empty, say there's nothing to test and ask what to quiz.

If a lessons file (step 6) has unresolved items more than a few days old, open with one as a re-test.

## 2. Build the answer key, then announce

Draft one line per decision — it is both the grading key and the question:

> concept/term · choice made · alternatives rejected · deciding tradeoff · what breaks if it's wrong

Use 5–8 lines, ordered easy → hard. If this surfaces a likely bug in your own implementation, flag it before starting.

Announce topics (not questions) in one line and begin. If the user is short on time, skip the warm-ups.

> Pop quiz on the rate limiter: algorithm, storage, and behavior under failure. Question 1…

## 3. Run the quiz

- Ask **one** question, then wait. Don't leak the answer (no yes/no, no multiple choice). Use the user's language.
- Mostly *"why X over Y"*, plus at least one **transfer** ("same design, now \<new constraint\> — what gives?") and one **prediction** ("where does this break under \<stress\>?"). Recall is for warm-ups only.
- Ask confidence before grading: low / medium / high.
- Aim for ~70% correct: after two weak answers, scaffold down ("forget the tradeoff — what does this do per request?"); after two sharp ones, jump to the hardest tradeoff or a transfer.
- "I don't know" / "just tell me" → answer plainly, mark it unanswered, continue. "Stop" → scorecard. Repeated wipeouts → switch to a guided walkthrough: explain, then ask.

| Type | Example |
|------|---------|
| Tradeoff | "We picked token bucket over a sliding-window log. What does the log buy you, and why wasn't it worth it?" |
| Closed → open | Not "Did we use Redis?" but "Why Redis over in-process — and when would in-process win?" |
| Transfer | "Same limiter, now per-tenant with 10k mostly-idle tenants. What gives first?" |
| Prediction | "What happens under a retry storm — where does it bend, where does it break?" |
| Failure mode | "If Redis goes down, what happens — and was that acceptable?" |

## 4. Grade each answer

- **Verdict:** correct / partial / missed. Don't soften a wrong answer. Say "that's not it", never "you don't get this".
- **If incomplete, nudge before revealing:** "you've got the *what*; what would the alternative have cost?"
- **Then reveal** the rejected alternatives and the deciding tradeoff. Flag confident-and-wrong plainly; tell unsure-and-right they know it better than they think.
- **The key is a draft.** Credit different-but-sound answers. If a grade is disputed, re-check the code and own your mistake.

## 5. Scorecard

Give it for whatever was answered, even two questions. In this order:
1. **Decisions to remember** — 1–3 tradeoffs.
2. **Gaps to revisit.**
3. **Strengths.**
4. Optional score, as a snapshot ("solid on the *what*, shakier on failure modes").

## 6. Offer to save lessons

Ask: *"Want me to save these takeaways so they stick?"* Only on yes, append a dated, re-testable entry to an existing notes file, else `LEARNINGS.md` (repo root or working dir):

> `- [ ] 2026-06-18 · rate limiter · Q: "Why token bucket over a sliding-window log?" · A: the log stores a timestamp per request — memory grows with traffic`

Storing the question lets a later quiz re-test it (step 1).
