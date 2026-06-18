# onverwachts-so 📝

> *De onverwachtse SO* — the dreaded Dutch high-school "surprise written test" (*onverwachtse schriftelijke overhoring*), now for your code.

A Claude Code skill that **flips the roles**. Normally the AI writes the code and you nod along. This skill makes the agent spring a **surprise pop quiz on you** about the work it just implemented — the concepts, the terms, and above all the **design tradeoffs** behind each decision.

The goal isn't to make you feel bad. It's to find out whether you *actually* understand what was built and **why the choice that was made is the best one** — so you learn the tradeoffs and make sharper decisions next time.

## How it works

After the agent implements a feature, run the quiz. It will:

1. **Figure out what was just built** — from the current session, or the current git branch's diff.
2. **Ask one question at a time**, ramping from an easy warm-up to the tradeoff questions that separate "followed the tutorial" from "actually gets it."
3. **Grade your answer honestly**, then reveal the alternatives it rejected and *why* — the actual decision framework.
4. **Finish with a scorecard**: your strengths, the gaps to revisit, and the tradeoffs worth remembering.

It runs the quiz in whatever language you're chatting in (Dutch for an *echte SO*, English, or anything else).

## Installation

In Claude Code, add this repo as a marketplace and install the plugin:

```
/plugin marketplace add <your-github-username>/onverwachts-so
/plugin install onverwachts-so
```

Then restart Claude Code.

> Replace `<your-github-username>` with the GitHub account this repo lives under. You can also point at the full URL: `/plugin marketplace add https://github.com/<your-github-username>/onverwachts-so`.

## Usage

Three ways to trigger it after the agent has built something:

- **Slash command:** `/onverwachts-so`
- **Scoped:** `/onverwachts-so the caching layer` (focus the quiz on a topic, file, or concept)
- **Just ask:** "Quiz me on what you just built", "Overhoor me", "Test my understanding of this"

## Why use it

- **Catch shallow understanding** before it ships. If you can't explain why the alternative is worse, you don't yet own the decision.
- **Learn tradeoffs, not trivia.** At least half the questions are "why X over Y," which is where real engineering judgment lives.
- **Build better instincts.** The scorecard turns each session into a small, deliberate lesson.

## What's inside

```
onverwachts-so/
├── .claude-plugin/
│   └── marketplace.json              # makes the repo installable
├── plugins/
│   └── onverwachts-so/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── skills/
│       │   └── onverwachts-so/
│       │       └── SKILL.md          # the quiz logic
│       └── commands/
│           └── onverwachts-so.md     # the /onverwachts-so command
└── README.md
```

## License

MIT — see [LICENSE](LICENSE).
