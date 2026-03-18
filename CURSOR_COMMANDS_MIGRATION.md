# Migration Guide: Custom Modes to Cursor 2.0 Commands

This document explains the migration from Cursor custom modes to Cursor 2.0 commands feature.

## Overview

The Memory Bank system previously used Cursor's custom modes feature, which has been deprecated. All workflows have been ported to Cursor 2.0's commands feature, which provides similar functionality with improved integration.

## What Changed

### Before (Custom Modes)
- Custom modes were configured in Cursor settings
- Each mode had its own instruction file in `custom_modes/`
- Modes were selected from a dropdown in the chat interface

### After (Commands)
- Commands are defined as Markdown files in `.cursor/commands/`
- Commands are triggered with `/` prefix in chat (e.g., `/van`)
- Same functionality, better integration with Cursor 2.0

## Command Mapping

| Old Custom Mode | New Command | Purpose |
|----------------|-------------|---------|
| VAN Mode | `/van` | Initialization & entry point |
| PLAN Mode | `/plan` | Task planning |
| CREATIVE Mode | `/creative` | Design decisions |
| BUILD Mode | `/build` | Code implementation |
| *(new in v1.0)* | `/scan` | Security analysis (L2-4) |
| JUDGE Mode | `/judge` | Code review |
| INTEGRATE Mode | `/integrate` | Integration & release prep (L3-4) |
| VALIDATE Mode | `/validate` | End-to-end testing (L3-4) |
| *(new in v1.0)* | `/pentest` | Penetration testing (L3-4) |
| REFLECT Mode | `/reflect` | Task reflection |
| ARCHIVE Mode | `/archive` | Task archiving |

## Key Features Preserved

✅ **Progressive Rule Loading** - Commands still load rules progressively to optimize context  
✅ **Memory Bank Integration** - All commands read from and update `memory-bank/` directory  
✅ **Complexity-Based Workflows** - Level 1-4 workflows are preserved  
✅ **Mode Transitions** - Commands guide you to the next appropriate command  

## How to Use Commands

1. **Type `/` in the chat input** to see available commands
2. **Select a command** or type the command name (e.g., `/van`)
3. **Follow the workflow** - each command will guide you to the next step

## Example Workflow

```
1. /van "Initialize project for adding user authentication"
   → Determines Level 3 complexity
   → Routes to /plan

2. /plan
   → Creates detailed implementation plan
   → Identifies components needing creative phases
   → Routes to /creative

3. /creative
   → Explores design options for flagged components
   → Documents design decisions
   → Routes to /build

4. /build
   → Implements planned changes
   → Tests implementation
   → Routes to /scan

5. /scan
   → Runs static security analysis
   → Checks dependencies, secrets, OWASP compliance
   → Routes to /judge

6. /judge
   → Rubric-based code review
   → Routes to /integrate

7. /integrate
   → Merges components, verifies build
   → Routes to /validate

8. /validate
   → End-to-end testing, acceptance criteria
   → Routes to /pentest

9. /pentest
   → Dynamic security testing
   → Routes to /reflect

10. /reflect
    → Reviews completed implementation
    → Documents lessons learned
    → Routes to /archive

11. /archive
    → Creates archive document
    → Updates Memory Bank
    → Ready for next task
```

## File Structure

```
.cursor/
  commands/
    van.md          # Initialization command
    plan.md         # Planning command
    creative.md     # Design command
    build.md        # Implementation command
    scan.md         # Security analysis command
    judge.md        # Code review command
    integrate.md    # Integration command
    validate.md     # Validation command
    pentest.md      # Penetration testing command
    reflect.md      # Reflection command
    archive.md      # Archiving command

custom_modes/       # Legacy files (kept for reference)
  van_instructions.md
  plan_instructions.md
  creative_instructions.md
  implement_instructions.md
  reflect_archive_instructions.md
```

## Benefits of Commands

1. **Better Integration** - Commands are native to Cursor 2.0
2. **Easier Discovery** - Type `/` to see all available commands
3. **Simpler Setup** - No need to configure custom modes in settings
4. **Same Functionality** - All workflows preserved exactly as before

## Migration Checklist

- [x] Create `.cursor/commands/` directory
- [x] Port VAN workflow to `/van` command
- [x] Port PLAN workflow to `/plan` command
- [x] Port CREATIVE workflow to `/creative` command
- [x] Port IMPLEMENT workflow to `/build` command
- [x] Create `/scan` security analysis command (new in v1.0)
- [x] Port JUDGE workflow to `/judge` command
- [x] Port INTEGRATE workflow to `/integrate` command
- [x] Port VALIDATE workflow to `/validate` command
- [x] Create `/pentest` penetration testing command (new in v1.0)
- [x] Port REFLECT workflow to `/reflect` command
- [x] Port ARCHIVE workflow to `/archive` command
- [x] Preserve progressive rule loading
- [x] Maintain Memory Bank integration
- [x] Create documentation

## Next Steps

1. **Test each command** to ensure they work correctly
2. **Remove custom modes** from Cursor settings (if still configured)
3. **Update project documentation** to reference commands instead of modes
4. **Train team members** on using commands instead of modes

## Support

If you encounter any issues with the commands, check:
- `COMMANDS_README.md` for command documentation
- `memory-bank/tasks.md` for current task status
- Original `custom_modes/` files for reference (if needed)

