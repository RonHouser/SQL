SELECT*
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	ORDER BY 3,4

--SELECT*
--	FROM [COVID Stats]..[CovidVaccinations]
--	ORDER BY 3,4

--Select Data that we will be using.

SELECT location, date, total_cases, new_cases,	total_deaths, population
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	ORDER BY 1,2

--Looking at Total Cases vs. Total Deaths.
--Shows likelyhood of dying if you contract COVID in your country.

SELECT location, date, total_cases,	total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
	FROM [COVID Stats]..[CovidDeaths]
	WHERE location LIKE '%states%' AND continent IS NOT Null
	ORDER BY 1,2

--Looking at Total Cases vs. Population.

SELECT location, date, total_cases,	population, (total_cases/population)*100 AS PercentPopulationInfected
	FROM [COVID Stats]..[CovidDeaths]
	WHERE location LIKE '%states%' AND continent IS NOT Null
	ORDER BY 1,2

--Looking at Countries with highest Infection Rates compared to populations.

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	GROUP BY location, population
	ORDER BY PercentPopulationInfected desc

--Showing Countries with highest deathcount per population.

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	GROUP BY location
	ORDER BY TotalDeathCount desc

--Let's break things down by continent

--Showing the continents with the highest death count per population.

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null 
	GROUP BY continent
	ORDER BY TotalDeathCount desc

--Global Numbers.

SELECT SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS INT)) AS TotalDeaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
	FROM [COVID Stats]..[CovidDeaths]
	WHERE continent IS NOT Null
	ORDER BY 1,2


--Looking at Total population vs Vaccinations.

SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations, 
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
--(RollingPeopleVaccinated/dea.population)*100
	FROM [COVID Stats]..[CovidDeaths] AS dea
	JOIN [COVID Stats]..[CovidVaccinations] AS vac
		ON dea.location=vac.location 
			AND dea.date=vac.date
	WHERE dea.continent IS NOT Null
	ORDER BY 2,3

--USE CTE

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

--Temp Table
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

-- Creating View to store data for lata visualizations.

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
