-- This module encodes the admissible-class bridge for the Absolute/Convective Instability Stability Hydrodynamic Lemma.
import Mathlib.Analysis.Calculus.Deriv
import Mathlib.Data.Complex.Basic

noncomputable section

open Complex

namespace AbsoluteConvective

-- Admissible class of perturbations (canonical domain structure)
structure AdmissibleClass (X : Type) [NormedAddCommGroup X] [NormedSpace ℂ X] where
  carrier : Set X
  nonempty : carrier.Nonempty

-- Hydrodynamic state with velocity and pressure fields
structure HydroState (X : Type) [NormedAddCommGroup X] [NormedSpace ℂ X] where
  velocity : X → ℂ
  pressure : X → ℂ
  admissible : AdmissibleClass X

-- Dispersion relation from linear stability analysis
structure DispersionRelation where
  ω : ℂ → ℂ
  differentiability : ∀ k, DifferentiableAt ℂ ω k

-- Group velocity: derivative of ω with respect to wavenumber
def groupVelocity (D : DispersionRelation) (k : ℂ) : ℂ :=
  deriv D.ω k

-- Absolute instability: exists a mode with zero group velocity and positive growth rate
def absoluteInstability (D : DispersionRelation) : Prop :=
  ∃ k : ℂ, groupVelocity D k = 0 ∧ 0 < (D.ω k).im

-- Convective instability: unstable modes all have nonzero group velocity
def convectiveInstability (D : DispersionRelation) : Prop :=
  (∃ k : ℂ, 0 < (D.ω k).im) ∧ ∀ k, 0 < (D.ω k).im → groupVelocity D k ≠ 0

-- Stability: no growing modes
def stability (D : DispersionRelation) : Prop :=
  ∀ k, (D.ω k).im ≤ 0

-- Bridge lemma: absolute instability contradicts stability
theorem absolute_implies_not_stable (D : DispersionRelation) :
    absoluteInstability D → ¬ stability D :=
  by
    intro h_abs h_stab
    rcases h_abs with ⟨k, hvg, hhim⟩
    have h := h_stab k
    linarith

-- Bridge lemma: convective instability is not absolute instability
theorem convective_not_absolute (D : DispersionRelation) :
    convectiveInstability D → ¬ absoluteInstability D :=
  by
    intro h_conv h_abs
    rcases h_abs with ⟨k, hvg, hhim⟩
    rcases h_conv with ⟨_, h_ne_zero⟩
    exact h_ne_zero k hhim hvg

-- Hydrodynamic Lemma: in the admissible class, absolute instability destroys stability.
theorem hydrodynamic_lemma {X : Type} [NormedAddCommGroup X] [NormedSpace ℂ X]
    (H : HydroState X) (D : DispersionRelation)
    (h_abs : absoluteInstability D) :
    ¬ stability D :=
  absolute_implies_not_stable D h_abs

end AbsoluteConvective