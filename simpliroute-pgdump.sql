--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: _Visits; Type: TABLE; Schema: public; Owner: dkottow
--

CREATE TABLE public."_Visits" (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    address character varying(4000),
    planned_date date
);


ALTER TABLE public."_Visits" OWNER TO dkottow;

--
-- Name: TABLE "_Visits"; Type: COMMENT; Schema: public; Owner: dkottow
--

COMMENT ON TABLE public."_Visits" IS 'Store SimpliRoute Visit objects';


--
-- Name: Visits; Type: VIEW; Schema: public; Owner: dkottow
--

CREATE VIEW public."Visits" WITH (security_barrier='false') AS
 SELECT "_Visits".id,
    "_Visits".title,
    "_Visits".address,
    "_Visits".planned_date
   FROM public."_Visits";


ALTER TABLE public."Visits" OWNER TO dkottow;

--
-- Name: Visits_id_seq; Type: SEQUENCE; Schema: public; Owner: dkottow
--

CREATE SEQUENCE public."Visits_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Visits_id_seq" OWNER TO dkottow;

--
-- Name: Visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dkottow
--

ALTER SEQUENCE public."Visits_id_seq" OWNED BY public."_Visits".id;


--
-- Name: _Visits id; Type: DEFAULT; Schema: public; Owner: dkottow
--

ALTER TABLE ONLY public."_Visits" ALTER COLUMN id SET DEFAULT nextval('public."Visits_id_seq"'::regclass);


--
-- Data for Name: _Visits; Type: TABLE DATA; Schema: public; Owner: dkottow
--

COPY public."_Visits" (id, title, address, planned_date) FROM stdin;
1	Sodimac La Reina	\N	2018-08-06
2	Parque Arauco	\N	2018-08-10
3	Municipalidad de Las Condes	\N	2018-08-06
4	Foo	Bar	2018-10-03
5	Plaza de Armas	\N	2018-08-04
6	Foo	Bar	2018-10-03
7	Plaza de Armas	\N	2018-08-04
8	dada	\N	2018-08-04
9	dada	\N	2018-08-04
10	Soprole Ñuñoa	\N	2018-08-08
11	Soprole Ñuñoa	\N	2018-08-08
12	Soprole Los Angeles	\N	2018-09-08
13	Soprole Los Angeles	\N	2018-09-08
14	Soprole Rancagua	\N	2018-09-08
15	Soprole Temuco	\N	2018-09-08
16	Soprole Temuco	\N	2018-09-08
17	Soprole Valdivia	\N	2018-09-08
18	Soprole Valdivia	\N	2018-09-08
19	Soprole Concepción	\N	2018-09-08
20	Soprole Concepción	\N	2018-09-08
21	123	\N	2018-09-08
22	123	\N	2018-09-08
23	Test	\N	1999-01-01
24	Odisssey	\N	2001-01-01
25	Odisssey	\N	2001-01-01
26	Mama	\N	2018-09-08
27	Mom	\N	2015-09-08
28	Dad	\N	2016-09-08
29	Odisssey	\N	2001-01-01
30	Ma	\N	2015-09-08
31	Pa	\N	2016-09-08
32	Odisssey	\N	2001-01-01
33	Zeuss	\N	1250-01-01
34	Olimpo	\N	1444-01-01
35	Ma	\N	2015-09-08
36	Pa	\N	2016-09-08
37	Olimpo	\N	1444-01-01
38	One	\N	2015-09-08
39	Two	\N	2016-09-08
40	Olimpo	\N	1444-01-01
\.


--
-- Name: Visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dkottow
--

SELECT pg_catalog.setval('public."Visits_id_seq"', 40, true);


--
-- Name: _Visits Visits_pkey; Type: CONSTRAINT; Schema: public; Owner: dkottow
--

ALTER TABLE ONLY public."_Visits"
    ADD CONSTRAINT "Visits_pkey" PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: dkottow
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO dkottow;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

