
# COVID-19 Tableau Dashboard 

### Dataset 
The COVID-19 deaths Excel file contains data on the location, continent, cases, new cases, deaths, new deaths, and other information regarding the hospitalization rate. 

The COVID-19 vaccination Excel file contains data on the location, continent, tests, new tests, vaccinations,  new vaccinations, and other information regarding demographics. 

<br> Spreadsheets from Our World In Data
<br>Covid Death Data (https://ourworldindata.org/covid-deaths)
<br>Covid Vaccination Data (https://ourworldindata.org/covid-vaccinations)


### Queries
The file SQL_COVID_PORTFOLIO showcases a variety of queries to display the data in both tables. 
It includes:
- Displaying the full tables ordered by location and date.
- The total cases, deaths, and death percentage over time in the U.S.
- The infection rate to population in the descending order of location.
- The death count in each continent in descending order of continent.
- The cumulative cases, deaths, and death percentage in the world.

Using the death and vaccination tables, the two tables can be joined with the location on the vaccination table as the primary key and the location on the death table as the foreign key. To accomplish the following:
- Comparing the total population to vaccinations
- Creating a temp table and inserting data to be used in the visualization tool Tableau.


### Visualization
Using the exported SQL data as an Excel file, it can then be imported into Tableau. The Tableau dashboard displays the following data 
- Total cases, total deaths, and the death percentage as of February 20th, 2023.
- The total percent populated infected as a heat map.
- The death count by each continent.
- The percent population infected using actual and forecasted data of the following countries: Canada, China, India, Mexico, the United Kingdom, and the United States. 

![image](https://user-images.githubusercontent.com/123119481/222032662-7ebec862-e11c-4534-a99d-da443d7d2ea6.png)

Tableau Dashboard (https://public.tableau.com/app/profile/daniel7724/viz/Covid19Project_16774359919870/Dashboard1#1)

