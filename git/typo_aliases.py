#!/usr/bin/env python3
"""
typo_aliases.py

Generate "reasonable" typos for a given string, suitable for aliasing.

Definition (default):
- 1-edit typos via:
  - adjacent transposition (swap i and i+1)
  - single deletion
  - single insertion (duplicate char OR insert keyboard-neighbor char)
  - single substitution (replace with keyboard-neighbor char)

Optional:
- max_edits=2, but ONLY when the two edits occur within a small locality window.

Notes:
- By default uses a QWERTY neighbor map (approx). You can disable keyboard-based
  edits or adjust the neighbor map for your environment.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable, Iterator, List, Optional, Sequence, Set, Tuple, Dict


# --- QWERTY adjacency (approx) -------------------------------------------------
# We build neighbors by placing keys on a grid and connecting nearby positions.
# This isn't perfect (keyboard staggering), but it's a good practical approximation.

_QWERTY_ROWS = [
    "qwertyuiop",
    "asdfghjkl",
    "zxcvbnm",
]

# Column offsets per row to emulate stagger (roughly).
# These are not exact; they just help approximate adjacency.
_ROW_OFFSETS = [0.0, 0.5, 1.0]


def build_qwerty_neighbors() -> Dict[str, Set[str]]:
    pos: Dict[str, Tuple[float, int]] = {}
    for r, row in enumerate(_QWERTY_ROWS):
        off = _ROW_OFFSETS[r]
        for c, ch in enumerate(row):
            pos[ch] = (c + off, r)

    neighbors: Dict[str, Set[str]] = {ch: set() for row in _QWERTY_ROWS for ch in row}

    # consider neighbors within Chebyshev distance 1 in this pseudo-grid
    for a, (ax, ay) in pos.items():
        for b, (bx, by) in pos.items():
            if a == b:
                continue
            if max(abs(ax - bx), abs(ay - by)) <= 1.01:  # small slack for float offsets
                neighbors[a].add(b)

    # Add self-row immediate neighbors too (already captured, but keep explicit)
    for row in _QWERTY_ROWS:
        for i, ch in enumerate(row):
            if i > 0:
                neighbors[ch].add(row[i - 1])
            if i + 1 < len(row):
                neighbors[ch].add(row[i + 1])

    return neighbors


QWERTY_NEIGHBORS = build_qwerty_neighbors()


# --- typo generation -----------------------------------------------------------

@dataclass(frozen=True)
class TypoConfig:
    max_edits: int = 1
    # If max_edits=2, require the second edit to be within this many positions of the first edit.
    locality_window: int = 2

    allow_transpose: bool = True
    allow_delete: bool = True
    allow_insert_duplicate: bool = True
    allow_insert_neighbor: bool = True
    allow_substitute_neighbor: bool = True

    keyboard_neighbors: Optional[Dict[str, Set[str]]] = None  # if None, uses QWERTY_NEIGHBORS

    # Output controls
    max_outputs: Optional[int] = None  # cap total outputs (after de-dupe) if desired


def _neighbors(cfg: TypoConfig, ch: str) -> Set[str]:
    nmap = cfg.keyboard_neighbors if cfg.keyboard_neighbors is not None else QWERTY_NEIGHBORS
    return nmap.get(ch.lower(), set())


def _one_edit_variants(s: str, cfg: TypoConfig) -> Iterator[Tuple[str, Optional[int]]]:
    """
    Yield (variant, edit_pos) where edit_pos is the index primarily affected,
    used to enforce locality when combining edits.
    """
    n = len(s)

    # adjacent transposition
    if cfg.allow_transpose:
        for i in range(n - 1):
            if s[i] == s[i + 1]:
                # swapping identical chars produces no change; skip
                continue
            yield (s[:i] + s[i + 1] + s[i] + s[i + 2 :], i)

    # deletion
    if cfg.allow_delete:
        for i in range(n):
            yield (s[:i] + s[i + 1 :], i)

    # insertion (duplicate)
    if cfg.allow_insert_duplicate:
        for i in range(n + 1):
            # Insert a duplicate of a nearby character. Reasonable choices:
            # - duplicate previous char (if exists)
            # - duplicate next char (if exists)
            if i > 0:
                yield (s[:i] + s[i - 1] + s[i:], i - 1)
            if i < n:
                yield (s[:i] + s[i] + s[i:], i)

    # insertion (keyboard neighbor)
    if cfg.allow_insert_neighbor:
        for i in range(n + 1):
            # Choose a reference char near insertion point (prev or next).
            refs: List[Tuple[str, int]] = []
            if i > 0:
                refs.append((s[i - 1], i - 1))
            if i < n:
                refs.append((s[i], i))
            for ref_ch, ref_pos in refs:
                for nb in _neighbors(cfg, ref_ch):
                    # preserve original case roughly
                    ins = nb.upper() if ref_ch.isupper() else nb
                    yield (s[:i] + ins + s[i:], ref_pos)

    # substitution (keyboard neighbor)
    if cfg.allow_substitute_neighbor:
        for i in range(n):
            ch = s[i]
            for nb in _neighbors(cfg, ch):
                sub = nb.upper() if ch.isupper() else nb
                if sub == ch:
                    continue
                yield (s[:i] + sub + s[i + 1 :], i)


def generate_typos(s: str, cfg: TypoConfig = TypoConfig()) -> List[str]:
    """
    Generate de-duplicated typos according to cfg.
    """
    if cfg.max_edits < 1:
        return []

    seen: Set[str] = set()
    out: List[str] = []

    def add(v: str):
        if v == s:
            return
        if v in seen:
            return
        seen.add(v)
        out.append(v)

    # 1-edit variants
    one_edits: List[Tuple[str, Optional[int]]] = []
    for v, pos in _one_edit_variants(s, cfg):
        add(v)
        one_edits.append((v, pos))
        if cfg.max_outputs is not None and len(out) >= cfg.max_outputs:
            return out

    # 2-edit variants with locality constraint
    if cfg.max_edits >= 2:
        for v1, p1 in one_edits:
            for v2, p2 in _one_edit_variants(v1, cfg):
                # enforce locality: p2 must be near p1 (if both known)
                if p1 is not None and p2 is not None:
                    if abs(p2 - p1) > cfg.locality_window:
                        continue
                add(v2)
                if cfg.max_outputs is not None and len(out) >= cfg.max_outputs:
                    return out

    return out


# --- CLI ----------------------------------------------------------------------

def main() -> None:
    import argparse
    import sys

    parser = argparse.ArgumentParser(description="Generate reasonable typos for aliasing.")
    parser.add_argument("text", help="Input string, e.g. checkout")
    parser.add_argument("--max-edits", type=int, default=1, choices=[1, 2], help="1 or 2 edits")
    parser.add_argument("--locality-window", type=int, default=2, help="Max positional distance between 2 edits")
    parser.add_argument("--no-keyboard", action="store_true", help="Disable keyboard-neighbor insert/substitute")
    parser.add_argument("--max-outputs", type=int, default=None, help="Cap outputs (after de-dupe)")
    args = parser.parse_args()

    cfg = TypoConfig(
        max_edits=args.max_edits,
        locality_window=args.locality_window,
        allow_insert_neighbor=not args.no_keyboard,
        allow_substitute_neighbor=not args.no_keyboard,
        keyboard_neighbors=None,  # uses default QWERTY
        max_outputs=args.max_outputs,
    )

    typos = generate_typos(args.text, cfg)
    for t in typos:
        print(t)

    return None


if __name__ == "__main__":
    main()
