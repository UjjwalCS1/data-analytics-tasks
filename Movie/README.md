# 🎬 Movie Success Classifier

Predicts whether a movie will be **Successful** or **Not Successful** based on metadata (year, runtime, rating, votes, revenue, Metascore) and genre, using a tuned Random Forest model. Includes an interactive Streamlit app for live predictions.

## Project Structure

```
.
├── app.py                          # Streamlit web app
├── best_model.pkl                  # Trained Random Forest model (pickled)
├── movie_success_classifier.ipynb  # Data analysis & model training notebook
├── movie_success_rate.csv          # Source dataset (839 movies)
└── README.md
```

## Dataset

`movie_success_rate.csv` contains 839 movies with 33 original columns, including:

- **Metadata:** Title, Director, Actors, Year, Runtime, Rating, Votes, Revenue, Metascore
- **Genre flags:** 20 binary columns (Action, Comedy, Drama, Horror, Sci-Fi, etc.)
- **Target:** `Success` (0 = Not Successful, 1 = Successful)

After cleaning (dropping text columns, filling missing numerics with the median), the model uses **26 features** across 838 rows.

## Model

Six classifiers were trained and compared with 5-fold stratified cross-validation:

| Model | CV AUC | Test Accuracy | Test AUC |
|---|---|---|---|
| Gradient Boosting | 0.9917 | 1.0000 | 1.0000 |
| **Random Forest (selected)** | 0.9993 | 1.0000 | 1.0000 |
| Decision Tree | 0.9678 | 0.9881 | 0.9928 |
| SVM | 0.9638 | 0.9286 | 0.9618 |
| Logistic Regression | 0.9630 | 0.9226 | 0.9514 |
| KNN | 0.8906 | 0.8810 | 0.8700 |

**Random Forest** was selected and tuned with `GridSearchCV`:

- Best params: `n_estimators=100`, `max_depth=None`, `max_features="sqrt"`, `min_samples_split=5`, `class_weight="balanced"`
- Top predictive features: Revenue, Votes, Rating, Metascore

The full workflow (EDA, preprocessing, model comparison, tuning, and saving) is in `movie_success_classifier.ipynb`.

## Running the App

### 1. Install dependencies

```bash
pip install streamlit pandas numpy scikit-learn
```

### 2. Run

Make sure `best_model.pkl` is in the same directory as `app.py`, then:

```bash
streamlit run app.py
```

This opens the app in your browser (default: `http://localhost:8501`).

### 3. Using the app

1. Enter movie details — Year, Runtime, IMDb Rating, Votes, Revenue, Metascore.
2. Select one or more Genres.
3. Click **Predict Success**.
4. View the verdict (Successful / Not Successful), confidence scores, probability breakdown, and top feature importances.

## Notes / Limitations

- The dataset is imbalanced (~82% Not Successful), so AUC and per-class precision/recall are more meaningful than raw accuracy.
- Near-perfect test scores suggest possible target leakage, since Revenue and Votes may be partially definitional of "success." Validate on an independent dataset before any production use.

## Tech Stack

Python · pandas · scikit-learn · Streamlit
