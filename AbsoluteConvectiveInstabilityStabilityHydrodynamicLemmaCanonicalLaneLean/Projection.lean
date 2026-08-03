import AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

open HautevilleHouse.CanonicalLaneMathlibCore

/-- Stability flags for a hydrodynamic mode: absolute and convective instability indicators. -/
structure StabilityFlags where
  absolute : Bool
  convective : Bool

/-- Closure operation enforcing the hydrodynamic lemma: absolute instability implies convective instability. -/
def closeBridge (f : StabilityFlags) : StabilityFlags :=
  { absolute := f.absolute,
    convective := f.absolute || f.convective }

/-- The closure operation is idempotent. -/
theorem closeBridge_idempotent (f : StabilityFlags) :
    closeBridge (closeBridge f) = closeBridge f := by
  simp [closeBridge, Bool.or_assoc]

/-- Canonical projection onto the closed stability flags. -/
def theoremProjection : Projection StabilityFlags := {
  toFun := closeBridge,
  idempotent := closeBridge_idempotent
}

/-- Idempotence of the canonical projection. -/
theorem theorem_projection_idempotent (f : StabilityFlags) :
    theoremProjection.toFun (theoremProjection.toFun f) = theoremProjection.toFun f := by
  exact theoremProjection.idempotent f

/-- A state satisfies the absolute-convective bridge if absolute instability forces convective instability. -/
def SatisfiesBridge (s : StabilityFlags) : Prop :=
  s.absolute = true → s.convective = true

/-- The projection always produces a state satisfying the bridge. -/
theorem projection_satisfies_bridge (f : StabilityFlags) :
    SatisfiesBridge (theoremProjection.toFun f) := by
  intro h
  unfold theoremProjection
  unfold SatisfiesBridge
  simp [closeBridge] at h ⊢
  simp [h]

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse