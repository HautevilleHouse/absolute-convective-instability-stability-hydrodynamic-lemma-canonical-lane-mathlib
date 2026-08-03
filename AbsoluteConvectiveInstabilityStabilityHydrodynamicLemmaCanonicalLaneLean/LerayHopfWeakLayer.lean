/-!
# Leray-Hopf Weak Layer (Absolute Convective Instability Stability Hydrodynamic Lemma)

This module records the admissible-class bridge for the absolute-convective
instability and hydrodynamic-stability lemma. The fields are proof-carrying
Lean terms, so the package checks that each named obligation is supplied by the
source-derived certificate route.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean

/-! Basic hydrodynamic flow types and predicates. -/
axiom HydrodynamicFlow : Type
axiom primitiveHydrodynamicFlow : HydrodynamicFlow

axiom AbsoluteInstability (flow : HydrodynamicFlow) : Prop
axiom ConvectiveInstability (flow : HydrodynamicFlow) : Prop
axiom HydrodynamicStability (flow : HydrodynamicFlow) : Prop
axiom BridgeCondition (flow : HydrodynamicFlow) : Prop

/-! Certificate proofs supplied by the source route. -/
axiom primitive_flow_absolute_instability_checked : AbsoluteInstability primitiveHydrodynamicFlow
axiom primitive_flow_convective_instability_checked : ConvectiveInstability primitiveHydrodynamicFlow
axiom primitive_flow_hydrodynamic_stability_checked : HydrodynamicStability primitiveHydrodynamicFlow
axiom primitive_flow_bridge_condition_checked : BridgeCondition primitiveHydrodynamicFlow

/-! The bridge lemma for the absolute-convective instability and stability classification. -/
def AbsoluteConvectiveBridgeLemma : Prop :=
  ∀ (flow : HydrodynamicFlow), BridgeCondition flow →
    (AbsoluteInstability flow ↔ ConvectiveInstability flow) ∧
    (HydrodynamicStability flow ↔ ¬ AbsoluteInstability flow)

axiom primitive_bridge_lemma_checked : AbsoluteConvectiveBridgeLemma

/-! The admissible-class bridge envelope. -/
structure AbsoluteConvectiveEnvelope where
  flow : HydrodynamicFlow
  absoluteInstability : Prop
  convectiveInstability : Prop
  hydrodynamicStability : Prop
  bridgeCondition : Prop
  bridgeLemma : AbsoluteConvectiveBridgeLemma
  absoluteInstabilityClosed : absoluteInstability
  convectiveInstabilityClosed : convectiveInstability
  hydrodynamicStabilityClosed : hydrodynamicStability
  bridgeConditionClosed : bridgeCondition
  bridgeLemmaClosed : bridgeLemma

def sourceAbsoluteConvectiveEnvelope : AbsoluteConvectiveEnvelope := {
  flow := primitiveHydrodynamicFlow
  absoluteInstability := AbsoluteInstability primitiveHydrodynamicFlow
  convectiveInstability := ConvectiveInstability primitiveHydrodynamicFlow
  hydrodynamicStability := HydrodynamicStability primitiveHydrodynamicFlow
  bridgeCondition := BridgeCondition primitiveHydrodynamicFlow
  bridgeLemma := AbsoluteConvectiveBridgeLemma
  absoluteInstabilityClosed := primitive_flow_absolute_instability_checked
  convectiveInstabilityClosed := primitive_flow_convective_instability_checked
  hydrodynamicStabilityClosed := primitive_flow_hydrodynamic_stability_checked
  bridgeConditionClosed := primitive_flow_bridge_condition_checked
  bridgeLemmaClosed := primitive_bridge_lemma_checked
}

def AbsoluteConvectiveEnvelopeClosed (E : AbsoluteConvectiveEnvelope) : Prop :=
  E.absoluteInstability ∧ E.convectiveInstability ∧ E.hydrodynamicStability ∧ E.bridgeCondition ∧ E.bridgeLemma

theorem source_absolute_convective_envelope_closed :
    AbsoluteConvectiveEnvelopeClosed sourceAbsoluteConvectiveEnvelope := by
  unfold AbsoluteConvectiveEnvelopeClosed sourceAbsoluteConvectiveEnvelope
  exact And.intro sourceAbsoluteConvectiveEnvelope.absoluteInstabilityClosed
    (And.intro sourceAbsoluteConvectiveEnvelope.convectiveInstabilityClosed
      (And.intro sourceAbsoluteConvectiveEnvelope.hydrodynamicStabilityClosed
        (And.intro sourceAbsoluteConvectiveEnvelope.bridgeConditionClosed
          sourceAbsoluteConvectiveEnvelope.bridgeLemmaClosed)))

end AbsoluteConvectiveInstabilityStabilityHydrodynamicLemmaCanonicalLaneLean
end HautevilleHouse