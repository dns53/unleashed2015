--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.9
-- Dumped by pg_dump version 9.3.9
-- Started on 2015-07-05 15:26:08 ACST

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
-- TOC entry 245 (class 1259 OID 25096)
-- Name: question; Type: TABLE; Schema: public; Owner: govhack; Tablespace: 
--

CREATE TABLE question (
    id integer DEFAULT nextval('question_seq'::regclass) NOT NULL,
    category integer,
    question text,
    source text,
    higher character(1),
    data_source text,
    datasa_url text
);


ALTER TABLE public.question OWNER TO govhack;

--
-- TOC entry 3571 (class 0 OID 25096)
-- Dependencies: 245
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: govhack
--

COPY question (id, category, question, source, higher, data_source, datasa_url) FROM stdin;
9	3	Who has the most road crashes in their area?	suburb_v_crash	L	SA DPTI	https://data.sa.gov.au/data/dataset/road-crash-data
5	1	Who has the most public shools nearby?	\N	H	SA DECD	https://data.sa.gov.au/data/dataset/south-australian-government-education-and-child-development-sites-and-services-as-at-march-2015
3	1	Who has the most people with a HECS debt?	suburb_v_numhecs	L	ATO	http://data.gov.au/dataset/taxation-statistics-2012-13
4	1	Who has the most amount of HECS debt still owing?	suburb_v_valhecs	L	ATO	http://data.gov.au/dataset/taxation-statistics-2012-13
17	2	Who has the most nearby community organisations?	suburb_v_org	H	Unleashed Industry & Community	https://data.sa.gov.au/data/dataset/south-australian-community-services-directory
1	3	Who has more roads?	suburb_v_roads	L	SA DPTI	https://data.sa.gov.au/data/dataset/roads
16	6	Who has the most people with a HECS debt?	suburb_v_numhecs	H	ATO	http://data.gov.au/dataset/taxation-statistics-2012-13
6	5	Who has the nearest public jetty?	\N	H	SA DPTI	https://data.sa.gov.au/data/dataset/jetties
7	4	Who has the most long waits at their neartest major hospital?	\N	L	SA Health	https://data.sa.gov.au/data/dataset/sa-health-emergency-department-4-hour-length-of-stay
8	6	Who has the most people that earned salary or wages in 2013?	suburb_v_nuwages	H	ATO	http://data.gov.au/dataset/taxation-statistics-2012-13
13	7	Who has the cleanest air?	\N	H	SA EPA	https://data.sa.gov.au/data/dataset/air-quality-index
14	6	Who has the closest major hospital?	\N	H	SA DHA	https://data.sa.gov.au/data/dataset/a48c54cf-f276-409b-b934-faeba4a85278
15	7	Who has the most recycling locations?	\N	H	SA EPA	https://data.sa.gov.au/data/dataset/collection-depots
2	1	Who has the highest education level?	\N	H	\N	\N
10	5	Who has the most playgrounds in their local council area?	playground_res	H	PAE	https://data.sa.gov.au/data/dataset/playgrounds-pae
11	2	Who has the most playgrounds in their local council area?	playground_res	H	ACC	https://data.sa.gov.au/data/dataset/park-land-playgrounds
12	5	Who has the most community facilites available for hire from public schools?	suburb_v_facility	H	SA DECD	https://data.sa.gov.au/data/dataset/south-australian-government-school-facilities-available-for-community-use-as-at-july-2015
\.


--
-- TOC entry 3447 (class 2606 OID 25104)
-- Name: question_pkey; Type: CONSTRAINT; Schema: public; Owner: govhack; Tablespace: 
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


-- Completed on 2015-07-05 15:26:11 ACST

--
-- PostgreSQL database dump complete
--

