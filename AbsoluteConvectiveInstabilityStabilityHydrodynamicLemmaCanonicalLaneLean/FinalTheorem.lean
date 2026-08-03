import AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean.GateLemmas
import AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean.TheoremStatement

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

def ConstrainedTheoremClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_theorem_closure (A : AdmissibleClass) :
    ConstrainedTheoremClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

def HydrodynamicLemmaConstrainedClosure (A : AdmissibleClass) : Prop :=
  ConstrainedTheoremClosure A ∧ AbsoluteConvectiveLemmaClosed

theorem hydrodynamic_lemma_constrained_closure (A : AdmissibleClass) :
    HydrodynamicLemmaConstrainedClosure A := by
  exact And.intro (constrained_theorem_closure A) absolute_convective_lemma_closed_checked

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse