#!/usr/bin/env python3
# Build risk-classified SQLi wordlists from sqlmap's payload XMLs.
# Splits each XML by <risk> into Low/Medium/High folders.
# Issue ref: https://github.com/danielmiessler/SecLists/issues/1011

import argparse
import os
import sys
import urllib.request
from xml.etree import ElementTree as ET

RAW = "https://raw.githubusercontent.com/sqlmapproject/sqlmap/master/data/xml/payloads"

# union_query.xml is skipped on purpose: sqlmap builds those payloads from
# a column-count range at runtime, there are no fixed strings to extract.
SOURCES = [
    "boolean_blind.xml",
    "error_based.xml",
    "inline_query.xml",
    "stacked_queries.xml",
    "time_blind.xml",
]

RISK = {1: "Low-Risk-Payloads", 2: "Medium-Risk-Payloads", 3: "High-Risk-Payloads"}


def load(name, offline):
    if offline:
        with open(os.path.join(offline, name), "rb") as f:
            return f.read()
    with urllib.request.urlopen(f"{RAW}/{name}", timeout=30) as r:
        return r.read()


def payloads(xml):
    for t in ET.fromstring(xml).findall(".//test"):
        r = t.find("risk")
        p = t.find("request/payload")
        if r is None or p is None or p.text is None:
            continue
        try:
            risk = int(r.text.strip())
        except ValueError:
            continue
        if risk in RISK:
            yield risk, p.text.strip()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--offline", help="path to sqlmap/data/xml/payloads")
    ap.add_argument("--out", default=os.getcwd())
    args = ap.parse_args()

    bucket = {(r, s): [] for r in RISK for s in SOURCES}
    for src in SOURCES:
        try:
            data = load(src, args.offline)
        except Exception as e:
            print(f"failed to read {src}: {e}", file=sys.stderr)
            return 1
        for risk, payload in payloads(data):
            bucket[(risk, src)].append(payload)

    n = 0
    for (risk, src), items in bucket.items():
        if not items:
            continue
        # dedupe but keep order (same payload string appears in multiple <test>
        # blocks with different dbms hints)
        seen = set()
        uniq = [p for p in items if not (p in seen or seen.add(p))]
        d = os.path.join(args.out, RISK[risk])
        os.makedirs(d, exist_ok=True)
        out = os.path.join(d, src.replace(".xml", ".txt"))
        with open(out, "w") as f:
            f.write("\n".join(uniq) + "\n")
        n += 1
        print(f"{RISK[risk]}/{os.path.basename(out)}: {len(uniq)}")
    print(f"wrote {n} files under {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
