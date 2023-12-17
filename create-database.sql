-- MySQL
CREATE DATABASE db;

-- OR
CREATE SCHEMA db;

-- PostgreSQL
-- Database and schema is same in MySQL
-- 
-- A new database will always have public schema by default.
create database db;

-- This will create a new schema inside existing database which will sit along side a public schema.
create schema db;