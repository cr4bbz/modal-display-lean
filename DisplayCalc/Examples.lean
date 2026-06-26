import DisplayCalc.Reduced

namespace DisplayCalc

def ex1 : Seq Nat :=
  { left := .comma (.fml (.var 0)) (.boxS (.fml (.var 1))),
    right := .diaS (.fml (.var 0)) }

def exNoRepeat : Seq Nat :=
  { left := .comma (.fml (.var 0)) (.boxS (.fml (.var 1))),
    right := .diaS (.fml (.var 2)) }

#eval ex1.substructureTerms
#eval isReduced ex1
#eval isReduced exNoRepeat

example : isReduced ex1 = false := by
  native_decide

example : isReduced exNoRepeat = true := by
  native_decide

end DisplayCalc
