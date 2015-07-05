--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.9
-- Dumped by pg_dump version 9.3.9
-- Started on 2015-07-05 11:51:33 ACST

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
-- TOC entry 247 (class 1259 OID 25335)
-- Name: state_postcode_rules; Type: TABLE; Schema: public; Owner: govhack; Tablespace: 
--

CREATE TABLE state_postcode_rules (
    state character varying(3),
    min integer,
    max integer
);


ALTER TABLE public.state_postcode_rules OWNER TO govhack;

--
-- TOC entry 3507 (class 0 OID 25335)
-- Dependencies: 247
-- Data for Name: state_postcode_rules; Type: TABLE DATA; Schema: public; Owner: govhack
--

COPY state_postcode_rules (state, min, max) FROM stdin;
ACT	2600	2618
ACT	2900	2920
NSW	2000	2599
NSW	2619	2899
NSW	2921	2999
NT	800	899
QLD	4000	4999
SA	5000	5999
TAS	7000	7799
VIC	3000	3999
WA	6000	6797
\.


-- Completed on 2015-07-05 11:51:36 ACST

--
-- PostgreSQL database dump complete
--

