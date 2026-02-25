#!/bin/bash
# This script groups interleaved/simultaneous DICOM series subfolders.
# Generated automatically by dicomSeriesToProtocolQueue.jl
# Edit this file to adjust groupings and destination paths as needed.

# Base directory containing the series folders
BASE_DIR="/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000"

# Destination directory for grouped series
DEST_DIR="/local/users/Proulx-S/db/multiVENC_sub01/dcmQueue"

# Commands to copy/group the series folders
# Each group represents series that were acquired simultaneously/interleaved

# Group 1 (Q1, ProtocolName: t1_mprage_sag_p2_iso): t1_mprage_sag_p2_iso_3001_MR
# Single series (not interleaved with others)
mkdir -p "${DEST_DIR}/Q1-t1_mprage_sag_p2_iso"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/t1_mprage_sag_p2_iso_3001_MR" "${DEST_DIR}/Q1-t1_mprage_sag_p2_iso/"

# Group 2 (Q2, ProtocolName: gre_ps_bold_1mm): gre_ps_bold_1mm_RR_63001_MR
# Single series (not interleaved with others)
mkdir -p "${DEST_DIR}/Q2-gre_ps_bold_1mm"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/gre_ps_bold_1mm_RR_63001_MR" "${DEST_DIR}/Q2-gre_ps_bold_1mm/"

# Group 3 (Q3, ProtocolName: gre_ps_bold_3mm): gre_ps_bold_3mm_RR_64001_MR
# Single series (not interleaved with others)
mkdir -p "${DEST_DIR}/Q3-gre_ps_bold_3mm"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/gre_ps_bold_3mm_RR_64001_MR" "${DEST_DIR}/Q3-gre_ps_bold_3mm/"

# Group 4 (Q4, ProtocolName: ToF): ToF_32001_MR, ToF_MIP_COR_34001_MR, ToF_MIP_SAG_33001_MR, ToF_MIP_TRA_35001_MR
# These series were acquired simultaneously/interleaved
mkdir -p "${DEST_DIR}/Q4-ToF"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_32001_MR" "${DEST_DIR}/Q4-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_MIP_COR_34001_MR" "${DEST_DIR}/Q4-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_MIP_SAG_33001_MR" "${DEST_DIR}/Q4-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_MIP_TRA_35001_MR" "${DEST_DIR}/Q4-ToF/"

# Group 5 (Q5, ProtocolName: BEAT_FQ_PLAN): BEAT_FQ_PLAN_MSUM_36001_MR
# Single series (not interleaved with others)
mkdir -p "${DEST_DIR}/Q5-BEAT_FQ_PLAN"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_PLAN_MSUM_36001_MR" "${DEST_DIR}/Q5-BEAT_FQ_PLAN/"

# Group 6 (Q6, ProtocolName: BEAT_FQ_venc_4_6_8_13_40): BEAT_FQ_venc_4_6_8_13_40_37001_MR, BEAT_FQ_venc_4_6_8_13_40_MAG_38001_MR, BEAT_FQ_venc_4_6_8_13_40_MAG_40001_MR, BEAT_FQ_venc_4_6_8_13_40_MAG_42001_MR, BEAT_FQ_venc_4_6_8_13_40_MAG_44001_MR, BEAT_FQ_venc_4_6_8_13_40_MAG_46001_MR, BEAT_FQ_venc_4_6_8_13_40_P_39001_MR, BEAT_FQ_venc_4_6_8_13_40_P_41001_MR, BEAT_FQ_venc_4_6_8_13_40_P_43001_MR, BEAT_FQ_venc_4_6_8_13_40_P_45001_MR, BEAT_FQ_venc_4_6_8_13_40_P_47001_MR
# These series were acquired simultaneously/interleaved
mkdir -p "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_37001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_MAG_38001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_MAG_40001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_MAG_42001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_MAG_44001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_MAG_46001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_P_39001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_P_41001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_P_43001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_P_45001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_6_8_13_40_P_47001_MR" "${DEST_DIR}/Q6-BEAT_FQ_venc_4_6_8_13_40/"

