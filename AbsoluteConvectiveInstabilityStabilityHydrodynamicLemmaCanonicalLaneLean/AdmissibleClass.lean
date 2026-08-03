import AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean.MathlibObjects

/-!
# Admissible Class

An admissible class is a proof-carrying object together with an endpoint
satisfied or a remainder recorded witness.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

structure AdmissibleClass where
  object : AdmittedTheoremObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

def admittedClosure (A : AdmissibleClass) : Prop :=
  NativeBridgeClosed A.object ∧ (A.endpointSatisfied ∨ A.remainderRecorded)

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse