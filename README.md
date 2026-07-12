# 🎓 End-to-End Student Performance & Attendance Data Warehouse & Analytics Project

This repository showcases an **end-to-end Data Engineering and Analytics project** that transforms raw educational data into meaningful academic insights using a modern data warehouse approach.

The project covers the complete analytics lifecycle—from **building a SQL Server data warehouse**, performing **ETL and data modeling**, to conducting **SQL-based exploratory and advanced analysis**, and finally creating **interactive Tableau dashboards**.

The analysis focuses on:

- Student academic performance
- Attendance patterns and trends
- Homework completion analysis
- Teacher-parent communication insights

This project demonstrates practical, industry-oriented skills in **Data Engineering, SQL Analytics, Data Warehousing, Data Visualization, and Business Intelligence**.

---

# 🏗️ Data Architecture

The project follows the **Medallion Architecture**, organizing data into **Bronze**, **Silver**, and **Gold** layers.

### 🥉 Bronze Layer
- Stores raw student datasets exactly as received from CSV files.
- No transformations are applied.

### 🥈 Silver Layer
- Performs data cleaning, standardization, validation, and deduplication.
- Produces clean and consistent datasets for analytics.

### 🥇 Gold Layer
- Creates business-ready dimension and fact views using a Star Schema.
- Serves as the analytical layer for SQL analysis and Tableau dashboards.

---

# 📖 Project Overview

This project includes:

### 1. Data Architecture
- Designing a modern data warehouse using the Medallion Architecture.

### 2. ETL Pipelines
- Loading raw educational datasets into SQL Server and transforming them into analytical models.

### 3. Data Cleaning
- Cleaning inconsistent values, handling missing data, standardizing formats, removing duplicates, and validating data quality.

### 4. Data Modeling
- Developing a Star Schema consisting of dimension and fact views optimized for analytical queries.

### 5. Exploratory Data Analysis (EDA)
- Database exploration
- Dimension exploration
- Date range exploration
- Measures exploration
- Magnitude analysis
- Ranking analysis

### 6. Advanced SQL Analytics
- Change-over-time analysis
- Cumulative analysis
- Data segmentation
- Part-to-whole analysis

### 7. Dashboard Development
- Building interactive Tableau dashboards that provide actionable insights for school administrators and educators.

---

# 🚀 Project Requirements

## Building the Data Warehouse (Data Engineering)

### Objective

Develop a modern SQL Server data warehouse to consolidate educational datasets into a clean analytical model for reporting and decision-making.

### Specifications

- **Data Source:** Student Performance & Attendance CSV datasets
- **Data Quality:** Clean inconsistent values, remove duplicates, standardize formats, and validate data
- **Integration:** Combine multiple educational datasets into a Star Schema
- **Documentation:** Provide documentation for ETL, architecture, data model, and naming conventions

---

## Data Analysis (EDA & Advanced Analytics)

### Objective

Analyze student performance, attendance, homework completion, and teacher-parent communication data to uncover meaningful academic insights.

### Specifications

#### Exploratory Data Analysis (EDA)

- Database exploration
- Dimension exploration
- Date range exploration
- Measures exploration
- Magnitude analysis
- Ranking analysis

#### Advanced Analytics

- Change-over-time analysis
- Cumulative analysis
- Data segmentation
- Part-to-whole analysis

#### Business Insights

- Identify high and low-performing students
- Analyze attendance behavior
- Evaluate homework completion patterns
- Explore subject-level academic performance
- Monitor teacher-parent communication

---

# 📊 Student Performance Dashboard

### Objective

Develop interactive Tableau dashboards that help school administrators and educators monitor academic performance, attendance, homework completion, and student engagement.

The solution consists of **three interactive dashboards** designed for different levels of academic analysis.

### 📌 Executive Overview
Provides a high-level summary of academic performance through KPI cards and interactive visualizations, including:

<img width="1250" height="800" alt="1  Executive Overview" src="https://github.com/user-attachments/assets/3222db2d-f542-4b8d-9731-c58011a075c3" />


### 📌 Student Analysis
Supports deeper academic analysis through:
<img width="1268" height="811" alt="3  Student Analysis" src="https://github.com/user-attachments/assets/a328c179-b5cd-4da8-94de-6f0d26f097c1" />


### 📌 Student Details
Provides a detailed student-level view including:
<img width="1282" height="819" alt="5  Student Summary" src="https://github.com/user-attachments/assets/75999e16-4c71-4e92-aba9-d7082f5b3362" />



### Dashboard Features

- Interactive dashboard navigation
- Expandable and collapsible filter panel
- Cross-filtering across visualizations
- Dashboard usage guide
- Clean and responsive layout

These dashboards transform educational data into actionable insights that support informed academic decision-making.

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
│   ├── Student_Performance_Dashboard.twbx
│   └── dashboard.images
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
