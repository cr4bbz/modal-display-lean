# Mechanized Reduced Sequents for Modal Display Calculi

This repository starts a Lean-first, Isabelle-compatible formalization of reduced sequents for modal display calculi.

The current milestone is deliberately small:

- formula, structure, sequent, side, and path syntax;
- one-hole structural contexts and plugging;
- path-indexed substructure occurrences;
- multiplicity of substructures in a sequent;
- syntactic reducedness and an executable checker;
- the theorem `isReduced_correct`.

Build with:

```powershell
lake build
```

The project pins Lean via `lean-toolchain`.
