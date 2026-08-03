import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic

/-!
# Absolute Convective Instability Stability Hydrodynamic Lemma: Analytic Objects

This module supplies the local analytic vocabulary for the
AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
theorem package: spatial domains, time, fields, hydrodynamic states, linear
stability problems, dispersion relations, and the stability classification
lemma.
-/

namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure HydrodynamicState where
  velocity : VectorField
  pressure : ScalarField
  density : ScalarField

def zeroHydrodynamicState : HydrodynamicState := {
  velocity := zeroVectorField,
  pressure := zeroScalarField,
  density := zeroScalarField
}

abbrev Perturbation := ScalarField
def zeroPerturbation : Perturbation := zeroScalarField

structure LinearStabilityProblem where
  baseFlow : HydrodynamicState
  dispersion : ℂ → ℂ → Prop
  groupVelocity : ℂ → ℂ → ℂ

def HasPositiveGrowth (p : LinearStabilityProblem) (k ω : ℂ) : Prop :=
  p.dispersion k ω ∧ 0 < ω.im

def IsStable (p : LinearStabilityProblem) : Prop :=
  ∀ k ω, p.dispersion k ω → ω.im ≤ 0

def HasAbsoluteInstability (p : LinearStabilityProblem) : Prop :=
  ∃ k ω, p.dispersion k ω ∧ 0 < ω.im ∧ p.groupVelocity k ω = 0

def HasConvectiveInstability (p : LinearStabilityProblem) : Prop :=
  ∃ k ω, p.dispersion k ω ∧ 0 < ω.im ∧ p.groupVelocity k ω ≠ 0

def StabilityClassified (p : LinearStabilityProblem) : Prop :=
  IsStable p ∨ HasAbsoluteInstability p ∨ HasConvectiveInstability p

theorem hydrodynamic_stability_lemma (p : LinearStabilityProblem) :
    StabilityClassified p := by
  unfold StabilityClassified
  classical
  by_cases hstable : IsStable p
  · exact Or.inl hstable
  · right
    simp only [IsStable] at hstable
    push_neg at hstable
    rcases hstable with ⟨k, ω, hdisp, hlt⟩
    have hpos : 0 < ω.im := lt_of_not_ge hlt
    by_cases hvel : p.groupVelocity k ω = 0
    · left
      exact ⟨k, ω, hdisp, hpos, hvel⟩
    · right
      exact ⟨k, ω, hdisp, hpos, hvel⟩

def primitiveLinearStabilityProblem : LinearStabilityProblem := {
  baseFlow := zeroHydrodynamicState,
  dispersion := fun _ _ => False,
  groupVelocity := fun _ _ => 0
}

theorem primitive_stable : IsStable primitiveLinearStabilityProblem := by
  intro k ω h
  exact False.elim h

theorem primitive_not_absolute : ¬ HasAbsoluteInstability primitiveLinearStabilityProblem := by
  intro h
  rcases h with ⟨k, ω, hdisp, hpos, hvel⟩
  exact False.elim hdisp

theorem primitive_not_convective : ¬ HasConvectiveInstability primitiveLinearStabilityProblem := by
  intro h
  rcases h with ⟨k, ω, hdisp, hpos, hvel⟩
  exact False.elim hdisp

theorem primitive_classified : StabilityClassified primitiveLinearStabilityProblem :=
  Or.inl primitive_stable

structure HydrodynamicLemma where
  problem : LinearStabilityProblem
  classification : StabilityClassified problem

def primitiveHydrodynamicLemma : HydrodynamicLemma := {
  problem := primitiveLinearStabilityProblem,
  classification := primitive_classified
}

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean