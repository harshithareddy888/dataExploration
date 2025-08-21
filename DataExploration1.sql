select * from PortifolioProjects..CovidDeaths$
 order by 3,4

--- select * from PortifolioProjects..CovidVaccinations$
--- order by 3,4

select date, location, total_cases, new_cases, total_deaths, population from PortifolioProjects..CovidDeaths$
order by 1,2

---Looking at the total cases vs total_deaths
--- likelihood of dying if you get covid in US 
select date, location, total_cases, total_deaths, (total_deaths/total_cases)*100 AS deathPerc 
from PortifolioProjects..CovidDeaths$
where location like '%india%'
order by 1,2

---Looking at total_cases vs population
select Location , date, total_cases, population, (total_cases/population)*100 as PopulationAvgCases
from PortifolioProjects..CovidDeaths$ 
order by 1,2

--- turns the excel sheet into sql table so its easy to fetch
SELECT *
INTO CovidDeaths
FROM PortifolioProjects..CovidDeaths$;


-- looking at countries with highest infection rate
SELECT location,
       population,
       MAX(total_cases) AS HIC,
       MAX((total_cases/population))*100 as percentPopulationInfected
FROM CovidDeaths
GROUP BY location, population
order by percentPopulationInfected desc


select * from PortifolioProjects..CovidDeaths$
where continent is not null order by 3,4

-- showing countries with highest death count
SELECT location,
       max(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
where continent is not null
GROUP BY location
order by TotalDeathCount desc

--breaking down by continent
SELECT continent,
       max(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
where continent is not null
GROUP BY continent
order by TotalDeathCount desc

 --global numbers

 select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/SUM(new_cases)*100 as deathPercentage from CovidDeaths
 where continent is not null
 --group by date
 order by 1,2


 --turning the excel sheet into sql table
 SELECT *
INTO CovidVaccinations
FROM PortifolioProjects..CovidVaccinations$


--looking at total_population vs vaccinations
select dea.continent, dea.location, dea.date , dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as RollingPeopleVaccinated
--you can't use a column you just created(RollingPeopleVaccinated) so instead you use a CTE or Temp table
--,RollingPeopleVaccinated/pop
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

--USE CTE
with PopVsVac(continent, location, date, population, new_vaccinations, RollingPeopleVaccinated) as 
(select dea.continent, dea.location, dea.date , dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as RollingPeopleVaccinated
--you can't use a column you just created(RollingPeopleVaccinated) so instead you use a CTE or Temp table
--,RollingPeopleVaccinated/pop
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,34
)
select *, (RollingPeopleVaccinated/population)*100 from PopVsVac

--temp table
drop table if exists #PPV --useful if planning on making any alterations or run  it multiple times
create table #PPV
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PPV
select dea.continent, dea.location, dea.date , dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as RollingPeopleVaccinated
--you can't use a column you just created(RollingPeopleVaccinated) so instead you use a CTE or Temp table
--,RollingPeopleVaccinated/pop
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null

select *, (RollingPeopleVaccinated/Population)*100
from #PPV


--creating a view to store data for later visualizations

create View PercenPopulationVaccinated as
select dea.continent, dea.location, dea.date , dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as RollingPeopleVaccinated
--you can't use a column you just created(RollingPeopleVaccinated) so instead you use a CTE or Temp table
--,RollingPeopleVaccinated/pop
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null

select * from PercenPopulationVaccinated