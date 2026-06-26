import DisplayCalc.Context

namespace DisplayCalc

structure Occurrence (Atom : Type u) where
  side : Side
  path : Path
  str : Str Atom
deriving DecidableEq, Repr

def Str.substructures : Str Atom -> List (Path × Str Atom)
  | .fml A => [([], .fml A)]
  | .unit => [([], .unit)]
  | .comma A B =>
      ([], .comma A B) ::
        ((A.substructures.map fun pX => (0 :: pX.1, pX.2)) ++
        (B.substructures.map fun pX => (1 :: pX.1, pX.2)))
  | .star A =>
      ([], .star A) ::
        (A.substructures.map fun pX => (0 :: pX.1, pX.2))
  | .boxS A =>
      ([], .boxS A) ::
        (A.substructures.map fun pX => (0 :: pX.1, pX.2))
  | .diaS A =>
      ([], .diaS A) ::
        (A.substructures.map fun pX => (0 :: pX.1, pX.2))

def Seq.substructures (S : Seq Atom) : List (Occurrence Atom) :=
  (S.left.substructures.map fun pX =>
    { side := .left, path := pX.1, str := pX.2 }) ++
  (S.right.substructures.map fun pX =>
    { side := .right, path := pX.1, str := pX.2 })

def Seq.substructureTerms (S : Seq Atom) : List (Str Atom) :=
  S.substructures.map Occurrence.str

end DisplayCalc
