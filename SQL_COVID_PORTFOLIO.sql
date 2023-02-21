/*
-- Author: Daniel Quach
-- Name: COVID_PORTFOLIO_PROJECT
-- Create date: 2/20/2023
-- Description: Using two Excel files gathered from ourworldindata.org,
-- the following queries explores COVID data from February 4th, 2020 to
-- February 20th, 2023. It will then be used to JOIN two tables and utilize
-- aggregates to compare total vaccinations and total populations of 
-- all countries. 

*/


--SHOW FULL TABLES ORDERED BY LOCATION & DATE 
SELECT *
FROM dbo.CovidDeaths$
order by 3,4

SELECT *
FROM dbo.CovidVaccinations$
order by 3,4

SELECT Location, date, total_cases, new_cases, total_deaths, population	
FROM dbo.CovidDeaths$
order by 1,2


-- TOTAL CASES,DEATHS, AND DEATH PERCENTAGE IN THE US OVER TIME
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM dbo.CovidDeaths$
WHERE location like '%states%'
ORDER BY 1,2

-- INFECTION RATE TO POPULATION IN DESCENDING ORDER
SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population)*100) as percent_pop_infected
FROM dbo.CovidDeaths$
Group BY Location, Population
ORDER BY percent_pop_infected desc


--DEATH COUNTS IN EACH CONTINENT IN DESCENDING ORDER
SELECT continent, max(cast(total_deaths as int)) as total_death_count
FROM dbo.CovidDeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY total_death_count desc

-- CUMULATIVE CASES, DEATHS, DEATH PERCENTAGE IN THE WORLD
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM dbo.CovidDeaths$
WHERE continent is not null 
ORDER BY 1,2


-- JOIN TWO TABLES BY LOCATION & DATE 
SELECT *
FROM dbo.CovidDeaths$ dt
JOIN dbo.CovidVaccinations$ vc
	On dt.location = vc.location
	and dt.date = vc.date


-- COMPARE TOTAL POPULATION TO VACCINATIONS 
WITH PopToVac (Continent, Location, Date, Population, New_Vaccinations, cumulative_vac)
AS
(
SELECT dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, SUM(CONVERT(bigint,vc.new_vaccinations)) OVER (Partition by dt.Location Order by 
dt.location, dt.Date) AS cumulative_vac
FROM dbo.CovidDeaths$ dt
JOIN dbo.CovidVaccinations$ vc
	ON dt.location = vc.location
	AND dt.date = vc.date
WHERE dt.continent is not null 
)
SELECT *, (cumulative_vac/Population)*100 as population_to_vac
FROM PopToVac



-- TEMP TABLE & INITIALIZE VARIABLES
DROP Table if exists PercentPopVac
CREATE Table PercentPopVac(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
cumulative_vac numeric
) 

-- INSERT DATA INTO TEMP TABLE
INSERT INTO PercentPopVac
SELECT dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, SUM(CONVERT(bigint,vc.new_vaccinations)) OVER (Partition by dt.Location Order by 
dt.location, dt.Date) AS cumulative_vac
FROM dbo.CovidDeaths$ dt
JOIN dbo.CovidVaccinations$ vc
	ON dt.location = vc.location
	AND dt.date = vc.date
WHERE dt.continent is not null 

-- DISPLAY TEMP TABLE
SELECT *, (cumulative_vac/Population)*100 as vaccinated_to_pop
FROM PercentPopVac

SELECT *
FROM PercentPopVac

