
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


CREATE TABLE public.branch (
    country text NOT NULL,
    address text,
    phone_number text
);


ALTER TABLE public.branch OWNER TO postgres;



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



CREATE TABLE public.guest (
    account_id integer,
    signup_date date
);


ALTER TABLE public.guest OWNER TO postgres;



CREATE TABLE public.host (
    account_id integer,
    signup_date date
);


ALTER TABLE public.host OWNER TO postgres;



CREATE TABLE public.listing (
    property_id integer,
    listing_name text,
    description text,
    start_date date,
    end_date date,
    listing_id integer NOT NULL
);


ALTER TABLE public.listing OWNER TO postgres;


CREATE SEQUENCE public.listing_listing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listing_listing_id_seq OWNER TO postgres;



ALTER SEQUENCE public.listing_listing_id_seq OWNED BY public.listing.listing_id;




CREATE TABLE public.manager (
    manager_id integer NOT NULL,
    account_id integer,
    branch text,
    salary integer
);


ALTER TABLE public.manager OWNER TO postgres;


CREATE TABLE public.payment (
    ra_id integer,
    payment_amount real,
    payment_type text,
    payment_status text,
    payment_date date
);


ALTER TABLE public.payment OWNER TO postgres;



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



CREATE TABLE public.pricing (
    property_id integer,
    rental_rate real,
    cleaning_fee real,
    deposit real,
    record_id integer NOT NULL
);


ALTER TABLE public.pricing OWNER TO postgres;



CREATE SEQUENCE public.pricing_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pricing_record_id_seq OWNER TO postgres;



ALTER SEQUENCE public.pricing_record_id_seq OWNED BY public.pricing.record_id;


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



CREATE TABLE public.review (
    ra_id integer,
    review_text text,
    overall_score integer,
    cleanliness_score integer,
    comm_score integer,
    value_score integer
);


ALTER TABLE public.review OWNER TO postgres;



ALTER TABLE ONLY public.listing ALTER COLUMN listing_id SET DEFAULT nextval('public.listing_listing_id_seq'::regclass);




ALTER TABLE ONLY public.pricing ALTER COLUMN record_id SET DEFAULT nextval('public.pricing_record_id_seq'::regclass);




ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (country);



ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_pkey PRIMARY KEY (listing_id);




ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_id);




ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (account_id);




ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (property_id);



ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_pkey PRIMARY KEY (ra_id);



ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);




ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);




ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);




ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);



ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.person(account_id);



ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_branch_fkey FOREIGN KEY (branch) REFERENCES public.branch(country);




ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_ra_id_fkey FOREIGN KEY (ra_id) REFERENCES public.rental_agreement(ra_id);




ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);




ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listing(listing_id) NOT VALID;



ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_ra_id_fkey FOREIGN KEY (ra_id) REFERENCES public.rental_agreement(ra_id);
