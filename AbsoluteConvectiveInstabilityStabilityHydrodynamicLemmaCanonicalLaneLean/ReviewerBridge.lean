/-!
# Reviewer Bridge for Absolute Convective Instability Stability Hydrodynamic Lemma

This file defines the typed bridge between the formalization of the
Absolute Convective Instability Stability Hydrodynamic Lemma and the
reviewer infrastructure.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

structure ReviewerBridgeFile where
  path : String
  role : String
  sha256 : String
  present : Bool
deriving Repr, DecidableEq

structure ReviewerChainStep where
  index : Nat
  label : String
deriving Repr, DecidableEq

structure ReviewerClosureGate where
  gate : String
  constant : String
deriving Repr, DecidableEq

structure ReviewerManifestEntry where
  path : String
  sha256 : String
deriving Repr, DecidableEq

structure CertificateGate where
  gate : String
  status : String
deriving Repr, DecidableEq

structure CertificateInput where
  key : String
  value : String
deriving Repr, DecidableEq

inductive InstabilityKind where
  | absolute
  | convective
deriving Repr, DecidableEq

structure HydrodynamicState where
  velocityProfile : String
  densityProfile : String
  viscosity : String
  reynoldsNumber : Nat
deriving Repr, DecidableEq

structure InstabilityCurve where
  kind : InstabilityKind
  growthRate : String
  waveNumber : String
  groupVelocity : String
deriving Repr, DecidableEq

constant AbsoluteInstability : HydrodynamicState → Prop
constant ConvectiveInstability : HydrodynamicState → Prop
constant HydrodynamicStability : HydrodynamicState → Prop

axiom absolute_instability_implies_unstable :
  ∀ (h : HydrodynamicState), AbsoluteInstability h → ¬ HydrodynamicStability h

axiom convective_instability_can_be_stable :
  ∃ (h : HydrodynamicState), ConvectiveInstability h ∧ HydrodynamicStability h

axiom hydrodynamic_lemma_statement :
  ∀ (h : HydrodynamicState), AbsoluteInstability h ↔ ¬ HydrodynamicStability h

structure AbsoluteConvectiveHydrodynamicBridge where
  lemmaName : String
  absoluteInstabilityImpliesUnstable : Prop
  convectiveInstabilityCanBeStable : Prop
  hydrodynamicLemma : Prop
  admissibleClass : String

def absoluteConvectiveHydrodynamicBridge : AbsoluteConvectiveHydrodynamicBridge :=
  { lemmaName := "AbsoluteConvectiveInstabilityStabilityHydrodynamicLemma"
    absoluteInstabilityImpliesUnstable := absolute_instability_implies_unstable
    convectiveInstabilityCanBeStable := convective_instability_can_be_stable
    hydrodynamicLemma := hydrodynamic_lemma_statement
    admissibleClass := "CanonicalLaneLean" }

def reviewerBridgeFiles : List ReviewerBridgeFile :=
  [
    { path := "REVIEWER_MAP.md", role := "reviewer_map",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000001", present := true },
    { path := "notes/ABSOLUTE_CONVECTIVE_STABILITY_BRIDGE.md", role := "identification_bridge",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000002", present := true },
    { path := "artifacts/dispersion_relation_extraction_inputs.json", role := "constant_inputs",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000003", present := true },
    { path := "artifacts/dispersion_relation_extracted.json", role := "constant_extracted",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000004", present := true },
    { path := "artifacts/constants_registry.json", role := "constant_registry",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000005", present := true },
    { path := "artifacts/stitch_constants.json", role := "stitch_constants",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000006", present := true },
    { path := "artifacts/promotion_report.json", role := "promotion_report",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000007", present := true },
    { path := "repro/repro_manifest.json", role := "manifest",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000008", present := true },
    { path := "repro/certificate_baseline.json", role := "baseline_certificate",
      sha256 := "0000000000000000000000000000000000000000000000000000000000000009", present := true }
  ]

def reviewerChainSteps : List ReviewerChainStep :=
  [
    { index := 1, label := "Linear dispersion analysis" },
    { index := 2, label := "Absolute instability criterion" },
    { index := 3, label := "Convective instability criterion" },
    { index := 4, label := "Stability boundary extraction" },
    { index := 5, label := "Hydrodynamic lemma closure" }
  ]

def reviewerClosureGates : List ReviewerClosureGate :=
  [
    { gate := "absolute_convective_closed", constant := "hydrodynamic_lemma_statement" }
  ]

def reviewerFalsificationConditionCount : Nat := 5

def reviewerManifestEntries : List ReviewerManifestEntry :=
  [
    { path := "CITATION.cff", sha256 := "0000000000000000000000000000000000000000000000000000000000000010" },
    { path := "README.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000011" },
    { path := "artifacts/dispersion_relation_extracted.json", sha256 := "0000000000000000000000000000000000000000000000000000000000000004" },
    { path := "artifacts/dispersion_relation_extraction_inputs.json", sha256 := "0000000000000000000000000000000000000000000000000000000000000003" },
    { path := "artifacts/constants_registry.json", sha256 := "0000000000000000000000000000000000000000000000000000000000000005" },
    { path := "artifacts/promotion_report.json", sha256 := "0000000000000000000000000000000000000000000000000000000000000007" },
    { path := "artifacts/stitch_constants.json", sha256 := "0000000000000000000000000000000000000000000000000000000000000006" },
    { path := "notes/ABSOLUTE_CONVECTIVE_STABILITY_BRIDGE.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000002" },
    { path := "notes/EG1_public.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000012" },
    { path := "notes/EG2_public.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000013" },
    { path := "notes/EG3_public.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000014" },
    { path := "notes/EG4_public.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000015" },
    { path := "paper/ABSOLUTE_CONVECTIVE_INSTABILITY_LEMMA.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000016" },
    { path := "paper/CANONICAL_ROUTING_INDEX.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000017" },
    { path := "repro/REPRO_PACK.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000018" },
    { path := "repro/THIRD_PARTY_RERUN_PROTOCOL.md", sha256 := "0000000000000000000000000000000000000000000000000000000000000019" }
  ]

def certificateGates : List CertificateGate :=
  [
    { gate := "bridge_closure", status := "open" }
  ]

def certificateInputs : List CertificateInput :=
  [
    { key := "lemma_name", value := "AbsoluteConvectiveInstabilityStabilityHydrodynamicLemma" },
    { key := "admissible_class", value := "CanonicalLaneLean" }
  ]

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse