/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-30';
SELECT name FROM animals WHERE neutered='t' AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name IN ('Augmon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered='t';
SELECT * FROM animals WHERE NOT name='Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.Then roll back the change
-- and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

-- update species in a transaction
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'digimon'
WHERE name NOT LIKE '%mon';
COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Delete all animals born after Jan 1st 2022
BEGIN;
DELETE FROM animals
WHERE date_of_birth >= '2022-01-01';

--Create savepoint and multipy all weights by -1
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * (-1);
ROLLBACK TO sp1;

-- update animals with negative weight to be positive by multiplying -1
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;

-- Count number of animals
SELECT COUNT(*) FROM animals;

-- count animals with no escape attempts
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

--minimum and maximum weight
SELECT MIN(weight_kg) FROM animals;
SELECT MAX(weight_kg) FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

SELECT date_of_birth, AVG(escape_attempts) FROM animals
GROUP BY date_of_birth
HAVING date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-30';
