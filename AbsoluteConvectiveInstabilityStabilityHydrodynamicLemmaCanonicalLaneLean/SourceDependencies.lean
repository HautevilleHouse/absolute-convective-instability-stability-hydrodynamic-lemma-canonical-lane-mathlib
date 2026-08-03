import AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean.SourcePackage

/-!
# Source dependency model for `absolute-convective-instability-stability-hydrodynamic-lemma`

This module records the import and data-route surface used by the source
package/scripts before translation into Lean data.

It makes the source runtime dependency boundary explicit. The dependency boundary is internal to the Lean package as structural data.

Key notions: absolute instability, convective instability, hydrodynamic stability lemma, and the admissible-class bridge.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

structure SourceImportDependency where
  file : String
  kind : String
  module : String
  name : String
  alias : String
  level : Nat
deriving Repr, DecidableEq

structure SourcePathDependency where
  file : String
  name : String
  path : String
  role : String
  line : Nat
deriving Repr, DecidableEq

def sourceImportDependencies : List SourceImportDependency := [
  { file := "scripts/extract_abs_conv.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/extract_abs_conv.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/extract_abs_conv.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/extract_abs_conv.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/extract_abs_conv.py", kind := "from_import", module := "pathlib", name := "Path", alias := "", level := 0 },
  { file := "scripts/extract_abs_conv.py", kind := "from_import", module := "typing", name := "Any", alias := "", level := 0 },
  { file := "scripts/bridge_lemma.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/bridge_lemma.py", kind := "import", module := "numpy", name := "", alias := "np", level := 0 },
  { file := "scripts/bridge_lemma.py", kind := "import", module := "scipy.optimize", name := "brentq", alias := "", level := 0 },
  { file := "scripts/bridge_lemma.py", kind := "from_import", module := "typing", name := "Tuple", alias := "", level := 0 },
  { file := "scripts/stability_guard.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/stability_guard.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/stability_guard.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/promote_constants.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/promote_constants.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/promote_constants.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "json", name := "", alias := "", level := 0 }
]

def sourcePathDependencies : List SourcePathDependency := [
  { file := "scripts/extract_abs_conv.py", name := "raw_dispersion_data", path := "data/dispersion_relations.json", role := "input", line := 12 },
  { file := "scripts/extract_abs_conv.py", name := "instability_classification", path := "data/instability_classes.json", role := "output", line := 45 },
  { file := "scripts/bridge_lemma.py", name := "admissible_class_bridge", path := "data/bridge_table.json", role := "output", line := 78 },
  { file := "scripts/stability_guard.py", name := "hydrodynamic_lemma_state", path := "state/stability_lemma.snapshot", role := "input", line := 23 },
  { file := "scripts/promote_constants.py", name := "canonical_constants", path := "data/canonical_lane_constants.json", role := "output", line := 15 },
  { file := "scripts/release_gate.py", name := "release_manifest", path := "manifest/release.json", role := "output", line := 30 }
]

--   Admissible-class bridge for the hydrodynamic stability lemma.

/-- A dispersion relation from a linear stability analysis. -/
structure DispersionRelation where
  waveNumber : ℝ
  frequency : ℝ
  growthRate : ℝ
deriving Repr

/-- The two admissible instability classes. -/
inductive InstabilityKind where
  | absolute
  | convective
deriving Repr, DecidableEq

/-- The hydrodynamic stability lemma with the canonical lane parameters. -/
structure StabilityHydrodynamicLemma where
  velocity : ℝ
  viscosity : ℝ
  density : ℝ
  dispersion : DispersionRelation
deriving Repr

/-- A growth rate below zero is the absolute stability signature. -/
def IsAbsolutelyStable (h : StabilityHydrodynamicLemma) : Prop :=
  h.dispersion.growthRate < 0

/-- A non-positive growth rate is the convective stability envelope. -/
def IsConvectivelyStable (h : StabilityHydrodynamicLemma) : Prop :=
  h.dispersion.growthRate ≤ 0

/-- Classify a hydrodynamic lemma into one of the admissible classes. -/
def classifyInstability (h : StabilityHydrodynamicLemma) : InstabilityKind :=
  if h.dispersion.growthRate < 0 then InstabilityKind.absolute else InstabilityKind.convective

/-- Absolute stability is a strictly stronger statement than convective stability. -/
theorem absolute_implies_convective_stability
    (h : StabilityHydrodynamicLemma) (habs : IsAbsolutelyStable h) :
    IsConvectivelyStable h := by
  unfold IsAbsolutelyStable at habs
  unfold IsConvectivelyStable
  exact le_of_lt habs

/-- The bridge lemma: every admissible lemma has an instability class. -/
lemma admissible_class_bridge (h : StabilityHydrodynamicLemma) :
    classifyInstability h = InstabilityKind.absolute ∨ classifyInstability h = InstabilityKind.convective := by
  unfold classifyInstability
  by_cases hpos : h.dispersion.growthRate < 0
  · left; simp [hpos]
  · right; simp [hpos]

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse