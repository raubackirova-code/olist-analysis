E-commerce Analysis
Project Overview

This project analyzes transactional data from the Brazilian e-commerce platform Olist.

The goal is to explore sales structure, customer segments, product categories, and seller contribution to revenue in order to identify business growth opportunities and optimize operational decisions.

This project was completed as part of my Data Analytics portfolio.

Business Objectives

1. Identify the target customer segments and determine their contribution to total revenue.
2. Determine the most profitable product categories to optimize inventory and logistics.
3. Evaluate seller performance and identify top-performing sellers.
4. Analyze revenue structure both overall and in dynamics.

Dataset

The dataset contains real transactional data including:
customers
orders
order_items
products

Data source: Olist Brazilian E-commerce Dataset.

Key fields used:
customer_id
order_id
product_id

Tools & Technologies
Python
Pandas
NumPy
Matplotlib / Seaborn
Jupyter Notebook

Key techniques used:
Data cleaning
Merging multiple tables
GroupBy & Aggregations
Revenue calculations
Customer segmentation
Category contribution analysis
Visualization

Data Preparation
Tables were merged in the following order:
customers + orders (by customer_id)
Result + order_items (by order_id)
Result + products (by product_id)

Revenue was calculated as:
Revenue = price + freight_value

Key Findings
Customer Segmentation
Customers were segmented into:
Gold
Silver
Regular

Findings:
Gold + Silver segments generate 53.5% of total revenue
Regular segment represents 80% of the customer base, generating 46.5% of revenue

Interpretation:
High-value customers require retention strategies (loyalty programs).
Large Regular segment indicates strong brand awareness and market presence.

Product Category Analysis
Top revenue-generating categories:
health_beauty
watches_gifts

Other high-contribution categories:
bed_bath_table
computers_accessories

Interpretation:
Leading categories have growth potential.
Seasonal demand patterns must be considered in logistics and inventory planning.

Seller Performance
Revenue distribution among sellers shows performance concentration.

Business implication:
Top sellers can be incentivized.
Medium performers can be stimulated.
Low performers require strategic evaluation.

Business Recommendations

Customer Strategy
Implement loyalty programs for Gold & Silver customers.
Develop marketing strategies targeting Regular customers to increase average order value.

Category Strategy
Expand assortment in top-performing categories.
Monitor seasonal demand in high-volume segments.

Seller Strategy
Create performance-based reward system.
Develop performance improvement program for mid-tier sellers.

Project Structure
olist-analysis/
│
├── data/
├── notebooks/
│   └── olist_analysis.ipynb
├── images/
├── README_RU.md
├── README_EN.md
└── requirements.txt

What This Project Demonstrates
Ability to work with relational datasets
Understanding of business-oriented analytics
Revenue structure analysis
Segmentation logic
Clear business interpretation of data
Structured project presentation

About Me

Junior+ Data Analyst
Skills: Python (Pandas) junior, SQL middle, Data Visualization Matplotlib junior
Open to freelance and junior opportunities.