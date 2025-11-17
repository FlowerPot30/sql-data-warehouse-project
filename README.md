# Data Warehouse Project
This project demonstrates a comprehensive **Data Warehousing** solution. The overall approach is inspired by the video created by [Data with Baraa](https://www.youtube.com/watch?v=9GVqKuTVANE&t=3963s). However, the dataset used in this project is different from the one in the video. Only the concept, architecture, and methodology from the video were adapted and applied to this project.

---

## 🏗️ Data Architecture
The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:
![Untitled Diagram](https://github.com/user-attachments/assets/ebaed7ff-e04b-4608-974f-3fbc8fe372e8)
  1. **Bronze Layer**: Stores raw data exactly as received from the source systems.  
   In this project, data is ingested from CSV files into a SQL Server database.  
   The dataset used is the **Brazilian E-Commerce Public Dataset by Olist**, available on Kaggle:  
   [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
  2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
  3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.
     
---

## 🏆 Project Overview 
This project involves:
  1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver** and **Gold** layers.
  2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
  3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.

---

## ⚙️ Links & Tools:
  - **Datasets**: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
  - **SQL Server Express**: server for hosting SQL database.
  - **SQL Server Management Studio (SSMS)**: GUI for managing and interacting with database.
  - **Draw.io**: Design data architecture, models, flows, and diagrams.

---

## 📖 Project Requirements
### Building the Data Warehouse (Data Engineering)

### Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

### Specifications
  - **Data Sources**: Data from three source systems (ERP, CRM, OMS) provided as CSV files.
  - **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
  - **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
  - **Scope**: Focus on the latest dataset only; historization of data is not required.

---

## 📂 Repository Structure
```bash
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file shows all different techniquies and methods of ETL
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
└── README.md                           # Project overview and instructions
```

---


