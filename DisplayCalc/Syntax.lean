import Std

namespace DisplayCalc

inductive Fml (Atom : Type u) where
  | var : Atom -> Fml Atom
  | bot : Fml Atom
  | neg : Fml Atom -> Fml Atom
  | conj : Fml Atom -> Fml Atom -> Fml Atom
  | disj : Fml Atom -> Fml Atom -> Fml Atom
  | box : Fml Atom -> Fml Atom
  | dia : Fml Atom -> Fml Atom
deriving DecidableEq, Repr

inductive Str (Atom : Type u) where
  | fml : Fml Atom -> Str Atom
  | unit : Str Atom
  | comma : Str Atom -> Str Atom -> Str Atom
  | star : Str Atom -> Str Atom
  | boxS : Str Atom -> Str Atom
  | diaS : Str Atom -> Str Atom
deriving DecidableEq, Repr

structure Seq (Atom : Type u) where
  left : Str Atom
  right : Str Atom
deriving DecidableEq, Repr

inductive Side where
  | left
  | right
deriving DecidableEq, Repr

abbrev Path := List Nat

end DisplayCalc
