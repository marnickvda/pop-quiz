# pop-quiz

An Agent Skill that quizzes **you** on what your agent just built — mostly *"why X over Y?"* — because you don't own a decision you can't defend against the alternative.

## How it works

1. **Scopes** to this session's work, a topic you name, or your branch's diff.
2. **Asks one question at a time**, adapting difficulty — tradeoffs, plus "what if…" and "predict what breaks".
3. **Grades the answer honestly** (never you), then reveals the rejected alternatives and the deciding tradeoff.
4. **Ends with a scorecard**: tradeoffs to remember, gaps, strengths.
5. **Offers to save** takeaways as re-testable notes — only if you say yes.

Runs in your chat language.

## Install

One `SKILL.md` in the [agentskills.io](https://agentskills.io) standard.

**Any agent** — Claude Code, Cursor, opencode, Codex, Copilot, Gemini & 60+ more, via the [vercel `skills`](https://github.com/vercel-labs/skills) CLI:

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
- Or just ask: *"quiz me on what you built"*

## License

MIT — see [LICENSE](LICENSE).
