/-!
# Source-derived formalization layer for `absolute-convective-instability-stability-hydrodynamic-lemma-canonical-lane`
This module encodes the admissible-class bridge for the key theorems and structures
in the absolute and convective instability classification of hydrodynamic systems.
It provides formula models, saddle-point conditions, and bridge certificates for
the canonical Lane representation.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

inductive FormulaExpr where
  | var (name : String)
  | num (value : String)
  | add (lhs rhs : FormulaExpr)
  | sub (lhs rhs : FormulaExpr)
  | mul (lhs rhs : FormulaExpr)
  | div (lhs rhs : FormulaExpr)
  | neg (arg : FormulaExpr)
  | abs (arg : FormulaExpr)
  | min (lhs rhs : FormulaExpr)
  | max (lhs rhs : FormulaExpr)
  | raw (formula : String)
deriving Repr, DecidableEq

structure FormulaComponent where
  key : String
  value : String
deriving Repr, DecidableEq

structure SourceFormulaModel where
  group : String
  key : String
  status : String
  formula : String
  expr : FormulaExpr
  parseStatus : String
  sourceSection : String
  notes : String
  validation : String
  componentKeys : List String
  components : List FormulaComponent
deriving Repr, DecidableEq

structure FormalizationCertificate where
  sourceRepo : String
  sourceCheckoutHead : String
  packageLayerTranslated : Bool
  sourceHashesRecorded : Bool
  formulaLayerModeled : Bool
  guardLayerModeled : Bool
  theoremBoundaryOpen : Bool
  sourceConjectureClosureClaimed : Bool
  leanBuildChecked : Bool
deriving Repr, DecidableEq

inductive InstabilityCharacterization where
  | stable
  | absolutelyUnstable
  | convectivelyUnstable
deriving Repr, DecidableEq

structure SaddlePointCondition where
  wavenumber : String
  frequency : String
  groupVelocityZero : Bool
  temporalGrowthPositive : Bool
  pinchPoint : Bool
  characterization : InstabilityCharacterization
deriving Repr, DecidableEq

structure AdmissibleBridge where
  key : String
  sourceSection : String
  condition : String
  conclusion : String
  admissible : Bool
deriving Repr, DecidableEq

def sourceFormulaModels : List SourceFormulaModel :=
  [ { group := "classification", key := "absolute_saddle", status := "theorem_condition",
      formula := "dω/dk = 0 ∧ ω_i > 0",
      expr := (FormulaExpr.raw "dω/dk = 0 ∧ ω_i > 0"),
      parseStatus := "parsed_source_condition",
      sourceSection := "AbsoluteConvectiveLemma.lean Theorem 3",
      notes := "Saddle point criterion for absolute instability.",
      validation := "required_zero_group_velocity",
      componentKeys := ["dω_dk", "ω_i"],
      components := [ { key := "dω_dk", value := "group_velocity" },
                      { key := "ω_i", value := "temporal_growth" } ] },
    { group := "classification", key := "convective_saddle", status := "theorem_condition",
      formula := "dω/dk ≠ 0 ∧ ω_i > 0",
      expr := (FormulaExpr.raw "dω/dk ≠ 0 ∧ ω_i > 0"),
      parseStatus := "parsed_source_condition",
      sourceSection := "AbsoluteConvectiveLemma.lean Theorem 4",
      notes := "Nonzero group velocity with growth marks convective instability.",
      validation := "required_nonzero_group_velocity",
      componentKeys := ["dω_dk", "ω_i"],
      components := [ { key := "dω_dk", value := "group_velocity" },
                      { key := "ω_i", value := "temporal_growth" } ] }
  ]

def saddlePointConditions : List SaddlePointCondition :=
  [ { wavenumber := "k*", frequency := "ω*", groupVelocityZero := true,
      temporalGrowthPositive := true, pinchPoint := true,
      characterization := InstabilityCharacterization.absolutelyUnstable },
    { wavenumber := "k0", frequency := "ω0", groupVelocityZero := false,
      temporalGrowthPositive := true, pinchPoint := false,
      characterization := InstabilityCharacterization.convectivelyUnstable }
  ]

def admissibleBridges : List AdmissibleBridge :=
  [ { key := "abs_saddle_bridge", sourceSection := "Theorem 3",
      condition := "dω/dk=0 ∧ ω_i>0", conclusion := "absolute instability",
      admissible := true },
    { key := "conv_saddle_bridge", sourceSection := "Theorem 4",
      condition := "dω/dk≠0 ∧ ω_i>0", conclusion := "convective instability",
      admissible := true }
  ]

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse