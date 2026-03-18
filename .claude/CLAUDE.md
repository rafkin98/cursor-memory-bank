# Memory Bank System v1.0

This project uses the Memory Bank development pipeline — an 11-stage structured workflow with built-in security gates.

## Usage

Run `/orchestrate <task description>` to execute the full pipeline automatically.

The orchestrator spawns each stage as a subagent, parses verdicts, and routes failures back automatically:

```
VAN → PLAN → CREATIVE → BUILD → SCAN → JUDGE → INTEGRATE → VALIDATE → PENTEST → REFLECT → ARCHIVE
```

## Complexity Routing

- **Level 1** (bug fix): VAN → BUILD → REFLECT
- **Level 2** (enhancement): VAN → PLAN → BUILD → SCAN → JUDGE → REFLECT
- **Level 3** (feature): VAN → PLAN → CREATIVE → BUILD → SCAN → JUDGE → INTEGRATE → VALIDATE → PENTEST → REFLECT
- **Level 4** (system): Full pipeline + ARCHIVE

## Memory Bank

All pipeline outputs are stored in `memory-bank/`:

- `tasks.md` — source of truth for task tracking
- `activeContext.md` — current stage and focus
- `progress.md` — implementation status
- `projectbrief.md` — project context and complexity level
- `creative/` — design decision documents
- `security/` — scan and pentest reports
- `review/` — code review reports
- `integration/` — integration reports
- `validation/` — validation reports
- `reflection/` — retrospective documents
- `archive/` — completed task archives

## Failure Routing

- **SCAN FAIL** → back to BUILD (remediate vulnerabilities)
- **JUDGE FAIL** → back to BUILD (fix code quality)
- **INTEGRATE FAIL** → back to BUILD or JUDGE
- **VALIDATE FAIL** → back to BUILD, JUDGE, or INTEGRATE
- **PENTEST FAIL** → back to BUILD (code bug) or INTEGRATE (config issue)

After 3 failed loops on any stage, the orchestrator asks for guidance.
