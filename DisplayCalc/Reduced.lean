import DisplayCalc.Occurrence

namespace DisplayCalc

def countEq [DecidableEq α] (x : α) : List α -> Nat
  | [] => 0
  | y :: ys => (if y = x then 1 else 0) + countEq x ys

def multiplicity [DecidableEq Atom] (T : Str Atom) (S : Seq Atom) : Nat :=
  countEq T S.substructureTerms

def Repetitive [DecidableEq Atom] (T : Str Atom) (S : Seq Atom) : Prop :=
  2 <= multiplicity T S

def Reduced [DecidableEq Atom] (S : Seq Atom) : Prop :=
  forall T, T ∈ S.substructureTerms -> multiplicity T S < 2

def checkReducedList [DecidableEq Atom] (xs : List (Str Atom)) (S : Seq Atom) : Bool :=
  match xs with
  | [] => true
  | T :: Ts => decide (multiplicity T S < 2) && checkReducedList Ts S

def isReduced [DecidableEq Atom] (S : Seq Atom) : Bool :=
  checkReducedList S.substructureTerms S

theorem checkReducedList_correct [DecidableEq Atom]
    (xs : List (Str Atom)) (S : Seq Atom) :
    checkReducedList xs S = true <->
      forall T, T ∈ xs -> multiplicity T S < 2 := by
  induction xs with
  | nil =>
      simp [checkReducedList]
  | cons T Ts ih =>
      simp [checkReducedList, ih, Bool.and_eq_true]

theorem isReduced_correct [DecidableEq Atom] (S : Seq Atom) :
    isReduced S = true <-> Reduced S := by
  simp [isReduced, Reduced, checkReducedList_correct]

def EqStr (Atom : Type u) :=
  Str Atom -> Str Atom -> Prop

def ReducedRel (EqS : EqStr Atom) (S : Seq Atom) : Prop :=
  forall T, T ∈ S.substructureTerms ->
    forall U, U ∈ S.substructureTerms -> EqS T U -> T = U

end DisplayCalc
