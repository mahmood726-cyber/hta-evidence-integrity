"""Verify all numerical claims in the Evidence Integrity Suite manuscript against pipeline output."""
import csv, sys, os, statistics

os.chdir(os.path.join(os.path.dirname(__file__), ".."))

checks = []
def check(name, expected, actual, tol=0.2):
    passed = abs(expected - actual) <= tol
    checks.append((name, passed, expected, actual))
    return passed

# ========================================================================
# 1. Information Adequacy (492 meta-analyses)
# ========================================================================
with open("analysis/output/information_adequacy/information_adequacy_FINAL.csv") as f:
    ia = list(csv.DictReader(f))

n_ia = len(ia)
check("IAI total meta-analyses", 492, n_ia)

iai_classes = {}
for r in ia:
    c = r["IAI_final_class"]
    iai_classes[c] = iai_classes.get(c, 0) + 1

check("IAI Adequate count", 179, iai_classes.get("Adequate", 0))
check("IAI Marginal count", 120, iai_classes.get("Marginal", 0))
check("IAI Inadequate count", 177, iai_classes.get("Inadequate", 0))
check("IAI Critical count", 16, iai_classes.get("Critical", 0))

check("IAI Adequate %", 36.4, 100 * iai_classes.get("Adequate", 0) / n_ia)
check("IAI Marginal %", 24.4, 100 * iai_classes.get("Marginal", 0) / n_ia)
check("IAI Inadequate %", 36.0, 100 * iai_classes.get("Inadequate", 0) / n_ia)
check("IAI Critical %", 3.3, 100 * iai_classes.get("Critical", 0) / n_ia, tol=0.1)

# IAI stats
iai_vals = [float(r["IAI_final"]) for r in ia if r["IAI_final"]]
check("IAI mean", 0.616, statistics.mean(iai_vals), tol=0.01)
check("IAI median", 0.554, statistics.median(iai_vals), tol=0.01)

# Information fraction
inf_fracs = [float(r["information_fraction"]) for r in ia if r.get("information_fraction")]
check("Mean info fraction", 4.76, statistics.mean(inf_fracs), tol=0.1)
check("Median info fraction", 1.48, statistics.median(inf_fracs), tol=0.1)

# Significance
sig_count = sum(1 for r in ia if r["significant"] == "TRUE")
check("Significant %", 45.1, 100 * sig_count / n_ia)

# Sequential status
seq_statuses = {}
for r in ia:
    s = r["sequential_status"]
    seq_statuses[s] = seq_statuses.get(s, 0) + 1
check("Conclusive benefit %", 16.7, 100 * seq_statuses.get("conclusive_benefit", 0) / n_ia)
check("Conclusive harm %", 22.6, 100 * seq_statuses.get("conclusive_harm", 0) / n_ia)
check("Continue %", 40.4, 100 * seq_statuses.get("continue", 0) / n_ia)
check("Futile %", 11.0, 100 * seq_statuses.get("futile", 0) / n_ia)

# I2 and k stats
i2_vals = [float(r["I2"]) for r in ia if r.get("I2")]
check("I2 mean", 31.7, statistics.mean(i2_vals), tol=0.5)
k_vals = [int(r["k"]) for r in ia if r.get("k")]
check("k median", 71.0, statistics.median(k_vals), tol=1.0)

# ========================================================================
# 2. Unified HTA Validation (44 bias-corrected reviews)
# ========================================================================
with open("analysis/output/unified_hta_validation.csv") as f:
    uhv = list(csv.DictReader(f))

n_uhv = len(uhv)
check("Bias correction sample size", 44, n_uhv)

# GRADE
grade_counts = {}
for r in uhv:
    g = r["grade_certainty"]
    grade_counts[g] = grade_counts.get(g, 0) + 1
check("GRADE VERY LOW count", 27, grade_counts.get("VERY LOW", 0))
check("GRADE LOW count", 16, sum(v for k, v in grade_counts.items() if "LOW" in k and "VERY" not in k))
check("GRADE MODERATE count", 1, sum(v for k, v in grade_counts.items() if "MODERATE" in k))

# Discordant
disc_count = sum(1 for r in uhv if r["discordant"] == "TRUE")
check("Discordant count", 13, disc_count)
check("Discordant %", 29.5, 100 * disc_count / n_uhv)

# Bias detected
bias_count = sum(1 for r in uhv if r["bias_detected"] == "TRUE")
check("Bias detected count", 3, bias_count)
check("Bias detected %", 6.8, 100 * bias_count / n_uhv)

# Rare disease
rare_count = sum(1 for r in uhv if r["is_rare_disease"] == "TRUE")
check("Rare disease count", 3, rare_count)
check("Rare disease %", 6.8, 100 * rare_count / n_uhv)

# Median k
k_uhv = [int(r["k"]) for r in uhv]
check("UHV median k", 13.5, statistics.median(k_uhv), tol=0.5)

# ========================================================================
# 3. Cross-Validation AUC
# ========================================================================
with open("analysis/output/cv_results.csv") as f:
    cv = list(csv.DictReader(f))
aucs = [float(r["Logistic_AUC"]) for r in cv]
check("CV AUC mean", 0.688, statistics.mean(aucs), tol=0.002)
check("CV AUC SD", 0.023, statistics.stdev(aucs), tol=0.002)

# ========================================================================
# 4. Fragility (summary stats)
# ========================================================================
with open("analysis/output/fragility_comprehensive_summary.csv") as f:
    reader = csv.reader(f)
    frag_data = {}
    for row in reader:
        if len(row) >= 3:
            frag_data[row[1].strip()] = row[2].strip()

check("Fragility total analyses", 4424, int(frag_data.get("Total analyses", 0)))
check("Fragility total datasets", 474, int(frag_data.get("Total datasets", 0)))
check("Fragility AUC direction", 0.837, float(frag_data.get("AUC direction", 0)), tol=0.002)
check("Fragility AUC significance", 0.773, float(frag_data.get("AUC significance", 0)), tol=0.002)
check("k threshold dir fragile", 25, int(frag_data.get("k for <10% dir fragile", 0)))
check("k threshold sig fragile", 35, int(frag_data.get("k for <10% sig fragile", 0)))

# ========================================================================
# 5. Simulation (HKSJ coverage)
# ========================================================================
with open("analysis/output/simulation_1000_overall.csv") as f:
    sim = list(csv.DictReader(f))
for r in sim:
    if r.get("Method") == "HKSJ" or r.get("method") == "HKSJ":
        cov_key = [k for k in r.keys() if "coverage" in k.lower() or "Coverage" in k]
        if cov_key:
            cov = float(r[cov_key[0]])
            check("HKSJ overall coverage", 89.0, cov * 100 if cov <= 1 else cov, tol=0.5)
        break

# ========================================================================
# Summary
# ========================================================================
passed = sum(1 for _, p, _, _ in checks if p)
failed = sum(1 for _, p, _, _ in checks if not p)

print("=" * 70)
for name, p, exp, act in checks:
    status = "PASS" if p else "FAIL"
    print(f"  [{status}] {name}: expected={exp}, actual={act}")
print("=" * 70)
print(f"SUMMARY: {passed}/{len(checks)} PASS, {failed}/{len(checks)} FAIL")
if failed > 0:
    print("FAILURES DETECTED")
    sys.exit(1)
else:
    print("ALL MANUSCRIPT NUMBERS VERIFIED SUCCESSFULLY")
