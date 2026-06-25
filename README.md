# pop-quiz 📝

> Your agent wrote it. You skimmed the diff, mumbled *"yeah, looks good,"* and merged it under your name.
>
> 🔔 **Laptops dicht, pak een blaadje** — *onverwachtse SO.* Let's see if you understood a single line of it.

<p align="center">
  <a href="https://youtu.be/hFDZdXpgVP8?t=54">
    <img src="https://img.youtube.com/vi/hFDZdXpgVP8/hqdefault.jpg" alt="The Rundfunk Onverwachts sketch this skill is named after" width="480">
  </a>
</p>
<p align="center"><sub>▶︎ The <em>Rundfunk</em> "Onverwachts" sketch that inspired the name — opens at 0:54.</sub></p>

A portable **Agent Skill** named after the *onverwachtse schriftelijke overhoring* — the surprise test Dutch teachers spring to find out who actually did the reading. It flips the roles: after your agent implements something, it springs that exam on **you** — the concepts, the terms, and above all the **design tradeoffs** behind every choice. Not to humble you; to make sure you *own* the decisions and learn the tradeoffs for next time.

## How it works

Run it after your agent builds something. It:

1. **Scopes itself** to this session's work, a topic you name, or your current branch's diff.
2. **Asks one question at a time**, adapting to how you do — mostly *"why X over Y?"*, with transfer ("what if…") and "predict what breaks" twists.
3. **Grades the answer honestly** (never *you*), makes you reach for the reasoning, then reveals the rejected alternatives and the tradeoff that decided it.
4. **Ends with a scorecard**: what to remember, gaps to revisit, and your strengths.
5. **Offers to save** the takeaways (only if you say yes) as re-testable notes, so the lessons stick across sessions.

Runs in your chat language — Dutch for an *echte SO*, or anything else.

## Install

One `SKILL.md` in the [agentskills.io](https://agentskills.io) standard — three ways in:

**Any agent, one command** — Claude Code, Cursor, opencode, Codex, Copilot, Gemini & 60+ more, via the [vercel `skills`](https://github.com/vercel-labs/skills) CLI:

```bash
npx skills add marnickvda/pop-quiz
```

**Claude Code plugin** — also gives you the `/pop-quiz` command:

```
/plugin marketplace add marnickvda/pop-quiz
/plugin install pop-quiz
```

**Manual, no Node** — symlinks into `~/.agents/skills/` (every tool) + `~/.claude/skills/` (Claude Code):

```bash
git clone https://github.com/marnickvda/pop-quiz
./pop-quiz/install.sh        # --copy on Windows · --uninstall to remove
```

> Native skill support needs **Cursor ≥ 2.4** or **opencode ≥ 1.16**.

## Trigger it

- `/pop-quiz` — or scope it: `/pop-quiz the caching layer`
- Or just ask: *"quiz me on what you built"* · *"overhoor me"*

## Why bother

- You don't own a decision you can't defend against the alternative.
- Half the questions are *"why X over Y"* — where the real engineering judgment lives.
- Every session turns into a small, deliberate lesson.

## License

MIT — see [LICENSE](LICENSE).
