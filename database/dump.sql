--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: rmm_database; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE rmm_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE rmm_database OWNER TO postgres;

\connect rmm_database

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE rmm_database; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE rmm_database IS 'diploma';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: module_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.module_data (
    id integer NOT NULL,
    module_id integer NOT NULL,
    "time" timestamp without time zone,
    temperature real,
    visits integer,
    below_water_lvl boolean,
    upper_water_lvl boolean
);


ALTER TABLE public.module_data OWNER TO postgres;

--
-- Name: module_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.module_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.module_data_id_seq OWNER TO postgres;

--
-- Name: module_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.module_data_id_seq OWNED BY public.module_data.id;


--
-- Name: modules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modules (
    id integer NOT NULL,
    password text,
    address text
);


ALTER TABLE public.modules OWNER TO postgres;

--
-- Name: modules_errors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modules_errors (
    id integer NOT NULL,
    module_id integer,
    err_type text,
    create_at timestamp without time zone,
    solve_at timestamp without time zone
);


ALTER TABLE public.modules_errors OWNER TO postgres;

--
-- Name: COLUMN modules_errors.module_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.modules_errors.module_id IS 'login';


--
-- Name: modules_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modules_errors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modules_errors_id_seq OWNER TO postgres;

--
-- Name: modules_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modules_errors_id_seq OWNED BY public.modules_errors.id;


--
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modules_id_seq OWNER TO postgres;

