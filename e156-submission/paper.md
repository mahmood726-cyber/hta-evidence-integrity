Mahmood Ahmad
Tahir Heart Institute
mahmood.ahmad2@nhs.net

Evidence Integrity Suite for Multi-Layered Health Technology Assessment of Cochrane Reviews

Can automated information adequacy, fragility, and publication bias assessment improve health technology assessment decision-making across hundreds of Cochrane reviews? The Evidence Integrity Suite analyzed 501 Cochrane systematic reviews from the Pairwise70 dataset, encompassing 4,424 meta-analyses across 17 clinical domains with 43,000 individual studies. The pipeline integrates an Information Adequacy Index using heterogeneity-adjusted optimal information size, leave-one-out fragility classification, and dual-pronged bias correction with a rare-disease guardrail for small populations. Only 36.4 percent of 492 meta-analyses met adequate information thresholds, while 26.1 percent exhibited directional fragility and 29.5 percent showed sign reversals under bias correction. Simulation across eight scenarios confirmed that Hartung-Knapp-Sidik-Jonkman achieved the best coverage at 89.0 percent overall, while all methods severely undercovered under high heterogeneity with publication bias. The integrated triage dashboard maps these quantitative signals to GRADE-aligned HTA decision categories for transparent evidence prioritization. However, a limitation is that the evidence decay prediction model achieved only moderate discrimination with cross-validated AUC of 0.688.

Outside Notes

Type: methods
Primary estimand: Information Adequacy Index
App: HTA Evidence Integrity Suite v2.1
Data: Pairwise70 Cochrane dataset (501 reviews, 4,424 meta-analyses)
Code: https://github.com/mahmood726-cyber/hta-evidence-integrity
Version: 2.1
Validation: DRAFT

References

1. Walsh M, Srinathan SK, McAuley DF, et al. The statistical significance of randomized controlled trial results is frequently fragile: a case for a Fragility Index. J Clin Epidemiol. 2014;67(6):622-628.
2. Atal I, Porcher R, Boutron I, Ravaud P. The statistical significance of meta-analyses is frequently fragile: definition of a fragility index for meta-analyses. J Clin Epidemiol. 2019;111:32-40.
3. Borenstein M, Hedges LV, Higgins JPT, Rothstein HR. Introduction to Meta-Analysis. 2nd ed. Wiley; 2021.

AI Disclosure

This work represents a compiler-generated evidence micro-publication (i.e., a structured, pipeline-based synthesis output). AI is used as a constrained synthesis engine operating on structured inputs and predefined rules, rather than as an autonomous author. Deterministic components of the pipeline, together with versioned, reproducible evidence capsules (TruthCert), are designed to support transparent and auditable outputs. All results and text were reviewed and verified by the author, who takes full responsibility for the content. The workflow operationalises key transparency and reporting principles consistent with CONSORT-AI/SPIRIT-AI, including explicit input specification, predefined schemas, logged human-AI interaction, and reproducible outputs.
