--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-04-09 19:38:24

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 16589)
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    country text NOT NULL,
    address text,
    phone_number text
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16633)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    account_id integer,
    "position" text,
    salary real,
    start_date date,
    end_date date,
    weekly_hours integer,
    manager_id integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16676)
-- Name: guest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guest (
    account_id integer,
    signup_date date
);


ALTER TABLE public.guest OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16684)
-- Name: host; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.host (
    account_id integer,
    signup_date date
);


ALTER TABLE public.host OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16615)
-- Name: listing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listing (
    property_id integer,
    listing_name text,
    description text,
    start_date date,
    end_date date,
    listing_id integer NOT NULL
);


ALTER TABLE public.listing OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16700)
-- Name: listing_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listing_listing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listing_listing_id_seq OWNER TO postgres;

--
-- TOC entry 2897 (class 0 OID 0)
-- Dependencies: 214
-- Name: listing_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listing_listing_id_seq OWNED BY public.listing.listing_id;


--
-- TOC entry 206 (class 1259 OID 16597)
-- Name: manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager (
    manager_id integer NOT NULL,
    account_id integer,
    branch text,
    salary integer
);


ALTER TABLE public.manager OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16655)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    ra_id integer,
    payment_amount real,
    payment_type text,
    payment_status text,
    payment_date date
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16581)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    account_id integer NOT NULL,
    first_name text,
    middle_name text,
    last_name text,
    address text,
    email text,
    phone_number text
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16666)
-- Name: pricing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pricing (
    property_id integer,
    rental_rate real,
    cleaning_fee real,
    deposit real,
    record_id integer NOT NULL
);


ALTER TABLE public.pricing OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16738)
-- Name: pricing_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pricing_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pricing_record_id_seq OWNER TO postgres;

--
-- TOC entry 2898 (class 0 OID 0)
-- Dependencies: 215
-- Name: pricing_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pricing_record_id_seq OWNED BY public.pricing.record_id;


--
-- TOC entry 202 (class 1259 OID 16565)
-- Name: property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.property (
    property_id integer NOT NULL,
    address text,
    property_type text,
    room_type text,
    num_bathrooms integer,
    num_bedrooms integer,
    num_beds integer,
    amenities text,
    host_id integer
);


ALTER TABLE public.property OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16573)
-- Name: rental_agreement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rental_agreement (
    ra_id integer NOT NULL,
    signing_date date,
    start_date date,
    end_date date,
    property_rules text,
    listing_id integer,
    guest_id integer
);


ALTER TABLE public.rental_agreement OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16644)
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    ra_id integer,
    review_text text,
    overall_score integer,
    cleanliness_score integer,
    comm_score integer,
    value_score integer
);


ALTER TABLE public.review OWNER TO postgres;

--
-- TOC entry 2742 (class 2604 OID 16702)
-- Name: listing listing_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listing ALTER COLUMN listing_id SET DEFAULT nextval('public.listing_listing_id_seq'::regclass);


--
-- TOC entry 2743 (class 2604 OID 16740)
-- Name: pricing record_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing ALTER COLUMN record_id SET DEFAULT nextval('public.pricing_record_id_seq'::regclass);


--
-- TOC entry 2751 (class 2606 OID 16717)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (country);


--
-- TOC entry 2755 (class 2606 OID 16710)
-- Name: listing listing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_pkey PRIMARY KEY (listing_id);


--
-- TOC entry 2753 (class 2606 OID 16604)
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_id);


--
-- TOC entry 2749 (class 2606 OID 16588)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (account_id);


--
-- TOC entry 2745 (class 2606 OID 16572)
-- Name: property property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (property_id);


--
-- TOC entry 2747 (class 2606 OID 16580)
-- Name: rental_agreement rental_agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_pkey PRIMARY KEY (ra_id);


--
-- TOC entry 2760 (class 2606 OID 16639)
-- Name: employee employee_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);


--
-- TOC entry 2764 (class 2606 OID 16679)
-- Name: guest guest_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);


--
-- TOC entry 2765 (class 2606 OID 16687)
-- Name: host host_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);


--
-- TOC entry 2759 (class 2606 OID 16623)
-- Name: listing listing_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- TOC entry 2757 (class 2606 OID 16605)
-- Name: manager manager_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);


--
-- TOC entry 2758 (class 2606 OID 16733)
-- Name: manager manager_branch_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_branch_fkey FOREIGN KEY (branch) REFERENCES public.branch(country);


--
-- TOC entry 2762 (class 2606 OID 16661)
-- Name: payment payment_ra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_ra_id_fkey FOREIGN KEY (ra_id) REFERENCES public.rental_agreement(ra_id);


--
-- TOC entry 2763 (class 2606 OID 16671)
-- Name: pricing pricing_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- TOC entry 2756 (class 2606 OID 16711)
-- Name: rental_agreement rental_agreement_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listing(listing_id) NOT VALID;


--
-- TOC entry 2761 (class 2606 OID 16650)
-- Name: review review_ra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_ra_id_fkey FOREIGN KEY (ra_id) REFERENCES public.rental_agreement(ra_id);


-- Completed on 2020-04-09 19:38:25

--
-- PostgreSQL database dump complete
--

