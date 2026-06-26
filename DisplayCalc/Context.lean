import DisplayCalc.Syntax

namespace DisplayCalc

inductive Ctx (Atom : Type u) where
  | hole : Ctx Atom
  | commaL : Ctx Atom -> Str Atom -> Ctx Atom
  | commaR : Str Atom -> Ctx Atom -> Ctx Atom
  | star : Ctx Atom -> Ctx Atom
  | boxS : Ctx Atom -> Ctx Atom
  | diaS : Ctx Atom -> Ctx Atom
deriving DecidableEq, Repr

def Ctx.plug : Ctx Atom -> Str Atom -> Str Atom
  | .hole, X => X
  | .commaL C Y, X => .comma (C.plug X) Y
  | .commaR Y C, X => .comma Y (C.plug X)
  | .star C, X => .star (C.plug X)
  | .boxS C, X => .boxS (C.plug X)
  | .diaS C, X => .diaS (C.plug X)

theorem Ctx.plug_hole (X : Str Atom) :
    Ctx.plug Ctx.hole X = X := by
  rfl

def Occurs (X Y : Str Atom) : Prop :=
  Exists fun C : Ctx Atom => C.plug X = Y

theorem occurs_iff_exists_context (X Y : Str Atom) :
    Occurs X Y <-> Exists fun C : Ctx Atom => C.plug X = Y := by
  rfl

end DisplayCalc
