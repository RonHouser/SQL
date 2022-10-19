/*

Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

SELECT*
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	ORDER BY 3,4


--Select Data that we will be using

SELECT location, date, total_cases, new_cases,	total_deaths, population
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	ORDER BY 1,2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases,	total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
	FROM [COVID Stats]..[CovidDeaths]
	WHERE location LIKE '%states%' AND continent IS NOT Null
	ORDER BY 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT location, date, total_cases,	population, (total_cases/population)*100 AS PercentPopulationInfected
	FROM [COVID Stats]..[CovidDeaths]
	WHERE location LIKE '%states%' AND continent IS NOT Null
	ORDER BY 1,2


-- Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	GROUP BY location, population
	ORDER BY PercentPopulationInfected desc


-- Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	GROUP BY location
	ORDER BY TotalDeathCount desc


-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null 
	GROUP BY continent
	ORDER BY TotalDeathCount desc


-- GLOBAL NUMBERS

SELECT SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS INT)) AS TotalDeaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	ORDER BY 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations, 
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--(RollingPeopleVaccinated/dea.population)*100
	FROM [COVID Stats]..[CovidDeaths] AS dea
	JOIN [COVID Stats]..[CovidVaccinations] AS vac
		ON dea.location=vac.location 
			AND dea.date=vac.date
	WHERE dea.continent IS NOT Null
	ORDER BY 2,3


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [COVID Stats]..[CovidDeaths] dea
Join [COVID Stats]..[CovidVaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac
Order By RollingPeopleVaccinated desc


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [COVID Stats]..[CovidDeaths] dea
Join [COVID Stats]..[CovidVaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating Views to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [COVID Stats]..[CovidDeaths] dea
Join [COVID Stats]..[CovidVaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3

CREATE VIEW PopVsVac AS
SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations, 
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--(RollingPeopleVaccinated/dea.population)*100
	FROM [COVID Stats]..[CovidDeaths] AS dea
	JOIN [COVID Stats]..[CovidVaccinations] AS vac
		ON dea.location=vac.location 
			AND dea.date=vac.date
	WHERE dea.continent IS NOT Null
	--ORDER BY 2,3


CREATE VIEW DeathPercentages AS
SELECT location, date, total_cases,	total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
	FROM [COVID Stats]..[CovidDeaths]
	WHERE location LIKE '%states%' AND continent IS NOT Null
	--ORDER BY 1,2
