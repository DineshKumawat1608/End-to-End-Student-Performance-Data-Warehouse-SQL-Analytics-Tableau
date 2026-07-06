# End-to-End Student Performance & Attendance Data Warehouse & Analytics Project

This repository showcases an **end-to-end data analytics project** where raw educational data is transformed into meaningful academic insights using a modern data warehouse approach.

The project covers the complete analytics lifecycle — from **building a data warehouse**, performing **ETL and data modeling**, to conducting **SQL-based exploratory and advanced analysis**, and finally creating **interactive Tableau dashboards**.

Key analysis and dashboards focus on:

- **Student academic performance**
- **Attendance patterns and trends**
- **Homework completion analysis**
- **Teacher-parent communication insights**

This project is created as a **portfolio project** to demonstrate practical, industry-relevant skills in data engineering, SQL analytics, data visualization, and business intelligence.

---

# 🏗️ Data Architecture

The data architecture for this project follows the **Medallion Architecture** using **Bronze**, **Silver**, and **Gold** layers.

1. **Bronze Layer**
   - Stores raw student datasets exactly as received from CSV files.
   - No transformations are applied.

2. **Silver Layer**
   - Performs data cleaning, standardization, normalization, deduplication, and validation.
   - Produces clean and consistent datasets suitable for analytics.

3. **Gold Layer**
   - Creates business-ready dimension and fact views using a Star Schema.
   - Serves as the analytical layer for SQL analysis and Tableau dashboards.

---

# 📖 Project Overview

This project involves:

1. **Data Architecture**
   - Designing a modern data warehouse using the Medallion Architecture.

2. **ETL Pipelines**
   - Loading raw educational datasets into SQL Server and transforming them into analytical models.

3. **Data Cleaning**
   - Cleaning inconsistent values, handling missing values, standardizing formats, removing duplicates, and validating data quality.

4. **Data Modeling**
   - Developing a Star Schema consisting of dimension and fact views optimized for analytical queries.

5. **Exploratory Data Analysis (EDA)**
   - Performing database exploration, dimension analysis, date analysis, measures exploration, ranking, and magnitude analysis.

6. **Advanced SQL Analytics**
   - Conducting trend analysis, segmentation, cumulative analysis, and part-to-whole analysis using advanced SQL window functions.

7. **Dashboard Development**
   - Building interactive Tableau dashboards that provide meaningful educational insights for school management.

---

# 🚀 Project Requirements

## Building the Data Warehouse (Data Engineering)

### Objective

Develop a modern SQL Server data warehouse to consolidate educational datasets into a clean analytical model for reporting and decision-making.

### Specifications

- **Data Source:** Student Performance & Attendance CSV datasets.
- **Data Quality:** Clean inconsistent values, remove duplicates, standardize formats, and validate data.
- **Integration:** Combine multiple educational datasets into a Star Schema.
- **Documentation:** Provide complete documentation for ETL, architecture, data model, and naming conventions.

---

## Data Analysis (EDA & Advanced Analytics)

### Objective

Analyze student performance, attendance, homework completion, and teacher-parent communication data to uncover meaningful academic insights.

### Specifications

- **Exploratory Data Analysis (EDA):**
  - Database exploration
  - Dimension exploration
  - Date range exploration
  - Measures exploration
  - Magnitude analysis
  - Ranking analysis

- **Advanced Analytics**
  - Change-over-time analysis
  - Cumulative analysis
  - Data segmentation
  - Part-to-whole analysis

- **Business Insights**
  - Identify high and low-performing students.
  - Analyze attendance behavior.
  - Evaluate homework completion patterns.
  - Explore subject-level academic performance.

---

## Student Performance Dashboard

### Objective

Develop interactive Tableau dashboards that allow school administrators and educators to monitor academic performance, attendance behavior, and student engagement.



These dashboards transform raw educational data into actionable insights to support better academic planning and student success.

---

# 📂 Repository Structure

```text
SQL_P1_Student_Performance_and_Attendance
│
├── 1. data_warehouse
│   │
│   ├── 1. datasets
│   │   └── Student Performance and Attendance Dataset
│   │       ├── attendance.csv
│   │       ├── homework.csv
│   │       ├── performance.csv
│   │       ├── students.csv
│   │       └── teacher_parent_communication.csv
│   │
│   ├── 2. scripts
│   │   ├── bronze
│   │   │   ├── ddl_bronze.sql
│   │   │   └── load_bronze.sql
│   │   │
│   │   ├── silver
│   │   │   ├── ddl_silver.sql
│   │   │   ├── load_silver.sql
│   │   │
│   │   └── gold
│   │   |   └── ddl_gold.sql
│   │   |
|   |   └── init_database.sql
│   │   
│   ├── 3. tests
│   │   ├── quality_checks_silver.sql
│   │   └── quality_checks_gold.sql
│   │
│   └── 4. docs
│       ├── data_architecture.png
│       ├── data_catalog.md
│       ├── data_flow.png
│       ├── data_model.png
│       └── naming_conventions.md
│
├── 2. eda_&_advanced_analysis
│   │
│   ├── 1. datasets
│   │   ├── dim_students.csv
│   │   ├── dim_subjects.csv
│   │   ├── fact_attendance.csv
│   │   ├── fact_homework.csv
│   │   ├── fact_performance.csv
│   │   └── fact_teacher_parent_communication.csv
│   │
│   ├── 2. scripts
│   │   ├── 00_init_database.sql
│   │   ├── 01_database_exploration.sql
│   │   ├── 02_dimensions_exploration.sql
│   │   ├── 03_date_range_exploration.sql
│   │   ├── 04_measures_exploration.sql
│   │   ├── 05_magnitude_analysis.sql
│   │   ├── 06_ranking_analysis.sql
│   │   ├── 07_change_over_time_analysis.sql
│   │   ├── 08_data_segmentation.sql
│   │   ├── 09_part_to_whole_analysis.sql
│   │   └── 10_cumulative_analysis.sql
│   │
│   └── 3. docs
│       └── Project_Roadmap.pdf
│
├── 3. dashboard
│   ├── Student_Performance_Dashboard.twb
│   ├── dashboard.pdf
│   └── dashboard.png
│
├── LICENSE
└── README.md
```

---

# 🌟 About Me

Hi there! I'm **Dinesh Kumawat**.

I'm a Data Analyst passionate about transforming raw data into meaningful insights using **SQL, Python, Excel, Power BI, Tableau, and Data Engineering concepts**. I enjoy building end-to-end analytics solutions—from designing data warehouses to creating interactive dashboards that solve real business problems.

Let's connect!

**LinkedIn:**  
https://www.linkedin.com/in/dineshkumawat1608/