--
-- Name: modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modules_id_seq OWNED BY public.modules.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    user_id integer,
    date timestamp without time zone,
    message text,
    type text,
    module_id integer
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: user_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_status (
    id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE public.user_status OWNER TO postgres;

--
-- Name: user_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_status_id_seq OWNER TO postgres;

--
-- Name: user_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_status_id_seq OWNED BY public.user_status.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    user_name text,
    status_id integer DEFAULT 2 NOT NULL,
    log character varying(20),
    password character varying(30)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: module_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_data ALTER COLUMN id SET DEFAULT nextval('public.module_data_id_seq'::regclass);


--
-- Name: modules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules ALTER COLUMN id SET DEFAULT nextval('public.modules_id_seq'::regclass);


--
-- Name: modules_errors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules_errors ALTER COLUMN id SET DEFAULT nextval('public.modules_errors_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: user_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_status ALTER COLUMN id SET DEFAULT nextval('public.user_status_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: module_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.module_data (id, module_id, "time", temperature, visits, below_water_lvl, upper_water_lvl) FROM stdin;
1	1	2021-05-17 19:52:45	25	\N	t	f
2	1	2021-05-17 20:23:18	25	\N	t	f
3	1	2021-05-17 20:23:46	15	\N	f	t
4	1	2021-05-17 20:24:53	15	\N	f	t
5	1	2021-05-17 20:26:20	10	\N	t	f
6	1	2021-05-17 20:28:21	10	\N	t	f
7	1	2021-05-17 20:28:53	20	\N	t	f
8	1	2021-05-17 20:30:22	20	\N	t	f
9	1	2021-05-17 20:30:45	10	\N	f	t
10	1	2021-05-17 20:38:08	10	\N	t	f
11	1	2021-05-17 20:39:54	10	\N	t	f
12	1	2021-05-17 20:46:50	10	\N	t	f
13	1	2021-05-17 20:48:57	10	14	f	t
14	1	2021-05-17 20:54:34	10	14	f	t
15	1	2021-05-17 20:57:15	10	13	f	t
16	1	2021-05-17 21:01:48	10	13	f	t
17	1	2021-05-17 21:02:36	10	13	f	t
18	1	2021-05-17 21:04:22	10	13	f	t
19	1	2021-05-20 11:35:19	10	125	f	t
20	1	2021-05-20 11:35:35	10	125	t	f
21	2	2021-05-20 11:35:47	10	125	t	f
22	2	2021-05-20 11:43:02	-20	125	f	t
23	1	2021-05-22 20:09:01	\N	\N	f	f
24	1	2021-05-22 20:12:33	\N	\N	f	f
25	1	2021-05-22 20:14:12	\N	\N	f	f
26	1	2021-05-22 20:15:02	\N	\N	f	f
27	1	2021-05-22 20:15:23	\N	\N	f	f
28	1	2021-05-22 20:15:53	\N	\N	f	f
29	1	2021-05-22 20:16:23	\N	\N	f	f
30	1	2021-05-22 20:16:35	\N	\N	f	f
31	1	2021-05-22 20:17:48	\N	\N	f	f
32	1	2021-05-22 20:18:47	\N	\N	f	f
33	1	2021-05-22 20:24:45	\N	\N	t	t
34	1	2021-05-22 20:24:56	20	120	t	t
35	1	2021-05-22 20:34:35	\N	\N	f	f
36	1	2021-05-23 13:50:51	10	125	t	f
37	2	2021-05-23 13:51:02	25	102	f	t
38	3	2021-05-23 13:51:18	-10	5	t	t
39	1	2021-05-25 14:12:20	20	1	f	f
40	1	2021-05-25 14:12:51	20	1	f	f
41	1	2021-05-25 14:13:24	\N	\N	f	f
42	1	2021-05-25 14:17:15	20	200	t	f
43	1	2021-05-25 14:17:31	20	200	t	t
44	1	2021-05-25 14:36:12	10	15	t	f
45	1	2021-05-25 14:40:07	10	15	t	f
46	1	2021-05-25 14:40:16	10	15	t	f
47	1	2021-05-25 14:40:41	\N	\N	f	f
48	1	2021-05-25 14:40:44	\N	\N	f	f
49	1	2021-05-25 14:41:02	20	1	t	f
50	1	2021-05-25 14:42:53	20	12	t	f
51	1	2021-05-25 14:47:02	20	12	t	f
52	1	2021-05-25 14:48:20	20	20	t	f
53	1	2021-05-25 14:48:36	20	20	t	f
54	1	2021-05-25 14:48:38	20	20	t	f
55	1	2021-05-25 14:48:41	20	20	t	f
56	1	2021-05-25 14:53:37	20	20	t	f
57	1	2021-05-25 14:53:43	20	20	t	f
58	1	2021-05-25 15:26:07	20	20	t	f
59	1	2021-05-25 16:12:38	20	20	t	f
60	1	2021-05-25 16:39:37	20	20	t	f
61	1	2021-05-25 17:03:52	20	20	t	f
62	1	2021-05-25 17:04:02	20	20	t	f
63	1	2021-05-25 17:07:07	20	20	t	f
64	1	2021-05-25 17:07:38	20	20	t	f
65	1	2021-05-25 17:10:28	20	20	t	f
66	1	2021-05-25 17:10:41	20	20	t	f
67	1	2021-05-25 17:12:07	20	20	t	f
68	1	2021-05-25 17:13:03	20	20	t	f
69	1	2021-05-25 17:16:20	20	20	t	f
70	1	2021-05-25 17:20:33	20	20	t	f
71	1	2021-05-25 17:23:01	20	20	t	f
72	1	2021-05-25 17:24:57	20	20	t	f
73	1	2021-05-25 17:25:46	20	20	t	f
74	1	2021-05-25 17:26:47	20	20	t	f
75	1	2021-05-25 17:27:21	20	20	t	f
76	1	2021-05-25 17:27:37	20	20	t	f
77	1	2021-05-25 17:29:41	20	20	t	f
78	1	2021-05-25 17:53:37	20	20	t	f
79	1	2021-05-25 17:56:38	20	24	t	f
80	1	2021-05-25 17:58:28	20	24	t	f
81	1	2021-05-25 17:59:47	20	12	t	f
82	1	2021-05-25 18:00:02	20	12	t	f
83	1	2021-05-25 18:00:11	20	12	t	f
84	1	2021-05-25 18:00:13	20	12	t	f
85	1	2021-05-25 18:00:21	20	12	t	f
86	1	2021-05-25 18:01:33	10	235	t	f
87	1	2021-05-26 14:05:13	24	12	t	f
88	1	2021-05-26 15:10:41	24	12	t	f
\.


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modules (id, password, address) FROM stdin;
1	1	г.Москва пр-кт 60-летия Октября 11
2	2	г.Москва ул. Строителей 36
3	3	г.Москва ул. Ленина д.15
\.


--
-- Data for Name: modules_errors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modules_errors (id, module_id, err_type, create_at, solve_at) FROM stdin;
40	1	Мало воды	2021-05-06 16:40:27	2021-05-06 16:46:50
41	1	Избыток воды	2021-05-06 16:40:27	2021-05-06 16:46:50
44	1	Высокая температура	2021-05-06 16:47:13	2021-05-06 16:47:29
45	1	Высокая температура	2021-05-06 17:00:14	2021-05-06 17:00:51
46	1	Мало воды	2021-05-06 17:00:14	2021-05-06 17:00:51
47	1	Избыток воды	2021-05-06 17:00:14	2021-05-06 17:00:51
48	1	Высокая температура	2021-05-06 17:01:24	2021-05-06 17:03:52
49	1	Мало воды	2021-05-06 17:01:24	2021-05-06 17:03:52
50	1	Избыток воды	2021-05-06 17:01:24	2021-05-06 17:03:52
54	1	Высокая температура	2021-05-17 19:19:56	2021-05-17 19:24:33
55	1	Мало воды	2021-05-17 19:19:56	2021-05-17 19:24:33
56	1	Избыток воды	2021-05-17 19:19:56	2021-05-17 19:24:33
59	1	Мало воды	2021-05-17 20:23:46	2021-05-17 20:26:20
60	1	Избыток воды	2021-05-17 20:23:46	2021-05-17 20:26:20
61	1	Мало воды	2021-05-17 20:30:45	2021-05-17 20:38:08
62	1	Избыток воды	2021-05-17 20:30:45	2021-05-17 20:38:08
63	1	Нет данных по посещениям	2021-05-17 20:48:57	2021-05-17 21:02:36
64	1	Мало воды	2021-05-17 20:48:57	2021-05-20 11:35:35
65	1	Избыток воды	2021-05-17 20:48:57	2021-05-20 11:35:35
69	1	Нет данных по посещениям	2021-05-22 20:09:01	2021-05-22 20:24:56
70	1	Нет данных по температуре	2021-05-22 20:09:01	2021-05-22 20:24:56
72	1	Нет данных по посещениям	2021-05-22 20:34:35	2021-05-23 13:50:51
73	1	Нет данных по температуре	2021-05-22 20:34:35	2021-05-23 13:50:51
66	2	Низкая температура	2021-05-20 11:43:02	2021-05-23 13:51:02
67	2	Мало воды	2021-05-20 11:43:02	2021-05-23 13:51:02
68	2	Избыток воды	2021-05-20 11:43:02	2021-05-23 13:51:02
74	2	Нет данных по уровню воды	2021-05-23 13:51:02	\N
51	3	Высокая температура	2021-05-16 16:48:49	2021-05-23 13:51:18
52	3	Мало воды	2021-05-16 16:48:49	2021-05-23 13:51:18
53	3	Избыток воды	2021-05-16 16:48:49	2021-05-23 13:51:18
75	3	Нет данных по уровню воды	2021-05-23 13:51:18	\N
76	1	Нет данных по посещениям	2021-05-25 14:13:24	2021-05-25 14:17:15
77	1	Нет данных по температуре	2021-05-25 14:13:24	2021-05-25 14:17:15
71	1	Нет данных по уровню воды	2021-05-22 20:09:01	2021-05-25 14:36:12
80	1	Нет данных по посещениям	2021-05-25 14:40:41	2021-05-25 14:41:02
81	1	Нет данных по температуре	2021-05-25 14:40:41	2021-05-25 14:41:02
78	1	Мало чистой воды	2021-05-25 14:36:12	2021-05-25 14:42:53
79	1	Избыток серой воды	2021-05-25 14:36:12	2021-05-25 14:42:53
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, user_id, date, message, type, module_id) FROM stdin;
1	1	2021-05-18 21:07:10	12 литров	Слив воды	1
2	1	2021-05-20 11:58:44	20 литров	Слив воды	1
\.


--
-- Data for Name: user_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_status (id, name) FROM stdin;
1	admin
2	manager
3	cleaner
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, user_name, status_id, log, password) FROM stdin;
1	admin	1	admin	admin
\.


