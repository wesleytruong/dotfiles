#!/usr/bin/env python3
"""Dotfiles symlink manager. Links packages defined in targets.json."""

import argparse
import json
import shutil
import sys
from datetime import datetime
from pathlib import Path

DOTFILES_DIR = Path(__file__).resolve().parent
TARGETS_FILE = DOTFILES_DIR / "targets.json"
BACKUP_DIR = Path.home() / ".dotfiles-backup"

# Colors
GREEN = "\033[32m"
YELLOW = "\033[33m"
RED = "\033[31m"
BOLD = "\033[1m"
RESET = "\033[0m"


def load_targets():
    with open(TARGETS_FILE) as f:
        return json.load(f)


def resolve_source(package, entry):
    """Resolve the source path for a package entry."""
    pkg_dir = DOTFILES_DIR / package
    if "source" in entry:
        return pkg_dir / entry["source"]
    return pkg_dir


def resolve_target(entry):
    """Resolve the target path, expanding ~."""
    return Path(entry["target"]).expanduser()


def backup(target, dry_run=False):
    """Back up an existing file/directory to ~/.dotfiles-backup/<timestamp>/."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dest = BACKUP_DIR / timestamp / target.name
    if dry_run:
        print(f"  {RED}would back up{RESET} {target} -> {backup_dest}")
        return
    backup_dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.move(str(target), str(backup_dest))
    print(f"  {RED}backed up{RESET} {target} -> {backup_dest}")


def link(package, entry, dry_run=False):
    """Create a symlink for a single package."""
    source = resolve_source(package, entry)
    target = resolve_target(entry)

    if not source.exists():
        print(f"  {RED}error{RESET} {package}: source {source} does not exist")
        return False

    # Already correctly linked
    if target.is_symlink() and target.resolve() == source.resolve():
        print(f"  {GREEN}ok{RESET} {package}: {target} -> {source}")
        return True

    # Symlink pointing elsewhere
    if target.is_symlink():
        if dry_run:
            print(f"  {YELLOW}would relink{RESET} {package}: {target} -> {source}")
            return True
        target.unlink()
        print(f"  {YELLOW}relinked{RESET} {package}: {target} -> {source}")
    # Existing file or directory (not a symlink)
    elif target.exists():
        backup(target, dry_run)
        if dry_run:
            print(f"  {YELLOW}would link{RESET} {package}: {target} -> {source}")
            return True
    else:
        if dry_run:
            print(f"  {YELLOW}would link{RESET} {package}: {target} -> {source}")
            return True

    target.parent.mkdir(parents=True, exist_ok=True)
    target.symlink_to(source)
    print(f"  {YELLOW}linked{RESET} {package}: {target} -> {source}")
    return True


def unlink(package, entry, dry_run=False):
    """Remove a symlink for a single package, only if it points into the dotfiles repo."""
    source = resolve_source(package, entry)
    target = resolve_target(entry)

    if not target.is_symlink():
        print(f"  {GREEN}ok{RESET} {package}: no symlink at {target}")
        return True

    if target.resolve() != source.resolve():
        print(f"  {YELLOW}skipped{RESET} {package}: {target} points elsewhere")
        return True

    if dry_run:
        print(f"  {YELLOW}would unlink{RESET} {package}: {target}")
        return True

    target.unlink()
    print(f"  {YELLOW}unlinked{RESET} {package}: {target}")
    return True


def main():
    parser = argparse.ArgumentParser(
        description="Dotfiles symlink manager",
        usage="%(prog)s [--dry-run] [--uninstall] {--all | package [package ...]}",
    )
    parser.add_argument("packages", nargs="*", help="packages to install")
    parser.add_argument("--all", action="store_true", help="install all packages")
    parser.add_argument("--uninstall", action="store_true", help="remove symlinks")
    parser.add_argument("--dry-run", action="store_true", help="preview without changes")
    args = parser.parse_args()

    if not args.all and not args.packages:
        parser.print_help()
        sys.exit(1)

    targets = load_targets()

    if args.all:
        packages = list(targets.keys())
    else:
        packages = args.packages
        for pkg in packages:
            if pkg not in targets:
                print(f"{RED}error{RESET}: unknown package '{pkg}'")
                print(f"available: {', '.join(sorted(targets.keys()))}")
                sys.exit(1)

    action = unlink if args.uninstall else link
    label = "Uninstalling" if args.uninstall else "Installing"
    if args.dry_run:
        label = f"[dry run] {label}"

    print(f"{BOLD}{label} {len(packages)} package(s){RESET}")
    ok = True
    for pkg in packages:
        if not action(pkg, targets[pkg], dry_run=args.dry_run):
            ok = False

    if not ok:
        sys.exit(1)


if __name__ == "__main__":
    main()
