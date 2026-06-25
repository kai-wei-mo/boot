### KUSTOMIZE ALIASES #########################################################

kustomizediff() {
  local new_out="kustomize.out.new"
  local old_out="kustomize.out.old"
  local diff_out="kustomize.diff"
  local tmpdir git_root rel_dir old_ref ref old_dir kustomization_file

  if ! command -v kustomize >/dev/null 2>&1; then
    echo "kustomize is not on PATH" >&2
    return 1
  fi

  if ! kustomize build . > "$new_out"; then
    return 1
  fi

  : > "$old_out"

  if git_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
    rel_dir="$(realpath --relative-to="$git_root" "$PWD")"
    old_ref=""

    for ref in origin/main origin/master; do
      if ! git -C "$git_root" rev-parse --verify --quiet "${ref}^{commit}" >/dev/null; then
        continue
      fi

      for kustomization_file in kustomization.yaml kustomization.yml Kustomization; do
        if git -C "$git_root" cat-file -e "${ref}:${rel_dir}/${kustomization_file}" 2>/dev/null; then
          old_ref="$ref"
          break 2
        fi
      done
    done

    if [[ -n "$old_ref" ]]; then
      tmpdir="$(mktemp -d)"

      if git -C "$git_root" archive "$old_ref" "$rel_dir" | tar -x -C "$tmpdir"; then
        old_dir="$tmpdir/$rel_dir"
        (cd "$old_dir" && kustomize build .) > "$old_out"
      else
        echo "Could not read $old_ref:$rel_dir; leaving $old_out empty." >&2
      fi

      rm -rf "$tmpdir"
    else
      for ref in origin/main origin/master; do
        if git -C "$git_root" rev-parse --verify --quiet "${ref}^{commit}" >/dev/null; then
          echo "No kustomization found at $ref:$rel_dir." >&2
        fi
      done

      if ! git -C "$git_root" rev-parse --verify --quiet origin/main >/dev/null &&
         ! git -C "$git_root" rev-parse --verify --quiet origin/master >/dev/null; then
        echo "Neither origin/main nor origin/master is available." >&2
      fi

      echo "Leaving $old_out empty." >&2
    fi
  else
    echo "Not in a git repo; leaving $old_out empty." >&2
  fi

  diff -u "$old_out" "$new_out" > "$diff_out" || true
  echo "Wrote $old_out, $new_out, and $diff_out"
}

kustomizebeforeafter() {
  kustomizediff "$@"
}

kustomizebeforeandafter() {
  kustomizediff "$@"
}

kustomizebeforenafter() {
  kustomizediff "$@"
}
