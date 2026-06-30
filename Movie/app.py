"""
Movie Success Predictor — Streamlit App
Run:  streamlit run app.py
Requires: best_model.pkl in the same directory
"""

import pickle
from pathlib import Path

import numpy as np
import pandas as pd
import streamlit as st

# ── Page config ───────────────────────────────────────────────────────────────
st.set_page_config(
    page_title="Movie Success Predictor",
    page_icon="🎬",
    layout="centered",
)

# ── Custom CSS ────────────────────────────────────────────────────────────────
st.markdown("""
<style>
    .stApp { max-width: 780px; margin: auto; }
    .metric-box {
        background: #1a1d27;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
        border: 1px solid #2d3147;
    }
    .metric-label { color: #8892a4; font-size: 12px; text-transform: uppercase; letter-spacing: 0.1em; }
    .metric-value { font-size: 36px; font-weight: 800; margin-top: 4px; font-family: monospace; }
    .verdict-banner {
        border-radius: 14px;
        padding: 24px 28px;
        margin: 20px 0;
        border: 1px solid;
    }
    .section-header {
        font-size: 13px;
        font-weight: 700;
        color: #8892a4;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        margin: 24px 0 10px;
    }
</style>
""", unsafe_allow_html=True)

GENRE_COLS = [
    "Action", "Adventure", "Aniimation", "Biography", "Comedy", "Crime",
    "Drama", "Family", "Fantasy", "History", "Horror", "Music",
    "Musical", "Mystery", "Romance", "Sci-Fi", "Sport", "Thriller", "War", "Western",
]

FEATURE_ORDER = [
    "Year", "Runtime (Minutes)", "Rating", "Votes",
    "Revenue (Millions)", "Metascore",
] + GENRE_COLS


# ── Load model ────────────────────────────────────────────────────────────────
@st.cache_resource
def load_model():
    model_path = Path("best_model.pkl")
    if not model_path.exists():
        st.error("❌ `best_model.pkl` not found. Place it in the same folder as app.py.")
        st.stop()
    with open(model_path, "rb") as f:
        return pickle.load(f)


model = load_model()

# ── Header ────────────────────────────────────────────────────────────────────
st.markdown("## 🎬 Movie Success Predictor")
st.markdown("Enter movie details to predict whether it will be **Successful** or **Not Successful**.")
st.divider()

# ── Input form ────────────────────────────────────────────────────────────────
st.markdown('<div class="section-header">📋 Movie Details</div>', unsafe_allow_html=True)

col1, col2 = st.columns(2)
with col1:
    year    = st.number_input("Year",               min_value=1900, max_value=2030, value=2023)
    runtime = st.number_input("Runtime (Minutes)",  min_value=1,    max_value=300,  value=120)
    rating  = st.slider      ("IMDb Rating",         0.0, 10.0, 7.0, step=0.1)
    votes   = st.number_input("Votes (IMDb)",        min_value=0,    max_value=3_000_000, value=100_000, step=1000)

with col2:
    revenue   = st.number_input("Revenue (Millions $)", min_value=0.0, max_value=3000.0, value=80.0, step=1.0)
    metascore = st.slider      ("Metascore",            0, 100, 65)

st.markdown('<div class="section-header">🎭 Genres</div>', unsafe_allow_html=True)
genre_display = [g if g != "Aniimation" else "Animation" for g in GENRE_COLS]
selected_genres = st.multiselect(
    "Select all that apply",
    options=genre_display,
    default=["Action"],
)

# ── Predict ───────────────────────────────────────────────────────────────────
st.divider()
predict_btn = st.button("🎬  Predict Success", use_container_width=True, type="primary")

if predict_btn:
    genre_values = {g: (1 if d in selected_genres else 0) for g, d in zip(GENRE_COLS, genre_display)}

    row = {
        "Year":               year,
        "Runtime (Minutes)":  runtime,
        "Rating":             rating,
        "Votes":              votes,
        "Revenue (Millions)": revenue,
        "Metascore":          metascore,
        **genre_values,
    }
    X_input = pd.DataFrame([row])[FEATURE_ORDER]

    pred         = model.predict(X_input)[0]
    proba        = model.predict_proba(X_input)[0]
    success_prob = proba[1] * 100
    fail_prob    = proba[0] * 100

    # Verdict banner
    if pred == 1:
        color, emoji, label, bg, border = "#4ade80", "✅", "SUCCESSFUL", "#0d2818", "#4ade8060"
    else:
        color, emoji, label, bg, border = "#f87171", "❌", "NOT SUCCESSFUL", "#2a0f0f", "#f8717160"

    st.markdown(f"""
    <div class="verdict-banner" style="background:{bg}; border-color:{border};">
        <div style="font-size:13px; color:#8892a4; text-transform:uppercase; letter-spacing:0.1em;">Prediction</div>
        <div style="font-size:32px; font-weight:900; color:{color}; margin-top:6px;">{emoji} &nbsp;{label}</div>
        <div style="color:#c9d1d9; margin-top:8px; font-size:14px;">
            The model is <strong style="color:{color}">{max(success_prob, fail_prob):.1f}%</strong> confident.
        </div>
    </div>
    """, unsafe_allow_html=True)

    # Score cards
    c1, c2, c3 = st.columns(3)
    cards = [
        ("Success Probability", f"{success_prob:.1f}%", "#4ade80"),
        ("Failure Probability", f"{fail_prob:.1f}%",    "#f87171"),
        ("Confidence",          f"{max(success_prob, fail_prob):.1f}%",
         "#4ade80" if max(success_prob, fail_prob) >= 75 else "#f5c518"),
    ]
    for col, (lbl, val, clr) in zip([c1, c2, c3], cards):
        with col:
            st.markdown(f"""
            <div class="metric-box">
                <div class="metric-label">{lbl}</div>
                <div class="metric-value" style="color:{clr};">{val}</div>
            </div>""", unsafe_allow_html=True)

    # Probability bar
    st.markdown('<div class="section-header">📊 Probability Breakdown</div>', unsafe_allow_html=True)
    prob_df = pd.DataFrame({
        "Outcome":     ["✅ Successful", "❌ Not Successful"],
        "Probability": [success_prob / 100, fail_prob / 100],
    })
    st.bar_chart(prob_df.set_index("Outcome"), color=["#4ade80"], height=200)

    # Feature importances
    st.markdown('<div class="section-header">🔍 Key Factors (Feature Importances)</div>', unsafe_allow_html=True)
    importances = pd.Series(
        model.feature_importances_, index=model.feature_names_in_
    ).sort_values(ascending=False).head(10)
    importances.index = [i.replace("Aniimation", "Animation") for i in importances.index]
    st.bar_chart(importances, color=["#60a5fa"], height=280)

    # Input summary
    with st.expander("📋 View Input Summary"):
        summary = {
            "Year": year, "Runtime (min)": runtime, "IMDb Rating": rating,
            "Votes": f"{votes:,}", "Revenue ($M)": f"${revenue:.1f}M",
            "Metascore": metascore, "Genres": ", ".join(selected_genres) or "None",
        }
        for k, v in summary.items():
            a, b = st.columns([1, 2])
            a.markdown(f"**{k}**")
            b.markdown(str(v))

# ── Footer ────────────────────────────────────────────────────────────────────
st.divider()
st.caption("Model: Random Forest Classifier  |  Features: 26  |  Target: Movie Success (0 / 1)")