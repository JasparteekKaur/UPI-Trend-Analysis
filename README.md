#  UPI Usage Analysis Dashboard (2021–2024)

This project delivers a data-driven exploration of India’s digital payment landscape through UPI (Unified Payments Interface) statistics. Using **Python, SQL, and Power BI**, it reveals transaction behavior, adoption trends, and event-driven spikes and dips in digital payments.

##  Objective

To analyze monthly UPI transaction trends and uncover actionable insights related to consumer behavior, value growth, and seasonal payment shifts.

## Tools & Technologies

- **Python (Selenium + BeautifulSoup)** – For web scraping raw UPI data from [NPCI](https://www.npci.org.in).
- **SQL** – For data cleaning, transformation, and feature creation.
- **Power BI** – For building interactive dashboards with dynamic visuals and annotations.
- **Excel** – For intermediate data formatting and validation.

## 🗂 Project Workflow

### 1. Data Extraction (Python)
- Automated web scraping pipeline using `Selenium` and `BeautifulSoup` to extract monthly UPI statistics directly from NPCI’s website.

### 2. Data Preparation (SQL)
- Cleaned raw data and structured it for analysis.
- Created new columns:
  - `Month_Year` and `MonthNumber` (for accurate sorting)
  - `Average Ticket Size` = Value ÷ Volume
  - `MoM Growth %` for both **Volume** and **Value**

### 3. Dashboarding (Power BI)
- Built **dual-axis combo charts** for Value and Volume trends.
- Added **chart annotations** for significant economic/tech events (like RBI guidelines, UPI Lite launches, festive surges).
- Visualized:
  - Monthly growth
  - Quarterly performance
  - Drop-off anomalies
  - Seasonal usage trends
  - 
##  Key Insights

- **₹98.3T+ total value** transacted across **60.8M+ UPI transactions**
- ⬇ **Average Ticket Size** consistently declined, highlighting widespread micro-payments and increased usage for small purchases
- Major spikes observed during festive seasons (Diwali, year-end bonuses)
- Notable dips (e.g., Feb 2023) explained via less days and budget effect
- Huge decline in Nov 2024 despite UPI Lite upgrades. They didn’t instantly reflect in transaction value—indicating phased adoption or smaller value caps. 


## Notable Features

- Automated data sourcing (Python scraping)
- Dual-axis trend visualization (Volume + Value)
- Interactive tooltips with real-world event explanations
- MoM growth logic built using DAX in Power BI
- Comparative views for quarters and years


##  Screenshots

> *(Insert dashboard screenshots here: combo chart, MoM growth graph with annotations, etc.)*

## Future Improvements

- Integrate real-time API-based data updates
- Extend to include bank-wise or region-wise trends
- Forecast future UPI growth using time series modeling

## Author

**Jasparteek Kaur**  
Engineering Student | Data & Product Analyst Enthusiast  
Passionate about digital finance, consumer payments, and using data to drive product innovation.




