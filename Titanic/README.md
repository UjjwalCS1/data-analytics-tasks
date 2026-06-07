# 🚢 Titanic Exploratory Data Analysis (EDA)

## 📌 Overview

This project performs Exploratory Data Analysis (EDA) on the famous Titanic dataset from Kaggle. The objective is to understand passenger demographics, identify patterns affecting survival, handle missing values, and visualize relationships between features.

## 📂 Dataset

The dataset contains information about passengers aboard the Titanic, including:

| Feature     | Description                       |
| ----------- | --------------------------------- |
| PassengerId | Unique passenger identifier       |
| Survived    | Survival status (0 = No, 1 = Yes) |
| Pclass      | Ticket class                      |
| Name        | Passenger name                    |
| Sex         | Gender                            |
| Age         | Age of passenger                  |
| SibSp       | Number of siblings/spouses aboard |
| Parch       | Number of parents/children aboard |
| Ticket      | Ticket number                     |
| Fare        | Ticket fare                       |
| Cabin       | Cabin number                      |
| Embarked    | Port of embarkation               |

**Target Variable:** `Survived`

---

## 🛠️ Technologies Used

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* Jupyter Notebook

---

## 📊 Exploratory Data Analysis

### Data Inspection

* Dataset shape
* Data types
* Statistical summary
* Missing value analysis

### Data Cleaning

* Filled missing values in **Age** using median
* Filled missing values in **Embarked** using mode

### Correlation Analysis

* Correlation matrix
* Heatmap visualization

### Visualizations

* Pair Plot
* Correlation Heatmap
* Age Distribution Histogram
* Fare vs Survival Box Plot
* Age vs Fare Scatter Plot
* Count Plots for:

  * Survival Status
  * Passenger Class
  * Gender
  * Embarked Port

---

## 📈 Key Insights

* Female passengers had a significantly higher survival rate.
* First-class passengers were more likely to survive than lower classes.
* Younger passengers showed slightly better survival rates.
* Fare and passenger class exhibited relationships with survival probability.
* Missing values were primarily found in Age and Embarked columns.

---

## 🚀 Getting Started

### Clone the Repository

```bash
git clone https://github.com/your-username/titanic-eda.git
cd titanic-eda
```

### Install Dependencies

```bash
pip install pandas numpy matplotlib seaborn
```

### Run the Notebook

```bash
jupyter notebook titanic.ipynb
```

---

## 📁 Project Structure

```text
Titanic-EDA/
│
├── titanic.ipynb
├── train.csv
├── README.md
```

---

## 🎯 Learning Outcomes

This project demonstrates:

* Data preprocessing techniques
* Handling missing values
* Exploratory Data Analysis (EDA)
* Data visualization using Seaborn and Matplotlib
* Extracting actionable insights from data

---
---

## 📜 License

This project is for educational and learning purposes.

---
