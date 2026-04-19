# E156 Protocol — `hta-evidence-integrity`

This repository is the source code and dashboard backing an E156 micro-paper on the [E156 Student Board](https://mahmood726-cyber.github.io/e156/students.html).

---

## `[67]` Evidence Integrity Suite for Multi-Layered Health Technology Assessment of Cochrane Reviews

**Type:** methods  |  ESTIMAND: Information Adequacy Index  
**Data:** Pairwise70 Cochrane dataset (501 reviews, 4,424 meta-analyses)

### 156-word body

Can automated information adequacy, fragility, and publication bias assessment improve health technology assessment decision-making across hundreds of Cochrane reviews? The Evidence Integrity Suite analyzed 501 Cochrane systematic reviews from the Pairwise70 dataset, encompassing 4,424 meta-analyses across 17 clinical domains with 43,000 individual studies. The pipeline integrates an Information Adequacy Index using heterogeneity-adjusted optimal information size, leave-one-out fragility classification, and dual-pronged bias correction with a rare-disease guardrail for small populations. Only 36.4 percent of 492 meta-analyses met adequate information thresholds, while 26.1 percent exhibited directional fragility and 29.5 percent showed sign reversals under bias correction. Simulation across eight scenarios confirmed that Hartung-Knapp-Sidik-Jonkman achieved the best coverage at 89.0 percent overall, while all methods severely undercovered under high heterogeneity with publication bias. The integrated triage dashboard maps these quantitative signals to GRADE-aligned HTA decision categories for transparent evidence prioritization. However, a limitation is that the evidence decay prediction model achieved only moderate discrimination with cross-validated AUC of 0.688.

### Submission metadata

```
Corresponding author: Mahmood Ahmad <mahmood.ahmad2@nhs.net>
ORCID: 0000-0001-9107-3704
Affiliation: Tahir Heart Institute, Rabwah, Pakistan

Links:
  Code:      https://github.com/mahmood726-cyber/hta-evidence-integrity
  Protocol:  https://github.com/mahmood726-cyber/hta-evidence-integrity/blob/main/E156-PROTOCOL.md
  Dashboard: https://mahmood726-cyber.github.io/hta-evidence-integrity/

References (topic pack: fragility index):
  1. Walsh M, Srinathan SK, McAuley DF, et al. 2014. The statistical significance of randomized controlled trial results is frequently fragile: a case for a Fragility Index. J Clin Epidemiol. 67(6):622-628. doi:10.1016/j.jclinepi.2013.10.019
  2. Atal I, Porcher R, Boutron I, Ravaud P. 2019. The statistical significance of meta-analyses is frequently fragile: definition of a fragility index for meta-analyses. J Clin Epidemiol. 111:32-40. doi:10.1016/j.jclinepi.2019.03.012

Data availability: No patient-level data used. Analysis derived exclusively
  from publicly available aggregate records. All source identifiers are in
  the protocol document linked above.

Ethics: Not required. Study uses only publicly available aggregate data; no
  human participants; no patient-identifiable information; no individual-
  participant data. No institutional review board approval sought or required
  under standard research-ethics guidelines for secondary methodological
  research on published literature.

Funding: None.

Competing interests: MA serves on the editorial board of Synthēsis (the
  target journal); MA had no role in editorial decisions on this
  manuscript, which was handled by an independent editor of the journal.

Author contributions (CRediT):
  [STUDENT REWRITER, first author] — Writing – original draft, Writing –
    review & editing, Validation.
  [SUPERVISING FACULTY, last/senior author] — Supervision, Validation,
    Writing – review & editing.
  Mahmood Ahmad (middle author, NOT first or last) — Conceptualization,
    Methodology, Software, Data curation, Formal analysis, Resources.

AI disclosure: Computational tooling (including AI-assisted coding via
  Claude Code [Anthropic]) was used to develop analysis scripts and assist
  with data extraction. The final manuscript was human-written, reviewed,
  and approved by the author; the submitted text is not AI-generated. All
  quantitative claims were verified against source data; cross-validation
  was performed where applicable. The author retains full responsibility for
  the final content.

Preprint: Not preprinted.

Reporting checklist: PRISMA 2020 (methods-paper variant — reports on review corpus).

Target journal: ◆ Synthēsis (https://www.synthesis-medicine.org/index.php/journal)
  Section: Methods Note — submit the 156-word E156 body verbatim as the main text.
  The journal caps main text at ≤400 words; E156's 156-word, 7-sentence
  contract sits well inside that ceiling. Do NOT pad to 400 — the
  micro-paper length is the point of the format.

Manuscript license: CC-BY-4.0.
Code license: MIT.

SUBMITTED: [ ]
```


---

_Auto-generated from the workbook by `C:/E156/scripts/create_missing_protocols.py`. If something is wrong, edit `rewrite-workbook.txt` and re-run the script — it will overwrite this file via the GitHub API._