#!/usr/bin/env python3
"""
Print DICOM tags related to VENC (velocity encoding) from phase-contrast MRA files.
Use this to find which tag holds the per-series VENC value (4, 6, 8, 13, 40).
"""
import os
import sys

try:
    import pydicom
except ImportError:
    print("Install pydicom: pip install pydicom", file=sys.stderr)
    sys.exit(1)

# Standard DICOM tags for velocity encoding (see DICOM MR Velocity Encoding Macro)
# (0018,9091) Velocity Encoding Minimum Value (cm/s)
# (0018,9217) Velocity Encoding Maximum Value (cm/s)  <- often reported as "VENC"
# (0018,9092) Velocity Encoding Acquisition Sequence
# (0018,9197) MR Velocity Encoding Sequence
VENCO_TAGS = [
    ("0018", "9091"),  # VelocityEncodingMinimumValue
    ("0018", "9217"),  # VelocityEncodingMaximumValue
    ("0018", "9092"),  # VelocityEncodingAcquisitionSequence
    ("0018", "9197"),  # MRVelocityEncodingSequence
    ("0018", "9090"),  # VelocityEncodingDirection
]

def get_tag(ds, group, elem):
    tag = pydicom.tag.Tag(group + elem)
    if tag in ds:
        return ds[tag]
    return None

def format_val(v):
    if v is None:
        return "—"
    if hasattr(v, "value"):
        return v.value
    return v

def main():
    base = "/local/users/Proulx-S/db/multiVENC_sub01/dcmQueue/Q6-BEAT_FQ_venc_4_6_8_13_40"
    # One first-instance file per phase series (expected VENC: 4, 6, 8, 13, 40)
    phase_dirs = [
        "BEAT_FQ_venc_4_6_8_13_40_P_39001_MR",
        "BEAT_FQ_venc_4_6_8_13_40_P_41001_MR",
        "BEAT_FQ_venc_4_6_8_13_40_P_43001_MR",
        "BEAT_FQ_venc_4_6_8_13_40_P_45001_MR",
        "BEAT_FQ_venc_4_6_8_13_40_P_47001_MR",
    ]
    dcm_paths = [os.path.join(base, d, "1.dcm") for d in phase_dirs]

    print("=== Standard DICOM velocity encoding tags ===\n")
    for path in dcm_paths:
        name = os.path.basename(os.path.dirname(path))
        if not os.path.isfile(path):
            print(f"Skip (missing): {path}")
            continue
        ds = pydicom.dcmread(path, stop_before_pixels=True)
        print(f"--- {name} ---")
        for g, e in VENCO_TAGS:
            val = get_tag(ds, g, e)
            print(f"  ({g},{e}) {format_val(val)}")
        print()

    print("=== All tags whose value is exactly 4, 6, 8, 13, or 40 (candidates for per-file VENC) ===\n")
    for path in dcm_paths:
        name = os.path.basename(os.path.dirname(path))
        if not os.path.isfile(path):
            continue
        ds = pydicom.dcmread(path, stop_before_pixels=True)
        candidates = []
        for elem in ds.iterall():
            try:
                v = elem.value
                if v in (4, 6, 8, 13, 40):
                    candidates.append((str(elem.tag), elem.name, v))
            except Exception:
                pass
        if candidates:
            print(f"--- {name} ---")
            for tag, n, v in candidates:
                print(f"  {tag} {n} = {v}")
            print()

    # Collect all (tag, name) -> list of values across the 5 files; print only those that differ
    print("=== Tags that DIFFER across the 5 phase series (likely flow/VENC index or similar) ===\n")
    from collections import defaultdict
    tag_values = defaultdict(list)
    for path in dcm_paths:
        name = os.path.basename(os.path.dirname(path))
        if not os.path.isfile(path):
            continue
        ds = pydicom.dcmread(path, stop_before_pixels=True)
        seen = set()
        for elem in ds.iterall():
            try:
                key = (str(elem.tag), elem.name)
                if key in seen:
                    continue
                seen.add(key)
                v = elem.value
                if isinstance(v, (int, float, str)) and not isinstance(v, bytes):
                    tag_values[key].append((name, v))
            except Exception:
                pass
    # Only show tags that have different values across files
    for (tag, name), vals in sorted(tag_values.items()):
        if len(vals) < 2:
            continue
        values = [v for _, v in vals]
        if len(set(str(v) for v in values)) > 1:
            print(f"{tag} {name}")
            for n, v in vals:
                print(f"  {n}: {v}")
            print()

    print("=== Siemens private (0029,1010) CSA header dump: search for single velocity ===\n")
    for path in dcm_paths:
        name = os.path.basename(os.path.dirname(path))
        if not os.path.isfile(path):
            continue
        ds = pydicom.dcmread(path, stop_before_pixels=True)
        # Siemens private: (0029,1010) ICE Dims / CSA header often has flow/velocity
        tag = pydicom.tag.Tag(0x0029, 0x1010)
        if tag not in ds:
            continue
        raw = ds[tag].value
        if raw is None:
            continue
        # Look for nVelocity in CSA (binary); as fallback show snippet
        s = raw if isinstance(raw, bytes) else (raw.tobytes() if hasattr(raw, "tobytes") else b"")
        if isinstance(s, bytes) and b"nVelocity" in s:
            idx = s.find(b"nVelocity")
            snippet = s[max(0, idx - 20) : idx + 60]
            print(f"--- {name} ---")
            print(f"  ... nVelocity ... snippet: {snippet}")
            print()

if __name__ == "__main__":
    main()
