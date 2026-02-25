#!/bin/bash
# Find DICOM field(s) that store the VENC value for phase-contrast MRA (per-series, not the full protocol list).

dir="/local/users/Proulx-S/db/multiVENC_sub01/dcmQueue/Q6-BEAT_FQ_venc_4_6_8_13_40"

# ---------------------------------------------------------------------------
# VENC location (from venc_dicom_tags.py on Siemens BEAT_FQ multi-VENC data):
# ---------------------------------------------------------------------------
# Standard DICOM:
#   (0018,0024) Sequence Name  --> e.g. *fl2d1_v004in, *fl2d1_v006in, *fl2d1_v008in, *fl2d1_v013in, *fl2d1_v040in
#   Parse VENC from the "vNNN" part (4, 6, 8, 13, 40).
#
# Standard velocity encoding tags (0018,9091) and (0018,9217) are NOT populated
# in these Siemens legacy MR images.
#
# Siemens private (also carry per-series VENC):
#   (0021,1129)  --> "v4_through", "v6_through", "v8_through", "v13_through", "v40_through"
#   (0021,1177)  --> same as Sequence Name (*fl2d1_v004in, ...)
#
# For BIDS: use (0018,0024) Sequence Name and parse vNNN, or use (0021,1129) and parse vN.
# ---------------------------------------------------------------------------

# List the 5 files, each with a different VENC value
ls "$dir"/BEAT_FQ_venc_4_6_8_13_40_P_??001_MR/1.dcm

# Show Sequence Name (0018,0024) and Siemens (0021,1129) for each phase series
echo ""
echo "=== (0018,0024) Sequence Name and (0021,1129) per series ==="
for f in "$dir"/BEAT_FQ_venc_4_6_8_13_40_P_??001_MR/1.dcm; do
  [ -f "$f" ] || continue
  name=$(basename "$(dirname "$f")")
  python3 - "$f" "$name" 2>/dev/null << 'PY' || true
import sys
try:
  import pydicom
  ds = pydicom.dcmread(sys.argv[1], stop_before_pixels=True)
  t1824 = pydicom.tag.Tag(0x0018, 0x0024)
  t2129 = pydicom.tag.Tag(0x0021, 0x1129)
  seq = ds[t1824].value if t1824 in ds else ""
  p2129 = ds[t2129].value if t2129 in ds else ""
  print(f"  {sys.argv[2]}: SequenceName={seq!r}  (0021,1129)={p2129!r}")
except Exception as e:
  print(f"  {sys.argv[2]}: error {e}", file=sys.stderr)
PY
done
