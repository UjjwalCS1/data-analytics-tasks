# Customer Personality Analysis

## Project Overview

This project performs Customer Personality Analysis using marketing campaign data. The objective is to understand customer demographics, purchasing behavior, and campaign responses to help businesses improve marketing strategies and customer targeting.

## Dataset

The dataset contains customer information such as:

* Demographic details

  * Year of Birth
  * Education
  * Marital Status
  * Income

* Household Information

  * Number of Children
  * Number of Teenagers

* Purchase Behavior

  * Wine Products
  * Fruits
  * Meat Products
  * Fish Products
  * Sweet Products
  * Gold Products

* Marketing Campaign Responses

  * Accepted Campaigns
  * Complaints
  * Web Purchases
  * Store Purchases
  * Catalog Purchases

## Technologies Used

* Python
* NumPy
* Pandas
* Jupyter Notebook

## Data Preprocessing

The following preprocessing steps were performed:

1. Loaded the marketing campaign dataset.
2. Converted column names to lowercase format.
3. Handled missing values in the `income` column using mean imputation.
4. Converted customer enrollment dates to datetime format.
5. Removed duplicate records.
6. Created an `age` feature from the birth year.
7. Handled age outliers by replacing unrealistic values with the median age.

## Project Workflow

1. Data Collection
2. Data Cleaning
3. Feature Engineering
4. Exploratory Data Analysis (EDA)
5. Customer Behavior Analysis
6. Insights Generation

## Key Features

* Customer demographic analysis
* Income distribution analysis
* Age-based customer segmentation
* Campaign response analysis
* Purchase pattern identification
* Data quality improvement through preprocessing

## Installation

Clone the repository:

```bash
git clone https://github.com/UjjwalCS1/data-analysis-tasks
```

Install dependencies:

```bash
pip install -r requirements.txt
```

## Usage

Run the Jupyter Notebook:

```bash
jupyter notebook customeranalysis.ipynb
```

## Project Structure

```text
├── customeranalysis.ipynb
├── marketing_campaign.csv
├── requirements.txt
├── README.md
```

## Author

Ujjwal Kumar

## License

This project is intended for educational and learning purposes.