# Group 7 (Q7, ProtocolName: BEAT_FQ_venc_4_5_7_10_20): BEAT_FQ_venc_4_5_7_10_20_48001_MR, BEAT_FQ_venc_4_5_7_10_20_MAG_49001_MR, BEAT_FQ_venc_4_5_7_10_20_MAG_51001_MR, BEAT_FQ_venc_4_5_7_10_20_MAG_53001_MR, BEAT_FQ_venc_4_5_7_10_20_MAG_55001_MR, BEAT_FQ_venc_4_5_7_10_20_MAG_57001_MR, BEAT_FQ_venc_4_5_7_10_20_P_50001_MR, BEAT_FQ_venc_4_5_7_10_20_P_52001_MR, BEAT_FQ_venc_4_5_7_10_20_P_54001_MR, BEAT_FQ_venc_4_5_7_10_20_P_56001_MR, BEAT_FQ_venc_4_5_7_10_20_P_58001_MR
# These series were acquired simultaneously/interleaved
mkdir -p "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_48001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_MAG_49001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_MAG_51001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_MAG_53001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_MAG_55001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_MAG_57001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_P_50001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_P_52001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_P_54001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_P_56001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/BEAT_FQ_venc_4_5_7_10_20_P_58001_MR" "${DEST_DIR}/Q7-BEAT_FQ_venc_4_5_7_10_20/"

# Group 8 (Q8, ProtocolName: ToF): ToF_59001_MR, ToF_MIP_COR_61001_MR, ToF_MIP_SAG_60001_MR, ToF_MIP_TRA_62001_MR, ToF_RR_65001_MR, ToF_RR_69001_MR, ToF_RR_73001_MR, ToF_RR_MIP_COR_67001_MR, ToF_RR_MIP_COR_71001_MR, ToF_RR_MIP_COR_75001_MR, ToF_RR_MIP_SAG_66001_MR, ToF_RR_MIP_SAG_70001_MR, ToF_RR_MIP_SAG_74001_MR, ToF_RR_MIP_TRA_68001_MR, ToF_RR_MIP_TRA_72001_MR, ToF_RR_MIP_TRA_76001_MR
# These series were acquired simultaneously/interleaved
mkdir -p "${DEST_DIR}/Q8-ToF"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_59001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_MIP_COR_61001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_MIP_SAG_60001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_MIP_TRA_62001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_65001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_69001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_73001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_COR_67001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_COR_71001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_COR_75001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_SAG_66001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_SAG_70001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_SAG_74001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_TRA_68001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_TRA_72001_MR" "${DEST_DIR}/Q8-ToF/"
cp -r "/local/users/Proulx-S/db/multiVENC_sub01/dcm/PS_001_PS_001_19920101/Polimeni_Nadira_20251023_181032.500000/ToF_RR_MIP_TRA_76001_MR" "${DEST_DIR}/Q8-ToF/"

# Summary of all series analyzed:
# BEAT_FQ_PLAN_MSUM_36001_MR: 4 files, duration: 33.60s
# BEAT_FQ_venc_4_5_7_10_20_48001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_MAG_49001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_MAG_51001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_MAG_53001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_MAG_55001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_MAG_57001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_P_50001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_P_52001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_P_54001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_P_56001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_5_7_10_20_P_58001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_37001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_MAG_38001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_MAG_40001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_MAG_42001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_MAG_44001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_MAG_46001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_P_39001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_P_41001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_P_43001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_P_45001_MR: 24 files, duration: 257.59s
# BEAT_FQ_venc_4_6_8_13_40_P_47001_MR: 24 files, duration: 257.59s
# ToF_32001_MR: 32 files, duration: 0.00s
# ToF_59001_MR: 32 files, duration: 0.00s
# ToF_MIP_COR_34001_MR: 1 files, duration: 0.00s
# ToF_MIP_COR_61001_MR: 1 files, duration: 0.00s
# ToF_MIP_SAG_33001_MR: 1 files, duration: 0.00s
# ToF_MIP_SAG_60001_MR: 1 files, duration: 0.00s
# ToF_MIP_TRA_35001_MR: 1 files, duration: 0.00s
# ToF_MIP_TRA_62001_MR: 1 files, duration: 0.00s
# ToF_RR_65001_MR: 32 files, duration: 0.00s
# ToF_RR_69001_MR: 32 files, duration: 0.00s
# ToF_RR_73001_MR: 32 files, duration: 0.00s
# ToF_RR_MIP_COR_67001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_COR_71001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_COR_75001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_SAG_66001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_SAG_70001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_SAG_74001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_TRA_68001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_TRA_72001_MR: 1 files, duration: 0.00s
# ToF_RR_MIP_TRA_76001_MR: 1 files, duration: 0.00s
# gre_ps_bold_1mm_RR_63001_MR: 75 files, duration: 443.19s
# gre_ps_bold_3mm_RR_64001_MR: 75 files, duration: 250.12s
# t1_mprage_sag_p2_iso_3001_MR: 192 files, duration: 0.00s
