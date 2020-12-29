--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9
-- Dumped by pg_dump version 13.1

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
-- Name: adres_temizleme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.adres_temizleme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 
	 BEGIN
	 NEW."adres" = LTRIM(NEW."adres");
	    RETURN NEW;
	END; 
	$$;


ALTER FUNCTION public.adres_temizleme() OWNER TO postgres;

--
-- Name: film_dilleri(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_dilleri() RETURNS void
    LANGUAGE sql
    AS $$
	 SELECT * FROM "film" INNER JOIN "dil" ON "film"."dil_id" =  "dil"."dil_id"
	$$;


ALTER FUNCTION public.film_dilleri() OWNER TO postgres;

--
-- Name: film_kalitesi_iyi_olan(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_kalitesi_iyi_olan() RETURNS void
    LANGUAGE sql
    AS $$
	 SELECT * FROM film WHERE film.imdb_puan>7;
	$$;


ALTER FUNCTION public.film_kalitesi_iyi_olan() OWNER TO postgres;

--
-- Name: film_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
	 DECLARE
	 x integer; 
	 BEGIN
	 SELECT count(*) into x FROM "film";
	   RETURN x;
	END; 
	$$;


ALTER FUNCTION public.film_sayisi() OWNER TO postgres;

--
-- Name: oyuncu_son_duzenleme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.oyuncu_son_duzenleme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE 
	 
	 BEGIN
	  UPDATE "oyuncu" SET son_duzenleme = CURRENT_DATE WHERE "oyuncu_id" = NEW."oyuncu_id";
	
	    RETURN NEW;
	 
	END; 
	$$;


ALTER FUNCTION public.oyuncu_son_duzenleme() OWNER TO postgres;

--
-- Name: personel_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.personel_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
	 DECLARE 
	 x integer;
	 BEGIN
	 SELECT count(*) into x FROM "personel";
	   RETURN x;
	END; 
	$$;


ALTER FUNCTION public.personel_sayisi() OWNER TO postgres;

--
-- Name: ulke_isim_duzenleme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ulke_isim_duzenleme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
	 BEGIN
	 NEW."ulke_ismi" = UPPER(NEW."ulke_ismi");
	    RETURN NEW;
	    END;
	$$;


ALTER FUNCTION public.ulke_isim_duzenleme() OWNER TO postgres;

--
-- Name: adres_adres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adres_adres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.adres_adres_id_seq OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adres (
    adres_id integer DEFAULT nextval('public.adres_adres_id_seq'::regclass) NOT NULL,
    sehir_id integer NOT NULL,
    mahalle_kodu integer NOT NULL,
    adres character varying NOT NULL,
    son_duzenleme character varying(2044) NOT NULL
);


ALTER TABLE public.adres OWNER TO postgres;

--
-- Name: dil_dil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dil_dil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.dil_dil_id_seq OWNER TO postgres;

--
-- Name: dil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dil (
    dil_id integer DEFAULT nextval('public.dil_dil_id_seq'::regclass) NOT NULL,
    dil_ismi character varying NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.dil OWNER TO postgres;

--
-- Name: dukkan_dukkan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dukkan_dukkan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.dukkan_dukkan_id_seq OWNER TO postgres;

--
-- Name: dukkan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dukkan (
    dukkan_id integer DEFAULT nextval('public.dukkan_dukkan_id_seq'::regclass) NOT NULL,
    destek_personel_id integer NOT NULL,
    adres_id integer NOT NULL
);


ALTER TABLE public.dukkan OWNER TO postgres;

--
-- Name: film_film_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.film_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.film_film_id_seq OWNER TO postgres;

--
-- Name: film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film (
    film_id integer DEFAULT nextval('public.film_film_id_seq'::regclass) NOT NULL,
    baslik character varying NOT NULL,
    intro character varying NOT NULL,
    dil_id integer NOT NULL,
    sure integer NOT NULL,
    imdb_puan double precision NOT NULL,
    vizyon_tarihi character varying NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.film OWNER TO postgres;

--
-- Name: film_kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_kategori (
    kategori_id integer NOT NULL,
    film_id integer NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.film_kategori OWNER TO postgres;

--
-- Name: film_oyuncu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_oyuncu (
    oyuncu_id integer NOT NULL,
    film_id integer NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.film_oyuncu OWNER TO postgres;

--
-- Name: icerik_icerik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.icerik_icerik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.icerik_icerik_id_seq OWNER TO postgres;

--
-- Name: icerik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icerik (
    icerik_id integer DEFAULT nextval('public.icerik_icerik_id_seq'::regclass) NOT NULL,
    film_id integer NOT NULL,
    dukkan_id integer NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.icerik OWNER TO postgres;

--
-- Name: kategori_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_kategori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.kategori_kategori_id_seq OWNER TO postgres;

--
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    kategori_id integer DEFAULT nextval('public.kategori_kategori_id_seq'::regclass) NOT NULL,
    kategori_ismi character varying NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- Name: kira_kira_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kira_kira_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.kira_kira_id_seq OWNER TO postgres;

--
-- Name: kira; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kira (
    kira_id integer DEFAULT nextval('public.kira_kira_id_seq'::regclass) NOT NULL,
    icerik_id integer NOT NULL,
    musteri_id integer NOT NULL,
    personel_id integer NOT NULL,
    kira_tarihi date NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.kira OWNER TO postgres;

--
-- Name: musteri_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_musteri_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.musteri_musteri_id_seq OWNER TO postgres;

--
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    musteri_id integer DEFAULT nextval('public.musteri_musteri_id_seq'::regclass) NOT NULL,
    isim character varying NOT NULL,
    soyisim character varying NOT NULL,
    mail character varying NOT NULL,
    adres_id integer NOT NULL,
    dukkan_id integer NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- Name: odeme_odeme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odeme_odeme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.odeme_odeme_id_seq OWNER TO postgres;

--
-- Name: odeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odeme (
    odeme_id integer DEFAULT nextval('public.odeme_odeme_id_seq'::regclass) NOT NULL,
    musteri_id integer NOT NULL,
    personel_id integer NOT NULL,
    kira_id integer NOT NULL,
    miktar double precision NOT NULL,
    odeme_tarihi date NOT NULL
);


ALTER TABLE public.odeme OWNER TO postgres;

--
-- Name: oyuncu_oyuncu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oyuncu_oyuncu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.oyuncu_oyuncu_id_seq OWNER TO postgres;

--
-- Name: oyuncu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oyuncu (
    oyuncu_id integer DEFAULT nextval('public.oyuncu_oyuncu_id_seq'::regclass) NOT NULL,
    isim character varying NOT NULL,
    son_duzenleme character varying NOT NULL
);


ALTER TABLE public.oyuncu OWNER TO postgres;

--
-- Name: personel_personel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_personel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.personel_personel_id_seq OWNER TO postgres;

--
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    personel_id integer DEFAULT nextval('public.personel_personel_id_seq'::regclass) NOT NULL,
    isim character varying NOT NULL,
    soyisim character varying NOT NULL,
    mail character varying NOT NULL,
    adres_id integer NOT NULL,
    dukkan_id integer NOT NULL,
    kullanici_adi character varying NOT NULL,
    parola character varying NOT NULL,
    son_duzenleme date NOT NULL
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- Name: sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir (
    sehir_id integer NOT NULL,
    sehir_ismi character varying NOT NULL,
    ulke_id integer NOT NULL
);


ALTER TABLE public.sehir OWNER TO postgres;

--
-- Name: ulke_ulke_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ulke_ulke_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.ulke_ulke_id_seq OWNER TO postgres;

--
-- Name: ulke; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ulke (
    ulke_id integer DEFAULT nextval('public.ulke_ulke_id_seq'::regclass) NOT NULL,
    ulke_ismi character varying NOT NULL
);


ALTER TABLE public.ulke OWNER TO postgres;

--
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adres VALUES
	(1, 34, 34896, 'pendik velibaba', '2020-12-27'),
	(2, 37, 37896, 'sakarya serdivan', '2020-12-27'),
	(3, 100, 10042, '3.adresimiz', '2020-12-28'),
	(4, 101, 10141, '4.adresimiz', '2020-12-29'),
	(5, 101, 105, '5.aderes', '2020-12-29');


--
-- Data for Name: dil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dil VALUES
	(1, 'Türkçe', '2018-10-10'),
	(2, 'İngilizce', '2018-10-10'),
	(3, 'Rusca', '2018-10-10');


--
-- Data for Name: dukkan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dukkan VALUES
	(1, 1, 1),
	(2, 2, 3),
	(3, 4, 2),
	(4, 3, 4);


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film VALUES
	(1, 'Babam ve oğlum', 'duygusal baba oğul filmi', 1, 147, 7.79999999999999982, '2012', '2013-03-03'),
	(2, 'Yenilmezler', 'marvel ekibinin macerasi', 2, 125, 8.30000000000000071, '2015', '2016-03-03'),
	(3, '7.Koğuştaki Mucize', 'arasbulutun efsane filmi', 1, 132, 8.30000000000000071, '2018', '2018-08-08'),
	(4, 'Behzat Ç', 'Bir Erdal Beşikcioğlu efsanesi', 1, 97, 6.29999999999999982, '2014', '2014-04-04');


--
-- Data for Name: film_kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film_kategori VALUES
	(3, 2, '2020-03-03'),
	(5, 1, '2020-03-03'),
	(5, 1, '2020-03-03'),
	(3, 4, '2020-03-03');


--
-- Data for Name: film_oyuncu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film_oyuncu VALUES
	(1, 1, '2020-03-03'),
	(2, 2, '2020-03-03'),
	(3, 3, '2020-03-03'),
	(4, 4, '2020-03-03');


--
-- Data for Name: icerik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.icerik VALUES
	(1, 1, 1, '2020-04-04'),
	(2, 3, 1, '2020-04-04'),
	(3, 4, 1, '2020-04-04'),
	(4, 2, 2, '2020-05-05');


--
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategori VALUES
	(1, 'aşk', '2015-04-11'),
	(2, 'korku', '2016-08-17'),
	(3, 'macera', '2016-08-17'),
	(4, 'komedi', '2016-08-17'),
	(5, 'duygusal', '2016-08-17');


--
-- Data for Name: kira; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kira VALUES
	(1, 1, 1, 1, '2020-05-05', '2020-05-05'),
	(2, 2, 2, 2, '2020-05-05', '2020-05-05'),
	(3, 3, 3, 3, '2020-05-05', '2020-05-05'),
	(4, 4, 4, 4, '2020-05-05', '2020-05-05');


--
-- Data for Name: musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri VALUES
	(1, 'Hasan', 'Muslan', 'hasan_muslan@hotmail.com', 1, 1, '2017-07-10'),
	(2, 'Cemile', 'Özsoy', 'cemile_ozsoy', 2, 2, '2017-07-10'),
	(3, 'Necla', 'Diken', 'necla_diken@hotmail.com', 3, 3, '2017-07-10'),
	(4, 'Jehad', 'Assaf', 'jehad_assaf@gmail.com', 4, 4, '2020-05-11');


--
-- Data for Name: odeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.odeme VALUES
	(1, 1, 1, 1, 500, '2020-05-05'),
	(2, 2, 2, 2, 700, '2020-05-05'),
	(3, 3, 3, 3, 800, '2020-06-06'),
	(4, 4, 4, 4, 900, '2020-07-07');


--
-- Data for Name: oyuncu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oyuncu VALUES
	(1, 'Erdal Beşikcioğlu', '25.05.2020'),
	(2, 'Aras Bulut İynemli', '25.06.2020'),
	(3, 'Erkan Kolçak Köstendil', '26.07.2020'),
	(4, 'Öner Erkan', '27.07.2020');


--
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel VALUES
	(1, 'Emirhan', 'Ergen', 'emirhan_ergen@hotmail.com', 1, 1, 'emiirrhan', '123456789', '2020-05-06'),
	(2, 'Ezgi', 'Ergen', 'ezgi_ergen@hotmail.com', 2, 2, 'ezgii', '123456789', '2020-05-06'),
	(3, 'Nazlı', 'Ergen', 'nazlı_ergen@hot.com', 3, 3, 'nazlii', '123456789', '2020-05-07'),
	(4, 'Nazo', 'Erol', 'nazo_erol@hot.com', 4, 4, 'nazdiyeceksin', '123456789', '2020-05-07');


--
-- Data for Name: sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sehir VALUES
	(34, 'İstanbul', 1),
	(54, 'Sakarya', 1),
	(37, 'Kastamonu', 1),
	(123, 'Newyork', 3),
	(100, 'Delhi', 5),
	(101, 'Dc', 2);


--
-- Data for Name: ulke; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ulke VALUES
	(1, 'TÜRKIYE'),
	(2, 'ABD'),
	(3, 'İngiltere'),
	(4, 'RUSYA'),
	(5, 'HINDISTAN'),
	(6, 'İTALYA');


--
-- Name: adres_adres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adres_adres_id_seq', 5, true);


--
-- Name: dil_dil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dil_dil_id_seq', 3, true);


--
-- Name: dukkan_dukkan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dukkan_dukkan_id_seq', 1, false);


--
-- Name: film_film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.film_film_id_seq', 4, true);


--
-- Name: icerik_icerik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.icerik_icerik_id_seq', 1, false);


--
-- Name: kategori_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_kategori_id_seq', 5, true);


--
-- Name: kira_kira_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kira_kira_id_seq', 1, false);


--
-- Name: musteri_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_musteri_id_seq', 4, true);


--
-- Name: odeme_odeme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odeme_odeme_id_seq', 1, false);


--
-- Name: oyuncu_oyuncu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oyuncu_oyuncu_id_seq', 4, true);


--
-- Name: personel_personel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_personel_id_seq', 1, true);


--
-- Name: ulke_ulke_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ulke_ulke_id_seq', 6, true);


--
-- Name: dil dil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dil
    ADD CONSTRAINT dil_pkey PRIMARY KEY (dil_id);


--
-- Name: dukkan dukkan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dukkan
    ADD CONSTRAINT dukkan_pkey PRIMARY KEY (dukkan_id);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


--
-- Name: icerik icerik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icerik
    ADD CONSTRAINT icerik_pkey PRIMARY KEY (icerik_id);


--
-- Name: kira kira_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kira
    ADD CONSTRAINT kira_pkey PRIMARY KEY (kira_id);


--
-- Name: musteri musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT musteri_pkey PRIMARY KEY (musteri_id);


--
-- Name: odeme odeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT odeme_pkey PRIMARY KEY (odeme_id);


--
-- Name: oyuncu oyuncu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oyuncu
    ADD CONSTRAINT oyuncu_pkey PRIMARY KEY (oyuncu_id);


--
-- Name: personel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (personel_id);


--
-- Name: adres unique_adres_adres_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT unique_adres_adres_id PRIMARY KEY (adres_id);


--
-- Name: dil unique_dil_dil_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dil
    ADD CONSTRAINT unique_dil_dil_id UNIQUE (dil_id);


--
-- Name: dukkan unique_dukkan_dukkan_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dukkan
    ADD CONSTRAINT unique_dukkan_dukkan_id UNIQUE (dukkan_id);


--
-- Name: icerik unique_icerik_icerik_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icerik
    ADD CONSTRAINT unique_icerik_icerik_id UNIQUE (icerik_id);


--
-- Name: kategori unique_kategori_kategori_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT unique_kategori_kategori_id PRIMARY KEY (kategori_id);


--
-- Name: kira unique_kira_kira_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kira
    ADD CONSTRAINT unique_kira_kira_id UNIQUE (kira_id);


--
-- Name: musteri unique_musteri_musteri_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT unique_musteri_musteri_id UNIQUE (musteri_id);


--
-- Name: odeme unique_odeme_odeme_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT unique_odeme_odeme_id UNIQUE (odeme_id);


--
-- Name: oyuncu unique_oyuncu_oyuncu_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oyuncu
    ADD CONSTRAINT unique_oyuncu_oyuncu_id UNIQUE (oyuncu_id);


--
-- Name: personel unique_personel_personel_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT unique_personel_personel_id UNIQUE (personel_id);


--
-- Name: sehir unique_sehir_sehir_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT unique_sehir_sehir_id PRIMARY KEY (sehir_id);


--
-- Name: ulke unique_ulke_ulke_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT unique_ulke_ulke_id PRIMARY KEY (ulke_id);


--
-- Name: adres adres_temizleme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER adres_temizleme BEFORE INSERT ON public.adres FOR EACH ROW EXECUTE PROCEDURE public.adres_temizleme();


--
-- Name: oyuncu oyuncu_son_duzenleme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER oyuncu_son_duzenleme BEFORE INSERT ON public.oyuncu FOR EACH ROW EXECUTE PROCEDURE public.oyuncu_son_duzenleme();


--
-- Name: ulke ulke_isim_duzenleme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ulke_isim_duzenleme BEFORE INSERT ON public.ulke FOR EACH ROW EXECUTE PROCEDURE public.ulke_isim_duzenleme();


--
-- Name: dukkan adres_dukkan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dukkan
    ADD CONSTRAINT adres_dukkan FOREIGN KEY (adres_id) REFERENCES public.adres(adres_id) MATCH FULL;


--
-- Name: musteri adres_musteri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT adres_musteri FOREIGN KEY (adres_id) REFERENCES public.adres(adres_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel adres_personel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT adres_personel FOREIGN KEY (adres_id) REFERENCES public.adres(adres_id) MATCH FULL;


--
-- Name: film dil_film; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT dil_film FOREIGN KEY (dil_id) REFERENCES public.dil(dil_id) MATCH FULL;


--
-- Name: film_kategori film_filmkategori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_kategori
    ADD CONSTRAINT film_filmkategori FOREIGN KEY (film_id) REFERENCES public.film(film_id) MATCH FULL;


--
-- Name: film_oyuncu film_filmoyuncu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_oyuncu
    ADD CONSTRAINT film_filmoyuncu FOREIGN KEY (film_id) REFERENCES public.film(film_id) MATCH FULL;


--
-- Name: icerik film_icerik; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icerik
    ADD CONSTRAINT film_icerik FOREIGN KEY (film_id) REFERENCES public.film(film_id) MATCH FULL;


--
-- Name: kira icerik_kira; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kira
    ADD CONSTRAINT icerik_kira FOREIGN KEY (icerik_id) REFERENCES public.icerik(icerik_id) MATCH FULL;


--
-- Name: film_kategori kategori_filmkategori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_kategori
    ADD CONSTRAINT kategori_filmkategori FOREIGN KEY (kategori_id) REFERENCES public.kategori(kategori_id) MATCH FULL;


--
-- Name: odeme kira_odeme; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT kira_odeme FOREIGN KEY (kira_id) REFERENCES public.kira(kira_id) MATCH FULL;


--
-- Name: kira musteri_kira; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kira
    ADD CONSTRAINT musteri_kira FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id) MATCH FULL;


--
-- Name: odeme musteri_odeme; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT musteri_odeme FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_oyuncu oyuncu_filmoyuncu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_oyuncu
    ADD CONSTRAINT oyuncu_filmoyuncu FOREIGN KEY (oyuncu_id) REFERENCES public.oyuncu(oyuncu_id) MATCH FULL;


--
-- Name: dukkan personel_dukkan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dukkan
    ADD CONSTRAINT personel_dukkan FOREIGN KEY (destek_personel_id) REFERENCES public.personel(personel_id) MATCH FULL;


--
-- Name: kira personel_kira; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kira
    ADD CONSTRAINT personel_kira FOREIGN KEY (personel_id) REFERENCES public.personel(personel_id) MATCH FULL;


--
-- Name: odeme personel_odeme; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT personel_odeme FOREIGN KEY (personel_id) REFERENCES public.personel(personel_id) MATCH FULL;


--
-- Name: adres sehir_adres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT sehir_adres FOREIGN KEY (sehir_id) REFERENCES public.sehir(sehir_id) MATCH FULL;


--
-- Name: sehir ulke_sehir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT ulke_sehir FOREIGN KEY (ulke_id) REFERENCES public.ulke(ulke_id) MATCH FULL;


--
-- PostgreSQL database dump complete
--

