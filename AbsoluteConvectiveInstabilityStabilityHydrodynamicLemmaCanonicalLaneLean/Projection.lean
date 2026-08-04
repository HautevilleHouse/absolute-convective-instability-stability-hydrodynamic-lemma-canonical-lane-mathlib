/-
All Rights Reserved - No License Granted

Copyright (c) 2026 HautevilleHouse. All rights reserved.

This repository is published for academic review, citation, priority, public
notice, and research-reference purposes only.

No license is granted to use, copy, reproduce, redistribute, modify, merge,
publish, distribute, sublicense, sell, fork, mirror, scrape, use for training or
fine-tuning, include in a dataset or benchmark, use to create, evaluate, or
benchmark a derivative system, incorporate into another system, or create
derivative works from this repository or any substantial portion of it without
prior written permission from the rights holder.

Viewing this repository on GitHub for academic review and citation is permitted
with all rights reserved by the rights holder.

Any discussion, review, comparison, implementation, derivative research use, or
public reference to this repository must cite the repository and preserve this
notice.

Unauthorized reproduction or redistribution of this repository, including public
GitHub forks containing the repository contents, constitutes copyright
infringement and may be subject to DMCA.
-/
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
  ext <;> simp [closeBridge]

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
  unfold SatisfiesBridge theoremProjection closeBridge
  intro hf
  simp [hf]

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse