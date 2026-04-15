from itertools import permutations

def hamming(a, b):
    return sum(x != y for x, y in zip(a, b))

def typo_aliases(cmd, max_diff=2):
    out = []
    for p in set(permutations(cmd)):
        s = ''.join(p)
        if hamming(s, cmd) <= max_diff and s != cmd:
            out.append(s)
    return sorted(out)

word = "commit"
aliases = typo_aliases(word, max_diff=2)
for alias in aliases:
    print(f"{alias} = {word}")