--
-- Name: module_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.module_data_id_seq', 88, true);


--
-- Name: modules_errors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modules_errors_id_seq', 81, true);


--
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modules_id_seq', 3, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 2, true);


--
-- Name: user_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_status_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: module_data module_data_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_data
    ADD CONSTRAINT module_data_pk PRIMARY KEY (id);


--
-- Name: modules_errors modules_errors_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules_errors
    ADD CONSTRAINT modules_errors_pk PRIMARY KEY (id);


--
-- Name: modules modules_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pk PRIMARY KEY (id);


--
-- Name: services services_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pk PRIMARY KEY (id);


--
-- Name: user_status user_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_status
    ADD CONSTRAINT user_status_pk PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: modules_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX modules_id_uindex ON public.modules USING btree (id);


--
-- Name: module_data module_data_modules_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_data
    ADD CONSTRAINT module_data_modules_id_fk FOREIGN KEY (module_id) REFERENCES public.modules(id);


--
-- Name: modules_errors modules_errors_modules_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modules_errors
    ADD CONSTRAINT modules_errors_modules_id_fk FOREIGN KEY (module_id) REFERENCES public.modules(id);


--
-- Name: services services_modules_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_modules_id_fk FOREIGN KEY (module_id) REFERENCES public.modules(id);


--
-- Name: services services_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users users_user_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_status_id_fk FOREIGN KEY (status_id) REFERENCES public.user_status(id);


--
-- PostgreSQL database dump complete
--

