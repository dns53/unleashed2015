--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.9
-- Dumped by pg_dump version 9.3.9
-- Started on 2015-07-05 11:25:52 ACST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 244 (class 1259 OID 25084)
-- Name: category; Type: TABLE; Schema: public; Owner: govhack; Tablespace: 
--

CREATE TABLE category (
    id integer DEFAULT nextval('category_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE public.category OWNER TO govhack;

--
-- TOC entry 3503 (class 0 OID 25084)
-- Dependencies: 244
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: govhack
--

COPY category (id, name) FROM stdin;
1	Education
2	Community Facilities
3	Transportation
4	Health
5	Community
6	Employment
7	Environment
8	Pets
9	Events
10	Crime
\.


--
-- TOC entry 3388 (class 2606 OID 25092)
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: govhack; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


-- Completed on 2015-07-05 11:25:56 ACST

--
-- PostgreSQL database dump complete
--

