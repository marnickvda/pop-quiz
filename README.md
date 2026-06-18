# onverwachts-so 📝

> *De onverwachtse SO* — the dreaded Dutch high-school "surprise written test" (*onverwachtse schriftelijke overhoring*), now for your code.

A portable **Agent Skill** that flips the roles. Normally the AI writes the code and you nod along. This skill makes the agent spring a **surprise pop quiz on you** about the work it just implemented — the concepts, the terms, and above all the **design tradeoffs** behind each decision.

The goal isn't to make you feel bad. It's to find out whether you *actually* understand what was built and **why the chosen approach is the best one** — so you learn the tradeoffs and make sharper decisions next time.

## How it works

After the agent implements a feature, trigger the quiz. It will:

1. **Figure out what was just built** — from the current session, or the current git branch's diff.
2. **Ask one question at a time**, ramping from an easy warm-up to the tradeoff questions that separate "followed the tutorial" from "actually gets it."
3. **Grade your answer honestly**, then reveal the alternatives it rejected and *why* — the actual decision framework.
4. **Finish with a scorecard**: your strengths, the gaps to revisit, and the tradeoffs worth remembering.

It runs in whatever language you're chatting in (Dutch for an *echte SO*, English, or anything else).

## Install

The skill is a single, standards-compliant [`SKILL.md`](skills/onverwachts-so/SKILL.md) (the [agentskills.io](https://agentskills.io) Agent Skills format), so it works across tools. Pick the install path that fits you:

### Option A — Any agent, one command (recommended)

Uses the [`vercel-labs/skills`](https://github.com/vercel-labs/skills) CLI, which installs the skill into **every AI coding agent you have installed** (Claude Code, Cursor, opencode, Codex, GitHub Copilot, Gemini CLI, Windsurf, Cline, Zed, and 60+ more). It auto-detects your agents, writes one canonical copy to `~/.agents/skills/`, and symlinks each agent to it:

```bash
npx skills add <your-github-username>/onverwachts-so          # install into all detected agents
npx skills add <your-github-username>/onverwachts-so -a cursor -a claude-code   # pick specific agents
npx skills use <your-github-username>/onverwachts-so | claude  # one-off, no install
```

### Option B — Claude Code plugin

For the native Claude Code experience (`/onverwachts-so` command + auto-trigger):

```
/plugin marketplace add <your-github-username>/onverwachts-so
/plugin install onverwachts-so
```

Then restart Claude Code.

### Option C — Manual, zero dependencies

No Node required. Clone the repo and run the bundled installer — it symlinks the skill into `~/.agents/skills/` (covers Cursor, opencode, Codex, Gemini CLI, Copilot CLI) and `~/.claude/skills/` (Claude Code):

```bash
git clone https://github.com/<your-github-username>/onverwachts-so
cd onverwachts-so
./install.sh                 # or: ./install.sh --copy   (Windows / no-symlink)
./install.sh --uninstall     # to remove
```

Or just copy `skills/onverwachts-so/` into any agent's skills directory yourself (see the table below).

## Where it lands & how to invoke it per tool

| Tool | Reads from | Invoke |
|------|-----------|--------|
| **Claude Code** | plugin, or `~/.claude/skills/` | auto on "quiz me…", or `/onverwachts-so` |
| **Cursor** (≥ 2.4) | `~/.agents/skills/` or `~/.cursor/skills/` | auto, or `/onverwachts-so` in Agent chat |
| **opencode** (≥ 1.16) | `~/.agents/skills/` or `~/.config/opencode/skills/` | the `skill` tool / auto |
| **Codex CLI** | `~/.agents/skills/` | auto on relevant request |
| **Gemini CLI** | `~/.agents/skills/` or `~/.gemini/skills/` | auto |
| **GitHub Copilot CLI** | `~/.agents/skills/` or `~/.claude/skills/` | auto (`/skills reload` to refresh) |

All of these read the **`~/.agents/skills/`** cross-runtime convention except Claude Code, which uses `~/.claude/skills/`. The two locations together cover every tool above — which is exactly what `install.sh` and the `skills` CLI set up.

## Usage

After the agent has built something, trigger it any of these ways:

- **Slash command** (Claude Code / Cursor): `/onverwachts-so`
- **Scoped:** `/onverwachts-so the caching layer` (focus on a topic, file, or concept)
- **Just ask:** "Quiz me on what you just built", "Overhoor me", "Test my understanding of this"

## Why use it

- **Catch shallow understanding** before it ships. If you can't explain why the alternative is worse, you don't yet own the decision.
- **Learn tradeoffs, not trivia.** At least half the questions are "why X over Y," which is where real engineering judgment lives.
- **Build better instincts.** The scorecard turns each session into a small, deliberate lesson.

## Repo layout

```
onverwachts-so/
├── skills/onverwachts-so/SKILL.md   # the portable skill — single source of truth
├── commands/onverwachts-so.md       # /onverwachts-so command (Claude Code plugin)
├── .claude-plugin/
│   ├── plugin.json                  # Claude Code plugin manifest
│   └── marketplace.json             # makes the repo /plugin-installable
├── install.sh                       # zero-dependency cross-tool installer
└── README.md · LICENSE
```

The same `skills/onverwachts-so/SKILL.md` is what the plugin loads, what `install.sh` links, and what `npx skills add` distributes — there is only ever one copy to maintain.

## License

MIT — see [LICENSE](LICENSE).
