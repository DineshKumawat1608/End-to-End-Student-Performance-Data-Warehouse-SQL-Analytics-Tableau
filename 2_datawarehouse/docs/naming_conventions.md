# **Naming Conventions**

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.

## **Table of Contents**

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Rules](#bronze-rules)
   - [Silver Rules](#silver-rules)
   - [Gold Rules](#gold-rules)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedure Naming Conventions](#stored-procedure-naming-conventions)

---

## **General Principles**

- **Naming Convention:** Use snake_case with lowercase letters and underscores (`_`) to separate words.
- **Language:** Use English for all object names.
- **Avoid Reserved Words:** Do not use SQL reserved words as object names.

---

## **Table Naming Conventions**

### **Bronze Rules**

- Bronze tables store raw data exactly as received from the source files.
- Table names must match the original source entity names without renaming.

- **`<entity>`**
  - `<entity>`: Original dataset entity name.
  - Examples:
    - `attendance`
    - `homework`
    - `performance`
    - `students`
    - `teacher_parent_communication`

---

### **Silver Rules**

- Silver tables retain the same entity names as the Bronze layer after data cleansing and standardization.

- **`<entity>`**
  - `<entity>`: Original dataset entity name.
  - Examples:
    - `attendance`
    - `homework`
    - `performance`
    - `students`
    - `teacher_parent_communication`

---

### **Gold Rules**

- Gold objects use meaningful business-aligned names following the Star Schema.

- **`<category>_<entity>`**
  - `<category>`: Describes the role of the object, such as `dim` (dimension) or `fact` (fact table).
  - `<entity>`: Business entity represented by the object.
  - Examples:
    - `dim_students`
    - `dim_subjects`
    - `fact_attendance`
    - `fact_homework`
    - `fact_performance`
    - `fact_teacher_parent_communication`

#### **Glossary of Category Patterns**

| Pattern | Meaning | Example(s) |
|----------|---------|------------|
| `dim_` | Dimension view | `dim_students`, `dim_subjects` |
| `fact_` | Fact view | `fact_attendance`, `fact_homework`, `fact_performance` |

---

## **Column Naming Conventions**

### **Surrogate Keys**

- All surrogate keys in dimension views must use the suffix `_key`.

- **`<entity>_key`**
  - `<entity>`: Name of the business entity.
  - `_key`: Indicates a surrogate key.
  - Examples:
    - `student_key`
    - `subject_key`

---

### **Technical Columns**

- All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.

- **`dwh_<column_name>`**
  - `dwh`: Prefix exclusively for system-generated metadata.
  - `<column_name>`: Descriptive name indicating the column's purpose.
  - Example:
    - `dwh_create_date`

---

## **Stored Procedure Naming Conventions**

- All stored procedures used for loading data must follow the naming pattern:

- **`load_<layer>`**

  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.
  - Example: 
    - `load_bronze` → Stored procedure for loading data into the Bronze layer.
    - `load_silver` → Stored procedure for loading data into the Silver layer.
