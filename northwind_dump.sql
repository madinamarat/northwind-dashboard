--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10
-- Dumped by pg_dump version 10.10

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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    categoryid integer NOT NULL,
    categoryname character varying(255),
    description character varying(255),
    picture bytea
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_categoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_categoryid_seq OWNER TO postgres;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_categoryid_seq OWNED BY public.categories.categoryid;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id character varying(255) NOT NULL,
    companyname character varying(255),
    contactname character varying(255),
    contacttitle character varying(255),
    address character varying(255),
    city character varying(255),
    region character varying(255),
    postalcode character varying(255),
    country character varying(255),
    phone character varying(255),
    fax character varying(255)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: employee_territories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_territories (
    employeeid integer,
    territoryid character varying(255) NOT NULL
);


ALTER TABLE public.employee_territories OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employeeid integer NOT NULL,
    lastname character varying(255),
    firstname character varying(255),
    title character varying(255),
    titleofcourtesy character varying(10),
    birthdate timestamp without time zone,
    hiredate timestamp without time zone,
    address character varying(255),
    city character varying(255),
    region character varying(255),
    postalcode character varying(255),
    country character varying(255),
    homephone character varying(255),
    extension character varying(255),
    photo bytea,
    notes text,
    reportsto character varying(255),
    photopath text
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employeeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employeeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_employeeid_seq OWNER TO postgres;

--
-- Name: employees_employeeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employeeid_seq OWNED BY public.employees.employeeid;


--
-- Name: hiringage; Type: VIEW; Schema: public; Owner: madinamukhambekova
--

CREATE VIEW public.hiringage AS
 SELECT employees.lastname,
    "substring"(((((employees.hiredate - employees.birthdate) / (365)::double precision))::character varying(50))::text, 1, 2) AS hiringage
   FROM public.employees;


ALTER TABLE public.hiringage OWNER TO madinamukhambekova;

--
-- Name: order_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_details (
    id integer NOT NULL,
    orderid smallint,
    productid smallint,
    unitprice real,
    quantity smallint,
    discount real
);


ALTER TABLE public.order_details OWNER TO postgres;

--
-- Name: order_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_details_id_seq OWNER TO postgres;

--
-- Name: order_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_details_id_seq OWNED BY public.order_details.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    orderid character varying(255) NOT NULL,
    customerid character varying(255),
    employeeid smallint,
    orderdate timestamp without time zone,
    requireddate timestamp without time zone,
    shippeddate timestamp without time zone,
    shipvia smallint,
    freight real,
    shipname character varying(255),
    shipaddress character varying(255),
    shipcity character varying(255),
    shipregion character varying(255),
    shippostalcode character varying(255),
    shipcountry character varying(255)
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    productid integer NOT NULL,
    productname character varying(255),
    supplierid smallint,
    categoryid smallint,
    quantityperunit character varying(255),
    unitprice real,
    unitsinstock smallint,
    unitsonorder smallint,
    reorderlevel smallint,
    discontinued smallint
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_productid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_productid_seq OWNER TO postgres;

--
-- Name: products_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_productid_seq OWNED BY public.products.productid;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    regionid integer NOT NULL,
    regiondescription character varying(255)
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_regionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_regionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_regionid_seq OWNER TO postgres;

--
-- Name: regions_regionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_regionid_seq OWNED BY public.regions.regionid;


--
-- Name: shippers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shippers (
    shipperid integer NOT NULL,
    companyname character varying(255),
    phone character varying(255)
);


ALTER TABLE public.shippers OWNER TO postgres;

--
-- Name: shippers_shipperid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shippers_shipperid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shippers_shipperid_seq OWNER TO postgres;

--
-- Name: shippers_shipperid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shippers_shipperid_seq OWNED BY public.shippers.shipperid;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    supplierid integer NOT NULL,
    companyname character varying(255),
    contactname character varying(255),
    contacttitle character varying(255),
    address character varying(255),
    city character varying(255),
    region character varying(255),
    postalcode character varying(255),
    country character varying(255),
    phone character varying(255),
    fax character varying(255),
    homepage character varying(255)
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_supplierid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_supplierid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_supplierid_seq OWNER TO postgres;

--
-- Name: suppliers_supplierid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_supplierid_seq OWNED BY public.suppliers.supplierid;


--
-- Name: territories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.territories (
    territoryid character varying(255) NOT NULL,
    territorydescription character varying(255),
    regionid smallint
);


ALTER TABLE public.territories OWNER TO postgres;

--
-- Name: categories categoryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN categoryid SET DEFAULT nextval('public.categories_categoryid_seq'::regclass);


--
-- Name: employees employeeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employeeid SET DEFAULT nextval('public.employees_employeeid_seq'::regclass);


--
-- Name: order_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details ALTER COLUMN id SET DEFAULT nextval('public.order_details_id_seq'::regclass);


--
-- Name: products productid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN productid SET DEFAULT nextval('public.products_productid_seq'::regclass);


--
-- Name: regions regionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN regionid SET DEFAULT nextval('public.regions_regionid_seq'::regclass);


--
-- Name: shippers shipperid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shippers ALTER COLUMN shipperid SET DEFAULT nextval('public.shippers_shipperid_seq'::regclass);


--
-- Name: suppliers supplierid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN supplierid SET DEFAULT nextval('public.suppliers_supplierid_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (categoryid, categoryname, description, picture) FROM stdin;
1	Beverages	Soft drinks coffees teas beers and ales	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
2	Condiments	Sweet and savory sauces relishes spreads and seasonings	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
3	Confections	Desserts candies and sweet breads	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
4	Dairy Products	Cheeses	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
5	Grains/Cereals	Breads crackers pasta and cereal	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
6	Meat/Poultry	Prepared meats	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
7	Produce	Dried fruit and bean curd	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
8	Seafood	Seaweed and fish	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303041303239303030303432344439383239303030303030303030303030353630303030303032383030303030304143303030303030373830303030303030313030303430303030303030303030303030303030303038383042303030303838304230303030303830303030
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax) FROM stdin;
ALFKI	Alfreds Futterkiste	Maria Anders	Sales Representative	Obere Str. 57	Berlin	NULL	12209	Germany	030-0074321	030-0076545
ANATR	Ana Trujillo Emparedados y helados	Ana Trujillo	Owner	Avda. de la Constitución 2222	México D.F.	NULL	05021	Mexico	(5) 555-4729	(5) 555-3745
ANTON	Antonio Moreno Taquería	Antonio Moreno	Owner	Mataderos  2312	México D.F.	NULL	05023	Mexico	(5) 555-3932	NULL
AROUT	Around the Horn	Thomas Hardy	Sales Representative	120 Hanover Sq.	London	NULL	WA1 1DP	UK	(171) 555-7788	(171) 555-6750
BERGS	Berglunds snabbköp	Christina Berglund	Order Administrator	Berguvsvägen  8	Luleå	NULL	S-958 22	Sweden	0921-12 34 65	0921-12 34 67
BLAUS	Blauer See Delikatessen	Hanna Moos	Sales Representative	Forsterstr. 57	Mannheim	NULL	68306	Germany	0621-08460	0621-08924
BLONP	Blondesddsl père et fils	Frédérique Citeaux	Marketing Manager	24 place Kléber	Strasbourg	NULL	67000	France	88.60.15.31	88.60.15.32
BOLID	Bólido Comidas preparadas	Martín Sommer	Owner	67C Araquil	Madrid	NULL	28023	Spain	(91) 555 22 82	(91) 555 91 99
BONAP	Bon app'	Laurence Lebihan	Owner	12 rue des Bouchers	Marseille	NULL	13008	France	91.24.45.40	91.24.45.41
BOTTM	Bottom-Dollar Markets	Elizabeth Lincoln	Accounting Manager	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada	(604) 555-4729	(604) 555-3745
BSBEV	B's Beverages	Victoria Ashworth	Sales Representative	Fauntleroy Circus	London	NULL	EC2 5NT	UK	(171) 555-1212	NULL
CACTU	Cactus Comidas para llevar	Patricio Simpson	Sales Agent	Cerrito 333	Buenos Aires	NULL	1010	Argentina	(1) 135-5555	(1) 135-4892
CENTC	Centro comercial Moctezuma	Francisco Chang	Marketing Manager	Sierras de Granada 9993	México D.F.	NULL	05022	Mexico	(5) 555-3392	(5) 555-7293
CHOPS	Chop-suey Chinese	Yang Wang	Owner	Hauptstr. 29	Bern	NULL	3012	Switzerland	0452-076545	NULL
COMMI	Comércio Mineiro	Pedro Afonso	Sales Associate	23 Av. dos Lusíadas	Sao Paulo	SP	05432-043	Brazil	(11) 555-7647	NULL
CONSH	Consolidated Holdings	Elizabeth Brown	Sales Representative	Berkeley Gardens 12  Brewery	London	NULL	WX1 6LT	UK	(171) 555-2282	(171) 555-9199
DRACD	Drachenblut Delikatessen	Sven Ottlieb	Order Administrator	Walserweg 21	Aachen	NULL	52066	Germany	0241-039123	0241-059428
DUMON	Du monde entier	Janine Labrune	Owner	67 rue des Cinquante Otages	Nantes	NULL	44000	France	40.67.88.88	40.67.89.89
EASTC	Eastern Connection	Ann Devon	Sales Agent	35 King George	London	NULL	WX3 6FW	UK	(171) 555-0297	(171) 555-3373
ERNSH	Ernst Handel	Roland Mendel	Sales Manager	Kirchgasse 6	Graz	NULL	8010	Austria	7675-3425	7675-3426
FAMIA	Familia Arquibaldo	Aria Cruz	Marketing Assistant	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil	(11) 555-9857	NULL
FISSA	FISSA Fabrica Inter. Salchichas S.A.	Diego Roel	Accounting Manager	C/ Moralzarzal 86	Madrid	NULL	28034	Spain	(91) 555 94 44	(91) 555 55 93
FOLIG	Folies gourmandes	Martine Rancé	Assistant Sales Agent	184 chaussée de Tournai	Lille	NULL	59000	France	20.16.10.16	20.16.10.17
FOLKO	Folk och fä HB	Maria Larsson	Owner	Åkergatan 24	Bräcke	NULL	S-844 67	Sweden	0695-34 67 21	NULL
FRANK	Frankenversand	Peter Franken	Marketing Manager	Berliner Platz 43	München	NULL	80805	Germany	089-0877310	089-0877451
FRANR	France restauration	Carine Schmitt	Marketing Manager	54 rue Royale	Nantes	NULL	44000	France	40.32.21.21	40.32.21.20
FRANS	Franchi S.p.A.	Paolo Accorti	Sales Representative	Via Monte Bianco 34	Torino	NULL	10100	Italy	011-4988260	011-4988261
FURIB	Furia Bacalhau e Frutos do Mar	Lino Rodriguez	Sales Manager	Jardim das rosas n. 32	Lisboa	NULL	1675	Portugal	(1) 354-2534	(1) 354-2535
GALED	Galería del gastrónomo	Eduardo Saavedra	Marketing Manager	Rambla de Cataluña 23	Barcelona	NULL	08022	Spain	(93) 203 4560	(93) 203 4561
GODOS	Godos Cocina Típica	José Pedro Freyre	Sales Manager	C/ Romero 33	Sevilla	NULL	41101	Spain	(95) 555 82 82	NULL
GOURL	Gourmet Lanchonetes	André Fonseca	Sales Associate	Av. Brasil 442	Campinas	SP	04876-786	Brazil	(11) 555-9482	NULL
GREAL	Great Lakes Food Market	Howard Snyder	Marketing Manager	2732 Baker Blvd.	Eugene	OR	97403	USA	(503) 555-7555	NULL
GROSR	GROSELLA-Restaurante	Manuel Pereira	Owner	5ª Ave. Los Palos Grandes	Caracas	DF	1081	Venezuela	(2) 283-2951	(2) 283-3397
HANAR	Hanari Carnes	Mario Pontes	Accounting Manager	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil	(21) 555-0091	(21) 555-8765
HILAA	HILARION-Abastos	Carlos Hernández	Sales Representative	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela	(5) 555-1340	(5) 555-1948
HUNGC	Hungry Coyote Import Store	Yoshi Latimer	Sales Representative	City Center Plaza 516 Main St.	Elgin	OR	97827	USA	(503) 555-6874	(503) 555-2376
HUNGO	Hungry Owl All-Night Grocers	Patricia McKenna	Sales Associate	8 Johnstown Road	Cork	Co. Cork	NULL	Ireland	2967 542	2967 3333
ISLAT	Island Trading	Helen Bennett	Marketing Manager	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK	(198) 555-8888	NULL
KOENE	Königlich Essen	Philip Cramer	Sales Associate	Maubelstr. 90	Brandenburg	NULL	14776	Germany	0555-09876	NULL
LACOR	La corne d'abondance	Daniel Tonini	Sales Representative	67 avenue de l'Europe	Versailles	NULL	78000	France	30.59.84.10	30.59.85.11
LAMAI	La maison d'Asie	Annette Roulet	Sales Manager	1 rue Alsace-Lorraine	Toulouse	NULL	31000	France	61.77.61.10	61.77.61.11
LAUGB	Laughing Bacchus Wine Cellars	Yoshi Tannamuri	Marketing Assistant	1900 Oak St.	Vancouver	BC	V3F 2K1	Canada	(604) 555-3392	(604) 555-7293
LAZYK	Lazy K Kountry Store	John Steel	Marketing Manager	12 Orchestra Terrace	Walla Walla	WA	99362	USA	(509) 555-7969	(509) 555-6221
LEHMS	Lehmanns Marktstand	Renate Messner	Sales Representative	Magazinweg 7	Frankfurt a.M.	NULL	60528	Germany	069-0245984	069-0245874
LETSS	Let's Stop N Shop	Jaime Yorres	Owner	87 Polk St. Suite 5	San Francisco	CA	94117	USA	(415) 555-5938	NULL
LILAS	LILA-Supermercado	Carlos González	Accounting Manager	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela	(9) 331-6954	(9) 331-7256
LINOD	LINO-Delicateses	Felipe Izquierdo	Owner	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela	(8) 34-56-12	(8) 34-93-93
LONEP	Lonesome Pine Restaurant	Fran Wilson	Sales Manager	89 Chiaroscuro Rd.	Portland	OR	97219	USA	(503) 555-9573	(503) 555-9646
MAGAA	Magazzini Alimentari Riuniti	Giovanni Rovelli	Marketing Manager	Via Ludovico il Moro 22	Bergamo	NULL	24100	Italy	035-640230	035-640231
MAISD	Maison Dewey	Catherine Dewey	Sales Agent	Rue Joseph-Bens 532	Bruxelles	NULL	B-1180	Belgium	(02) 201 24 67	(02) 201 24 68
MEREP	Mère Paillarde	Jean Fresnière	Marketing Assistant	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada	(514) 555-8054	(514) 555-8055
MORGK	Morgenstern Gesundkost	Alexander Feuer	Marketing Assistant	Heerstr. 22	Leipzig	NULL	04179	Germany	0342-023176	NULL
NORTS	North/South	Simon Crowther	Sales Associate	South House 300 Queensbridge	London	NULL	SW7 1RZ	UK	(171) 555-7733	(171) 555-2530
OCEAN	Océano Atlántico Ltda.	Yvonne Moncada	Sales Agent	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	NULL	1010	Argentina	(1) 135-5333	(1) 135-5535
OLDWO	Old World Delicatessen	Rene Phillips	Sales Representative	2743 Bering St.	Anchorage	AK	99508	USA	(907) 555-7584	(907) 555-2880
OTTIK	Ottilies Käseladen	Henriette Pfalzheim	Owner	Mehrheimerstr. 369	Köln	NULL	50739	Germany	0221-0644327	0221-0765721
PARIS	Paris spécialités	Marie Bertrand	Owner	265 boulevard Charonne	Paris	NULL	75012	France	(1) 42.34.22.66	(1) 42.34.22.77
PERIC	Pericles Comidas clásicas	Guillermo Fernández	Sales Representative	Calle Dr. Jorge Cash 321	México D.F.	NULL	05033	Mexico	(5) 552-3745	(5) 545-3745
PICCO	Piccolo und mehr	Georg Pipps	Sales Manager	Geislweg 14	Salzburg	NULL	5020	Austria	6562-9722	6562-9723
PRINI	Princesa Isabel Vinhos	Isabel de Castro	Sales Representative	Estrada da saúde n. 58	Lisboa	NULL	1756	Portugal	(1) 356-5634	NULL
QUEDE	Que Delícia	Bernardo Batista	Accounting Manager	Rua da Panificadora	 12Rio de Janeiro	RJ	02389-673	Brazil	(21) 555-4252	(21) 555-4545
QUEEN	Queen Cozinha	Lúcia Carvalho	Marketing Assistant	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil	(11) 555-1189	NULL
QUICK	QUICK-Stop	Horst Kloss	Accounting Manager	Taucherstraße 10	Cunewalde	NULL	01307	Germany	0372-035188	NULL
RANCH	Rancho grande	Sergio Gutiérrez	Sales Representative	Av. del Libertador 900	Buenos Aires	NULL	1010	Argentina	(1) 123-5555	(1) 123-5556
RATTC	Rattlesnake Canyon Grocery	Paula Wilson	Assistant Sales Representative	2817 Milton Dr.	Albuquerque	NM	87110	USA	(505) 555-5939	(505) 555-3620
REGGC	Reggiani Caseifici	Maurizio Moroni	Sales Associate	Strada Provinciale 124	Reggio Emilia	NULL	42100	Italy	0522-556721	0522-556722
RICAR	Ricardo Adocicados	Janete Limeira	Assistant Sales Agent	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil	(21) 555-3412	NULL
RICSU	Richter Supermarkt	Michael Holz	Sales Manager	Grenzacherweg 237	Genève	NULL	1203	Switzerland	0897-034214	NULL
ROMEY	Romero y tomillo	Alejandra Camino	Accounting Manager	Gran Vía 1	Madrid	NULL	28001	Spain	(91) 745 6200	(91) 745 6210
SANTG	Santé Gourmet	Jonas Bergulfsen	Owner	Erling Skakkes gate 78	Stavern	NULL	4110	Norway	07-98 92 35	07-98 92 47
SAVEA	Save-a-lot Markets	Jose Pavarotti	Sales Representative	187 Suffolk Ln.	Boise	ID	83720	USA	(208) 555-8097	NULL
SEVES	Seven Seas Imports	Hari Kumar	Sales Manager	90 Wadhurst Rd.	London	NULL	OX15 4NB	UK	(171) 555-1717	(171) 555-5646
SIMOB	Simons bistro	Jytte Petersen	Owner	Vinbæltet 34	Kobenhavn	NULL	1734	Denmark	31 12 34 56	31 13 35 57
SPECD	Spécialités du monde	Dominique Perrier	Marketing Manager	25 rue Lauriston	Paris	NULL	75016	France	(1) 47.55.60.10	(1) 47.55.60.20
SPLIR	Split Rail Beer & Ale	Art Braunschweiger	Sales Manager	P.O. Box 555	Lander	WY	82520	USA	(307) 555-4680	(307) 555-6525
SUPRD	Suprêmes délices	Pascale Cartrain	Accounting Manager	Boulevard Tirou 255	Charleroi	NULL	B-6000	Belgium	(071) 23 67 22 20	(071) 23 67 22 21
THEBI	The Big Cheese	Liz Nixon	Marketing Manager	89 Jefferson Way Suite 2	Portland	OR	97201	USA	(503) 555-3612	NULL
THECR	The Cracker Box	Liu Wong	Marketing Assistant	55 Grizzly Peak Rd.	Butte	MT	59801	USA	(406) 555-5834	(406) 555-8083
TOMSP	Toms Spezialitäten	Karin Josephs	Marketing Manager	Luisenstr. 48	Münster	NULL	44087	Germany	0251-031259	0251-035695
TORTU	Tortuga Restaurante	Miguel Angel Paolino	Owner	Avda. Azteca 123	México D.F.	NULL	05033	Mexico	(5) 555-2933	NULL
TRADH	Tradição Hipermercados	Anabela Domingues	Sales Representative	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil	(11) 555-2167	(11) 555-2168
TRAIH	Trail's Head Gourmet Provisioners	Helvetius Nagy	Sales Associate	722 DaVinci Blvd.	Kirkland	WA	98034	USA	(206) 555-8257	(206) 555-2174
VAFFE	Vaffeljernet	Palle Ibsen	Sales Manager	Smagsloget 45	Århus	NULL	8200	Denmark	86 21 32 43	86 22 33 44
VICTE	Victuailles en stock	Mary Saveley	Sales Agent	2 rue du Commerce	Lyon	NULL	69004	France	78.32.54.86	78.32.54.87
VINET	Vins et alcools Chevalier	Paul Henriot	Accounting Manager	59 rue de l'Abbaye	Reims	NULL	51100	France	26.47.15.10	26.47.15.11
WANDK	Die Wandernde Kuh	Rita Müller	Sales Representative	Adenauerallee 900	Stuttgart	NULL	70563	Germany	0711-020361	0711-035428
WARTH	Wartian Herkku	Pirkko Koskitalo	Accounting Manager	Torikatu 38	Oulu	NULL	90110	Finland	981-443655	981-443655
WELLI	Wellington Importadora	Paula Parente	Sales Manager	Rua do Mercado 12	Resende	SP	08737-363	Brazil	(14) 555-8122	NULL
WHITC	White Clover Markets	Karl Jablonski	Owner	305 - 14th Ave. S. Suite 3B	Seattle	WA	98128	USA	(206) 555-4112	(206) 555-4115
WILMK	Wilman Kala	Matti Karttunen	Owner/Marketing Assistant	Keskuskatu 45	Helsinki	NULL	21240	Finland	90-224 8858	90-224 8858
WOLZA	Wolski  Zajazd	Zbyszek Piestrzeniewicz	Owner	ul. Filtrowa 68	Warszawa	NULL	01-012	Poland	(26) 642-7012	(26) 642-7012
\.


--
-- Data for Name: employee_territories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_territories (employeeid, territoryid) FROM stdin;
1	06897
1	19713
2	01581
2	01730
2	01833
2	02116
2	02139
2	02184
2	40222
3	30346
3	31406
3	32859
3	33607
4	20852
4	27403
4	27511
5	02903
5	07960
5	08837
5	10019
5	10038
5	11747
5	14450
6	85014
6	85251
6	98004
6	98052
6	98104
7	60179
7	60601
7	80202
7	80909
7	90405
7	94025
7	94105
7	95008
7	95054
7	95060
8	19428
8	44122
8	45839
8	53404
9	03049
9	03801
9	48075
9	48084
9	48304
9	55113
9	55439
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employeeid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, homephone, extension, photo, notes, reportsto, photopath) FROM stdin;
1	Davolio	Nancy	Sales Representative	Ms.	1948-12-08 00:00:00	1992-05-01 00:00:00	507 20th Ave. E. Apt. 2A	Seattle	WA	98122	USA	(206) 555-9857	5467	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344432303534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Education includes a BA in psychology from Colorado State University in 1970.  She also completed The Art of the Cold Call.  Nancy is a member of Toastmasters International.	2	http://accweb/emmployees/davolio.bmp
2	Fuller	Andrew	Vice President Sales	Dr.	1952-02-19 00:00:00	1992-08-14 00:00:00	908 W. Capital Way	Tacoma	WA	98401	USA	(206) 555-9482	3457	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344432303534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative was promoted to sales manager	NULL	http://accweb/emmployees/fuller.bmp
3	Leverling	Janet	Sales Representative	Ms.	1963-08-30 00:00:00	1992-04-01 00:00:00	722 Moss Bay Blvd.	Kirkland	WA	98033	USA	(206) 555-3412	3355	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303038303534303030303432344438303534303030303030303030303030373630303030303032383030303030304330303030303030453030303030303030313030303430303030303030303030303035343030303043453045303030304438304530303030303030303030	Janet has a BS degree in chemistry from Boston College (1984). She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.	2	http://accweb/emmployees/leverling.bmp
4	Peacock	Margaret	Sales Representative	Mrs.	1937-09-19 00:00:00	1993-05-03 00:00:00	4110 Old Redmond Rd.	Redmond	WA	98052	USA	(206) 555-8122	5176	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344432303534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.	2	http://accweb/emmployees/peacock.bmp
5	Buchanan	Steven	Sales Manager	Mr.	1955-03-04 00:00:00	1993-10-17 00:00:00	14 Garrett Hill	London	NULL	SW1 8JR	UK	(71) 555-4848	3453	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344432303534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Steven Buchanan graduated from St. Andrews University in Scotland with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992 he spent 6 months in an orientation program at the Seattle office.	2	http://accweb/emmployees/buchanan.bmp
6	Suyama	Michael	Sales Representative	Mr.	1963-07-02 00:00:00	1993-10-17 00:00:00	Coventry House Miner Rd.	London	NULL	EC2 7JR	UK	(71) 555-7773	428	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344431363534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Michael is a graduate of Sussex University (MA Economics 1983) and the University of California at Los Angeles (MBA marketing 1986).  He has also taken the courses Multi-Cultural Selling and Time Management for the Sales Professional.	5	http://accweb/emmployees/davolio.bmp
7	King	Robert	Sales Representative	Mr.	1960-05-29 00:00:00	1994-01-02 00:00:00	Edgeham Hollow Winchester Way	London	NULL	RG1 9SP	UK	(71) 555-5598	465	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344431363534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992 the year he joined the company.	5	http://accweb/emmployees/davolio.bmp
8	Callahan	Laura	Inside Sales Coordinator	Ms.	1958-01-09 00:00:00	1994-03-05 00:00:00	4726 11th Ave. N.E.	Seattle	WA	98105	USA	(206) 555-1189	2344	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344431363534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.	2	http://accweb/emmployees/davolio.bmp
9	Dodsworth	Anne	Sales Representative	Ms.	1966-01-27 00:00:00	1994-11-15 00:00:00	7 Houndstooth Rd.	London	NULL	WG2 7LT	UK	(71) 555-4444	452	\\x30783135314332463030303230303030303030443030304530303134303032313030464646464646464634323639373436443631373032303439364436313637363530303530363136393645373432453530363936333734373537323635303030313035303030303032303030303030303730303030303035303432373237353733363830303030303030303030303030303030303032303534303030303432344431363534303030303030303030303030373630303030303032383030303030304330303030303030444630303030303030313030303430303030303030303030413035333030303043453045303030304438304530303030303030303030	Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.	5	http://accweb/emmployees/davolio.bmp
\.


--
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_details (id, orderid, productid, unitprice, quantity, discount) FROM stdin;
1	10248	11	14	12	0
2	10248	42	9.80000019	10	0
3	10248	72	34.7999992	5	0
4	10249	14	18.6000004	9	0
5	10249	51	42.4000015	40	0
6	10250	41	7.69999981	10	0
7	10250	51	42.4000015	35	0.150000006
8	10250	65	16.7999992	15	0.150000006
9	10251	22	16.7999992	6	0.0500000007
10	10251	57	15.6000004	15	0.0500000007
11	10251	65	16.7999992	20	0
12	10252	20	64.8000031	40	0.0500000007
13	10252	33	2	25	0.0500000007
14	10252	60	27.2000008	40	0
15	10253	31	10	20	0
16	10253	39	14.3999996	42	0
17	10253	49	16	40	0
18	10254	24	3.5999999	15	0.150000006
19	10254	55	19.2000008	21	0.150000006
20	10254	74	8	21	0
21	10255	2	15.1999998	20	0
22	10255	16	13.8999996	35	0
23	10255	36	15.1999998	25	0
24	10255	59	44	30	0
25	10256	53	26.2000008	15	0
26	10256	77	10.3999996	12	0
27	10257	27	35.0999985	25	0
28	10257	39	14.3999996	6	0
29	10257	77	10.3999996	15	0
30	10258	2	15.1999998	50	0.200000003
31	10258	5	17	65	0.200000003
32	10258	32	25.6000004	6	0.200000003
33	10259	21	8	10	0
34	10259	37	20.7999992	1	0
35	10260	41	7.69999981	16	0.25
36	10260	57	15.6000004	50	0
37	10260	62	39.4000015	15	0.25
38	10260	70	12	21	0.25
39	10261	21	8	20	0
40	10261	35	14.3999996	20	0
41	10262	5	17	12	0.200000003
42	10262	7	24	15	0
43	10262	56	30.3999996	2	0
44	10263	16	13.8999996	60	0.25
45	10263	24	3.5999999	28	0
46	10263	30	20.7000008	60	0.25
47	10263	74	8	36	0.25
48	10264	2	15.1999998	35	0
49	10264	41	7.69999981	25	0.150000006
50	10265	17	31.2000008	30	0
51	10265	70	12	20	0
52	10266	12	30.3999996	12	0.0500000007
53	10267	40	14.6999998	50	0
54	10267	59	44	70	0.150000006
55	10267	76	14.3999996	15	0.150000006
56	10268	29	99	10	0
57	10268	72	27.7999992	4	0
58	10269	33	2	60	0.0500000007
59	10269	72	27.7999992	20	0.0500000007
60	10270	36	15.1999998	30	0
61	10270	43	36.7999992	25	0
62	10271	33	2	24	0
63	10272	20	64.8000031	6	0
64	10272	31	10	40	0
65	10272	72	27.7999992	24	0
66	10273	10	24.7999992	24	0.0500000007
67	10273	31	10	15	0.0500000007
68	10273	33	2	20	0
69	10273	40	14.6999998	60	0.0500000007
70	10273	76	14.3999996	33	0.0500000007
71	10274	71	17.2000008	20	0
72	10274	72	27.7999992	7	0
73	10275	24	3.5999999	12	0.0500000007
74	10275	59	44	6	0.0500000007
75	10276	10	24.7999992	15	0
76	10276	13	4.80000019	10	0
77	10277	28	36.4000015	20	0
78	10277	62	39.4000015	12	0
79	10278	44	15.5	16	0
80	10278	59	44	15	0
81	10278	63	35.0999985	8	0
82	10278	73	12	25	0
83	10279	17	31.2000008	15	0.25
84	10280	24	3.5999999	12	0
85	10280	55	19.2000008	20	0
86	10280	75	6.19999981	30	0
87	10281	19	7.30000019	1	0
88	10281	24	3.5999999	6	0
89	10281	35	14.3999996	4	0
90	10282	30	20.7000008	6	0
91	10282	57	15.6000004	2	0
92	10283	15	12.3999996	20	0
93	10283	19	7.30000019	18	0
94	10283	60	27.2000008	35	0
95	10283	72	27.7999992	3	0
96	10284	27	35.0999985	15	0.25
97	10284	44	15.5	21	0
98	10284	60	27.2000008	20	0.25
99	10284	67	11.1999998	5	0.25
100	10285	1	14.3999996	45	0.200000003
101	10285	40	14.6999998	40	0.200000003
102	10285	53	26.2000008	36	0.200000003
103	10286	35	14.3999996	100	0
104	10286	62	39.4000015	40	0
105	10287	16	13.8999996	40	0.150000006
106	10287	34	11.1999998	20	0
107	10287	46	9.60000038	15	0.150000006
108	10288	54	5.9000001	10	0.100000001
109	10288	68	10	3	0.100000001
110	10289	3	8	30	0
111	10289	64	26.6000004	9	0
112	10290	5	17	20	0
113	10290	29	99	15	0
114	10290	49	16	15	0
115	10290	77	10.3999996	10	0
116	10291	13	4.80000019	20	0.100000001
117	10291	44	15.5	24	0.100000001
118	10291	51	42.4000015	2	0.100000001
119	10292	20	64.8000031	20	0
120	10293	18	50	12	0
121	10293	24	3.5999999	10	0
122	10293	63	35.0999985	5	0
123	10293	75	6.19999981	6	0
124	10294	1	14.3999996	18	0
125	10294	17	31.2000008	15	0
126	10294	43	36.7999992	15	0
127	10294	60	27.2000008	21	0
128	10294	75	6.19999981	6	0
129	10295	56	30.3999996	4	0
130	10296	11	16.7999992	12	0
131	10296	16	13.8999996	30	0
132	10296	69	28.7999992	15	0
133	10297	39	14.3999996	60	0
134	10297	72	27.7999992	20	0
135	10298	2	15.1999998	40	0
136	10298	36	15.1999998	40	0.25
137	10298	59	44	30	0.25
138	10298	62	39.4000015	15	0
139	10299	19	7.30000019	15	0
140	10299	70	12	20	0
141	10300	66	13.6000004	30	0
142	10300	68	10	20	0
143	10301	40	14.6999998	10	0
144	10301	56	30.3999996	20	0
145	10302	17	31.2000008	40	0
146	10302	28	36.4000015	28	0
147	10302	43	36.7999992	12	0
148	10303	40	14.6999998	40	0.100000001
149	10303	65	16.7999992	30	0.100000001
150	10303	68	10	15	0.100000001
151	10304	49	16	30	0
152	10304	59	44	10	0
153	10304	71	17.2000008	2	0
154	10305	18	50	25	0.100000001
155	10305	29	99	25	0.100000001
156	10305	39	14.3999996	30	0.100000001
157	10306	30	20.7000008	10	0
158	10306	53	26.2000008	10	0
159	10306	54	5.9000001	5	0
160	10307	62	39.4000015	10	0
161	10307	68	10	3	0
162	10308	69	28.7999992	1	0
163	10308	70	12	5	0
164	10309	4	17.6000004	20	0
165	10309	6	20	30	0
166	10309	42	11.1999998	2	0
167	10309	43	36.7999992	20	0
168	10309	71	17.2000008	3	0
169	10310	16	13.8999996	10	0
170	10310	62	39.4000015	5	0
171	10311	42	11.1999998	6	0
172	10311	69	28.7999992	7	0
173	10312	28	36.4000015	4	0
174	10312	43	36.7999992	24	0
175	10312	53	26.2000008	20	0
176	10312	75	6.19999981	10	0
177	10313	36	15.1999998	12	0
178	10314	32	25.6000004	40	0.100000001
179	10314	58	10.6000004	30	0.100000001
180	10314	62	39.4000015	25	0.100000001
181	10315	34	11.1999998	14	0
182	10315	70	12	30	0
183	10316	41	7.69999981	10	0
184	10316	62	39.4000015	70	0
185	10317	1	14.3999996	20	0
186	10318	41	7.69999981	20	0
187	10318	76	14.3999996	6	0
188	10319	17	31.2000008	8	0
189	10319	28	36.4000015	14	0
190	10319	76	14.3999996	30	0
191	10320	71	17.2000008	30	0
192	10321	35	14.3999996	10	0
193	10322	52	5.5999999	20	0
194	10323	15	12.3999996	5	0
195	10323	25	11.1999998	4	0
196	10323	39	14.3999996	4	0
197	10324	16	13.8999996	21	0.150000006
198	10324	35	14.3999996	70	0.150000006
199	10324	46	9.60000038	30	0
200	10324	59	44	40	0.150000006
201	10324	63	35.0999985	80	0.150000006
202	10325	6	20	6	0
203	10325	13	4.80000019	12	0
204	10325	14	18.6000004	9	0
205	10325	31	10	4	0
206	10325	72	27.7999992	40	0
207	10326	4	17.6000004	24	0
208	10326	57	15.6000004	16	0
209	10326	75	6.19999981	50	0
210	10327	2	15.1999998	25	0.200000003
211	10327	11	16.7999992	50	0.200000003
212	10327	30	20.7000008	35	0.200000003
213	10327	58	10.6000004	30	0.200000003
214	10328	59	44	9	0
215	10328	65	16.7999992	40	0
216	10328	68	10	10	0
217	10329	19	7.30000019	10	0.0500000007
218	10329	30	20.7000008	8	0.0500000007
219	10329	38	210.800003	20	0.0500000007
220	10329	56	30.3999996	12	0.0500000007
221	10330	26	24.8999996	50	0.150000006
222	10330	72	27.7999992	25	0.150000006
223	10331	54	5.9000001	15	0
224	10332	18	50	40	0.200000003
225	10332	42	11.1999998	10	0.200000003
226	10332	47	7.5999999	16	0.200000003
227	10333	14	18.6000004	10	0
228	10333	21	8	10	0.100000001
229	10333	71	17.2000008	40	0.100000001
230	10334	52	5.5999999	8	0
231	10334	68	10	10	0
232	10335	2	15.1999998	7	0.200000003
233	10335	31	10	25	0.200000003
234	10335	32	25.6000004	6	0.200000003
235	10335	51	42.4000015	48	0.200000003
236	10336	4	17.6000004	18	0.100000001
237	10337	23	7.19999981	40	0
238	10337	26	24.8999996	24	0
239	10337	36	15.1999998	20	0
240	10337	37	20.7999992	28	0
241	10337	72	27.7999992	25	0
242	10338	17	31.2000008	20	0
243	10338	30	20.7000008	15	0
244	10339	4	17.6000004	10	0
245	10339	17	31.2000008	70	0.0500000007
246	10339	62	39.4000015	28	0
247	10340	18	50	20	0.0500000007
248	10340	41	7.69999981	12	0.0500000007
249	10340	43	36.7999992	40	0.0500000007
250	10341	33	2	8	0
251	10341	59	44	9	0.150000006
252	10342	2	15.1999998	24	0.200000003
253	10342	31	10	56	0.200000003
254	10342	36	15.1999998	40	0.200000003
255	10342	55	19.2000008	40	0.200000003
256	10343	64	26.6000004	50	0
257	10343	68	10	4	0.0500000007
258	10343	76	14.3999996	15	0
259	10344	4	17.6000004	35	0
260	10344	8	32	70	0.25
261	10345	8	32	70	0
262	10345	19	7.30000019	80	0
263	10345	42	11.1999998	9	0
264	10346	17	31.2000008	36	0.100000001
265	10346	56	30.3999996	20	0
266	10347	25	11.1999998	10	0
267	10347	39	14.3999996	50	0.150000006
268	10347	40	14.6999998	4	0
269	10347	75	6.19999981	6	0.150000006
270	10348	1	14.3999996	15	0.150000006
271	10348	23	7.19999981	25	0
272	10349	54	5.9000001	24	0
273	10350	50	13	15	0.100000001
274	10350	69	28.7999992	18	0.100000001
275	10351	38	210.800003	20	0.0500000007
276	10351	41	7.69999981	13	0
277	10351	44	15.5	77	0.0500000007
278	10351	65	16.7999992	10	0.0500000007
279	10352	24	3.5999999	10	0
280	10352	54	5.9000001	20	0.150000006
281	10353	11	16.7999992	12	0.200000003
282	10353	38	210.800003	50	0.200000003
283	10354	1	14.3999996	12	0
284	10354	29	99	4	0
285	10355	24	3.5999999	25	0
286	10355	57	15.6000004	25	0
287	10356	31	10	30	0
288	10356	55	19.2000008	12	0
289	10356	69	28.7999992	20	0
290	10357	10	24.7999992	30	0.200000003
291	10357	26	24.8999996	16	0
292	10357	60	27.2000008	8	0.200000003
293	10358	24	3.5999999	10	0.0500000007
294	10358	34	11.1999998	10	0.0500000007
295	10358	36	15.1999998	20	0.0500000007
296	10359	16	13.8999996	56	0.0500000007
297	10359	31	10	70	0.0500000007
298	10359	60	27.2000008	80	0.0500000007
299	10360	28	36.4000015	30	0
300	10360	29	99	35	0
301	10360	38	210.800003	10	0
302	10360	49	16	35	0
303	10360	54	5.9000001	28	0
304	10361	39	14.3999996	54	0.100000001
305	10361	60	27.2000008	55	0.100000001
306	10362	25	11.1999998	50	0
307	10362	51	42.4000015	20	0
308	10362	54	5.9000001	24	0
309	10363	31	10	20	0
310	10363	75	6.19999981	12	0
311	10363	76	14.3999996	12	0
312	10364	69	28.7999992	30	0
313	10364	71	17.2000008	5	0
314	10365	11	16.7999992	24	0
315	10366	65	16.7999992	5	0
316	10366	77	10.3999996	5	0
317	10367	34	11.1999998	36	0
318	10367	54	5.9000001	18	0
319	10367	65	16.7999992	15	0
320	10367	77	10.3999996	7	0
321	10368	21	8	5	0.100000001
322	10368	28	36.4000015	13	0.100000001
323	10368	57	15.6000004	25	0
324	10368	64	26.6000004	35	0.100000001
325	10369	29	99	20	0
326	10369	56	30.3999996	18	0.25
327	10370	1	14.3999996	15	0.150000006
328	10370	64	26.6000004	30	0
329	10370	74	8	20	0.150000006
330	10371	36	15.1999998	6	0.200000003
331	10372	20	64.8000031	12	0.25
332	10372	38	210.800003	40	0.25
333	10372	60	27.2000008	70	0.25
334	10372	72	27.7999992	42	0.25
335	10373	58	10.6000004	80	0.200000003
336	10373	71	17.2000008	50	0.200000003
337	10374	31	10	30	0
338	10374	58	10.6000004	15	0
339	10375	14	18.6000004	15	0
340	10375	54	5.9000001	10	0
341	10376	31	10	42	0.0500000007
342	10377	28	36.4000015	20	0.150000006
343	10377	39	14.3999996	20	0.150000006
344	10378	71	17.2000008	6	0
345	10379	41	7.69999981	8	0.100000001
346	10379	63	35.0999985	16	0.100000001
347	10379	65	16.7999992	20	0.100000001
348	10380	30	20.7000008	18	0.100000001
349	10380	53	26.2000008	20	0.100000001
350	10380	60	27.2000008	6	0.100000001
351	10380	70	12	30	0
352	10381	74	8	14	0
353	10382	5	17	32	0
354	10382	18	50	9	0
355	10382	29	99	14	0
356	10382	33	2	60	0
357	10382	74	8	50	0
358	10383	13	4.80000019	20	0
359	10383	50	13	15	0
360	10383	56	30.3999996	20	0
361	10384	20	64.8000031	28	0
362	10384	60	27.2000008	15	0
363	10385	7	24	10	0.200000003
364	10385	60	27.2000008	20	0.200000003
365	10385	68	10	8	0.200000003
366	10386	24	3.5999999	15	0
367	10386	34	11.1999998	10	0
368	10387	24	3.5999999	15	0
369	10387	28	36.4000015	6	0
370	10387	59	44	12	0
371	10387	71	17.2000008	15	0
372	10388	45	7.5999999	15	0.200000003
373	10388	52	5.5999999	20	0.200000003
374	10388	53	26.2000008	40	0
375	10389	10	24.7999992	16	0
376	10389	55	19.2000008	15	0
377	10389	62	39.4000015	20	0
378	10389	70	12	30	0
379	10390	31	10	60	0.100000001
380	10390	35	14.3999996	40	0.100000001
381	10390	46	9.60000038	45	0
382	10390	72	27.7999992	24	0.100000001
383	10391	13	4.80000019	18	0
384	10392	69	28.7999992	50	0
385	10393	2	15.1999998	25	0.25
386	10393	14	18.6000004	42	0.25
387	10393	25	11.1999998	7	0.25
388	10393	26	24.8999996	70	0.25
389	10393	31	10	32	0
390	10394	13	4.80000019	10	0
391	10394	62	39.4000015	10	0
392	10395	46	9.60000038	28	0.100000001
393	10395	53	26.2000008	70	0.100000001
394	10395	69	28.7999992	8	0
395	10396	23	7.19999981	40	0
396	10396	71	17.2000008	60	0
397	10396	72	27.7999992	21	0
398	10397	21	8	10	0.150000006
399	10397	51	42.4000015	18	0.150000006
400	10398	35	14.3999996	30	0
401	10398	55	19.2000008	120	0.100000001
402	10399	68	10	60	0
403	10399	71	17.2000008	30	0
404	10399	76	14.3999996	35	0
405	10399	77	10.3999996	14	0
406	10400	29	99	21	0
407	10400	35	14.3999996	35	0
408	10400	49	16	30	0
409	10401	30	20.7000008	18	0
410	10401	56	30.3999996	70	0
411	10401	65	16.7999992	20	0
412	10401	71	17.2000008	60	0
413	10402	23	7.19999981	60	0
414	10402	63	35.0999985	65	0
415	10403	16	13.8999996	21	0.150000006
416	10403	48	10.1999998	70	0.150000006
417	10404	26	24.8999996	30	0.0500000007
418	10404	42	11.1999998	40	0.0500000007
419	10404	49	16	30	0.0500000007
420	10405	3	8	50	0
421	10406	1	14.3999996	10	0
422	10406	21	8	30	0.100000001
423	10406	28	36.4000015	42	0.100000001
424	10406	36	15.1999998	5	0.100000001
425	10406	40	14.6999998	2	0.100000001
426	10407	11	16.7999992	30	0
427	10407	69	28.7999992	15	0
428	10407	71	17.2000008	15	0
429	10408	37	20.7999992	10	0
430	10408	54	5.9000001	6	0
431	10408	62	39.4000015	35	0
432	10409	14	18.6000004	12	0
433	10409	21	8	12	0
434	10410	33	2	49	0
435	10410	59	44	16	0
436	10411	41	7.69999981	25	0.200000003
437	10411	44	15.5	40	0.200000003
438	10411	59	44	9	0.200000003
439	10412	14	18.6000004	20	0.100000001
440	10413	1	14.3999996	24	0
441	10413	62	39.4000015	40	0
442	10413	76	14.3999996	14	0
443	10414	19	7.30000019	18	0.0500000007
444	10414	33	2	50	0
445	10415	17	31.2000008	2	0
446	10415	33	2	20	0
447	10416	19	7.30000019	20	0
448	10416	53	26.2000008	10	0
449	10416	57	15.6000004	20	0
450	10417	38	210.800003	50	0
451	10417	46	9.60000038	2	0.25
452	10417	68	10	36	0.25
453	10417	77	10.3999996	35	0
454	10418	2	15.1999998	60	0
455	10418	47	7.5999999	55	0
456	10418	61	22.7999992	16	0
457	10418	74	8	15	0
458	10419	60	27.2000008	60	0.0500000007
459	10419	69	28.7999992	20	0.0500000007
460	10420	9	77.5999985	20	0.100000001
461	10420	13	4.80000019	2	0.100000001
462	10420	70	12	8	0.100000001
463	10420	73	12	20	0.100000001
464	10421	19	7.30000019	4	0.150000006
465	10421	26	24.8999996	30	0
466	10421	53	26.2000008	15	0.150000006
467	10421	77	10.3999996	10	0.150000006
468	10422	26	24.8999996	2	0
469	10423	31	10	14	0
470	10423	59	44	20	0
471	10424	35	14.3999996	60	0.200000003
472	10424	38	210.800003	49	0.200000003
473	10424	68	10	30	0.200000003
474	10425	55	19.2000008	10	0.25
475	10425	76	14.3999996	20	0.25
476	10426	56	30.3999996	5	0
477	10426	64	26.6000004	7	0
478	10427	14	18.6000004	35	0
479	10428	46	9.60000038	20	0
480	10429	50	13	40	0
481	10429	63	35.0999985	35	0.25
482	10430	17	31.2000008	45	0.200000003
483	10430	21	8	50	0
484	10430	56	30.3999996	30	0
485	10430	59	44	70	0.200000003
486	10431	17	31.2000008	50	0.25
487	10431	40	14.6999998	50	0.25
488	10431	47	7.5999999	30	0.25
489	10432	26	24.8999996	10	0
490	10432	54	5.9000001	40	0
491	10433	56	30.3999996	28	0
492	10434	11	16.7999992	6	0
493	10434	76	14.3999996	18	0.150000006
494	10435	2	15.1999998	10	0
495	10435	22	16.7999992	12	0
496	10435	72	27.7999992	10	0
497	10436	46	9.60000038	5	0
498	10436	56	30.3999996	40	0.100000001
499	10436	64	26.6000004	30	0.100000001
500	10436	75	6.19999981	24	0.100000001
501	10437	53	26.2000008	15	0
502	10438	19	7.30000019	15	0.200000003
503	10438	34	11.1999998	20	0.200000003
504	10438	57	15.6000004	15	0.200000003
505	10439	12	30.3999996	15	0
506	10439	16	13.8999996	16	0
507	10439	64	26.6000004	6	0
508	10439	74	8	30	0
509	10440	2	15.1999998	45	0.150000006
510	10440	16	13.8999996	49	0.150000006
511	10440	29	99	24	0.150000006
512	10440	61	22.7999992	90	0.150000006
513	10441	27	35.0999985	50	0
514	10442	11	16.7999992	30	0
515	10442	54	5.9000001	80	0
516	10442	66	13.6000004	60	0
517	10443	11	16.7999992	6	0.200000003
518	10443	28	36.4000015	12	0
519	10444	17	31.2000008	10	0
520	10444	26	24.8999996	15	0
521	10444	35	14.3999996	8	0
522	10444	41	7.69999981	30	0
523	10445	39	14.3999996	6	0
524	10445	54	5.9000001	15	0
525	10446	19	7.30000019	12	0.100000001
526	10446	24	3.5999999	20	0.100000001
527	10446	31	10	3	0.100000001
528	10446	52	5.5999999	15	0.100000001
529	10447	19	7.30000019	40	0
530	10447	65	16.7999992	35	0
531	10447	71	17.2000008	2	0
532	10448	26	24.8999996	6	0
533	10448	40	14.6999998	20	0
534	10449	10	24.7999992	14	0
535	10449	52	5.5999999	20	0
536	10449	62	39.4000015	35	0
537	10450	10	24.7999992	20	0.200000003
538	10450	54	5.9000001	6	0.200000003
539	10451	55	19.2000008	120	0.100000001
540	10451	64	26.6000004	35	0.100000001
541	10451	65	16.7999992	28	0.100000001
542	10451	77	10.3999996	55	0.100000001
543	10452	28	36.4000015	15	0
544	10452	44	15.5	100	0.0500000007
545	10453	48	10.1999998	15	0.100000001
546	10453	70	12	25	0.100000001
547	10454	16	13.8999996	20	0.200000003
548	10454	33	2	20	0.200000003
549	10454	46	9.60000038	10	0.200000003
550	10455	39	14.3999996	20	0
551	10455	53	26.2000008	50	0
552	10455	61	22.7999992	25	0
553	10455	71	17.2000008	30	0
554	10456	21	8	40	0.150000006
555	10456	49	16	21	0.150000006
556	10457	59	44	36	0
557	10458	26	24.8999996	30	0
558	10458	28	36.4000015	30	0
559	10458	43	36.7999992	20	0
560	10458	56	30.3999996	15	0
561	10458	71	17.2000008	50	0
562	10459	7	24	16	0.0500000007
563	10459	46	9.60000038	20	0.0500000007
564	10459	72	27.7999992	40	0
565	10460	68	10	21	0.25
566	10460	75	6.19999981	4	0.25
567	10461	21	8	40	0.25
568	10461	30	20.7000008	28	0.25
569	10461	55	19.2000008	60	0.25
570	10462	13	4.80000019	1	0
571	10462	23	7.19999981	21	0
572	10463	19	7.30000019	21	0
573	10463	42	11.1999998	50	0
574	10464	4	17.6000004	16	0.200000003
575	10464	43	36.7999992	3	0
576	10464	56	30.3999996	30	0.200000003
577	10464	60	27.2000008	20	0
578	10465	24	3.5999999	25	0
579	10465	29	99	18	0.100000001
580	10465	40	14.6999998	20	0
581	10465	45	7.5999999	30	0.100000001
582	10465	50	13	25	0
583	10466	11	16.7999992	10	0
584	10466	46	9.60000038	5	0
585	10467	24	3.5999999	28	0
586	10467	25	11.1999998	12	0
587	10468	30	20.7000008	8	0
588	10468	43	36.7999992	15	0
589	10469	2	15.1999998	40	0.150000006
590	10469	16	13.8999996	35	0.150000006
591	10469	44	15.5	2	0.150000006
592	10470	18	50	30	0
593	10470	23	7.19999981	15	0
594	10470	64	26.6000004	8	0
595	10471	7	24	30	0
596	10471	56	30.3999996	20	0
597	10472	24	3.5999999	80	0.0500000007
598	10472	51	42.4000015	18	0
599	10473	33	2	12	0
600	10473	71	17.2000008	12	0
601	10474	14	18.6000004	12	0
602	10474	28	36.4000015	18	0
603	10474	40	14.6999998	21	0
604	10474	75	6.19999981	10	0
605	10475	31	10	35	0.150000006
606	10475	66	13.6000004	60	0.150000006
607	10475	76	14.3999996	42	0.150000006
608	10476	55	19.2000008	2	0.0500000007
609	10476	70	12	12	0
610	10477	1	14.3999996	15	0
611	10477	21	8	21	0.25
612	10477	39	14.3999996	20	0.25
613	10478	10	24.7999992	20	0.0500000007
614	10479	38	210.800003	30	0
615	10479	53	26.2000008	28	0
616	10479	59	44	60	0
617	10479	64	26.6000004	30	0
618	10480	47	7.5999999	30	0
619	10480	59	44	12	0
620	10481	49	16	24	0
621	10481	60	27.2000008	40	0
622	10482	40	14.6999998	10	0
623	10483	34	11.1999998	35	0.0500000007
624	10483	77	10.3999996	30	0.0500000007
625	10484	21	8	14	0
626	10484	40	14.6999998	10	0
627	10484	51	42.4000015	3	0
628	10485	2	15.1999998	20	0.100000001
629	10485	3	8	20	0.100000001
630	10485	55	19.2000008	30	0.100000001
631	10485	70	12	60	0.100000001
632	10486	11	16.7999992	5	0
633	10486	51	42.4000015	25	0
634	10486	74	8	16	0
635	10487	19	7.30000019	5	0
636	10487	26	24.8999996	30	0
637	10487	54	5.9000001	24	0.25
638	10488	59	44	30	0
639	10488	73	12	20	0.200000003
640	10489	11	16.7999992	15	0.25
641	10489	16	13.8999996	18	0
642	10490	59	44	60	0
643	10490	68	10	30	0
644	10490	75	6.19999981	36	0
645	10491	44	15.5	15	0.150000006
646	10491	77	10.3999996	7	0.150000006
647	10492	25	11.1999998	60	0.0500000007
648	10492	42	11.1999998	20	0.0500000007
649	10493	65	16.7999992	15	0.100000001
650	10493	66	13.6000004	10	0.100000001
651	10493	69	28.7999992	10	0.100000001
652	10494	56	30.3999996	30	0
653	10495	23	7.19999981	10	0
654	10495	41	7.69999981	20	0
655	10495	77	10.3999996	5	0
656	10496	31	10	20	0.0500000007
657	10497	56	30.3999996	14	0
658	10497	72	27.7999992	25	0
659	10497	77	10.3999996	25	0
660	10498	24	4.5	14	0
661	10498	40	18.3999996	5	0
662	10498	42	14	30	0
663	10499	28	45.5999985	20	0
664	10499	49	20	25	0
665	10500	15	15.5	12	0.0500000007
666	10500	28	45.5999985	8	0.0500000007
667	10501	54	7.44999981	20	0
668	10502	45	9.5	21	0
669	10502	53	32.7999992	6	0
670	10502	67	14	30	0
671	10503	14	23.25	70	0
672	10503	65	21.0499992	20	0
673	10504	2	19	12	0
674	10504	21	10	12	0
675	10504	53	32.7999992	10	0
676	10504	61	28.5	25	0
677	10505	62	49.2999992	3	0
678	10506	25	14	18	0.100000001
679	10506	70	15	14	0.100000001
680	10507	43	46	15	0.150000006
681	10507	48	12.75	15	0.150000006
682	10508	13	6	10	0
683	10508	39	18	10	0
684	10509	28	45.5999985	3	0
685	10510	29	123.790001	36	0
686	10510	75	7.75	36	0.100000001
687	10511	4	22	50	0.150000006
688	10511	7	30	50	0.150000006
689	10511	8	40	10	0.150000006
690	10512	24	4.5	10	0.150000006
691	10512	46	12	9	0.150000006
692	10512	47	9.5	6	0.150000006
693	10512	60	34	12	0.150000006
694	10513	21	10	40	0.200000003
695	10513	32	32	50	0.200000003
696	10513	61	28.5	15	0.200000003
697	10514	20	81	39	0
698	10514	28	45.5999985	35	0
699	10514	56	38	70	0
700	10514	65	21.0499992	39	0
701	10514	75	7.75	50	0
702	10515	9	97	16	0.150000006
703	10515	16	17.4500008	50	0
704	10515	27	43.9000015	120	0
705	10515	33	2.5	16	0.150000006
706	10515	60	34	84	0.150000006
707	10516	18	62.5	25	0.100000001
708	10516	41	9.64999962	80	0.100000001
709	10516	42	14	20	0
710	10517	52	7	6	0
711	10517	59	55	4	0
712	10517	70	15	6	0
713	10518	24	4.5	5	0
714	10518	38	263.5	15	0
715	10518	44	19.4500008	9	0
716	10519	10	31	16	0.0500000007
717	10519	56	38	40	0
718	10519	60	34	10	0.0500000007
719	10520	24	4.5	8	0
720	10520	53	32.7999992	5	0
721	10521	35	18	3	0
722	10521	41	9.64999962	10	0
723	10521	68	12.5	6	0
724	10522	1	18	40	0.200000003
725	10522	8	40	24	0
726	10522	30	25.8899994	20	0.200000003
727	10522	40	18.3999996	25	0.200000003
728	10523	17	39	25	0.100000001
729	10523	20	81	15	0.100000001
730	10523	37	26	18	0.100000001
731	10523	41	9.64999962	6	0.100000001
732	10524	10	31	2	0
733	10524	30	25.8899994	10	0
734	10524	43	46	60	0
735	10524	54	7.44999981	15	0
736	10525	36	19	30	0
737	10525	40	18.3999996	15	0.100000001
738	10526	1	18	8	0.150000006
739	10526	13	6	10	0
740	10526	56	38	30	0.150000006
741	10527	4	22	50	0.100000001
742	10527	36	19	30	0.100000001
743	10528	11	21	3	0
744	10528	33	2.5	8	0.200000003
745	10528	72	34.7999992	9	0
746	10529	55	24	14	0
747	10529	68	12.5	20	0
748	10529	69	36	10	0
749	10530	17	39	40	0
750	10530	43	46	25	0
751	10530	61	28.5	20	0
752	10530	76	18	50	0
753	10531	59	55	2	0
754	10532	30	25.8899994	15	0
755	10532	66	17	24	0
756	10533	4	22	50	0.0500000007
757	10533	72	34.7999992	24	0
758	10533	73	15	24	0.0500000007
759	10534	30	25.8899994	10	0
760	10534	40	18.3999996	10	0.200000003
761	10534	54	7.44999981	10	0.200000003
762	10535	11	21	50	0.100000001
763	10535	40	18.3999996	10	0.100000001
764	10535	57	19.5	5	0.100000001
765	10535	59	55	15	0.100000001
766	10536	12	38	15	0.25
767	10536	31	12.5	20	0
768	10536	33	2.5	30	0
769	10536	60	34	35	0.25
770	10537	31	12.5	30	0
771	10537	51	53	6	0
772	10537	58	13.25	20	0
773	10537	72	34.7999992	21	0
774	10537	73	15	9	0
775	10538	70	15	7	0
776	10538	72	34.7999992	1	0
777	10539	13	6	8	0
778	10539	21	10	15	0
779	10539	33	2.5	15	0
780	10539	49	20	6	0
781	10540	3	10	60	0
782	10540	26	31.2299995	40	0
783	10540	38	263.5	30	0
784	10540	68	12.5	35	0
785	10541	24	4.5	35	0.100000001
786	10541	38	263.5	4	0.100000001
787	10541	65	21.0499992	36	0.100000001
788	10541	71	21.5	9	0.100000001
789	10542	11	21	15	0.0500000007
790	10542	54	7.44999981	24	0.0500000007
791	10543	12	38	30	0.150000006
792	10543	23	9	70	0.150000006
793	10544	28	45.5999985	7	0
794	10544	67	14	7	0
795	10545	11	21	10	0
796	10546	7	30	10	0
797	10546	35	18	30	0
798	10546	62	49.2999992	40	0
799	10547	32	32	24	0.150000006
800	10547	36	19	60	0
801	10548	34	14	10	0.25
802	10548	41	9.64999962	14	0
803	10549	31	12.5	55	0.150000006
804	10549	45	9.5	100	0.150000006
805	10549	51	53	48	0.150000006
806	10550	17	39	8	0.100000001
807	10550	19	9.19999981	10	0
808	10550	21	10	6	0.100000001
809	10550	61	28.5	10	0.100000001
810	10551	16	17.4500008	40	0.150000006
811	10551	35	18	20	0.150000006
812	10551	44	19.4500008	40	0
813	10552	69	36	18	0
814	10552	75	7.75	30	0
815	10553	11	21	15	0
816	10553	16	17.4500008	14	0
817	10553	22	21	24	0
818	10553	31	12.5	30	0
819	10553	35	18	6	0
820	10554	16	17.4500008	30	0.0500000007
821	10554	23	9	20	0.0500000007
822	10554	62	49.2999992	20	0.0500000007
823	10554	77	13	10	0.0500000007
824	10555	14	23.25	30	0.200000003
825	10555	19	9.19999981	35	0.200000003
826	10555	24	4.5	18	0.200000003
827	10555	51	53	20	0.200000003
828	10555	56	38	40	0.200000003
829	10556	72	34.7999992	24	0
830	10557	64	33.25	30	0
831	10557	75	7.75	20	0
832	10558	47	9.5	25	0
833	10558	51	53	20	0
834	10558	52	7	30	0
835	10558	53	32.7999992	18	0
836	10558	73	15	3	0
837	10559	41	9.64999962	12	0.0500000007
838	10559	55	24	18	0.0500000007
839	10560	30	25.8899994	20	0
840	10560	62	49.2999992	15	0.25
841	10561	44	19.4500008	10	0
842	10561	51	53	50	0
843	10562	33	2.5	20	0.100000001
844	10562	62	49.2999992	10	0.100000001
845	10563	36	19	25	0
846	10563	52	7	70	0
847	10564	17	39	16	0.0500000007
848	10564	31	12.5	6	0.0500000007
849	10564	55	24	25	0.0500000007
850	10565	24	4.5	25	0.100000001
851	10565	64	33.25	18	0.100000001
852	10566	11	21	35	0.150000006
853	10566	18	62.5	18	0.150000006
854	10566	76	18	10	0
855	10567	31	12.5	60	0.200000003
856	10567	51	53	3	0
857	10567	59	55	40	0.200000003
858	10568	10	31	5	0
859	10569	31	12.5	35	0.200000003
860	10569	76	18	30	0
861	10570	11	21	15	0.0500000007
862	10570	56	38	60	0.0500000007
863	10571	14	23.25	11	0.150000006
864	10571	42	14	28	0.150000006
865	10572	16	17.4500008	12	0.100000001
866	10572	32	32	10	0.100000001
867	10572	40	18.3999996	50	0
868	10572	75	7.75	15	0.100000001
869	10573	17	39	18	0
870	10573	34	14	40	0
871	10573	53	32.7999992	25	0
872	10574	33	2.5	14	0
873	10574	40	18.3999996	2	0
874	10574	62	49.2999992	10	0
875	10574	64	33.25	6	0
876	10575	59	55	12	0
877	10575	63	43.9000015	6	0
878	10575	72	34.7999992	30	0
879	10575	76	18	10	0
880	10576	1	18	10	0
881	10576	31	12.5	20	0
882	10576	44	19.4500008	21	0
883	10577	39	18	10	0
884	10577	75	7.75	20	0
885	10577	77	13	18	0
886	10578	35	18	20	0
887	10578	57	19.5	6	0
888	10579	15	15.5	10	0
889	10579	75	7.75	21	0
890	10580	14	23.25	15	0.0500000007
891	10580	41	9.64999962	9	0.0500000007
892	10580	65	21.0499992	30	0.0500000007
893	10581	75	7.75	50	0.200000003
894	10582	57	19.5	4	0
895	10582	76	18	14	0
896	10583	29	123.790001	10	0
897	10583	60	34	24	0.150000006
898	10583	69	36	10	0.150000006
899	10584	31	12.5	50	0.0500000007
900	10585	47	9.5	15	0
901	10586	52	7	4	0.150000006
902	10587	26	31.2299995	6	0
903	10587	35	18	20	0
904	10587	77	13	20	0
905	10588	18	62.5	40	0.200000003
906	10588	42	14	100	0.200000003
907	10589	35	18	4	0
908	10590	1	18	20	0
909	10590	77	13	60	0.0500000007
910	10591	3	10	14	0
911	10591	7	30	10	0
912	10591	54	7.44999981	50	0
913	10592	15	15.5	25	0.0500000007
914	10592	26	31.2299995	5	0.0500000007
915	10593	20	81	21	0.200000003
916	10593	69	36	20	0.200000003
917	10593	76	18	4	0.200000003
918	10594	52	7	24	0
919	10594	58	13.25	30	0
920	10595	35	18	30	0.25
921	10595	61	28.5	120	0.25
922	10595	69	36	65	0.25
923	10596	56	38	5	0.200000003
924	10596	63	43.9000015	24	0.200000003
925	10596	75	7.75	30	0.200000003
926	10597	24	4.5	35	0.200000003
927	10597	57	19.5	20	0
928	10597	65	21.0499992	12	0.200000003
929	10598	27	43.9000015	50	0
930	10598	71	21.5	9	0
931	10599	62	49.2999992	10	0
932	10600	54	7.44999981	4	0
933	10600	73	15	30	0
934	10601	13	6	60	0
935	10601	59	55	35	0
936	10602	77	13	5	0.25
937	10603	22	21	48	0
938	10603	49	20	25	0.0500000007
939	10604	48	12.75	6	0.100000001
940	10604	76	18	10	0.100000001
941	10605	16	17.4500008	30	0.0500000007
942	10605	59	55	20	0.0500000007
943	10605	60	34	70	0.0500000007
944	10605	71	21.5	15	0.0500000007
945	10606	4	22	20	0.200000003
946	10606	55	24	20	0.200000003
947	10606	62	49.2999992	10	0.200000003
948	10607	7	30	45	0
949	10607	17	39	100	0
950	10607	33	2.5	14	0
951	10607	40	18.3999996	42	0
952	10607	72	34.7999992	12	0
953	10608	56	38	28	0
954	10609	1	18	3	0
955	10609	10	31	10	0
956	10609	21	10	6	0
957	10610	36	19	21	0.25
958	10611	1	18	6	0
959	10611	2	19	10	0
960	10611	60	34	15	0
961	10612	10	31	70	0
962	10612	36	19	55	0
963	10612	49	20	18	0
964	10612	60	34	40	0
965	10612	76	18	80	0
966	10613	13	6	8	0.100000001
967	10613	75	7.75	40	0
968	10614	11	21	14	0
969	10614	21	10	8	0
970	10614	39	18	5	0
971	10615	55	24	5	0
972	10616	38	263.5	15	0.0500000007
973	10616	56	38	14	0
974	10616	70	15	15	0.0500000007
975	10616	71	21.5	15	0.0500000007
976	10617	59	55	30	0.150000006
977	10618	6	25	70	0
978	10618	56	38	20	0
979	10618	68	12.5	15	0
980	10619	21	10	42	0
981	10619	22	21	40	0
982	10620	24	4.5	5	0
983	10620	52	7	5	0
984	10621	19	9.19999981	5	0
985	10621	23	9	10	0
986	10621	70	15	20	0
987	10621	71	21.5	15	0
988	10622	2	19	20	0
989	10622	68	12.5	18	0.200000003
990	10623	14	23.25	21	0
991	10623	19	9.19999981	15	0.100000001
992	10623	21	10	25	0.100000001
993	10623	24	4.5	3	0
994	10623	35	18	30	0.100000001
995	10624	28	45.5999985	10	0
996	10624	29	123.790001	6	0
997	10624	44	19.4500008	10	0
998	10625	14	23.25	3	0
999	10625	42	14	5	0
1000	10625	60	34	10	0
1001	10626	53	32.7999992	12	0
1002	10626	60	34	20	0
1003	10626	71	21.5	20	0
1004	10627	62	49.2999992	15	0
1005	10627	73	15	35	0.150000006
1006	10628	1	18	25	0
1007	10629	29	123.790001	20	0
1008	10629	64	33.25	9	0
1009	10630	55	24	12	0.0500000007
1010	10630	76	18	35	0
1011	10631	75	7.75	8	0.100000001
1012	10632	2	19	30	0.0500000007
1013	10632	33	2.5	20	0.0500000007
1014	10633	12	38	36	0.150000006
1015	10633	13	6	13	0.150000006
1016	10633	26	31.2299995	35	0.150000006
1017	10633	62	49.2999992	80	0.150000006
1018	10634	7	30	35	0
1019	10634	18	62.5	50	0
1020	10634	51	53	15	0
1021	10634	75	7.75	2	0
1022	10635	4	22	10	0.100000001
1023	10635	5	21.3500004	15	0.100000001
1024	10635	22	21	40	0
1025	10636	4	22	25	0
1026	10636	58	13.25	6	0
1027	10637	11	21	10	0
1028	10637	50	16.25	25	0.0500000007
1029	10637	56	38	60	0.0500000007
1030	10638	45	9.5	20	0
1031	10638	65	21.0499992	21	0
1032	10638	72	34.7999992	60	0
1033	10639	18	62.5	8	0
1034	10640	69	36	20	0.25
1035	10640	70	15	15	0.25
1036	10641	2	19	50	0
1037	10641	40	18.3999996	60	0
1038	10642	21	10	30	0.200000003
1039	10642	61	28.5	20	0.200000003
1040	10643	28	45.5999985	15	0.25
1041	10643	39	18	21	0.25
1042	10643	46	12	2	0.25
1043	10644	18	62.5	4	0.100000001
1044	10644	43	46	20	0
1045	10644	46	12	21	0.100000001
1046	10645	18	62.5	20	0
1047	10645	36	19	15	0
1048	10646	1	18	15	0.25
1049	10646	10	31	18	0.25
1050	10646	71	21.5	30	0.25
1051	10646	77	13	35	0.25
1052	10647	19	9.19999981	30	0
1053	10647	39	18	20	0
1054	10648	22	21	15	0
1055	10648	24	4.5	15	0.150000006
1056	10649	28	45.5999985	20	0
1057	10649	72	34.7999992	15	0
1058	10650	30	25.8899994	30	0
1059	10650	53	32.7999992	25	0.0500000007
1060	10650	54	7.44999981	30	0
1061	10651	19	9.19999981	12	0.25
1062	10651	22	21	20	0.25
1063	10652	30	25.8899994	2	0.25
1064	10652	42	14	20	0
1065	10653	16	17.4500008	30	0.100000001
1066	10653	60	34	20	0.100000001
1067	10654	4	22	12	0.100000001
1068	10654	39	18	20	0.100000001
1069	10654	54	7.44999981	6	0.100000001
1070	10655	41	9.64999962	20	0.200000003
1071	10656	14	23.25	3	0.100000001
1072	10656	44	19.4500008	28	0.100000001
1073	10656	47	9.5	6	0.100000001
1074	10657	15	15.5	50	0
1075	10657	41	9.64999962	24	0
1076	10657	46	12	45	0
1077	10657	47	9.5	10	0
1078	10657	56	38	45	0
1079	10657	60	34	30	0
1080	10658	21	10	60	0
1081	10658	40	18.3999996	70	0.0500000007
1082	10658	60	34	55	0.0500000007
1083	10658	77	13	70	0.0500000007
1084	10659	31	12.5	20	0.0500000007
1085	10659	40	18.3999996	24	0.0500000007
1086	10659	70	15	40	0.0500000007
1087	10660	20	81	21	0
1088	10661	39	18	3	0.200000003
1089	10661	58	13.25	49	0.200000003
1090	10662	68	12.5	10	0
1091	10663	40	18.3999996	30	0.0500000007
1092	10663	42	14	30	0.0500000007
1093	10663	51	53	20	0.0500000007
1094	10664	10	31	24	0.150000006
1095	10664	56	38	12	0.150000006
1096	10664	65	21.0499992	15	0.150000006
1097	10665	51	53	20	0
1098	10665	59	55	1	0
1099	10665	76	18	10	0
1100	10666	29	123.790001	36	0
1101	10666	65	21.0499992	10	0
1102	10667	69	36	45	0.200000003
1103	10667	71	21.5	14	0.200000003
1104	10668	31	12.5	8	0.100000001
1105	10668	55	24	4	0.100000001
1106	10668	64	33.25	15	0.100000001
1107	10669	36	19	30	0
1108	10670	23	9	32	0
1109	10670	46	12	60	0
1110	10670	67	14	25	0
1111	10670	73	15	50	0
1112	10670	75	7.75	25	0
1113	10671	16	17.4500008	10	0
1114	10671	62	49.2999992	10	0
1115	10671	65	21.0499992	12	0
1116	10672	38	263.5	15	0.100000001
1117	10672	71	21.5	12	0
1118	10673	16	17.4500008	3	0
1119	10673	42	14	6	0
1120	10673	43	46	6	0
1121	10674	23	9	5	0
1122	10675	14	23.25	30	0
1123	10675	53	32.7999992	10	0
1124	10675	58	13.25	30	0
1125	10676	10	31	2	0
1126	10676	19	9.19999981	7	0
1127	10676	44	19.4500008	21	0
1128	10677	26	31.2299995	30	0.150000006
1129	10677	33	2.5	8	0.150000006
1130	10678	12	38	100	0
1131	10678	33	2.5	30	0
1132	10678	41	9.64999962	120	0
1133	10678	54	7.44999981	30	0
1134	10679	59	55	12	0
1135	10680	16	17.4500008	50	0.25
1136	10680	31	12.5	20	0.25
1137	10680	42	14	40	0.25
1138	10681	19	9.19999981	30	0.100000001
1139	10681	21	10	12	0.100000001
1140	10681	64	33.25	28	0
1141	10682	33	2.5	30	0
1142	10682	66	17	4	0
1143	10682	75	7.75	30	0
1144	10683	52	7	9	0
1145	10684	40	18.3999996	20	0
1146	10684	47	9.5	40	0
1147	10684	60	34	30	0
1148	10685	10	31	20	0
1149	10685	41	9.64999962	4	0
1150	10685	47	9.5	15	0
1151	10686	17	39	30	0.200000003
1152	10686	26	31.2299995	15	0
1153	10687	9	97	50	0.25
1154	10687	29	123.790001	10	0
1155	10687	36	19	6	0.25
1156	10688	10	31	18	0.100000001
1157	10688	28	45.5999985	60	0.100000001
1158	10688	34	14	14	0
1159	10689	1	18	35	0.25
1160	10690	56	38	20	0.25
1161	10690	77	13	30	0.25
1162	10691	1	18	30	0
1163	10691	29	123.790001	40	0
1164	10691	43	46	40	0
1165	10691	44	19.4500008	24	0
1166	10691	62	49.2999992	48	0
1167	10692	63	43.9000015	20	0
1168	10693	9	97	6	0
1169	10693	54	7.44999981	60	0.150000006
1170	10693	69	36	30	0.150000006
1171	10693	73	15	15	0.150000006
1172	10694	7	30	90	0
1173	10694	59	55	25	0
1174	10694	70	15	50	0
1175	10695	8	40	10	0
1176	10695	12	38	4	0
1177	10695	24	4.5	20	0
1178	10696	17	39	20	0
1179	10696	46	12	18	0
1180	10697	19	9.19999981	7	0.25
1181	10697	35	18	9	0.25
1182	10697	58	13.25	30	0.25
1183	10697	70	15	30	0.25
1184	10698	11	21	15	0
1185	10698	17	39	8	0.0500000007
1186	10698	29	123.790001	12	0.0500000007
1187	10698	65	21.0499992	65	0.0500000007
1188	10698	70	15	8	0.0500000007
1189	10699	47	9.5	12	0
1190	10700	1	18	5	0.200000003
1191	10700	34	14	12	0.200000003
1192	10700	68	12.5	40	0.200000003
1193	10700	71	21.5	60	0.200000003
1194	10701	59	55	42	0.150000006
1195	10701	71	21.5	20	0.150000006
1196	10701	76	18	35	0.150000006
1197	10702	3	10	6	0
1198	10702	76	18	15	0
1199	10703	2	19	5	0
1200	10703	59	55	35	0
1201	10703	73	15	35	0
1202	10704	4	22	6	0
1203	10704	24	4.5	35	0
1204	10704	48	12.75	24	0
1205	10705	31	12.5	20	0
1206	10705	32	32	4	0
1207	10706	16	17.4500008	20	0
1208	10706	43	46	24	0
1209	10706	59	55	8	0
1210	10707	55	24	21	0
1211	10707	57	19.5	40	0
1212	10707	70	15	28	0.150000006
1213	10708	5	21.3500004	4	0
1214	10708	36	19	5	0
1215	10709	8	40	40	0
1216	10709	51	53	28	0
1217	10709	60	34	10	0
1218	10710	19	9.19999981	5	0
1219	10710	47	9.5	5	0
1220	10711	19	9.19999981	12	0
1221	10711	41	9.64999962	42	0
1222	10711	53	32.7999992	120	0
1223	10712	53	32.7999992	3	0.0500000007
1224	10712	56	38	30	0
1225	10713	10	31	18	0
1226	10713	26	31.2299995	30	0
1227	10713	45	9.5	110	0
1228	10713	46	12	24	0
1229	10714	2	19	30	0.25
1230	10714	17	39	27	0.25
1231	10714	47	9.5	50	0.25
1232	10714	56	38	18	0.25
1233	10714	58	13.25	12	0.25
1234	10715	10	31	21	0
1235	10715	71	21.5	30	0
1236	10716	21	10	5	0
1237	10716	51	53	7	0
1238	10716	61	28.5	10	0
1239	10717	21	10	32	0.0500000007
1240	10717	54	7.44999981	15	0
1241	10717	69	36	25	0.0500000007
1242	10718	12	38	36	0
1243	10718	16	17.4500008	20	0
1244	10718	36	19	40	0
1245	10718	62	49.2999992	20	0
1246	10719	18	62.5	12	0.25
1247	10719	30	25.8899994	3	0.25
1248	10719	54	7.44999981	40	0.25
1249	10720	35	18	21	0
1250	10720	71	21.5	8	0
1251	10721	44	19.4500008	50	0.0500000007
1252	10722	2	19	3	0
1253	10722	31	12.5	50	0
1254	10722	68	12.5	45	0
1255	10722	75	7.75	42	0
1256	10723	26	31.2299995	15	0
1257	10724	10	31	16	0
1258	10724	61	28.5	5	0
1259	10725	41	9.64999962	12	0
1260	10725	52	7	4	0
1261	10725	55	24	6	0
1262	10726	4	22	25	0
1263	10726	11	21	5	0
1264	10727	17	39	20	0.0500000007
1265	10727	56	38	10	0.0500000007
1266	10727	59	55	10	0.0500000007
1267	10728	30	25.8899994	15	0
1268	10728	40	18.3999996	6	0
1269	10728	55	24	12	0
1270	10728	60	34	15	0
1271	10729	1	18	50	0
1272	10729	21	10	30	0
1273	10729	50	16.25	40	0
1274	10730	16	17.4500008	15	0.0500000007
1275	10730	31	12.5	3	0.0500000007
1276	10730	65	21.0499992	10	0.0500000007
1277	10731	21	10	40	0.0500000007
1278	10731	51	53	30	0.0500000007
1279	10732	76	18	20	0
1280	10733	14	23.25	16	0
1281	10733	28	45.5999985	20	0
1282	10733	52	7	25	0
1283	10734	6	25	30	0
1284	10734	30	25.8899994	15	0
1285	10734	76	18	20	0
1286	10735	61	28.5	20	0.100000001
1287	10735	77	13	2	0.100000001
1288	10736	65	21.0499992	40	0
1289	10736	75	7.75	20	0
1290	10737	13	6	4	0
1291	10737	41	9.64999962	12	0
1292	10738	16	17.4500008	3	0
1293	10739	36	19	6	0
1294	10739	52	7	18	0
1295	10740	28	45.5999985	5	0.200000003
1296	10740	35	18	35	0.200000003
1297	10740	45	9.5	40	0.200000003
1298	10740	56	38	14	0.200000003
1299	10741	2	19	15	0.200000003
1300	10742	3	10	20	0
1301	10742	60	34	50	0
1302	10742	72	34.7999992	35	0
1303	10743	46	12	28	0.0500000007
1304	10744	40	18.3999996	50	0.200000003
1305	10745	18	62.5	24	0
1306	10745	44	19.4500008	16	0
1307	10745	59	55	45	0
1308	10745	72	34.7999992	7	0
1309	10746	13	6	6	0
1310	10746	42	14	28	0
1311	10746	62	49.2999992	9	0
1312	10746	69	36	40	0
1313	10747	31	12.5	8	0
1314	10747	41	9.64999962	35	0
1315	10747	63	43.9000015	9	0
1316	10747	69	36	30	0
1317	10748	23	9	44	0
1318	10748	40	18.3999996	40	0
1319	10748	56	38	28	0
1320	10749	56	38	15	0
1321	10749	59	55	6	0
1322	10749	76	18	10	0
1323	10750	14	23.25	5	0.150000006
1324	10750	45	9.5	40	0.150000006
1325	10750	59	55	25	0.150000006
1326	10751	26	31.2299995	12	0.100000001
1327	10751	30	25.8899994	30	0
1328	10751	50	16.25	20	0.100000001
1329	10751	73	15	15	0
1330	10752	1	18	8	0
1331	10752	69	36	3	0
1332	10753	45	9.5	4	0
1333	10753	74	10	5	0
1334	10754	40	18.3999996	3	0
1335	10755	47	9.5	30	0.25
1336	10755	56	38	30	0.25
1337	10755	57	19.5	14	0.25
1338	10755	69	36	25	0.25
1339	10756	18	62.5	21	0.200000003
1340	10756	36	19	20	0.200000003
1341	10756	68	12.5	6	0.200000003
1342	10756	69	36	20	0.200000003
1343	10757	34	14	30	0
1344	10757	59	55	7	0
1345	10757	62	49.2999992	30	0
1346	10757	64	33.25	24	0
1347	10758	26	31.2299995	20	0
1348	10758	52	7	60	0
1349	10758	70	15	40	0
1350	10759	32	32	10	0
1351	10760	25	14	12	0.25
1352	10760	27	43.9000015	40	0
1353	10760	43	46	30	0.25
1354	10761	25	14	35	0.25
1355	10761	75	7.75	18	0
1356	10762	39	18	16	0
1357	10762	47	9.5	30	0
1358	10762	51	53	28	0
1359	10762	56	38	60	0
1360	10763	21	10	40	0
1361	10763	22	21	6	0
1362	10763	24	4.5	20	0
1363	10764	3	10	20	0.100000001
1364	10764	39	18	130	0.100000001
1365	10765	65	21.0499992	80	0.100000001
1366	10766	2	19	40	0
1367	10766	7	30	35	0
1368	10766	68	12.5	40	0
1369	10767	42	14	2	0
1370	10768	22	21	4	0
1371	10768	31	12.5	50	0
1372	10768	60	34	15	0
1373	10768	71	21.5	12	0
1374	10769	41	9.64999962	30	0.0500000007
1375	10769	52	7	15	0.0500000007
1376	10769	61	28.5	20	0
1377	10769	62	49.2999992	15	0
1378	10770	11	21	15	0.25
1379	10771	71	21.5	16	0
1380	10772	29	123.790001	18	0
1381	10772	59	55	25	0
1382	10773	17	39	33	0
1383	10773	31	12.5	70	0.200000003
1384	10773	75	7.75	7	0.200000003
1385	10774	31	12.5	2	0.25
1386	10774	66	17	50	0
1387	10775	10	31	6	0
1388	10775	67	14	3	0
1389	10776	31	12.5	16	0.0500000007
1390	10776	42	14	12	0.0500000007
1391	10776	45	9.5	27	0.0500000007
1392	10776	51	53	120	0.0500000007
1393	10777	42	14	20	0.200000003
1394	10778	41	9.64999962	10	0
1395	10779	16	17.4500008	20	0
1396	10779	62	49.2999992	20	0
1397	10780	70	15	35	0
1398	10780	77	13	15	0
1399	10781	54	7.44999981	3	0.200000003
1400	10781	56	38	20	0.200000003
1401	10781	74	10	35	0
1402	10782	31	12.5	1	0
1403	10783	31	12.5	10	0
1404	10783	38	263.5	5	0
1405	10784	36	19	30	0
1406	10784	39	18	2	0.150000006
1407	10784	72	34.7999992	30	0.150000006
1408	10785	10	31	10	0
1409	10785	75	7.75	10	0
1410	10786	8	40	30	0.200000003
1411	10786	30	25.8899994	15	0.200000003
1412	10786	75	7.75	42	0.200000003
1413	10787	2	19	15	0.0500000007
1414	10787	29	123.790001	20	0.0500000007
1415	10788	19	9.19999981	50	0.0500000007
1416	10788	75	7.75	40	0.0500000007
1417	10789	18	62.5	30	0
1418	10789	35	18	15	0
1419	10789	63	43.9000015	30	0
1420	10789	68	12.5	18	0
1421	10790	7	30	3	0.150000006
1422	10790	56	38	20	0.150000006
1423	10791	29	123.790001	14	0.0500000007
1424	10791	41	9.64999962	20	0.0500000007
1425	10792	2	19	10	0
1426	10792	54	7.44999981	3	0
1427	10792	68	12.5	15	0
1428	10793	41	9.64999962	14	0
1429	10793	52	7	8	0
1430	10794	14	23.25	15	0.200000003
1431	10794	54	7.44999981	6	0.200000003
1432	10795	16	17.4500008	65	0
1433	10795	17	39	35	0.25
1434	10796	26	31.2299995	21	0.200000003
1435	10796	44	19.4500008	10	0
1436	10796	64	33.25	35	0.200000003
1437	10796	69	36	24	0.200000003
1438	10797	11	21	20	0
1439	10798	62	49.2999992	2	0
1440	10798	72	34.7999992	10	0
1441	10799	13	6	20	0.150000006
1442	10799	24	4.5	20	0.150000006
1443	10799	59	55	25	0
1444	10800	11	21	50	0.100000001
1445	10800	51	53	10	0.100000001
1446	10800	54	7.44999981	7	0.100000001
1447	10801	17	39	40	0.25
1448	10801	29	123.790001	20	0.25
1449	10802	30	25.8899994	25	0.25
1450	10802	51	53	30	0.25
1451	10802	55	24	60	0.25
1452	10802	62	49.2999992	5	0.25
1453	10803	19	9.19999981	24	0.0500000007
1454	10803	25	14	15	0.0500000007
1455	10803	59	55	15	0.0500000007
1456	10804	10	31	36	0
1457	10804	28	45.5999985	24	0
1458	10804	49	20	4	0.150000006
1459	10805	34	14	10	0
1460	10805	38	263.5	10	0
1461	10806	2	19	20	0.25
1462	10806	65	21.0499992	2	0
1463	10806	74	10	15	0.25
1464	10807	40	18.3999996	1	0
1465	10808	56	38	20	0.150000006
1466	10808	76	18	50	0.150000006
1467	10809	52	7	20	0
1468	10810	13	6	7	0
1469	10810	25	14	5	0
1470	10810	70	15	5	0
1471	10811	19	9.19999981	15	0
1472	10811	23	9	18	0
1473	10811	40	18.3999996	30	0
1474	10812	31	12.5	16	0.100000001
1475	10812	72	34.7999992	40	0.100000001
1476	10812	77	13	20	0
1477	10813	2	19	12	0.200000003
1478	10813	46	12	35	0
1479	10814	41	9.64999962	20	0
1480	10814	43	46	20	0.150000006
1481	10814	48	12.75	8	0.150000006
1482	10814	61	28.5	30	0.150000006
1483	10815	33	2.5	16	0
1484	10816	38	263.5	30	0.0500000007
1485	10816	62	49.2999992	20	0.0500000007
1486	10817	26	31.2299995	40	0.150000006
1487	10817	38	263.5	30	0
1488	10817	40	18.3999996	60	0.150000006
1489	10817	62	49.2999992	25	0.150000006
1490	10818	32	32	20	0
1491	10818	41	9.64999962	20	0
1492	10819	43	46	7	0
1493	10819	75	7.75	20	0
1494	10820	56	38	30	0
1495	10821	35	18	20	0
1496	10821	51	53	6	0
1497	10822	62	49.2999992	3	0
1498	10822	70	15	6	0
1499	10823	11	21	20	0.100000001
1500	10823	57	19.5	15	0
1501	10823	59	55	40	0.100000001
1502	10823	77	13	15	0.100000001
1503	10824	41	9.64999962	12	0
1504	10824	70	15	9	0
1505	10825	26	31.2299995	12	0
1506	10825	53	32.7999992	20	0
1507	10826	31	12.5	35	0
1508	10826	57	19.5	15	0
1509	10827	10	31	15	0
1510	10827	39	18	21	0
1511	10828	20	81	5	0
1512	10828	38	263.5	2	0
1513	10829	2	19	10	0
1514	10829	8	40	20	0
1515	10829	13	6	10	0
1516	10829	60	34	21	0
1517	10830	6	25	6	0
1518	10830	39	18	28	0
1519	10830	60	34	30	0
1520	10830	68	12.5	24	0
1521	10831	19	9.19999981	2	0
1522	10831	35	18	8	0
1523	10831	38	263.5	8	0
1524	10831	43	46	9	0
1525	10832	13	6	3	0.200000003
1526	10832	25	14	10	0.200000003
1527	10832	44	19.4500008	16	0.200000003
1528	10832	64	33.25	3	0
1529	10833	7	30	20	0.100000001
1530	10833	31	12.5	9	0.100000001
1531	10833	53	32.7999992	9	0.100000001
1532	10834	29	123.790001	8	0.0500000007
1533	10834	30	25.8899994	20	0.0500000007
1534	10835	59	55	15	0
1535	10835	77	13	2	0.200000003
1536	10836	22	21	52	0
1537	10836	35	18	6	0
1538	10836	57	19.5	24	0
1539	10836	60	34	60	0
1540	10836	64	33.25	30	0
1541	10837	13	6	6	0
1542	10837	40	18.3999996	25	0
1543	10837	47	9.5	40	0.25
1544	10837	76	18	21	0.25
1545	10838	1	18	4	0.25
1546	10838	18	62.5	25	0.25
1547	10838	36	19	50	0.25
1548	10839	58	13.25	30	0.100000001
1549	10839	72	34.7999992	15	0.100000001
1550	10840	25	14	6	0.200000003
1551	10840	39	18	10	0.200000003
1552	10841	10	31	16	0
1553	10841	56	38	30	0
1554	10841	59	55	50	0
1555	10841	77	13	15	0
1556	10842	11	21	15	0
1557	10842	43	46	5	0
1558	10842	68	12.5	20	0
1559	10842	70	15	12	0
1560	10843	51	53	4	0.25
1561	10844	22	21	35	0
1562	10845	23	9	70	0.100000001
1563	10845	35	18	25	0.100000001
1564	10845	42	14	42	0.100000001
1565	10845	58	13.25	60	0.100000001
1566	10845	64	33.25	48	0
1567	10846	4	22	21	0
1568	10846	70	15	30	0
1569	10846	74	10	20	0
1570	10847	1	18	80	0.200000003
1571	10847	19	9.19999981	12	0.200000003
1572	10847	37	26	60	0.200000003
1573	10847	45	9.5	36	0.200000003
1574	10847	60	34	45	0.200000003
1575	10847	71	21.5	55	0.200000003
1576	10848	5	21.3500004	30	0
1577	10848	9	97	3	0
1578	10849	3	10	49	0
1579	10849	26	31.2299995	18	0.150000006
1580	10850	25	14	20	0.150000006
1581	10850	33	2.5	4	0.150000006
1582	10850	70	15	30	0.150000006
1583	10851	2	19	5	0.0500000007
1584	10851	25	14	10	0.0500000007
1585	10851	57	19.5	10	0.0500000007
1586	10851	59	55	42	0.0500000007
1587	10852	2	19	15	0
1588	10852	17	39	6	0
1589	10852	62	49.2999992	50	0
1590	10853	18	62.5	10	0
1591	10854	10	31	100	0.150000006
1592	10854	13	6	65	0.150000006
1593	10855	16	17.4500008	50	0
1594	10855	31	12.5	14	0
1595	10855	56	38	24	0
1596	10855	65	21.0499992	15	0.150000006
1597	10856	2	19	20	0
1598	10856	42	14	20	0
1599	10857	3	10	30	0
1600	10857	26	31.2299995	35	0.25
1601	10857	29	123.790001	10	0.25
1602	10858	7	30	5	0
1603	10858	27	43.9000015	10	0
1604	10858	70	15	4	0
1605	10859	24	4.5	40	0.25
1606	10859	54	7.44999981	35	0.25
1607	10859	64	33.25	30	0.25
1608	10860	51	53	3	0
1609	10860	76	18	20	0
1610	10861	17	39	42	0
1611	10861	18	62.5	20	0
1612	10861	21	10	40	0
1613	10861	33	2.5	35	0
1614	10861	62	49.2999992	3	0
1615	10862	11	21	25	0
1616	10862	52	7	8	0
1617	10863	1	18	20	0.150000006
1618	10863	58	13.25	12	0.150000006
1619	10864	35	18	4	0
1620	10864	67	14	15	0
1621	10865	38	263.5	60	0.0500000007
1622	10865	39	18	80	0.0500000007
1623	10866	2	19	21	0.25
1624	10866	24	4.5	6	0.25
1625	10866	30	25.8899994	40	0.25
1626	10867	53	32.7999992	3	0
1627	10868	26	31.2299995	20	0
1628	10868	35	18	30	0
1629	10868	49	20	42	0.100000001
1630	10869	1	18	40	0
1631	10869	11	21	10	0
1632	10869	23	9	50	0
1633	10869	68	12.5	20	0
1634	10870	35	18	3	0
1635	10870	51	53	2	0
1636	10871	6	25	50	0.0500000007
1637	10871	16	17.4500008	12	0.0500000007
1638	10871	17	39	16	0.0500000007
1639	10872	55	24	10	0.0500000007
1640	10872	62	49.2999992	20	0.0500000007
1641	10872	64	33.25	15	0.0500000007
1642	10872	65	21.0499992	21	0.0500000007
1643	10873	21	10	20	0
1644	10873	28	45.5999985	3	0
1645	10874	10	31	10	0
1646	10875	19	9.19999981	25	0
1647	10875	47	9.5	21	0.100000001
1648	10875	49	20	15	0
1649	10876	46	12	21	0
1650	10876	64	33.25	20	0
1651	10877	16	17.4500008	30	0.25
1652	10877	18	62.5	25	0
1653	10878	20	81	20	0.0500000007
1654	10879	40	18.3999996	12	0
1655	10879	65	21.0499992	10	0
1656	10879	76	18	10	0
1657	10880	23	9	30	0.200000003
1658	10880	61	28.5	30	0.200000003
1659	10880	70	15	50	0.200000003
1660	10881	73	15	10	0
1661	10882	42	14	25	0
1662	10882	49	20	20	0.150000006
1663	10882	54	7.44999981	32	0.150000006
1664	10883	24	4.5	8	0
1665	10884	21	10	40	0.0500000007
1666	10884	56	38	21	0.0500000007
1667	10884	65	21.0499992	12	0.0500000007
1668	10885	2	19	20	0
1669	10885	24	4.5	12	0
1670	10885	70	15	30	0
1671	10885	77	13	25	0
1672	10886	10	31	70	0
1673	10886	31	12.5	35	0
1674	10886	77	13	40	0
1675	10887	25	14	5	0
1676	10888	2	19	20	0
1677	10888	68	12.5	18	0
1678	10889	11	21	40	0
1679	10889	38	263.5	40	0
1680	10890	17	39	15	0
1681	10890	34	14	10	0
1682	10890	41	9.64999962	14	0
1683	10891	30	25.8899994	15	0.0500000007
1684	10892	59	55	40	0.0500000007
1685	10893	8	40	30	0
1686	10893	24	4.5	10	0
1687	10893	29	123.790001	24	0
1688	10893	30	25.8899994	35	0
1689	10893	36	19	20	0
1690	10894	13	6	28	0.0500000007
1691	10894	69	36	50	0.0500000007
1692	10894	75	7.75	120	0.0500000007
1693	10895	24	4.5	110	0
1694	10895	39	18	45	0
1695	10895	40	18.3999996	91	0
1696	10895	60	34	100	0
1697	10896	45	9.5	15	0
1698	10896	56	38	16	0
1699	10897	29	123.790001	80	0
1700	10897	30	25.8899994	36	0
1701	10898	13	6	5	0
1702	10899	39	18	8	0.150000006
1703	10900	70	15	3	0.25
1704	10901	41	9.64999962	30	0
1705	10901	71	21.5	30	0
1706	10902	55	24	30	0.150000006
1707	10902	62	49.2999992	6	0.150000006
1708	10903	13	6	40	0
1709	10903	65	21.0499992	21	0
1710	10903	68	12.5	20	0
1711	10904	58	13.25	15	0
1712	10904	62	49.2999992	35	0
1713	10905	1	18	20	0.0500000007
1714	10906	61	28.5	15	0
1715	10907	75	7.75	14	0
1716	10908	7	30	20	0.0500000007
1717	10908	52	7	14	0.0500000007
1718	10909	7	30	12	0
1719	10909	16	17.4500008	15	0
1720	10909	41	9.64999962	5	0
1721	10910	19	9.19999981	12	0
1722	10910	49	20	10	0
1723	10910	61	28.5	5	0
1724	10911	1	18	10	0
1725	10911	17	39	12	0
1726	10911	67	14	15	0
1727	10912	11	21	40	0.25
1728	10912	29	123.790001	60	0.25
1729	10913	4	22	30	0.25
1730	10913	33	2.5	40	0.25
1731	10913	58	13.25	15	0
1732	10914	71	21.5	25	0
1733	10915	17	39	10	0
1734	10915	33	2.5	30	0
1735	10915	54	7.44999981	10	0
1736	10916	16	17.4500008	6	0
1737	10916	32	32	6	0
1738	10916	57	19.5	20	0
1739	10917	30	25.8899994	1	0
1740	10917	60	34	10	0
1741	10918	1	18	60	0.25
1742	10918	60	34	25	0.25
1743	10919	16	17.4500008	24	0
1744	10919	25	14	24	0
1745	10919	40	18.3999996	20	0
1746	10920	50	16.25	24	0
1747	10921	35	18	10	0
1748	10921	63	43.9000015	40	0
1749	10922	17	39	15	0
1750	10922	24	4.5	35	0
1751	10923	42	14	10	0.200000003
1752	10923	43	46	10	0.200000003
1753	10923	67	14	24	0.200000003
1754	10924	10	31	20	0.100000001
1755	10924	28	45.5999985	30	0.100000001
1756	10924	75	7.75	6	0
1757	10925	36	19	25	0.150000006
1758	10925	52	7	12	0.150000006
1759	10926	11	21	2	0
1760	10926	13	6	10	0
1761	10926	19	9.19999981	7	0
1762	10926	72	34.7999992	10	0
1763	10927	20	81	5	0
1764	10927	52	7	5	0
1765	10927	76	18	20	0
1766	10928	47	9.5	5	0
1767	10928	76	18	5	0
1768	10929	21	10	60	0
1769	10929	75	7.75	49	0
1770	10929	77	13	15	0
1771	10930	21	10	36	0
1772	10930	27	43.9000015	25	0
1773	10930	55	24	25	0.200000003
1774	10930	58	13.25	30	0.200000003
1775	10931	13	6	42	0.150000006
1776	10931	57	19.5	30	0
1777	10932	16	17.4500008	30	0.100000001
1778	10932	62	49.2999992	14	0.100000001
1779	10932	72	34.7999992	16	0
1780	10932	75	7.75	20	0.100000001
1781	10933	53	32.7999992	2	0
1782	10933	61	28.5	30	0
1783	10934	6	25	20	0
1784	10935	1	18	21	0
1785	10935	18	62.5	4	0.25
1786	10935	23	9	8	0.25
1787	10936	36	19	30	0.200000003
1788	10937	28	45.5999985	8	0
1789	10937	34	14	20	0
1790	10938	13	6	20	0.25
1791	10938	43	46	24	0.25
1792	10938	60	34	49	0.25
1793	10938	71	21.5	35	0.25
1794	10939	2	19	10	0.150000006
1795	10939	67	14	40	0.150000006
1796	10940	7	30	8	0
1797	10940	13	6	20	0
1798	10941	31	12.5	44	0.25
1799	10941	62	49.2999992	30	0.25
1800	10941	68	12.5	80	0.25
1801	10941	72	34.7999992	50	0
1802	10942	49	20	28	0
1803	10943	13	6	15	0
1804	10943	22	21	21	0
1805	10943	46	12	15	0
1806	10944	11	21	5	0.25
1807	10944	44	19.4500008	18	0.25
1808	10944	56	38	18	0
1809	10945	13	6	20	0
1810	10945	31	12.5	10	0
1811	10946	10	31	25	0
1812	10946	24	4.5	25	0
1813	10946	77	13	40	0
1814	10947	59	55	4	0
1815	10948	50	16.25	9	0
1816	10948	51	53	40	0
1817	10948	55	24	4	0
1818	10949	6	25	12	0
1819	10949	10	31	30	0
1820	10949	17	39	6	0
1821	10949	62	49.2999992	60	0
1822	10950	4	22	5	0
1823	10951	33	2.5	15	0.0500000007
1824	10951	41	9.64999962	6	0.0500000007
1825	10951	75	7.75	50	0.0500000007
1826	10952	6	25	16	0.0500000007
1827	10952	28	45.5999985	2	0
1828	10953	20	81	50	0.0500000007
1829	10953	31	12.5	50	0.0500000007
1830	10954	16	17.4500008	28	0.150000006
1831	10954	31	12.5	25	0.150000006
1832	10954	45	9.5	30	0
1833	10954	60	34	24	0.150000006
1834	10955	75	7.75	12	0.200000003
1835	10956	21	10	12	0
1836	10956	47	9.5	14	0
1837	10956	51	53	8	0
1838	10957	30	25.8899994	30	0
1839	10957	35	18	40	0
1840	10957	64	33.25	8	0
1841	10958	5	21.3500004	20	0
1842	10958	7	30	6	0
1843	10958	72	34.7999992	5	0
1844	10959	75	7.75	20	0.150000006
1845	10960	24	4.5	10	0.25
1846	10960	41	9.64999962	24	0
1847	10961	52	7	6	0.0500000007
1848	10961	76	18	60	0
1849	10962	7	30	45	0
1850	10962	13	6	77	0
1851	10962	53	32.7999992	20	0
1852	10962	69	36	9	0
1853	10962	76	18	44	0
1854	10963	60	34	2	0.150000006
1855	10964	18	62.5	6	0
1856	10964	38	263.5	5	0
1857	10964	69	36	10	0
1858	10965	51	53	16	0
1859	10966	37	26	8	0
1860	10966	56	38	12	0.150000006
1861	10966	62	49.2999992	12	0.150000006
1862	10967	19	9.19999981	12	0
1863	10967	49	20	40	0
1864	10968	12	38	30	0
1865	10968	24	4.5	30	0
1866	10968	64	33.25	4	0
1867	10969	46	12	9	0
1868	10970	52	7	40	0.200000003
1869	10971	29	123.790001	14	0
1870	10972	17	39	6	0
1871	10972	33	2.5	7	0
1872	10973	26	31.2299995	5	0
1873	10973	41	9.64999962	6	0
1874	10973	75	7.75	10	0
1875	10974	63	43.9000015	10	0
1876	10975	8	40	16	0
1877	10975	75	7.75	10	0
1878	10976	28	45.5999985	20	0
1879	10977	39	18	30	0
1880	10977	47	9.5	30	0
1881	10977	51	53	10	0
1882	10977	63	43.9000015	20	0
1883	10978	8	40	20	0.150000006
1884	10978	21	10	40	0.150000006
1885	10978	40	18.3999996	10	0
1886	10978	44	19.4500008	6	0.150000006
1887	10979	7	30	18	0
1888	10979	12	38	20	0
1889	10979	24	4.5	80	0
1890	10979	27	43.9000015	30	0
1891	10979	31	12.5	24	0
1892	10979	63	43.9000015	35	0
1893	10980	75	7.75	40	0.200000003
1894	10981	38	263.5	60	0
1895	10982	7	30	20	0
1896	10982	43	46	9	0
1897	10983	13	6	84	0.150000006
1898	10983	57	19.5	15	0
1899	10984	16	17.4500008	55	0
1900	10984	24	4.5	20	0
1901	10984	36	19	40	0
1902	10985	16	17.4500008	36	0.100000001
1903	10985	18	62.5	8	0.100000001
1904	10985	32	32	35	0.100000001
1905	10986	11	21	30	0
1906	10986	20	81	15	0
1907	10986	76	18	10	0
1908	10986	77	13	15	0
1909	10987	7	30	60	0
1910	10987	43	46	6	0
1911	10987	72	34.7999992	20	0
1912	10988	7	30	60	0
1913	10988	62	49.2999992	40	0.100000001
1914	10989	6	25	40	0
1915	10989	11	21	15	0
1916	10989	41	9.64999962	4	0
1917	10990	21	10	65	0
1918	10990	34	14	60	0.150000006
1919	10990	55	24	65	0.150000006
1920	10990	61	28.5	66	0.150000006
1921	10991	2	19	50	0.200000003
1922	10991	70	15	20	0.200000003
1923	10991	76	18	90	0.200000003
1924	10992	72	34.7999992	2	0
1925	10993	29	123.790001	50	0.25
1926	10993	41	9.64999962	35	0.25
1927	10994	59	55	18	0.0500000007
1928	10995	51	53	20	0
1929	10995	60	34	4	0
1930	10996	42	14	40	0
1931	10997	32	32	50	0
1932	10997	46	12	20	0.25
1933	10997	52	7	20	0.25
1934	10998	24	4.5	12	0
1935	10998	61	28.5	7	0
1936	10998	74	10	20	0
1937	10998	75	7.75	30	0
1938	10999	41	9.64999962	20	0.0500000007
1939	10999	51	53	15	0.0500000007
1940	10999	77	13	21	0.0500000007
1941	11000	4	22	25	0.25
1942	11000	24	4.5	30	0.25
1943	11000	77	13	30	0
1944	11001	7	30	60	0
1945	11001	22	21	25	0
1946	11001	46	12	25	0
1947	11001	55	24	6	0
1948	11002	13	6	56	0
1949	11002	35	18	15	0.150000006
1950	11002	42	14	24	0.150000006
1951	11002	55	24	40	0
1952	11003	1	18	4	0
1953	11003	40	18.3999996	10	0
1954	11003	52	7	10	0
1955	11004	26	31.2299995	6	0
1956	11004	76	18	6	0
1957	11005	1	18	2	0
1958	11005	59	55	10	0
1959	11006	1	18	8	0
1960	11006	29	123.790001	2	0.25
1961	11007	8	40	30	0
1962	11007	29	123.790001	10	0
1963	11007	42	14	14	0
1964	11008	28	45.5999985	70	0.0500000007
1965	11008	34	14	90	0.0500000007
1966	11008	71	21.5	21	0
1967	11009	24	4.5	12	0
1968	11009	36	19	18	0.25
1969	11009	60	34	9	0
1970	11010	7	30	20	0
1971	11010	24	4.5	10	0
1972	11011	58	13.25	40	0.0500000007
1973	11011	71	21.5	20	0
1974	11012	19	9.19999981	50	0.0500000007
1975	11012	60	34	36	0.0500000007
1976	11012	71	21.5	60	0.0500000007
1977	11013	23	9	10	0
1978	11013	42	14	4	0
1979	11013	45	9.5	20	0
1980	11013	68	12.5	2	0
1981	11014	41	9.64999962	28	0.100000001
1982	11015	30	25.8899994	15	0
1983	11015	77	13	18	0
1984	11016	31	12.5	15	0
1985	11016	36	19	16	0
1986	11017	3	10	25	0
1987	11017	59	55	110	0
1988	11017	70	15	30	0
1989	11018	12	38	20	0
1990	11018	18	62.5	10	0
1991	11018	56	38	5	0
1992	11019	46	12	3	0
1993	11019	49	20	2	0
1994	11020	10	31	24	0.150000006
1995	11021	2	19	11	0.25
1996	11021	20	81	15	0
1997	11021	26	31.2299995	63	0
1998	11021	51	53	44	0.25
1999	11021	72	34.7999992	35	0
2000	11022	19	9.19999981	35	0
2001	11022	69	36	30	0
2002	11023	7	30	4	0
2003	11023	43	46	30	0
2004	11024	26	31.2299995	12	0
2005	11024	33	2.5	30	0
2006	11024	65	21.0499992	21	0
2007	11024	71	21.5	50	0
2008	11025	1	18	10	0.100000001
2009	11025	13	6	20	0.100000001
2010	11026	18	62.5	8	0
2011	11026	51	53	10	0
2012	11027	24	4.5	30	0.25
2013	11027	62	49.2999992	21	0.25
2014	11028	55	24	35	0
2015	11028	59	55	24	0
2016	11029	56	38	20	0
2017	11029	63	43.9000015	12	0
2018	11030	2	19	100	0.25
2019	11030	5	21.3500004	70	0
2020	11030	29	123.790001	60	0.25
2021	11030	59	55	100	0.25
2022	11031	1	18	45	0
2023	11031	13	6	80	0
2024	11031	24	4.5	21	0
2025	11031	64	33.25	20	0
2026	11031	71	21.5	16	0
2027	11032	36	19	35	0
2028	11032	38	263.5	25	0
2029	11032	59	55	30	0
2030	11033	53	32.7999992	70	0.100000001
2031	11033	69	36	36	0.100000001
2032	11034	21	10	15	0.100000001
2033	11034	44	19.4500008	12	0
2034	11034	61	28.5	6	0
2035	11035	1	18	10	0
2036	11035	35	18	60	0
2037	11035	42	14	30	0
2038	11035	54	7.44999981	10	0
2039	11036	13	6	7	0
2040	11036	59	55	30	0
2041	11037	70	15	4	0
2042	11038	40	18.3999996	5	0.200000003
2043	11038	52	7	2	0
2044	11038	71	21.5	30	0
2045	11039	28	45.5999985	20	0
2046	11039	35	18	24	0
2047	11039	49	20	60	0
2048	11039	57	19.5	28	0
2049	11040	21	10	20	0
2050	11041	2	19	30	0.200000003
2051	11041	63	43.9000015	30	0
2052	11042	44	19.4500008	15	0
2053	11042	61	28.5	4	0
2054	11043	11	21	10	0
2055	11044	62	49.2999992	12	0
2056	11045	33	2.5	15	0
2057	11045	51	53	24	0
2058	11046	12	38	20	0.0500000007
2059	11046	32	32	15	0.0500000007
2060	11046	35	18	18	0.0500000007
2061	11047	1	18	25	0.25
2062	11047	5	21.3500004	30	0.25
2063	11048	68	12.5	42	0
2064	11049	2	19	10	0.200000003
2065	11049	12	38	4	0.200000003
2066	11050	76	18	50	0.100000001
2067	11051	24	4.5	10	0.200000003
2068	11052	43	46	30	0.200000003
2069	11052	61	28.5	10	0.200000003
2070	11053	18	62.5	35	0.200000003
2071	11053	32	32	20	0
2072	11053	64	33.25	25	0.200000003
2073	11054	33	2.5	10	0
2074	11054	67	14	20	0
2075	11055	24	4.5	15	0
2076	11055	25	14	15	0
2077	11055	51	53	20	0
2078	11055	57	19.5	20	0
2079	11056	7	30	40	0
2080	11056	55	24	35	0
2081	11056	60	34	50	0
2082	11057	70	15	3	0
2083	11058	21	10	3	0
2084	11058	60	34	21	0
2085	11058	61	28.5	4	0
2086	11059	13	6	30	0
2087	11059	17	39	12	0
2088	11059	60	34	35	0
2089	11060	60	34	4	0
2090	11060	77	13	10	0
2091	11061	60	34	15	0
2092	11062	53	32.7999992	10	0.200000003
2093	11062	70	15	12	0.200000003
2094	11063	34	14	30	0
2095	11063	40	18.3999996	40	0.100000001
2096	11063	41	9.64999962	30	0.100000001
2097	11064	17	39	77	0.100000001
2098	11064	41	9.64999962	12	0
2099	11064	53	32.7999992	25	0.100000001
2100	11064	55	24	4	0.100000001
2101	11064	68	12.5	55	0
2102	11065	30	25.8899994	4	0.25
2103	11065	54	7.44999981	20	0.25
2104	11066	16	17.4500008	3	0
2105	11066	19	9.19999981	42	0
2106	11066	34	14	35	0
2107	11067	41	9.64999962	9	0
2108	11068	28	45.5999985	8	0.150000006
2109	11068	43	46	36	0.150000006
2110	11068	77	13	28	0.150000006
2111	11069	39	18	20	0
2112	11070	1	18	40	0.150000006
2113	11070	2	19	20	0.150000006
2114	11070	16	17.4500008	30	0.150000006
2115	11070	31	12.5	20	0
2116	11071	7	30	15	0.0500000007
2117	11071	13	6	10	0.0500000007
2118	11072	2	19	8	0
2119	11072	41	9.64999962	40	0
2120	11072	50	16.25	22	0
2121	11072	64	33.25	130	0
2122	11073	11	21	10	0
2123	11073	24	4.5	20	0
2124	11074	16	17.4500008	14	0.0500000007
2125	11075	2	19	10	0.150000006
2126	11075	46	12	30	0.150000006
2127	11075	76	18	2	0.150000006
2128	11076	6	25	20	0.25
2129	11076	14	23.25	20	0.25
2130	11076	19	9.19999981	10	0.25
2131	11077	2	19	24	0.200000003
2132	11077	3	10	4	0
2133	11077	4	22	1	0
2134	11077	6	25	1	0.0199999996
2135	11077	7	30	1	0.0500000007
2136	11077	8	40	2	0.100000001
2137	11077	10	31	1	0
2138	11077	12	38	2	0.0500000007
2139	11077	13	6	4	0
2140	11077	14	23.25	1	0.0299999993
2141	11077	16	17.4500008	2	0.0299999993
2142	11077	20	81	1	0.0399999991
2143	11077	23	9	2	0
2144	11077	32	32	1	0
2145	11077	39	18	2	0.0500000007
2146	11077	41	9.64999962	3	0
2147	11077	46	12	3	0.0199999996
2148	11077	52	7	2	0
2149	11077	55	24	2	0
2150	11077	60	34	2	0.0599999987
2151	11077	64	33.25	2	0.0299999993
2152	11077	66	17	1	0
2153	11077	73	15	2	0.00999999978
2154	11077	75	7.75	4	0
2155	11077	77	13	2	0
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipvia, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry) FROM stdin;
10248	VINET	5	1996-07-04 00:00:00	1996-08-01 00:00:00	1996-07-16 00:00:00	3	32.3800011	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France
10249	TOMSP	6	1996-07-05 00:00:00	1996-08-16 00:00:00	1996-07-10 00:00:00	1	11.6099997	Toms Spezialitäten	Luisenstr. 48	Münster	\N	44087	Germany
10250	HANAR	4	1996-07-08 00:00:00	1996-08-05 00:00:00	1996-07-12 00:00:00	2	65.8300018	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10251	VICTE	3	1996-07-08 00:00:00	1996-08-05 00:00:00	1996-07-15 00:00:00	1	41.3400002	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10252	SUPRD	4	1996-07-09 00:00:00	1996-08-06 00:00:00	1996-07-11 00:00:00	2	51.2999992	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10253	HANAR	3	1996-07-10 00:00:00	1996-07-24 00:00:00	1996-07-16 00:00:00	2	58.1699982	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10254	CHOPS	5	1996-07-11 00:00:00	1996-08-08 00:00:00	1996-07-23 00:00:00	2	22.9799995	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
10255	RICSU	9	1996-07-12 00:00:00	1996-08-09 00:00:00	1996-07-15 00:00:00	3	148.330002	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10256	WELLI	3	1996-07-15 00:00:00	1996-08-12 00:00:00	1996-07-17 00:00:00	2	13.9700003	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10257	HILAA	4	1996-07-16 00:00:00	1996-08-13 00:00:00	1996-07-22 00:00:00	3	81.9100037	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10258	ERNSH	1	1996-07-17 00:00:00	1996-08-14 00:00:00	1996-07-23 00:00:00	1	140.509995	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10259	CENTC	4	1996-07-18 00:00:00	1996-08-15 00:00:00	1996-07-25 00:00:00	3	3.25	Centro comercial Moctezuma	Sierras de Granada 9993	México D.F.	\N	05022	Mexico
10260	OTTIK	4	1996-07-19 00:00:00	1996-08-16 00:00:00	1996-07-29 00:00:00	1	55.0900002	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10261	QUEDE	4	1996-07-19 00:00:00	1996-08-16 00:00:00	1996-07-30 00:00:00	2	3.04999995	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10262	RATTC	8	1996-07-22 00:00:00	1996-08-19 00:00:00	1996-07-25 00:00:00	3	48.2900009	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10263	ERNSH	9	1996-07-23 00:00:00	1996-08-20 00:00:00	1996-07-31 00:00:00	3	146.059998	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10264	FOLKO	6	1996-07-24 00:00:00	1996-08-21 00:00:00	1996-08-23 00:00:00	3	3.67000008	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10265	BLONP	2	1996-07-25 00:00:00	1996-08-22 00:00:00	1996-08-12 00:00:00	1	55.2799988	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10266	WARTH	3	1996-07-26 00:00:00	1996-09-06 00:00:00	1996-07-31 00:00:00	3	25.7299995	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10267	FRANK	4	1996-07-29 00:00:00	1996-08-26 00:00:00	1996-08-06 00:00:00	1	208.580002	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10268	GROSR	8	1996-07-30 00:00:00	1996-08-27 00:00:00	1996-08-02 00:00:00	3	66.2900009	GROSELLA-Restaurante	5ª Ave. Los Palos Grandes	Caracas	DF	1081	Venezuela
10269	WHITC	5	1996-07-31 00:00:00	1996-08-14 00:00:00	1996-08-09 00:00:00	1	4.55999994	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10270	WARTH	1	1996-08-01 00:00:00	1996-08-29 00:00:00	1996-08-02 00:00:00	1	136.539993	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10271	SPLIR	6	1996-08-01 00:00:00	1996-08-29 00:00:00	1996-08-30 00:00:00	2	4.53999996	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10272	RATTC	6	1996-08-02 00:00:00	1996-08-30 00:00:00	1996-08-06 00:00:00	2	98.0299988	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10273	QUICK	3	1996-08-05 00:00:00	1996-09-02 00:00:00	1996-08-12 00:00:00	3	76.0699997	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10274	VINET	6	1996-08-06 00:00:00	1996-09-03 00:00:00	1996-08-16 00:00:00	1	6.01000023	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France
10275	MAGAA	1	1996-08-07 00:00:00	1996-09-04 00:00:00	1996-08-09 00:00:00	1	26.9300003	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10276	TORTU	8	1996-08-08 00:00:00	1996-08-22 00:00:00	1996-08-14 00:00:00	3	13.8400002	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10277	MORGK	2	1996-08-09 00:00:00	1996-09-06 00:00:00	1996-08-13 00:00:00	3	125.769997	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany
10278	BERGS	8	1996-08-12 00:00:00	1996-09-09 00:00:00	1996-08-16 00:00:00	2	92.6900024	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10279	LEHMS	8	1996-08-13 00:00:00	1996-09-10 00:00:00	1996-08-16 00:00:00	2	25.8299999	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10280	BERGS	2	1996-08-14 00:00:00	1996-09-11 00:00:00	1996-09-12 00:00:00	1	8.97999954	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10281	ROMEY	4	1996-08-14 00:00:00	1996-08-28 00:00:00	1996-08-21 00:00:00	1	2.94000006	Romero y tomillo	Gran Vía 1	Madrid	\N	28001	Spain
10282	ROMEY	4	1996-08-15 00:00:00	1996-09-12 00:00:00	1996-08-21 00:00:00	1	12.6899996	Romero y tomillo	Gran Vía 1	Madrid	\N	28001	Spain
10283	LILAS	3	1996-08-16 00:00:00	1996-09-13 00:00:00	1996-08-23 00:00:00	3	84.8099976	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10284	LEHMS	4	1996-08-19 00:00:00	1996-09-16 00:00:00	1996-08-27 00:00:00	1	76.5599976	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10285	QUICK	1	1996-08-20 00:00:00	1996-09-17 00:00:00	1996-08-26 00:00:00	2	76.8300018	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10286	QUICK	8	1996-08-21 00:00:00	1996-09-18 00:00:00	1996-08-30 00:00:00	3	229.240005	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10287	RICAR	8	1996-08-22 00:00:00	1996-09-19 00:00:00	1996-08-28 00:00:00	3	12.7600002	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10288	REGGC	4	1996-08-23 00:00:00	1996-09-20 00:00:00	1996-09-03 00:00:00	1	7.44999981	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10289	BSBEV	7	1996-08-26 00:00:00	1996-09-23 00:00:00	1996-08-28 00:00:00	3	22.7700005	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10290	COMMI	8	1996-08-27 00:00:00	1996-09-24 00:00:00	1996-09-03 00:00:00	1	79.6999969	Comércio Mineiro	Av. dos Lusíadas 23	Sao Paulo	SP	05432-043	Brazil
10291	QUEDE	6	1996-08-27 00:00:00	1996-09-24 00:00:00	1996-09-04 00:00:00	2	6.4000001	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10292	TRADH	1	1996-08-28 00:00:00	1996-09-25 00:00:00	1996-09-02 00:00:00	2	1.35000002	Tradiçao Hipermercados	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil
10293	TORTU	1	1996-08-29 00:00:00	1996-09-26 00:00:00	1996-09-11 00:00:00	3	21.1800003	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10294	RATTC	4	1996-08-30 00:00:00	1996-09-27 00:00:00	1996-09-05 00:00:00	2	147.259995	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10295	VINET	2	1996-09-02 00:00:00	1996-09-30 00:00:00	1996-09-10 00:00:00	2	1.14999998	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France
10296	LILAS	6	1996-09-03 00:00:00	1996-10-01 00:00:00	1996-09-11 00:00:00	1	0.119999997	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10297	BLONP	5	1996-09-04 00:00:00	1996-10-16 00:00:00	1996-09-10 00:00:00	2	5.73999977	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10298	HUNGO	6	1996-09-05 00:00:00	1996-10-03 00:00:00	1996-09-11 00:00:00	2	168.220001	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10299	RICAR	4	1996-09-06 00:00:00	1996-10-04 00:00:00	1996-09-13 00:00:00	2	29.7600002	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10300	MAGAA	2	1996-09-09 00:00:00	1996-10-07 00:00:00	1996-09-18 00:00:00	2	17.6800003	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10301	WANDK	8	1996-09-09 00:00:00	1996-10-07 00:00:00	1996-09-17 00:00:00	2	45.0800018	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10302	SUPRD	4	1996-09-10 00:00:00	1996-10-08 00:00:00	1996-10-09 00:00:00	2	6.26999998	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10303	GODOS	7	1996-09-11 00:00:00	1996-10-09 00:00:00	1996-09-18 00:00:00	2	107.830002	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10304	TORTU	1	1996-09-12 00:00:00	1996-10-10 00:00:00	1996-09-17 00:00:00	2	63.7900009	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10305	OLDWO	8	1996-09-13 00:00:00	1996-10-11 00:00:00	1996-10-09 00:00:00	3	257.619995	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10306	ROMEY	1	1996-09-16 00:00:00	1996-10-14 00:00:00	1996-09-23 00:00:00	3	7.55999994	Romero y tomillo	Gran Vía 1	Madrid	\N	28001	Spain
10307	LONEP	2	1996-09-17 00:00:00	1996-10-15 00:00:00	1996-09-25 00:00:00	2	0.560000002	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10308	ANATR	7	1996-09-18 00:00:00	1996-10-16 00:00:00	1996-09-24 00:00:00	3	1.61000001	Ana Trujillo Emparedados y helados	Avda. de la Constitución 2222	México D.F.	\N	05021	Mexico
10309	HUNGO	3	1996-09-19 00:00:00	1996-10-17 00:00:00	1996-10-23 00:00:00	1	47.2999992	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10310	THEBI	8	1996-09-20 00:00:00	1996-10-18 00:00:00	1996-09-27 00:00:00	2	17.5200005	The Big Cheese	89 Jefferson Way Suite 2	Portland	OR	97201	USA
10311	DUMON	1	1996-09-20 00:00:00	1996-10-04 00:00:00	1996-09-26 00:00:00	3	24.6900005	Du monde entier	67 rue des Cinquante Otages	Nantes	\N	44000	France
10312	WANDK	2	1996-09-23 00:00:00	1996-10-21 00:00:00	1996-10-03 00:00:00	2	40.2599983	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10313	QUICK	2	1996-09-24 00:00:00	1996-10-22 00:00:00	1996-10-04 00:00:00	2	1.96000004	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10314	RATTC	1	1996-09-25 00:00:00	1996-10-23 00:00:00	1996-10-04 00:00:00	2	74.1600037	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10315	ISLAT	4	1996-09-26 00:00:00	1996-10-24 00:00:00	1996-10-03 00:00:00	2	41.7599983	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10316	RATTC	1	1996-09-27 00:00:00	1996-10-25 00:00:00	1996-10-08 00:00:00	3	150.149994	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10317	LONEP	6	1996-09-30 00:00:00	1996-10-28 00:00:00	1996-10-10 00:00:00	1	12.6899996	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10318	ISLAT	8	1996-10-01 00:00:00	1996-10-29 00:00:00	1996-10-04 00:00:00	2	4.73000002	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10319	TORTU	7	1996-10-02 00:00:00	1996-10-30 00:00:00	1996-10-11 00:00:00	3	64.5	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10320	WARTH	5	1996-10-03 00:00:00	1996-10-17 00:00:00	1996-10-18 00:00:00	3	34.5699997	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10321	ISLAT	3	1996-10-03 00:00:00	1996-10-31 00:00:00	1996-10-11 00:00:00	2	3.43000007	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10322	PERIC	7	1996-10-04 00:00:00	1996-11-01 00:00:00	1996-10-23 00:00:00	3	0.400000006	Pericles Comidas clásicas	Calle Dr. Jorge Cash 321	México D.F.	\N	05033	Mexico
10323	KOENE	4	1996-10-07 00:00:00	1996-11-04 00:00:00	1996-10-14 00:00:00	1	4.88000011	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10324	SAVEA	9	1996-10-08 00:00:00	1996-11-05 00:00:00	1996-10-10 00:00:00	1	214.270004	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10325	KOENE	1	1996-10-09 00:00:00	1996-10-23 00:00:00	1996-10-14 00:00:00	3	64.8600006	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10326	BOLID	4	1996-10-10 00:00:00	1996-11-07 00:00:00	1996-10-14 00:00:00	2	77.9199982	Bólido Comidas preparadas	C/ Araquil 67	Madrid	\N	28023	Spain
10327	FOLKO	2	1996-10-11 00:00:00	1996-11-08 00:00:00	1996-10-14 00:00:00	1	63.3600006	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10328	FURIB	4	1996-10-14 00:00:00	1996-11-11 00:00:00	1996-10-17 00:00:00	3	87.0299988	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10329	SPLIR	4	1996-10-15 00:00:00	1996-11-26 00:00:00	1996-10-23 00:00:00	2	191.669998	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10330	LILAS	3	1996-10-16 00:00:00	1996-11-13 00:00:00	1996-10-28 00:00:00	1	12.75	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10331	BONAP	9	1996-10-16 00:00:00	1996-11-27 00:00:00	1996-10-21 00:00:00	1	10.1899996	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10332	MEREP	3	1996-10-17 00:00:00	1996-11-28 00:00:00	1996-10-21 00:00:00	2	52.8400002	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10333	WARTH	5	1996-10-18 00:00:00	1996-11-15 00:00:00	1996-10-25 00:00:00	3	0.589999974	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10334	VICTE	8	1996-10-21 00:00:00	1996-11-18 00:00:00	1996-10-28 00:00:00	2	8.56000042	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10335	HUNGO	7	1996-10-22 00:00:00	1996-11-19 00:00:00	1996-10-24 00:00:00	2	42.1100006	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10336	PRINI	7	1996-10-23 00:00:00	1996-11-20 00:00:00	1996-10-25 00:00:00	2	15.5100002	Princesa Isabel Vinhos	Estrada da saúde n. 58	Lisboa	\N	1756	Portugal
10337	FRANK	4	1996-10-24 00:00:00	1996-11-21 00:00:00	1996-10-29 00:00:00	3	108.260002	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10338	OLDWO	4	1996-10-25 00:00:00	1996-11-22 00:00:00	1996-10-29 00:00:00	3	84.2099991	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10339	MEREP	2	1996-10-28 00:00:00	1996-11-25 00:00:00	1996-11-04 00:00:00	2	15.6599998	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10340	BONAP	1	1996-10-29 00:00:00	1996-11-26 00:00:00	1996-11-08 00:00:00	3	166.309998	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10341	SIMOB	7	1996-10-29 00:00:00	1996-11-26 00:00:00	1996-11-05 00:00:00	3	26.7800007	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
10342	FRANK	4	1996-10-30 00:00:00	1996-11-13 00:00:00	1996-11-04 00:00:00	2	54.8300018	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10343	LEHMS	4	1996-10-31 00:00:00	1996-11-28 00:00:00	1996-11-06 00:00:00	1	110.370003	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10344	WHITC	4	1996-11-01 00:00:00	1996-11-29 00:00:00	1996-11-05 00:00:00	2	23.2900009	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10345	QUICK	2	1996-11-04 00:00:00	1996-12-02 00:00:00	1996-11-11 00:00:00	2	249.059998	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10346	RATTC	3	1996-11-05 00:00:00	1996-12-17 00:00:00	1996-11-08 00:00:00	3	142.080002	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10347	FAMIA	4	1996-11-06 00:00:00	1996-12-04 00:00:00	1996-11-08 00:00:00	3	3.0999999	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10348	WANDK	4	1996-11-07 00:00:00	1996-12-05 00:00:00	1996-11-15 00:00:00	2	0.779999971	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10349	SPLIR	7	1996-11-08 00:00:00	1996-12-06 00:00:00	1996-11-15 00:00:00	1	8.63000011	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10350	LAMAI	6	1996-11-11 00:00:00	1996-12-09 00:00:00	1996-12-03 00:00:00	2	64.1900024	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10351	ERNSH	1	1996-11-11 00:00:00	1996-12-09 00:00:00	1996-11-20 00:00:00	1	162.330002	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10352	FURIB	3	1996-11-12 00:00:00	1996-11-26 00:00:00	1996-11-18 00:00:00	3	1.29999995	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10353	PICCO	7	1996-11-13 00:00:00	1996-12-11 00:00:00	1996-11-25 00:00:00	3	360.630005	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10354	PERIC	8	1996-11-14 00:00:00	1996-12-12 00:00:00	1996-11-20 00:00:00	3	53.7999992	Pericles Comidas clásicas	Calle Dr. Jorge Cash 321	México D.F.	\N	05033	Mexico
10355	AROUT	6	1996-11-15 00:00:00	1996-12-13 00:00:00	1996-11-20 00:00:00	1	41.9500008	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10356	WANDK	6	1996-11-18 00:00:00	1996-12-16 00:00:00	1996-11-27 00:00:00	2	36.7099991	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10357	LILAS	1	1996-11-19 00:00:00	1996-12-17 00:00:00	1996-12-02 00:00:00	3	34.8800011	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10358	LAMAI	5	1996-11-20 00:00:00	1996-12-18 00:00:00	1996-11-27 00:00:00	1	19.6399994	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10359	SEVES	5	1996-11-21 00:00:00	1996-12-19 00:00:00	1996-11-26 00:00:00	3	288.429993	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10360	BLONP	4	1996-11-22 00:00:00	1996-12-20 00:00:00	1996-12-02 00:00:00	3	131.699997	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10361	QUICK	1	1996-11-22 00:00:00	1996-12-20 00:00:00	1996-12-03 00:00:00	2	183.169998	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10362	BONAP	3	1996-11-25 00:00:00	1996-12-23 00:00:00	1996-11-28 00:00:00	1	96.0400009	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10363	DRACD	4	1996-11-26 00:00:00	1996-12-24 00:00:00	1996-12-04 00:00:00	3	30.5400009	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany
10364	EASTC	1	1996-11-26 00:00:00	1997-01-07 00:00:00	1996-12-04 00:00:00	1	71.9700012	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
10365	ANTON	3	1996-11-27 00:00:00	1996-12-25 00:00:00	1996-12-02 00:00:00	2	22	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10366	GALED	8	1996-11-28 00:00:00	1997-01-09 00:00:00	1996-12-30 00:00:00	2	10.1400003	Galería del gastronómo	Rambla de Cataluña 23	Barcelona	\N	8022	Spain
10367	VAFFE	7	1996-11-28 00:00:00	1996-12-26 00:00:00	1996-12-02 00:00:00	3	13.5500002	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10368	ERNSH	2	1996-11-29 00:00:00	1996-12-27 00:00:00	1996-12-02 00:00:00	2	101.949997	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10369	SPLIR	8	1996-12-02 00:00:00	1996-12-30 00:00:00	1996-12-09 00:00:00	2	195.679993	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10370	CHOPS	6	1996-12-03 00:00:00	1996-12-31 00:00:00	1996-12-27 00:00:00	2	1.16999996	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
10371	LAMAI	1	1996-12-03 00:00:00	1996-12-31 00:00:00	1996-12-24 00:00:00	1	0.449999988	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10372	QUEEN	5	1996-12-04 00:00:00	1997-01-01 00:00:00	1996-12-09 00:00:00	2	890.780029	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10373	HUNGO	4	1996-12-05 00:00:00	1997-01-02 00:00:00	1996-12-11 00:00:00	3	124.120003	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10374	WOLZA	1	1996-12-05 00:00:00	1997-01-02 00:00:00	1996-12-09 00:00:00	3	3.94000006	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
10375	HUNGC	3	1996-12-06 00:00:00	1997-01-03 00:00:00	1996-12-09 00:00:00	2	20.1200008	Hungry Coyote Import Store	City Center Plaza 516 Main St.	Elgin	OR	97827	USA
10376	MEREP	1	1996-12-09 00:00:00	1997-01-06 00:00:00	1996-12-13 00:00:00	2	20.3899994	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10377	SEVES	1	1996-12-09 00:00:00	1997-01-06 00:00:00	1996-12-13 00:00:00	3	22.2099991	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10378	FOLKO	5	1996-12-10 00:00:00	1997-01-07 00:00:00	1996-12-19 00:00:00	3	5.44000006	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10379	QUEDE	2	1996-12-11 00:00:00	1997-01-08 00:00:00	1996-12-13 00:00:00	1	45.0299988	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10380	HUNGO	8	1996-12-12 00:00:00	1997-01-09 00:00:00	1997-01-16 00:00:00	3	35.0299988	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10381	LILAS	3	1996-12-12 00:00:00	1997-01-09 00:00:00	1996-12-13 00:00:00	3	7.98999977	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10382	ERNSH	4	1996-12-13 00:00:00	1997-01-10 00:00:00	1996-12-16 00:00:00	1	94.7699966	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10383	AROUT	8	1996-12-16 00:00:00	1997-01-13 00:00:00	1996-12-18 00:00:00	3	34.2400017	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10384	BERGS	3	1996-12-16 00:00:00	1997-01-13 00:00:00	1996-12-20 00:00:00	3	168.639999	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10385	SPLIR	1	1996-12-17 00:00:00	1997-01-14 00:00:00	1996-12-23 00:00:00	2	30.9599991	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10386	FAMIA	9	1996-12-18 00:00:00	1997-01-01 00:00:00	1996-12-25 00:00:00	3	13.9899998	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10387	SANTG	1	1996-12-18 00:00:00	1997-01-15 00:00:00	1996-12-20 00:00:00	2	93.6299973	Santé Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway
10388	SEVES	2	1996-12-19 00:00:00	1997-01-16 00:00:00	1996-12-20 00:00:00	1	34.8600006	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10389	BOTTM	4	1996-12-20 00:00:00	1997-01-17 00:00:00	1996-12-24 00:00:00	2	47.4199982	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10390	ERNSH	6	1996-12-23 00:00:00	1997-01-20 00:00:00	1996-12-26 00:00:00	1	126.379997	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10391	DRACD	3	1996-12-23 00:00:00	1997-01-20 00:00:00	1996-12-31 00:00:00	3	5.44999981	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany
10392	PICCO	2	1996-12-24 00:00:00	1997-01-21 00:00:00	1997-01-01 00:00:00	3	122.459999	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10393	SAVEA	1	1996-12-25 00:00:00	1997-01-22 00:00:00	1997-01-03 00:00:00	3	126.559998	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10394	HUNGC	1	1996-12-25 00:00:00	1997-01-22 00:00:00	1997-01-03 00:00:00	3	30.3400002	Hungry Coyote Import Store	City Center Plaza 516 Main St.	Elgin	OR	97827	USA
10395	HILAA	6	1996-12-26 00:00:00	1997-01-23 00:00:00	1997-01-03 00:00:00	1	184.410004	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10396	FRANK	1	1996-12-27 00:00:00	1997-01-10 00:00:00	1997-01-06 00:00:00	3	135.350006	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10397	PRINI	5	1996-12-27 00:00:00	1997-01-24 00:00:00	1997-01-02 00:00:00	1	60.2599983	Princesa Isabel Vinhos	Estrada da saúde n. 58	Lisboa	\N	1756	Portugal
10398	SAVEA	2	1996-12-30 00:00:00	1997-01-27 00:00:00	1997-01-09 00:00:00	3	89.1600037	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10399	VAFFE	8	1996-12-31 00:00:00	1997-01-14 00:00:00	1997-01-08 00:00:00	3	27.3600006	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10400	EASTC	1	1997-01-01 00:00:00	1997-01-29 00:00:00	1997-01-16 00:00:00	3	83.9300003	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
10401	RATTC	1	1997-01-01 00:00:00	1997-01-29 00:00:00	1997-01-10 00:00:00	1	12.5100002	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10402	ERNSH	8	1997-01-02 00:00:00	1997-02-13 00:00:00	1997-01-10 00:00:00	2	67.8799973	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10403	ERNSH	4	1997-01-03 00:00:00	1997-01-31 00:00:00	1997-01-09 00:00:00	3	73.7900009	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10404	MAGAA	2	1997-01-03 00:00:00	1997-01-31 00:00:00	1997-01-08 00:00:00	1	155.970001	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10405	LINOD	1	1997-01-06 00:00:00	1997-02-03 00:00:00	1997-01-22 00:00:00	1	34.8199997	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10406	QUEEN	7	1997-01-07 00:00:00	1997-02-18 00:00:00	1997-01-13 00:00:00	1	108.040001	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10407	OTTIK	2	1997-01-07 00:00:00	1997-02-04 00:00:00	1997-01-30 00:00:00	2	91.4800034	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10408	FOLIG	8	1997-01-08 00:00:00	1997-02-05 00:00:00	1997-01-14 00:00:00	1	11.2600002	Folies gourmandes	184 chaussée de Tournai	Lille	\N	59000	France
10409	OCEAN	3	1997-01-09 00:00:00	1997-02-06 00:00:00	1997-01-14 00:00:00	1	29.8299999	Océano Atlántico Ltda.	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	\N	1010	Argentina
10410	BOTTM	3	1997-01-10 00:00:00	1997-02-07 00:00:00	1997-01-15 00:00:00	3	2.4000001	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10411	BOTTM	9	1997-01-10 00:00:00	1997-02-07 00:00:00	1997-01-21 00:00:00	3	23.6499996	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10412	WARTH	8	1997-01-13 00:00:00	1997-02-10 00:00:00	1997-01-15 00:00:00	2	3.76999998	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10854	ERNSH	3	1998-01-27 00:00:00	1998-02-24 00:00:00	1998-02-05 00:00:00	2	100.220001	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10413	LAMAI	3	1997-01-14 00:00:00	1997-02-11 00:00:00	1997-01-16 00:00:00	2	95.6600037	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10414	FAMIA	2	1997-01-14 00:00:00	1997-02-11 00:00:00	1997-01-17 00:00:00	3	21.4799995	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10415	HUNGC	3	1997-01-15 00:00:00	1997-02-12 00:00:00	1997-01-24 00:00:00	1	0.200000003	Hungry Coyote Import Store	City Center Plaza 516 Main St.	Elgin	OR	97827	USA
10416	WARTH	8	1997-01-16 00:00:00	1997-02-13 00:00:00	1997-01-27 00:00:00	3	22.7199993	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10417	SIMOB	4	1997-01-16 00:00:00	1997-02-13 00:00:00	1997-01-28 00:00:00	3	70.2900009	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
10418	QUICK	4	1997-01-17 00:00:00	1997-02-14 00:00:00	1997-01-24 00:00:00	1	17.5499992	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10419	RICSU	4	1997-01-20 00:00:00	1997-02-17 00:00:00	1997-01-30 00:00:00	2	137.350006	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10420	WELLI	3	1997-01-21 00:00:00	1997-02-18 00:00:00	1997-01-27 00:00:00	1	44.1199989	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10421	QUEDE	8	1997-01-21 00:00:00	1997-03-04 00:00:00	1997-01-27 00:00:00	1	99.2300034	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10422	FRANS	2	1997-01-22 00:00:00	1997-02-19 00:00:00	1997-01-31 00:00:00	1	3.01999998	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy
10423	GOURL	6	1997-01-23 00:00:00	1997-02-06 00:00:00	1997-02-24 00:00:00	3	24.5	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10424	MEREP	7	1997-01-23 00:00:00	1997-02-20 00:00:00	1997-01-27 00:00:00	2	370.609985	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10425	LAMAI	6	1997-01-24 00:00:00	1997-02-21 00:00:00	1997-02-14 00:00:00	2	7.92999983	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10426	GALED	4	1997-01-27 00:00:00	1997-02-24 00:00:00	1997-02-06 00:00:00	1	18.6900005	Galería del gastronómo	Rambla de Cataluña 23	Barcelona	\N	8022	Spain
10427	PICCO	4	1997-01-27 00:00:00	1997-02-24 00:00:00	1997-03-03 00:00:00	2	31.2900009	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10428	REGGC	7	1997-01-28 00:00:00	1997-02-25 00:00:00	1997-02-04 00:00:00	1	11.0900002	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10429	HUNGO	3	1997-01-29 00:00:00	1997-03-12 00:00:00	1997-02-07 00:00:00	2	56.6300011	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10430	ERNSH	4	1997-01-30 00:00:00	1997-02-13 00:00:00	1997-02-03 00:00:00	1	458.779999	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10431	BOTTM	4	1997-01-30 00:00:00	1997-02-13 00:00:00	1997-02-07 00:00:00	2	44.1699982	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10432	SPLIR	3	1997-01-31 00:00:00	1997-02-14 00:00:00	1997-02-07 00:00:00	2	4.34000015	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10433	PRINI	3	1997-02-03 00:00:00	1997-03-03 00:00:00	1997-03-04 00:00:00	3	73.8300018	Princesa Isabel Vinhos	Estrada da saúde n. 58	Lisboa	\N	1756	Portugal
10434	FOLKO	3	1997-02-03 00:00:00	1997-03-03 00:00:00	1997-02-13 00:00:00	2	17.9200001	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10435	CONSH	8	1997-02-04 00:00:00	1997-03-18 00:00:00	1997-02-07 00:00:00	2	9.21000004	Consolidated Holdings	Berkeley Gardens 12  Brewery	London	\N	WX1 6LT	UK
10436	BLONP	3	1997-02-05 00:00:00	1997-03-05 00:00:00	1997-02-11 00:00:00	2	156.660004	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10437	WARTH	8	1997-02-05 00:00:00	1997-03-05 00:00:00	1997-02-12 00:00:00	1	19.9699993	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10438	TOMSP	3	1997-02-06 00:00:00	1997-03-06 00:00:00	1997-02-14 00:00:00	2	8.23999977	Toms Spezialitäten	Luisenstr. 48	Münster	\N	44087	Germany
10439	MEREP	6	1997-02-07 00:00:00	1997-03-07 00:00:00	1997-02-10 00:00:00	3	4.07000017	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10440	SAVEA	4	1997-02-10 00:00:00	1997-03-10 00:00:00	1997-02-28 00:00:00	2	86.5299988	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10441	OLDWO	3	1997-02-10 00:00:00	1997-03-24 00:00:00	1997-03-14 00:00:00	2	73.0199966	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10442	ERNSH	3	1997-02-11 00:00:00	1997-03-11 00:00:00	1997-02-18 00:00:00	2	47.9399986	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10443	REGGC	8	1997-02-12 00:00:00	1997-03-12 00:00:00	1997-02-14 00:00:00	1	13.9499998	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10444	BERGS	3	1997-02-12 00:00:00	1997-03-12 00:00:00	1997-02-21 00:00:00	3	3.5	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10445	BERGS	3	1997-02-13 00:00:00	1997-03-13 00:00:00	1997-02-20 00:00:00	1	9.30000019	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10446	TOMSP	6	1997-02-14 00:00:00	1997-03-14 00:00:00	1997-02-19 00:00:00	1	14.6800003	Toms Spezialitäten	Luisenstr. 48	Münster	\N	44087	Germany
10447	RICAR	4	1997-02-14 00:00:00	1997-03-14 00:00:00	1997-03-07 00:00:00	2	68.6600037	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10448	RANCH	4	1997-02-17 00:00:00	1997-03-17 00:00:00	1997-02-24 00:00:00	2	38.8199997	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina
10449	BLONP	3	1997-02-18 00:00:00	1997-03-18 00:00:00	1997-02-27 00:00:00	2	53.2999992	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10450	VICTE	8	1997-02-19 00:00:00	1997-03-19 00:00:00	1997-03-11 00:00:00	2	7.23000002	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10451	QUICK	4	1997-02-19 00:00:00	1997-03-05 00:00:00	1997-03-12 00:00:00	3	189.089996	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10452	SAVEA	8	1997-02-20 00:00:00	1997-03-20 00:00:00	1997-02-26 00:00:00	1	140.259995	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10453	AROUT	1	1997-02-21 00:00:00	1997-03-21 00:00:00	1997-02-26 00:00:00	2	25.3600006	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10454	LAMAI	4	1997-02-21 00:00:00	1997-03-21 00:00:00	1997-02-25 00:00:00	3	2.74000001	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10455	WARTH	8	1997-02-24 00:00:00	1997-04-07 00:00:00	1997-03-03 00:00:00	2	180.449997	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10456	KOENE	8	1997-02-25 00:00:00	1997-04-08 00:00:00	1997-02-28 00:00:00	2	8.11999989	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10457	KOENE	2	1997-02-25 00:00:00	1997-03-25 00:00:00	1997-03-03 00:00:00	1	11.5699997	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10458	SUPRD	7	1997-02-26 00:00:00	1997-03-26 00:00:00	1997-03-04 00:00:00	3	147.059998	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10459	VICTE	4	1997-02-27 00:00:00	1997-03-27 00:00:00	1997-02-28 00:00:00	2	25.0900002	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10460	FOLKO	8	1997-02-28 00:00:00	1997-03-28 00:00:00	1997-03-03 00:00:00	1	16.2700005	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10461	LILAS	1	1997-02-28 00:00:00	1997-03-28 00:00:00	1997-03-05 00:00:00	3	148.610001	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10462	CONSH	2	1997-03-03 00:00:00	1997-03-31 00:00:00	1997-03-18 00:00:00	1	6.17000008	Consolidated Holdings	Berkeley Gardens 12  Brewery	London	\N	WX1 6LT	UK
10463	SUPRD	5	1997-03-04 00:00:00	1997-04-01 00:00:00	1997-03-06 00:00:00	3	14.7799997	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10464	FURIB	4	1997-03-04 00:00:00	1997-04-01 00:00:00	1997-03-14 00:00:00	2	89	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10465	VAFFE	1	1997-03-05 00:00:00	1997-04-02 00:00:00	1997-03-14 00:00:00	3	145.039993	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10466	COMMI	4	1997-03-06 00:00:00	1997-04-03 00:00:00	1997-03-13 00:00:00	1	11.9300003	Comércio Mineiro	Av. dos Lusíadas 23	Sao Paulo	SP	05432-043	Brazil
10467	MAGAA	8	1997-03-06 00:00:00	1997-04-03 00:00:00	1997-03-11 00:00:00	2	4.92999983	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10468	KOENE	3	1997-03-07 00:00:00	1997-04-04 00:00:00	1997-03-12 00:00:00	3	44.1199989	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10469	WHITC	1	1997-03-10 00:00:00	1997-04-07 00:00:00	1997-03-14 00:00:00	1	60.1800003	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10470	BONAP	4	1997-03-11 00:00:00	1997-04-08 00:00:00	1997-03-14 00:00:00	2	64.5599976	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10471	BSBEV	2	1997-03-11 00:00:00	1997-04-08 00:00:00	1997-03-18 00:00:00	3	45.5900002	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10472	SEVES	8	1997-03-12 00:00:00	1997-04-09 00:00:00	1997-03-19 00:00:00	1	4.19999981	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10473	ISLAT	1	1997-03-13 00:00:00	1997-03-27 00:00:00	1997-03-21 00:00:00	3	16.3700008	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10474	PERIC	5	1997-03-13 00:00:00	1997-04-10 00:00:00	1997-03-21 00:00:00	2	83.4899979	Pericles Comidas clásicas	Calle Dr. Jorge Cash 321	México D.F.	\N	05033	Mexico
10475	SUPRD	9	1997-03-14 00:00:00	1997-04-11 00:00:00	1997-04-04 00:00:00	1	68.5199966	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10476	HILAA	8	1997-03-17 00:00:00	1997-04-14 00:00:00	1997-03-24 00:00:00	3	4.40999985	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10477	PRINI	5	1997-03-17 00:00:00	1997-04-14 00:00:00	1997-03-25 00:00:00	2	13.0200005	Princesa Isabel Vinhos	Estrada da saúde n. 58	Lisboa	\N	1756	Portugal
10478	VICTE	2	1997-03-18 00:00:00	1997-04-01 00:00:00	1997-03-26 00:00:00	3	4.80999994	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10479	RATTC	3	1997-03-19 00:00:00	1997-04-16 00:00:00	1997-03-21 00:00:00	3	708.950012	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10480	FOLIG	6	1997-03-20 00:00:00	1997-04-17 00:00:00	1997-03-24 00:00:00	2	1.35000002	Folies gourmandes	184 chaussée de Tournai	Lille	\N	59000	France
10481	RICAR	8	1997-03-20 00:00:00	1997-04-17 00:00:00	1997-03-25 00:00:00	2	64.3300018	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10482	LAZYK	1	1997-03-21 00:00:00	1997-04-18 00:00:00	1997-04-10 00:00:00	3	7.48000002	Lazy K Kountry Store	12 Orchestra Terrace	Walla Walla	WA	99362	USA
10483	WHITC	7	1997-03-24 00:00:00	1997-04-21 00:00:00	1997-04-25 00:00:00	2	15.2799997	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10484	BSBEV	3	1997-03-24 00:00:00	1997-04-21 00:00:00	1997-04-01 00:00:00	3	6.88000011	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10485	LINOD	4	1997-03-25 00:00:00	1997-04-08 00:00:00	1997-03-31 00:00:00	2	64.4499969	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10486	HILAA	1	1997-03-26 00:00:00	1997-04-23 00:00:00	1997-04-02 00:00:00	2	30.5300007	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10487	QUEEN	2	1997-03-26 00:00:00	1997-04-23 00:00:00	1997-03-28 00:00:00	2	71.0699997	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10488	FRANK	8	1997-03-27 00:00:00	1997-04-24 00:00:00	1997-04-02 00:00:00	2	4.92999983	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10489	PICCO	6	1997-03-28 00:00:00	1997-04-25 00:00:00	1997-04-09 00:00:00	2	5.28999996	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10490	HILAA	7	1997-03-31 00:00:00	1997-04-28 00:00:00	1997-04-03 00:00:00	2	210.190002	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10491	FURIB	8	1997-03-31 00:00:00	1997-04-28 00:00:00	1997-04-08 00:00:00	3	16.9599991	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10492	BOTTM	3	1997-04-01 00:00:00	1997-04-29 00:00:00	1997-04-11 00:00:00	1	62.8899994	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10493	LAMAI	4	1997-04-02 00:00:00	1997-04-30 00:00:00	1997-04-10 00:00:00	3	10.6400003	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10494	COMMI	4	1997-04-02 00:00:00	1997-04-30 00:00:00	1997-04-09 00:00:00	2	65.9899979	Comércio Mineiro	Av. dos Lusíadas 23	Sao Paulo	SP	05432-043	Brazil
10495	LAUGB	3	1997-04-03 00:00:00	1997-05-01 00:00:00	1997-04-11 00:00:00	3	4.6500001	Laughing Bacchus Wine Cellars	2319 Elm St.	Vancouver	BC	V3F 2K1	Canada
10496	TRADH	7	1997-04-04 00:00:00	1997-05-02 00:00:00	1997-04-07 00:00:00	2	46.7700005	Tradiçao Hipermercados	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil
10497	LEHMS	7	1997-04-04 00:00:00	1997-05-02 00:00:00	1997-04-07 00:00:00	1	36.2099991	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10498	HILAA	8	1997-04-07 00:00:00	1997-05-05 00:00:00	1997-04-11 00:00:00	2	29.75	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10499	LILAS	4	1997-04-08 00:00:00	1997-05-06 00:00:00	1997-04-16 00:00:00	2	102.019997	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10500	LAMAI	6	1997-04-09 00:00:00	1997-05-07 00:00:00	1997-04-17 00:00:00	1	42.6800003	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10501	BLAUS	9	1997-04-09 00:00:00	1997-05-07 00:00:00	1997-04-16 00:00:00	3	8.85000038	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
10502	PERIC	2	1997-04-10 00:00:00	1997-05-08 00:00:00	1997-04-29 00:00:00	1	69.3199997	Pericles Comidas clásicas	Calle Dr. Jorge Cash 321	México D.F.	\N	05033	Mexico
10503	HUNGO	6	1997-04-11 00:00:00	1997-05-09 00:00:00	1997-04-16 00:00:00	2	16.7399998	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10504	WHITC	4	1997-04-11 00:00:00	1997-05-09 00:00:00	1997-04-18 00:00:00	3	59.1300011	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10505	MEREP	3	1997-04-14 00:00:00	1997-05-12 00:00:00	1997-04-21 00:00:00	3	7.13000011	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10506	KOENE	9	1997-04-15 00:00:00	1997-05-13 00:00:00	1997-05-02 00:00:00	2	21.1900005	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10507	ANTON	7	1997-04-15 00:00:00	1997-05-13 00:00:00	1997-04-22 00:00:00	1	47.4500008	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10508	OTTIK	1	1997-04-16 00:00:00	1997-05-14 00:00:00	1997-05-13 00:00:00	2	4.98999977	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10509	BLAUS	4	1997-04-17 00:00:00	1997-05-15 00:00:00	1997-04-29 00:00:00	1	0.150000006	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
10510	SAVEA	6	1997-04-18 00:00:00	1997-05-16 00:00:00	1997-04-28 00:00:00	3	367.630005	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10511	BONAP	4	1997-04-18 00:00:00	1997-05-16 00:00:00	1997-04-21 00:00:00	3	350.640015	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10512	FAMIA	7	1997-04-21 00:00:00	1997-05-19 00:00:00	1997-04-24 00:00:00	2	3.52999997	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10513	WANDK	7	1997-04-22 00:00:00	1997-06-03 00:00:00	1997-04-28 00:00:00	1	105.650002	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10514	ERNSH	3	1997-04-22 00:00:00	1997-05-20 00:00:00	1997-05-16 00:00:00	2	789.950012	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10515	QUICK	2	1997-04-23 00:00:00	1997-05-07 00:00:00	1997-05-23 00:00:00	1	204.470001	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10516	HUNGO	2	1997-04-24 00:00:00	1997-05-22 00:00:00	1997-05-01 00:00:00	3	62.7799988	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10517	NORTS	3	1997-04-24 00:00:00	1997-05-22 00:00:00	1997-04-29 00:00:00	3	32.0699997	North/South	South House 300 Queensbridge	London	\N	SW7 1RZ	UK
10518	TORTU	4	1997-04-25 00:00:00	1997-05-09 00:00:00	1997-05-05 00:00:00	2	218.149994	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10519	CHOPS	6	1997-04-28 00:00:00	1997-05-26 00:00:00	1997-05-01 00:00:00	3	91.7600021	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
10520	SANTG	7	1997-04-29 00:00:00	1997-05-27 00:00:00	1997-05-01 00:00:00	1	13.3699999	Santé Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway
10521	CACTU	8	1997-04-29 00:00:00	1997-05-27 00:00:00	1997-05-02 00:00:00	2	17.2199993	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina
10522	LEHMS	4	1997-04-30 00:00:00	1997-05-28 00:00:00	1997-05-06 00:00:00	1	45.3300018	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10523	SEVES	7	1997-05-01 00:00:00	1997-05-29 00:00:00	1997-05-30 00:00:00	2	77.6299973	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10524	BERGS	1	1997-05-01 00:00:00	1997-05-29 00:00:00	1997-05-07 00:00:00	2	244.789993	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10525	BONAP	1	1997-05-02 00:00:00	1997-05-30 00:00:00	1997-05-23 00:00:00	2	11.0600004	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10526	WARTH	4	1997-05-05 00:00:00	1997-06-02 00:00:00	1997-05-15 00:00:00	2	58.5900002	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10527	QUICK	7	1997-05-05 00:00:00	1997-06-02 00:00:00	1997-05-07 00:00:00	1	41.9000015	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10528	GREAL	6	1997-05-06 00:00:00	1997-05-20 00:00:00	1997-05-09 00:00:00	2	3.3499999	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10529	MAISD	5	1997-05-07 00:00:00	1997-06-04 00:00:00	1997-05-09 00:00:00	2	66.6900024	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
10530	PICCO	3	1997-05-08 00:00:00	1997-06-05 00:00:00	1997-05-12 00:00:00	2	339.220001	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10531	OCEAN	7	1997-05-08 00:00:00	1997-06-05 00:00:00	1997-05-19 00:00:00	1	8.11999989	Océano Atlántico Ltda.	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	\N	1010	Argentina
10532	EASTC	7	1997-05-09 00:00:00	1997-06-06 00:00:00	1997-05-12 00:00:00	3	74.4599991	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
10533	FOLKO	8	1997-05-12 00:00:00	1997-06-09 00:00:00	1997-05-22 00:00:00	1	188.039993	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10534	LEHMS	8	1997-05-12 00:00:00	1997-06-09 00:00:00	1997-05-14 00:00:00	2	27.9400005	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10535	ANTON	4	1997-05-13 00:00:00	1997-06-10 00:00:00	1997-05-21 00:00:00	1	15.6400003	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10536	LEHMS	3	1997-05-14 00:00:00	1997-06-11 00:00:00	1997-06-06 00:00:00	2	58.8800011	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10537	RICSU	1	1997-05-14 00:00:00	1997-05-28 00:00:00	1997-05-19 00:00:00	1	78.8499985	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10538	BSBEV	9	1997-05-15 00:00:00	1997-06-12 00:00:00	1997-05-16 00:00:00	3	4.86999989	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10539	BSBEV	6	1997-05-16 00:00:00	1997-06-13 00:00:00	1997-05-23 00:00:00	3	12.3599997	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10540	QUICK	3	1997-05-19 00:00:00	1997-06-16 00:00:00	1997-06-13 00:00:00	3	1007.64001	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10541	HANAR	2	1997-05-19 00:00:00	1997-06-16 00:00:00	1997-05-29 00:00:00	1	68.6500015	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10542	KOENE	1	1997-05-20 00:00:00	1997-06-17 00:00:00	1997-05-26 00:00:00	3	10.9499998	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10543	LILAS	8	1997-05-21 00:00:00	1997-06-18 00:00:00	1997-05-23 00:00:00	2	48.1699982	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10544	LONEP	4	1997-05-21 00:00:00	1997-06-18 00:00:00	1997-05-30 00:00:00	1	24.9099998	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10545	LAZYK	8	1997-05-22 00:00:00	1997-06-19 00:00:00	1997-06-26 00:00:00	2	11.9200001	Lazy K Kountry Store	12 Orchestra Terrace	Walla Walla	WA	99362	USA
10546	VICTE	1	1997-05-23 00:00:00	1997-06-20 00:00:00	1997-05-27 00:00:00	3	194.720001	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10547	SEVES	3	1997-05-23 00:00:00	1997-06-20 00:00:00	1997-06-02 00:00:00	2	178.429993	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10548	TOMSP	3	1997-05-26 00:00:00	1997-06-23 00:00:00	1997-06-02 00:00:00	2	1.42999995	Toms Spezialitäten	Luisenstr. 48	Münster	\N	44087	Germany
10549	QUICK	5	1997-05-27 00:00:00	1997-06-10 00:00:00	1997-05-30 00:00:00	1	171.240005	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10550	GODOS	7	1997-05-28 00:00:00	1997-06-25 00:00:00	1997-06-06 00:00:00	3	4.32000017	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10551	FURIB	4	1997-05-28 00:00:00	1997-07-09 00:00:00	1997-06-06 00:00:00	3	72.9499969	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10552	HILAA	2	1997-05-29 00:00:00	1997-06-26 00:00:00	1997-06-05 00:00:00	1	83.2200012	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10553	WARTH	2	1997-05-30 00:00:00	1997-06-27 00:00:00	1997-06-03 00:00:00	2	149.490005	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10554	OTTIK	4	1997-05-30 00:00:00	1997-06-27 00:00:00	1997-06-05 00:00:00	3	120.970001	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10555	SAVEA	6	1997-06-02 00:00:00	1997-06-30 00:00:00	1997-06-04 00:00:00	3	252.490005	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10556	SIMOB	2	1997-06-03 00:00:00	1997-07-15 00:00:00	1997-06-13 00:00:00	1	9.80000019	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
10557	LEHMS	9	1997-06-03 00:00:00	1997-06-17 00:00:00	1997-06-06 00:00:00	2	96.7200012	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10558	AROUT	1	1997-06-04 00:00:00	1997-07-02 00:00:00	1997-06-10 00:00:00	2	72.9700012	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10559	BLONP	6	1997-06-05 00:00:00	1997-07-03 00:00:00	1997-06-13 00:00:00	1	8.05000019	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10560	FRANK	8	1997-06-06 00:00:00	1997-07-04 00:00:00	1997-06-09 00:00:00	1	36.6500015	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10561	FOLKO	2	1997-06-06 00:00:00	1997-07-04 00:00:00	1997-06-09 00:00:00	2	242.210007	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10562	REGGC	1	1997-06-09 00:00:00	1997-07-07 00:00:00	1997-06-12 00:00:00	1	22.9500008	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10563	RICAR	2	1997-06-10 00:00:00	1997-07-22 00:00:00	1997-06-24 00:00:00	2	60.4300003	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10564	RATTC	4	1997-06-10 00:00:00	1997-07-08 00:00:00	1997-06-16 00:00:00	3	13.75	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10565	MEREP	8	1997-06-11 00:00:00	1997-07-09 00:00:00	1997-06-18 00:00:00	2	7.1500001	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10566	BLONP	9	1997-06-12 00:00:00	1997-07-10 00:00:00	1997-06-18 00:00:00	1	88.4000015	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10567	HUNGO	1	1997-06-12 00:00:00	1997-07-10 00:00:00	1997-06-17 00:00:00	1	33.9700012	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10568	GALED	3	1997-06-13 00:00:00	1997-07-11 00:00:00	1997-07-09 00:00:00	3	6.53999996	Galería del gastronómo	Rambla de Cataluña 23	Barcelona	\N	8022	Spain
10569	RATTC	5	1997-06-16 00:00:00	1997-07-14 00:00:00	1997-07-11 00:00:00	1	58.9799995	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10570	MEREP	3	1997-06-17 00:00:00	1997-07-15 00:00:00	1997-06-19 00:00:00	3	188.990005	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10571	ERNSH	8	1997-06-17 00:00:00	1997-07-29 00:00:00	1997-07-04 00:00:00	3	26.0599995	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10572	BERGS	3	1997-06-18 00:00:00	1997-07-16 00:00:00	1997-06-25 00:00:00	2	116.43	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10573	ANTON	7	1997-06-19 00:00:00	1997-07-17 00:00:00	1997-06-20 00:00:00	3	84.8399963	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10574	TRAIH	4	1997-06-19 00:00:00	1997-07-17 00:00:00	1997-06-30 00:00:00	2	37.5999985	Trail's Head Gourmet Provisioners	722 DaVinci Blvd.	Kirkland	WA	98034	USA
10575	MORGK	5	1997-06-20 00:00:00	1997-07-04 00:00:00	1997-06-30 00:00:00	1	127.339996	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany
10576	TORTU	3	1997-06-23 00:00:00	1997-07-07 00:00:00	1997-06-30 00:00:00	3	18.5599995	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10577	TRAIH	9	1997-06-23 00:00:00	1997-08-04 00:00:00	1997-06-30 00:00:00	2	25.4099998	Trail's Head Gourmet Provisioners	722 DaVinci Blvd.	Kirkland	WA	98034	USA
10578	BSBEV	4	1997-06-24 00:00:00	1997-07-22 00:00:00	1997-07-25 00:00:00	3	29.6000004	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10579	LETSS	1	1997-06-25 00:00:00	1997-07-23 00:00:00	1997-07-04 00:00:00	2	13.7299995	Let's Stop N Shop	87 Polk St. Suite 5	San Francisco	CA	94117	USA
10580	OTTIK	4	1997-06-26 00:00:00	1997-07-24 00:00:00	1997-07-01 00:00:00	3	75.8899994	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10581	FAMIA	3	1997-06-26 00:00:00	1997-07-24 00:00:00	1997-07-02 00:00:00	1	3.00999999	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10582	BLAUS	3	1997-06-27 00:00:00	1997-07-25 00:00:00	1997-07-14 00:00:00	2	27.7099991	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
10583	WARTH	2	1997-06-30 00:00:00	1997-07-28 00:00:00	1997-07-04 00:00:00	2	7.28000021	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10584	BLONP	4	1997-06-30 00:00:00	1997-07-28 00:00:00	1997-07-04 00:00:00	1	59.1399994	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10585	WELLI	7	1997-07-01 00:00:00	1997-07-29 00:00:00	1997-07-10 00:00:00	1	13.4099998	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10586	REGGC	9	1997-07-02 00:00:00	1997-07-30 00:00:00	1997-07-09 00:00:00	1	0.479999989	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10587	QUEDE	1	1997-07-02 00:00:00	1997-07-30 00:00:00	1997-07-09 00:00:00	1	62.5200005	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10588	QUICK	2	1997-07-03 00:00:00	1997-07-31 00:00:00	1997-07-10 00:00:00	3	194.669998	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10589	GREAL	8	1997-07-04 00:00:00	1997-08-01 00:00:00	1997-07-14 00:00:00	2	4.42000008	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10590	MEREP	4	1997-07-07 00:00:00	1997-08-04 00:00:00	1997-07-14 00:00:00	3	44.7700005	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10591	VAFFE	1	1997-07-07 00:00:00	1997-07-21 00:00:00	1997-07-16 00:00:00	1	55.9199982	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10592	LEHMS	3	1997-07-08 00:00:00	1997-08-05 00:00:00	1997-07-16 00:00:00	1	32.0999985	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10593	LEHMS	7	1997-07-09 00:00:00	1997-08-06 00:00:00	1997-08-13 00:00:00	2	174.199997	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10594	OLDWO	3	1997-07-09 00:00:00	1997-08-06 00:00:00	1997-07-16 00:00:00	2	5.23999977	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10595	ERNSH	2	1997-07-10 00:00:00	1997-08-07 00:00:00	1997-07-14 00:00:00	1	96.7799988	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10596	WHITC	8	1997-07-11 00:00:00	1997-08-08 00:00:00	1997-08-12 00:00:00	1	16.3400002	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10597	PICCO	7	1997-07-11 00:00:00	1997-08-08 00:00:00	1997-07-18 00:00:00	3	35.1199989	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10598	RATTC	1	1997-07-14 00:00:00	1997-08-11 00:00:00	1997-07-18 00:00:00	3	44.4199982	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10599	BSBEV	6	1997-07-15 00:00:00	1997-08-26 00:00:00	1997-07-21 00:00:00	3	29.9799995	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10600	HUNGC	4	1997-07-16 00:00:00	1997-08-13 00:00:00	1997-07-21 00:00:00	1	45.1300011	Hungry Coyote Import Store	City Center Plaza 516 Main St.	Elgin	OR	97827	USA
10601	HILAA	7	1997-07-16 00:00:00	1997-08-27 00:00:00	1997-07-22 00:00:00	1	58.2999992	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10602	VAFFE	8	1997-07-17 00:00:00	1997-08-14 00:00:00	1997-07-22 00:00:00	2	2.92000008	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10603	SAVEA	8	1997-07-18 00:00:00	1997-08-15 00:00:00	1997-08-08 00:00:00	2	48.7700005	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10604	FURIB	1	1997-07-18 00:00:00	1997-08-15 00:00:00	1997-07-29 00:00:00	1	7.46000004	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10605	MEREP	1	1997-07-21 00:00:00	1997-08-18 00:00:00	1997-07-29 00:00:00	2	379.130005	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10606	TRADH	4	1997-07-22 00:00:00	1997-08-19 00:00:00	1997-07-31 00:00:00	3	79.4000015	Tradiçao Hipermercados	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil
10607	SAVEA	5	1997-07-22 00:00:00	1997-08-19 00:00:00	1997-07-25 00:00:00	1	200.240005	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10608	TOMSP	4	1997-07-23 00:00:00	1997-08-20 00:00:00	1997-08-01 00:00:00	2	27.7900009	Toms Spezialitäten	Luisenstr. 48	Münster	\N	44087	Germany
10609	DUMON	7	1997-07-24 00:00:00	1997-08-21 00:00:00	1997-07-30 00:00:00	2	1.85000002	Du monde entier	67 rue des Cinquante Otages	Nantes	\N	44000	France
10610	LAMAI	8	1997-07-25 00:00:00	1997-08-22 00:00:00	1997-08-06 00:00:00	1	26.7800007	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10611	WOLZA	6	1997-07-25 00:00:00	1997-08-22 00:00:00	1997-08-01 00:00:00	2	80.6500015	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
10612	SAVEA	1	1997-07-28 00:00:00	1997-08-25 00:00:00	1997-08-01 00:00:00	2	544.080017	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10613	HILAA	4	1997-07-29 00:00:00	1997-08-26 00:00:00	1997-08-01 00:00:00	2	8.10999966	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10614	BLAUS	8	1997-07-29 00:00:00	1997-08-26 00:00:00	1997-08-01 00:00:00	3	1.92999995	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
10615	WILMK	2	1997-07-30 00:00:00	1997-08-27 00:00:00	1997-08-06 00:00:00	3	0.75	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
10616	GREAL	1	1997-07-31 00:00:00	1997-08-28 00:00:00	1997-08-05 00:00:00	2	116.529999	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10617	GREAL	4	1997-07-31 00:00:00	1997-08-28 00:00:00	1997-08-04 00:00:00	2	18.5300007	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10618	MEREP	1	1997-08-01 00:00:00	1997-09-12 00:00:00	1997-08-08 00:00:00	1	154.679993	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10619	MEREP	3	1997-08-04 00:00:00	1997-09-01 00:00:00	1997-08-07 00:00:00	3	91.0500031	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10620	LAUGB	2	1997-08-05 00:00:00	1997-09-02 00:00:00	1997-08-14 00:00:00	3	0.939999998	Laughing Bacchus Wine Cellars	2319 Elm St.	Vancouver	BC	V3F 2K1	Canada
10621	ISLAT	4	1997-08-05 00:00:00	1997-09-02 00:00:00	1997-08-11 00:00:00	2	23.7299995	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10622	RICAR	4	1997-08-06 00:00:00	1997-09-03 00:00:00	1997-08-11 00:00:00	3	50.9700012	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10623	FRANK	8	1997-08-07 00:00:00	1997-09-04 00:00:00	1997-08-12 00:00:00	2	97.1800003	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10624	THECR	4	1997-08-07 00:00:00	1997-09-04 00:00:00	1997-08-19 00:00:00	2	94.8000031	The Cracker Box	55 Grizzly Peak Rd.	Butte	MT	59801	USA
10625	ANATR	3	1997-08-08 00:00:00	1997-09-05 00:00:00	1997-08-14 00:00:00	1	43.9000015	Ana Trujillo Emparedados y helados	Avda. de la Constitución 2222	México D.F.	\N	05021	Mexico
10626	BERGS	1	1997-08-11 00:00:00	1997-09-08 00:00:00	1997-08-20 00:00:00	2	138.690002	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10627	SAVEA	8	1997-08-11 00:00:00	1997-09-22 00:00:00	1997-08-21 00:00:00	3	107.459999	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10628	BLONP	4	1997-08-12 00:00:00	1997-09-09 00:00:00	1997-08-20 00:00:00	3	30.3600006	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10629	GODOS	4	1997-08-12 00:00:00	1997-09-09 00:00:00	1997-08-20 00:00:00	3	85.4599991	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10630	KOENE	1	1997-08-13 00:00:00	1997-09-10 00:00:00	1997-08-19 00:00:00	2	32.3499985	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10631	LAMAI	8	1997-08-14 00:00:00	1997-09-11 00:00:00	1997-08-15 00:00:00	1	0.870000005	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10632	WANDK	8	1997-08-14 00:00:00	1997-09-11 00:00:00	1997-08-19 00:00:00	1	41.3800011	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10633	ERNSH	7	1997-08-15 00:00:00	1997-09-12 00:00:00	1997-08-18 00:00:00	3	477.899994	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10634	FOLIG	4	1997-08-15 00:00:00	1997-09-12 00:00:00	1997-08-21 00:00:00	3	487.380005	Folies gourmandes	184 chaussée de Tournai	Lille	\N	59000	France
10635	MAGAA	8	1997-08-18 00:00:00	1997-09-15 00:00:00	1997-08-21 00:00:00	3	47.4599991	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10636	WARTH	4	1997-08-19 00:00:00	1997-09-16 00:00:00	1997-08-26 00:00:00	1	1.14999998	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10637	QUEEN	6	1997-08-19 00:00:00	1997-09-16 00:00:00	1997-08-26 00:00:00	1	201.289993	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10638	LINOD	3	1997-08-20 00:00:00	1997-09-17 00:00:00	1997-09-01 00:00:00	1	158.440002	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10639	SANTG	7	1997-08-20 00:00:00	1997-09-17 00:00:00	1997-08-27 00:00:00	3	38.6399994	Santé Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway
10640	WANDK	4	1997-08-21 00:00:00	1997-09-18 00:00:00	1997-08-28 00:00:00	1	23.5499992	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10641	HILAA	4	1997-08-22 00:00:00	1997-09-19 00:00:00	1997-08-26 00:00:00	2	179.610001	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10642	SIMOB	7	1997-08-22 00:00:00	1997-09-19 00:00:00	1997-09-05 00:00:00	3	41.8899994	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
10643	ALFKI	6	1997-08-25 00:00:00	1997-09-22 00:00:00	1997-09-02 00:00:00	1	29.4599991	Alfreds Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany
10644	WELLI	3	1997-08-25 00:00:00	1997-09-22 00:00:00	1997-09-01 00:00:00	2	0.140000001	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10645	HANAR	4	1997-08-26 00:00:00	1997-09-23 00:00:00	1997-09-02 00:00:00	1	12.4099998	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10646	HUNGO	9	1997-08-27 00:00:00	1997-10-08 00:00:00	1997-09-03 00:00:00	3	142.330002	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10647	QUEDE	4	1997-08-27 00:00:00	1997-09-10 00:00:00	1997-09-03 00:00:00	2	45.5400009	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10648	RICAR	5	1997-08-28 00:00:00	1997-10-09 00:00:00	1997-09-09 00:00:00	2	14.25	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10649	MAISD	5	1997-08-28 00:00:00	1997-09-25 00:00:00	1997-08-29 00:00:00	3	6.19999981	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
10650	FAMIA	5	1997-08-29 00:00:00	1997-09-26 00:00:00	1997-09-03 00:00:00	3	176.809998	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10651	WANDK	8	1997-09-01 00:00:00	1997-09-29 00:00:00	1997-09-11 00:00:00	2	20.6000004	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10652	GOURL	4	1997-09-01 00:00:00	1997-09-29 00:00:00	1997-09-08 00:00:00	2	7.13999987	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10653	FRANK	1	1997-09-02 00:00:00	1997-09-30 00:00:00	1997-09-19 00:00:00	1	93.25	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10654	BERGS	5	1997-09-02 00:00:00	1997-09-30 00:00:00	1997-09-11 00:00:00	1	55.2599983	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10655	REGGC	1	1997-09-03 00:00:00	1997-10-01 00:00:00	1997-09-11 00:00:00	2	4.40999985	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10656	GREAL	6	1997-09-04 00:00:00	1997-10-02 00:00:00	1997-09-10 00:00:00	1	57.1500015	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10657	SAVEA	2	1997-09-04 00:00:00	1997-10-02 00:00:00	1997-09-15 00:00:00	2	352.690002	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10658	QUICK	4	1997-09-05 00:00:00	1997-10-03 00:00:00	1997-09-08 00:00:00	1	364.149994	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10659	QUEEN	7	1997-09-05 00:00:00	1997-10-03 00:00:00	1997-09-10 00:00:00	2	105.809998	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10660	HUNGC	8	1997-09-08 00:00:00	1997-10-06 00:00:00	1997-10-15 00:00:00	1	111.290001	Hungry Coyote Import Store	City Center Plaza 516 Main St.	Elgin	OR	97827	USA
10661	HUNGO	7	1997-09-09 00:00:00	1997-10-07 00:00:00	1997-09-15 00:00:00	3	17.5499992	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10662	LONEP	3	1997-09-09 00:00:00	1997-10-07 00:00:00	1997-09-18 00:00:00	2	1.27999997	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10663	BONAP	2	1997-09-10 00:00:00	1997-09-24 00:00:00	1997-10-03 00:00:00	2	113.150002	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10664	FURIB	1	1997-09-10 00:00:00	1997-10-08 00:00:00	1997-09-19 00:00:00	3	1.26999998	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10665	LONEP	1	1997-09-11 00:00:00	1997-10-09 00:00:00	1997-09-17 00:00:00	2	26.3099995	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10666	RICSU	7	1997-09-12 00:00:00	1997-10-10 00:00:00	1997-09-22 00:00:00	2	232.419998	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10667	ERNSH	7	1997-09-12 00:00:00	1997-10-10 00:00:00	1997-09-19 00:00:00	1	78.0899963	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10668	WANDK	1	1997-09-15 00:00:00	1997-10-13 00:00:00	1997-09-23 00:00:00	2	47.2200012	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
10669	SIMOB	2	1997-09-15 00:00:00	1997-10-13 00:00:00	1997-09-22 00:00:00	1	24.3899994	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
10670	FRANK	4	1997-09-16 00:00:00	1997-10-14 00:00:00	1997-09-18 00:00:00	1	203.479996	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10671	FRANR	1	1997-09-17 00:00:00	1997-10-15 00:00:00	1997-09-24 00:00:00	1	30.3400002	France restauration	54 rue Royale	Nantes	\N	44000	France
10672	BERGS	9	1997-09-17 00:00:00	1997-10-01 00:00:00	1997-09-26 00:00:00	2	95.75	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10673	WILMK	2	1997-09-18 00:00:00	1997-10-16 00:00:00	1997-09-19 00:00:00	1	22.7600002	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
10674	ISLAT	4	1997-09-18 00:00:00	1997-10-16 00:00:00	1997-09-30 00:00:00	2	0.899999976	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10675	FRANK	5	1997-09-19 00:00:00	1997-10-17 00:00:00	1997-09-23 00:00:00	2	31.8500004	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10676	TORTU	2	1997-09-22 00:00:00	1997-10-20 00:00:00	1997-09-29 00:00:00	2	2.00999999	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10677	ANTON	1	1997-09-22 00:00:00	1997-10-20 00:00:00	1997-09-26 00:00:00	3	4.03000021	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10678	SAVEA	7	1997-09-23 00:00:00	1997-10-21 00:00:00	1997-10-16 00:00:00	3	388.980011	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10679	BLONP	8	1997-09-23 00:00:00	1997-10-21 00:00:00	1997-09-30 00:00:00	3	27.9400005	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10680	OLDWO	1	1997-09-24 00:00:00	1997-10-22 00:00:00	1997-09-26 00:00:00	1	26.6100006	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10681	GREAL	3	1997-09-25 00:00:00	1997-10-23 00:00:00	1997-09-30 00:00:00	3	76.1299973	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10682	ANTON	3	1997-09-25 00:00:00	1997-10-23 00:00:00	1997-10-01 00:00:00	2	36.1300011	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10683	DUMON	2	1997-09-26 00:00:00	1997-10-24 00:00:00	1997-10-01 00:00:00	1	4.4000001	Du monde entier	67 rue des Cinquante Otages	Nantes	\N	44000	France
10684	OTTIK	3	1997-09-26 00:00:00	1997-10-24 00:00:00	1997-09-30 00:00:00	1	145.630005	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10685	GOURL	4	1997-09-29 00:00:00	1997-10-13 00:00:00	1997-10-03 00:00:00	2	33.75	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10686	PICCO	2	1997-09-30 00:00:00	1997-10-28 00:00:00	1997-10-08 00:00:00	1	96.5	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10687	HUNGO	9	1997-09-30 00:00:00	1997-10-28 00:00:00	1997-10-30 00:00:00	2	296.429993	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10688	VAFFE	4	1997-10-01 00:00:00	1997-10-15 00:00:00	1997-10-07 00:00:00	2	299.089996	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10689	BERGS	1	1997-10-01 00:00:00	1997-10-29 00:00:00	1997-10-07 00:00:00	2	13.4200001	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10690	HANAR	1	1997-10-02 00:00:00	1997-10-30 00:00:00	1997-10-03 00:00:00	1	15.8000002	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10691	QUICK	2	1997-10-03 00:00:00	1997-11-14 00:00:00	1997-10-22 00:00:00	2	810.049988	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10692	ALFKI	4	1997-10-03 00:00:00	1997-10-31 00:00:00	1997-10-13 00:00:00	2	61.0200005	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany
10693	WHITC	3	1997-10-06 00:00:00	1997-10-20 00:00:00	1997-10-10 00:00:00	3	139.339996	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10694	QUICK	8	1997-10-06 00:00:00	1997-11-03 00:00:00	1997-10-09 00:00:00	3	398.359985	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10695	WILMK	7	1997-10-07 00:00:00	1997-11-18 00:00:00	1997-10-14 00:00:00	1	16.7199993	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
10696	WHITC	8	1997-10-08 00:00:00	1997-11-19 00:00:00	1997-10-14 00:00:00	3	102.550003	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10697	LINOD	3	1997-10-08 00:00:00	1997-11-05 00:00:00	1997-10-14 00:00:00	1	45.5200005	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10698	ERNSH	4	1997-10-09 00:00:00	1997-11-06 00:00:00	1997-10-17 00:00:00	1	272.470001	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10699	MORGK	3	1997-10-09 00:00:00	1997-11-06 00:00:00	1997-10-13 00:00:00	3	0.579999983	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany
10700	SAVEA	3	1997-10-10 00:00:00	1997-11-07 00:00:00	1997-10-16 00:00:00	1	65.0999985	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10701	HUNGO	6	1997-10-13 00:00:00	1997-10-27 00:00:00	1997-10-15 00:00:00	3	220.309998	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10702	ALFKI	4	1997-10-13 00:00:00	1997-11-24 00:00:00	1997-10-21 00:00:00	1	23.9400005	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany
10703	FOLKO	6	1997-10-14 00:00:00	1997-11-11 00:00:00	1997-10-20 00:00:00	2	152.300003	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10704	QUEEN	6	1997-10-14 00:00:00	1997-11-11 00:00:00	1997-11-07 00:00:00	1	4.78000021	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10705	HILAA	9	1997-10-15 00:00:00	1997-11-12 00:00:00	1997-11-18 00:00:00	2	3.51999998	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10706	OLDWO	8	1997-10-16 00:00:00	1997-11-13 00:00:00	1997-10-21 00:00:00	3	135.630005	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10707	AROUT	4	1997-10-16 00:00:00	1997-10-30 00:00:00	1997-10-23 00:00:00	3	21.7399998	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10708	THEBI	6	1997-10-17 00:00:00	1997-11-28 00:00:00	1997-11-05 00:00:00	2	2.96000004	The Big Cheese	89 Jefferson Way Suite 2	Portland	OR	97201	USA
10709	GOURL	1	1997-10-17 00:00:00	1997-11-14 00:00:00	1997-11-20 00:00:00	3	210.800003	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10710	FRANS	1	1997-10-20 00:00:00	1997-11-17 00:00:00	1997-10-23 00:00:00	1	4.98000002	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy
10711	SAVEA	5	1997-10-21 00:00:00	1997-12-02 00:00:00	1997-10-29 00:00:00	2	52.4099998	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10712	HUNGO	3	1997-10-21 00:00:00	1997-11-18 00:00:00	1997-10-31 00:00:00	1	89.9300003	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10713	SAVEA	1	1997-10-22 00:00:00	1997-11-19 00:00:00	1997-10-24 00:00:00	1	167.050003	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10714	SAVEA	5	1997-10-22 00:00:00	1997-11-19 00:00:00	1997-10-27 00:00:00	3	24.4899998	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10715	BONAP	3	1997-10-23 00:00:00	1997-11-06 00:00:00	1997-10-29 00:00:00	1	63.2000008	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10716	RANCH	4	1997-10-24 00:00:00	1997-11-21 00:00:00	1997-10-27 00:00:00	2	22.5699997	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina
10717	FRANK	1	1997-10-24 00:00:00	1997-11-21 00:00:00	1997-10-29 00:00:00	2	59.25	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10718	KOENE	1	1997-10-27 00:00:00	1997-11-24 00:00:00	1997-10-29 00:00:00	3	170.880005	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10719	LETSS	8	1997-10-27 00:00:00	1997-11-24 00:00:00	1997-11-05 00:00:00	2	51.4399986	Let's Stop N Shop	87 Polk St. Suite 5	San Francisco	CA	94117	USA
10720	QUEDE	8	1997-10-28 00:00:00	1997-11-11 00:00:00	1997-11-05 00:00:00	2	9.52999973	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10721	QUICK	5	1997-10-29 00:00:00	1997-11-26 00:00:00	1997-10-31 00:00:00	3	48.9199982	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10722	SAVEA	8	1997-10-29 00:00:00	1997-12-10 00:00:00	1997-11-04 00:00:00	1	74.5800018	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10723	WHITC	3	1997-10-30 00:00:00	1997-11-27 00:00:00	1997-11-25 00:00:00	1	21.7199993	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10724	MEREP	8	1997-10-30 00:00:00	1997-12-11 00:00:00	1997-11-05 00:00:00	2	57.75	Mère Paillarde	43 rue St. Laurent	Montréal	Québec	H1J 1C3	Canada
10725	FAMIA	4	1997-10-31 00:00:00	1997-11-28 00:00:00	1997-11-05 00:00:00	3	10.8299999	Familia Arquibaldo	Rua Orós 92	Sao Paulo	SP	05442-030	Brazil
10726	EASTC	4	1997-11-03 00:00:00	1997-11-17 00:00:00	1997-12-05 00:00:00	1	16.5599995	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
10727	REGGC	2	1997-11-03 00:00:00	1997-12-01 00:00:00	1997-12-05 00:00:00	1	89.9000015	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10728	QUEEN	4	1997-11-04 00:00:00	1997-12-02 00:00:00	1997-11-11 00:00:00	2	58.3300018	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10729	LINOD	8	1997-11-04 00:00:00	1997-12-16 00:00:00	1997-11-14 00:00:00	3	141.059998	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10730	BONAP	5	1997-11-05 00:00:00	1997-12-03 00:00:00	1997-11-14 00:00:00	1	20.1200008	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10731	CHOPS	7	1997-11-06 00:00:00	1997-12-04 00:00:00	1997-11-14 00:00:00	1	96.6500015	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
10732	BONAP	3	1997-11-06 00:00:00	1997-12-04 00:00:00	1997-11-07 00:00:00	1	16.9699993	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10733	BERGS	1	1997-11-07 00:00:00	1997-12-05 00:00:00	1997-11-10 00:00:00	3	110.110001	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10734	GOURL	2	1997-11-07 00:00:00	1997-12-05 00:00:00	1997-11-12 00:00:00	3	1.63	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10735	LETSS	6	1997-11-10 00:00:00	1997-12-08 00:00:00	1997-11-21 00:00:00	2	45.9700012	Let's Stop N Shop	87 Polk St. Suite 5	San Francisco	CA	94117	USA
10736	HUNGO	9	1997-11-11 00:00:00	1997-12-09 00:00:00	1997-11-21 00:00:00	2	44.0999985	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10737	VINET	2	1997-11-11 00:00:00	1997-12-09 00:00:00	1997-11-18 00:00:00	2	7.78999996	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France
10738	SPECD	2	1997-11-12 00:00:00	1997-12-10 00:00:00	1997-11-18 00:00:00	1	2.91000009	Spécialités du monde	25 rue Lauriston	Paris	\N	75016	France
10739	VINET	3	1997-11-12 00:00:00	1997-12-10 00:00:00	1997-11-17 00:00:00	3	11.0799999	Vins et alcools Chevalier	59 rue de l'Abbaye	Reims	\N	51100	France
10740	WHITC	4	1997-11-13 00:00:00	1997-12-11 00:00:00	1997-11-25 00:00:00	2	81.8799973	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10741	AROUT	4	1997-11-14 00:00:00	1997-11-28 00:00:00	1997-11-18 00:00:00	3	10.96	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10742	BOTTM	3	1997-11-14 00:00:00	1997-12-12 00:00:00	1997-11-18 00:00:00	3	243.729996	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10743	AROUT	1	1997-11-17 00:00:00	1997-12-15 00:00:00	1997-11-21 00:00:00	2	23.7199993	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10744	VAFFE	6	1997-11-17 00:00:00	1997-12-15 00:00:00	1997-11-24 00:00:00	1	69.1900024	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10745	QUICK	9	1997-11-18 00:00:00	1997-12-16 00:00:00	1997-11-27 00:00:00	1	3.51999998	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10746	CHOPS	1	1997-11-19 00:00:00	1997-12-17 00:00:00	1997-11-21 00:00:00	3	31.4300003	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
10747	PICCO	6	1997-11-19 00:00:00	1997-12-17 00:00:00	1997-11-26 00:00:00	1	117.330002	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10748	SAVEA	3	1997-11-20 00:00:00	1997-12-18 00:00:00	1997-11-28 00:00:00	1	232.550003	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10749	ISLAT	4	1997-11-20 00:00:00	1997-12-18 00:00:00	1997-12-19 00:00:00	2	61.5299988	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10750	WARTH	9	1997-11-21 00:00:00	1997-12-19 00:00:00	1997-11-24 00:00:00	1	79.3000031	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10751	RICSU	3	1997-11-24 00:00:00	1997-12-22 00:00:00	1997-12-03 00:00:00	3	130.789993	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10752	NORTS	2	1997-11-24 00:00:00	1997-12-22 00:00:00	1997-11-28 00:00:00	3	1.38999999	North/South	South House 300 Queensbridge	London	\N	SW7 1RZ	UK
10753	FRANS	3	1997-11-25 00:00:00	1997-12-23 00:00:00	1997-11-27 00:00:00	1	7.69999981	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy
10754	MAGAA	6	1997-11-25 00:00:00	1997-12-23 00:00:00	1997-11-27 00:00:00	3	2.38000011	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10755	BONAP	4	1997-11-26 00:00:00	1997-12-24 00:00:00	1997-11-28 00:00:00	2	16.7099991	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10756	SPLIR	8	1997-11-27 00:00:00	1997-12-25 00:00:00	1997-12-02 00:00:00	2	73.2099991	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10757	SAVEA	6	1997-11-27 00:00:00	1997-12-25 00:00:00	1997-12-15 00:00:00	1	8.18999958	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10758	RICSU	3	1997-11-28 00:00:00	1997-12-26 00:00:00	1997-12-04 00:00:00	3	138.169998	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10759	ANATR	3	1997-11-28 00:00:00	1997-12-26 00:00:00	1997-12-12 00:00:00	3	11.9899998	Ana Trujillo Emparedados y helados	Avda. de la Constitución 2222	México D.F.	\N	05021	Mexico
10760	MAISD	4	1997-12-01 00:00:00	1997-12-29 00:00:00	1997-12-10 00:00:00	1	155.639999	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
10761	RATTC	5	1997-12-02 00:00:00	1997-12-30 00:00:00	1997-12-08 00:00:00	2	18.6599998	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10762	FOLKO	3	1997-12-02 00:00:00	1997-12-30 00:00:00	1997-12-09 00:00:00	1	328.73999	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10763	FOLIG	3	1997-12-03 00:00:00	1997-12-31 00:00:00	1997-12-08 00:00:00	3	37.3499985	Folies gourmandes	184 chaussée de Tournai	Lille	\N	59000	France
10764	ERNSH	6	1997-12-03 00:00:00	1997-12-31 00:00:00	1997-12-08 00:00:00	3	145.449997	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10765	QUICK	3	1997-12-04 00:00:00	1998-01-01 00:00:00	1997-12-09 00:00:00	3	42.7400017	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10766	OTTIK	4	1997-12-05 00:00:00	1998-01-02 00:00:00	1997-12-09 00:00:00	1	157.550003	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10767	SUPRD	4	1997-12-05 00:00:00	1998-01-02 00:00:00	1997-12-15 00:00:00	3	1.59000003	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10768	AROUT	3	1997-12-08 00:00:00	1998-01-05 00:00:00	1997-12-15 00:00:00	2	146.320007	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10769	VAFFE	3	1997-12-08 00:00:00	1998-01-05 00:00:00	1997-12-12 00:00:00	1	65.0599976	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10770	HANAR	8	1997-12-09 00:00:00	1998-01-06 00:00:00	1997-12-17 00:00:00	3	5.32000017	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10771	ERNSH	9	1997-12-10 00:00:00	1998-01-07 00:00:00	1998-01-02 00:00:00	2	11.1899996	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10772	LEHMS	3	1997-12-10 00:00:00	1998-01-07 00:00:00	1997-12-19 00:00:00	2	91.2799988	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10773	ERNSH	1	1997-12-11 00:00:00	1998-01-08 00:00:00	1997-12-16 00:00:00	3	96.4300003	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10774	FOLKO	4	1997-12-11 00:00:00	1997-12-25 00:00:00	1997-12-12 00:00:00	1	48.2000008	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10775	THECR	7	1997-12-12 00:00:00	1998-01-09 00:00:00	1997-12-26 00:00:00	1	20.25	The Cracker Box	55 Grizzly Peak Rd.	Butte	MT	59801	USA
10776	ERNSH	1	1997-12-15 00:00:00	1998-01-12 00:00:00	1997-12-18 00:00:00	3	351.529999	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10777	GOURL	7	1997-12-15 00:00:00	1997-12-29 00:00:00	1998-01-21 00:00:00	2	3.00999999	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10778	BERGS	3	1997-12-16 00:00:00	1998-01-13 00:00:00	1997-12-24 00:00:00	1	6.78999996	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10779	MORGK	3	1997-12-16 00:00:00	1998-01-13 00:00:00	1998-01-14 00:00:00	2	58.1300011	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany
10780	LILAS	2	1997-12-16 00:00:00	1997-12-30 00:00:00	1997-12-25 00:00:00	1	42.1300011	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10781	WARTH	2	1997-12-17 00:00:00	1998-01-14 00:00:00	1997-12-19 00:00:00	3	73.1600037	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
10782	CACTU	9	1997-12-17 00:00:00	1998-01-14 00:00:00	1997-12-22 00:00:00	3	1.10000002	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina
10783	HANAR	4	1997-12-18 00:00:00	1998-01-15 00:00:00	1997-12-19 00:00:00	2	124.980003	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10784	MAGAA	4	1997-12-18 00:00:00	1998-01-15 00:00:00	1997-12-22 00:00:00	3	70.0899963	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10785	GROSR	1	1997-12-18 00:00:00	1998-01-15 00:00:00	1997-12-24 00:00:00	3	1.50999999	GROSELLA-Restaurante	5ª Ave. Los Palos Grandes	Caracas	DF	1081	Venezuela
10786	QUEEN	8	1997-12-19 00:00:00	1998-01-16 00:00:00	1997-12-23 00:00:00	1	110.870003	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10787	LAMAI	2	1997-12-19 00:00:00	1998-01-02 00:00:00	1997-12-26 00:00:00	1	249.929993	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10788	QUICK	1	1997-12-22 00:00:00	1998-01-19 00:00:00	1998-01-19 00:00:00	2	42.7000008	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10789	FOLIG	1	1997-12-22 00:00:00	1998-01-19 00:00:00	1997-12-31 00:00:00	2	100.599998	Folies gourmandes	184 chaussée de Tournai	Lille	\N	59000	France
10790	GOURL	6	1997-12-22 00:00:00	1998-01-19 00:00:00	1997-12-26 00:00:00	1	28.2299995	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10791	FRANK	6	1997-12-23 00:00:00	1998-01-20 00:00:00	1998-01-01 00:00:00	2	16.8500004	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10792	WOLZA	1	1997-12-23 00:00:00	1998-01-20 00:00:00	1997-12-31 00:00:00	3	23.7900009	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
10793	AROUT	3	1997-12-24 00:00:00	1998-01-21 00:00:00	1998-01-08 00:00:00	3	4.51999998	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10794	QUEDE	6	1997-12-24 00:00:00	1998-01-21 00:00:00	1998-01-02 00:00:00	1	21.4899998	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10795	ERNSH	8	1997-12-24 00:00:00	1998-01-21 00:00:00	1998-01-20 00:00:00	2	126.660004	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10796	HILAA	3	1997-12-25 00:00:00	1998-01-22 00:00:00	1998-01-14 00:00:00	1	26.5200005	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10797	DRACD	7	1997-12-25 00:00:00	1998-01-22 00:00:00	1998-01-05 00:00:00	2	33.3499985	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany
10798	ISLAT	2	1997-12-26 00:00:00	1998-01-23 00:00:00	1998-01-05 00:00:00	1	2.32999992	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10799	KOENE	9	1997-12-26 00:00:00	1998-02-06 00:00:00	1998-01-05 00:00:00	3	30.7600002	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10800	SEVES	1	1997-12-26 00:00:00	1998-01-23 00:00:00	1998-01-05 00:00:00	3	137.440002	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10801	BOLID	4	1997-12-29 00:00:00	1998-01-26 00:00:00	1997-12-31 00:00:00	2	97.0899963	Bólido Comidas preparadas	C/ Araquil 67	Madrid	\N	28023	Spain
10802	SIMOB	4	1997-12-29 00:00:00	1998-01-26 00:00:00	1998-01-02 00:00:00	2	257.26001	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
10803	WELLI	4	1997-12-30 00:00:00	1998-01-27 00:00:00	1998-01-06 00:00:00	1	55.2299995	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10804	SEVES	6	1997-12-30 00:00:00	1998-01-27 00:00:00	1998-01-07 00:00:00	2	27.3299999	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10805	THEBI	2	1997-12-30 00:00:00	1998-01-27 00:00:00	1998-01-09 00:00:00	3	237.339996	The Big Cheese	89 Jefferson Way Suite 2	Portland	OR	97201	USA
10806	VICTE	3	1997-12-31 00:00:00	1998-01-28 00:00:00	1998-01-05 00:00:00	2	22.1100006	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10807	FRANS	4	1997-12-31 00:00:00	1998-01-28 00:00:00	1998-01-30 00:00:00	1	1.36000001	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy
10808	OLDWO	2	1998-01-01 00:00:00	1998-01-29 00:00:00	1998-01-09 00:00:00	3	45.5299988	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10809	WELLI	7	1998-01-01 00:00:00	1998-01-29 00:00:00	1998-01-07 00:00:00	1	4.86999989	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10810	LAUGB	2	1998-01-01 00:00:00	1998-01-29 00:00:00	1998-01-07 00:00:00	3	4.32999992	Laughing Bacchus Wine Cellars	2319 Elm St.	Vancouver	BC	V3F 2K1	Canada
10811	LINOD	8	1998-01-02 00:00:00	1998-01-30 00:00:00	1998-01-08 00:00:00	1	31.2199993	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10812	REGGC	5	1998-01-02 00:00:00	1998-01-30 00:00:00	1998-01-12 00:00:00	1	59.7799988	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10813	RICAR	1	1998-01-05 00:00:00	1998-02-02 00:00:00	1998-01-09 00:00:00	1	47.3800011	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10814	VICTE	3	1998-01-05 00:00:00	1998-02-02 00:00:00	1998-01-14 00:00:00	3	130.940002	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10815	SAVEA	2	1998-01-05 00:00:00	1998-02-02 00:00:00	1998-01-14 00:00:00	3	14.6199999	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10816	GREAL	4	1998-01-06 00:00:00	1998-02-03 00:00:00	1998-02-04 00:00:00	2	719.780029	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10817	KOENE	3	1998-01-06 00:00:00	1998-01-20 00:00:00	1998-01-13 00:00:00	2	306.070007	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10818	MAGAA	7	1998-01-07 00:00:00	1998-02-04 00:00:00	1998-01-12 00:00:00	3	65.4800034	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10819	CACTU	2	1998-01-07 00:00:00	1998-02-04 00:00:00	1998-01-16 00:00:00	3	19.7600002	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina
10820	RATTC	3	1998-01-07 00:00:00	1998-02-04 00:00:00	1998-01-13 00:00:00	2	37.5200005	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10821	SPLIR	1	1998-01-08 00:00:00	1998-02-05 00:00:00	1998-01-15 00:00:00	1	36.6800003	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10822	TRAIH	6	1998-01-08 00:00:00	1998-02-05 00:00:00	1998-01-16 00:00:00	3	7	Trail's Head Gourmet Provisioners	722 DaVinci Blvd.	Kirkland	WA	98034	USA
10823	LILAS	5	1998-01-09 00:00:00	1998-02-06 00:00:00	1998-01-13 00:00:00	2	163.970001	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10824	FOLKO	8	1998-01-09 00:00:00	1998-02-06 00:00:00	1998-01-30 00:00:00	1	1.23000002	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10825	DRACD	1	1998-01-09 00:00:00	1998-02-06 00:00:00	1998-01-14 00:00:00	1	79.25	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany
10826	BLONP	6	1998-01-12 00:00:00	1998-02-09 00:00:00	1998-02-06 00:00:00	1	7.09000015	Blondel père et fils	24 place Kléber	Strasbourg	\N	67000	France
10827	BONAP	1	1998-01-12 00:00:00	1998-01-26 00:00:00	1998-02-06 00:00:00	2	63.5400009	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10828	RANCH	9	1998-01-13 00:00:00	1998-01-27 00:00:00	1998-02-04 00:00:00	1	90.8499985	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina
10829	ISLAT	9	1998-01-13 00:00:00	1998-02-10 00:00:00	1998-01-23 00:00:00	1	154.720001	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10830	TRADH	4	1998-01-13 00:00:00	1998-02-24 00:00:00	1998-01-21 00:00:00	2	81.8300018	Tradiçao Hipermercados	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil
10831	SANTG	3	1998-01-14 00:00:00	1998-02-11 00:00:00	1998-01-23 00:00:00	2	72.1900024	Santé Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway
10832	LAMAI	2	1998-01-14 00:00:00	1998-02-11 00:00:00	1998-01-19 00:00:00	2	43.2599983	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10833	OTTIK	6	1998-01-15 00:00:00	1998-02-12 00:00:00	1998-01-23 00:00:00	2	71.4899979	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
10834	TRADH	1	1998-01-15 00:00:00	1998-02-12 00:00:00	1998-01-19 00:00:00	3	29.7800007	Tradiçao Hipermercados	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil
10835	ALFKI	1	1998-01-15 00:00:00	1998-02-12 00:00:00	1998-01-21 00:00:00	3	69.5299988	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany
10836	ERNSH	7	1998-01-16 00:00:00	1998-02-13 00:00:00	1998-01-21 00:00:00	1	411.880005	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10837	BERGS	9	1998-01-16 00:00:00	1998-02-13 00:00:00	1998-01-23 00:00:00	3	13.3199997	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10838	LINOD	3	1998-01-19 00:00:00	1998-02-16 00:00:00	1998-01-23 00:00:00	3	59.2799988	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10839	TRADH	3	1998-01-19 00:00:00	1998-02-16 00:00:00	1998-01-22 00:00:00	3	35.4300003	Tradiçao Hipermercados	Av. Inês de Castro 414	Sao Paulo	SP	05634-030	Brazil
10840	LINOD	4	1998-01-19 00:00:00	1998-03-02 00:00:00	1998-02-16 00:00:00	2	2.71000004	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10841	SUPRD	5	1998-01-20 00:00:00	1998-02-17 00:00:00	1998-01-29 00:00:00	2	424.299988	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10842	TORTU	1	1998-01-20 00:00:00	1998-02-17 00:00:00	1998-01-29 00:00:00	3	54.4199982	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10843	VICTE	4	1998-01-21 00:00:00	1998-02-18 00:00:00	1998-01-26 00:00:00	2	9.26000023	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10844	PICCO	8	1998-01-21 00:00:00	1998-02-18 00:00:00	1998-01-26 00:00:00	2	25.2199993	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
10845	QUICK	8	1998-01-21 00:00:00	1998-02-04 00:00:00	1998-01-30 00:00:00	1	212.979996	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10846	SUPRD	2	1998-01-22 00:00:00	1998-03-05 00:00:00	1998-01-23 00:00:00	3	56.4599991	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10847	SAVEA	4	1998-01-22 00:00:00	1998-02-05 00:00:00	1998-02-10 00:00:00	3	487.570007	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10848	CONSH	7	1998-01-23 00:00:00	1998-02-20 00:00:00	1998-01-29 00:00:00	2	38.2400017	Consolidated Holdings	Berkeley Gardens 12  Brewery	London	\N	WX1 6LT	UK
10849	KOENE	9	1998-01-23 00:00:00	1998-02-20 00:00:00	1998-01-30 00:00:00	2	0.560000002	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10850	VICTE	1	1998-01-23 00:00:00	1998-03-06 00:00:00	1998-01-30 00:00:00	1	49.1899986	Victuailles en stock	2 rue du Commerce	Lyon	\N	69004	France
10851	RICAR	5	1998-01-26 00:00:00	1998-02-23 00:00:00	1998-02-02 00:00:00	1	160.550003	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10852	RATTC	8	1998-01-26 00:00:00	1998-02-09 00:00:00	1998-01-30 00:00:00	1	174.050003	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10853	BLAUS	9	1998-01-27 00:00:00	1998-02-24 00:00:00	1998-02-03 00:00:00	2	53.8300018	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
10855	OLDWO	3	1998-01-27 00:00:00	1998-02-24 00:00:00	1998-02-04 00:00:00	1	170.970001	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10856	ANTON	3	1998-01-28 00:00:00	1998-02-25 00:00:00	1998-02-10 00:00:00	2	58.4300003	Antonio Moreno Taquería	Mataderos  2312	México D.F.	\N	05023	Mexico
10857	BERGS	8	1998-01-28 00:00:00	1998-02-25 00:00:00	1998-02-06 00:00:00	2	188.850006	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10858	LACOR	2	1998-01-29 00:00:00	1998-02-26 00:00:00	1998-02-03 00:00:00	1	52.5099983	La corne d'abondance	67 avenue de l'Europe	Versailles	\N	78000	France
10859	FRANK	1	1998-01-29 00:00:00	1998-02-26 00:00:00	1998-02-02 00:00:00	2	76.0999985	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10860	FRANR	3	1998-01-29 00:00:00	1998-02-26 00:00:00	1998-02-04 00:00:00	3	19.2600002	France restauration	54 rue Royale	Nantes	\N	44000	France
10861	WHITC	4	1998-01-30 00:00:00	1998-02-27 00:00:00	1998-02-17 00:00:00	2	14.9300003	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10862	LEHMS	8	1998-01-30 00:00:00	1998-03-13 00:00:00	1998-02-02 00:00:00	2	53.2299995	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10863	HILAA	4	1998-02-02 00:00:00	1998-03-02 00:00:00	1998-02-17 00:00:00	2	30.2600002	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10864	AROUT	4	1998-02-02 00:00:00	1998-03-02 00:00:00	1998-02-09 00:00:00	2	3.03999996	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10865	QUICK	2	1998-02-02 00:00:00	1998-02-16 00:00:00	1998-02-12 00:00:00	1	348.140015	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10866	BERGS	5	1998-02-03 00:00:00	1998-03-03 00:00:00	1998-02-12 00:00:00	1	109.110001	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10867	LONEP	6	1998-02-03 00:00:00	1998-03-17 00:00:00	1998-02-11 00:00:00	1	1.92999995	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10868	QUEEN	7	1998-02-04 00:00:00	1998-03-04 00:00:00	1998-02-23 00:00:00	2	191.270004	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10869	SEVES	5	1998-02-04 00:00:00	1998-03-04 00:00:00	1998-02-09 00:00:00	1	143.279999	Seven Seas Imports	90 Wadhurst Rd.	London	\N	OX15 4NB	UK
10870	WOLZA	5	1998-02-04 00:00:00	1998-03-04 00:00:00	1998-02-13 00:00:00	3	12.04	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
10871	BONAP	9	1998-02-05 00:00:00	1998-03-05 00:00:00	1998-02-10 00:00:00	2	112.269997	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10872	GODOS	5	1998-02-05 00:00:00	1998-03-05 00:00:00	1998-02-09 00:00:00	2	175.320007	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10873	WILMK	4	1998-02-06 00:00:00	1998-03-06 00:00:00	1998-02-09 00:00:00	1	0.819999993	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
10874	GODOS	5	1998-02-06 00:00:00	1998-03-06 00:00:00	1998-02-11 00:00:00	2	19.5799999	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10875	BERGS	4	1998-02-06 00:00:00	1998-03-06 00:00:00	1998-03-03 00:00:00	2	32.3699989	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10876	BONAP	7	1998-02-09 00:00:00	1998-03-09 00:00:00	1998-02-12 00:00:00	3	60.4199982	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10877	RICAR	1	1998-02-09 00:00:00	1998-03-09 00:00:00	1998-02-19 00:00:00	1	38.0600014	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
10878	QUICK	4	1998-02-10 00:00:00	1998-03-10 00:00:00	1998-02-12 00:00:00	1	46.6899986	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10879	WILMK	3	1998-02-10 00:00:00	1998-03-10 00:00:00	1998-02-12 00:00:00	3	8.5	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
10880	FOLKO	7	1998-02-10 00:00:00	1998-03-24 00:00:00	1998-02-18 00:00:00	1	88.0100021	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10881	CACTU	4	1998-02-11 00:00:00	1998-03-11 00:00:00	1998-02-18 00:00:00	1	2.83999991	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina
10882	SAVEA	4	1998-02-11 00:00:00	1998-03-11 00:00:00	1998-02-20 00:00:00	3	23.1000004	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10883	LONEP	8	1998-02-12 00:00:00	1998-03-12 00:00:00	1998-02-20 00:00:00	3	0.529999971	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
10884	LETSS	4	1998-02-12 00:00:00	1998-03-12 00:00:00	1998-02-13 00:00:00	2	90.9700012	Let's Stop N Shop	87 Polk St. Suite 5	San Francisco	CA	94117	USA
10885	SUPRD	6	1998-02-12 00:00:00	1998-03-12 00:00:00	1998-02-18 00:00:00	3	5.63999987	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10886	HANAR	1	1998-02-13 00:00:00	1998-03-13 00:00:00	1998-03-02 00:00:00	1	4.98999977	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10887	GALED	8	1998-02-13 00:00:00	1998-03-13 00:00:00	1998-02-16 00:00:00	3	1.25	Galería del gastronómo	Rambla de Cataluña 23	Barcelona	\N	8022	Spain
10888	GODOS	1	1998-02-16 00:00:00	1998-03-16 00:00:00	1998-02-23 00:00:00	2	51.8699989	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10889	RATTC	9	1998-02-16 00:00:00	1998-03-16 00:00:00	1998-02-23 00:00:00	3	280.609985	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10890	DUMON	7	1998-02-16 00:00:00	1998-03-16 00:00:00	1998-02-18 00:00:00	1	32.7599983	Du monde entier	67 rue des Cinquante Otages	Nantes	\N	44000	France
10891	LEHMS	7	1998-02-17 00:00:00	1998-03-17 00:00:00	1998-02-19 00:00:00	2	20.3700008	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10892	MAISD	4	1998-02-17 00:00:00	1998-03-17 00:00:00	1998-02-19 00:00:00	2	120.269997	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
10893	KOENE	9	1998-02-18 00:00:00	1998-03-18 00:00:00	1998-02-20 00:00:00	2	77.7799988	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
10894	SAVEA	1	1998-02-18 00:00:00	1998-03-18 00:00:00	1998-02-20 00:00:00	1	116.129997	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10895	ERNSH	3	1998-02-18 00:00:00	1998-03-18 00:00:00	1998-02-23 00:00:00	1	162.75	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10896	MAISD	7	1998-02-19 00:00:00	1998-03-19 00:00:00	1998-02-27 00:00:00	3	32.4500008	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
10897	HUNGO	3	1998-02-19 00:00:00	1998-03-19 00:00:00	1998-02-25 00:00:00	2	603.539978	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10898	OCEAN	4	1998-02-20 00:00:00	1998-03-20 00:00:00	1998-03-06 00:00:00	2	1.26999998	Océano Atlántico Ltda.	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	\N	1010	Argentina
10899	LILAS	5	1998-02-20 00:00:00	1998-03-20 00:00:00	1998-02-26 00:00:00	3	1.21000004	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10900	WELLI	1	1998-02-20 00:00:00	1998-03-20 00:00:00	1998-03-04 00:00:00	2	1.65999997	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10901	HILAA	4	1998-02-23 00:00:00	1998-03-23 00:00:00	1998-02-26 00:00:00	1	62.0900002	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10902	FOLKO	1	1998-02-23 00:00:00	1998-03-23 00:00:00	1998-03-03 00:00:00	1	44.1500015	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10903	HANAR	3	1998-02-24 00:00:00	1998-03-24 00:00:00	1998-03-04 00:00:00	3	36.7099991	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10904	WHITC	3	1998-02-24 00:00:00	1998-03-24 00:00:00	1998-02-27 00:00:00	3	162.949997	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
10905	WELLI	9	1998-02-24 00:00:00	1998-03-24 00:00:00	1998-03-06 00:00:00	2	13.7200003	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10906	WOLZA	4	1998-02-25 00:00:00	1998-03-11 00:00:00	1998-03-03 00:00:00	3	26.2900009	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
10907	SPECD	6	1998-02-25 00:00:00	1998-03-25 00:00:00	1998-02-27 00:00:00	3	9.18999958	Spécialités du monde	25 rue Lauriston	Paris	\N	75016	France
10908	REGGC	4	1998-02-26 00:00:00	1998-03-26 00:00:00	1998-03-06 00:00:00	2	32.9599991	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10909	SANTG	1	1998-02-26 00:00:00	1998-03-26 00:00:00	1998-03-10 00:00:00	2	53.0499992	Santé Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway
10910	WILMK	1	1998-02-26 00:00:00	1998-03-26 00:00:00	1998-03-04 00:00:00	3	38.1100006	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
10911	GODOS	3	1998-02-26 00:00:00	1998-03-26 00:00:00	1998-03-05 00:00:00	1	38.1899986	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10912	HUNGO	2	1998-02-26 00:00:00	1998-03-26 00:00:00	1998-03-18 00:00:00	2	580.909973	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10913	QUEEN	4	1998-02-26 00:00:00	1998-03-26 00:00:00	1998-03-04 00:00:00	1	33.0499992	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10914	QUEEN	6	1998-02-27 00:00:00	1998-03-27 00:00:00	1998-03-02 00:00:00	1	21.1900005	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10915	TORTU	2	1998-02-27 00:00:00	1998-03-27 00:00:00	1998-03-02 00:00:00	2	3.50999999	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
10916	RANCH	1	1998-02-27 00:00:00	1998-03-27 00:00:00	1998-03-09 00:00:00	2	63.7700005	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina
10917	ROMEY	4	1998-03-02 00:00:00	1998-03-30 00:00:00	1998-03-11 00:00:00	2	8.28999996	Romero y tomillo	Gran Vía 1	Madrid	\N	28001	Spain
10918	BOTTM	3	1998-03-02 00:00:00	1998-03-30 00:00:00	1998-03-11 00:00:00	3	48.8300018	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10919	LINOD	2	1998-03-02 00:00:00	1998-03-30 00:00:00	1998-03-04 00:00:00	2	19.7999992	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10920	AROUT	4	1998-03-03 00:00:00	1998-03-31 00:00:00	1998-03-09 00:00:00	2	29.6100006	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10921	VAFFE	1	1998-03-03 00:00:00	1998-04-14 00:00:00	1998-03-09 00:00:00	1	176.479996	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10922	HANAR	5	1998-03-03 00:00:00	1998-03-31 00:00:00	1998-03-05 00:00:00	3	62.7400017	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10923	LAMAI	7	1998-03-03 00:00:00	1998-04-14 00:00:00	1998-03-13 00:00:00	3	68.2600021	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
10924	BERGS	3	1998-03-04 00:00:00	1998-04-01 00:00:00	1998-04-08 00:00:00	2	151.520004	Berglunds snabbköp	Berguvsvägen  8	Luleå	\N	S-958 22	Sweden
10925	HANAR	3	1998-03-04 00:00:00	1998-04-01 00:00:00	1998-03-13 00:00:00	1	2.26999998	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10926	ANATR	4	1998-03-04 00:00:00	1998-04-01 00:00:00	1998-03-11 00:00:00	3	39.9199982	Ana Trujillo Emparedados y helados	Avda. de la Constitución 2222	México D.F.	\N	05021	Mexico
10927	LACOR	4	1998-03-05 00:00:00	1998-04-02 00:00:00	1998-04-08 00:00:00	1	19.7900009	La corne d'abondance	67 avenue de l'Europe	Versailles	\N	78000	France
10928	GALED	1	1998-03-05 00:00:00	1998-04-02 00:00:00	1998-03-18 00:00:00	1	1.36000001	Galería del gastronómo	Rambla de Cataluña 23	Barcelona	\N	8022	Spain
10929	FRANK	6	1998-03-05 00:00:00	1998-04-02 00:00:00	1998-03-12 00:00:00	1	33.9300003	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
10930	SUPRD	4	1998-03-06 00:00:00	1998-04-17 00:00:00	1998-03-18 00:00:00	3	15.5500002	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
10931	RICSU	4	1998-03-06 00:00:00	1998-03-20 00:00:00	1998-03-19 00:00:00	2	13.6000004	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10932	BONAP	8	1998-03-06 00:00:00	1998-04-03 00:00:00	1998-03-24 00:00:00	1	134.639999	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10933	ISLAT	6	1998-03-06 00:00:00	1998-04-03 00:00:00	1998-03-16 00:00:00	3	54.1500015	Island Trading	Garden House Crowther Way	Cowes	Isle of Wight	PO31 7PJ	UK
10934	LEHMS	3	1998-03-09 00:00:00	1998-04-06 00:00:00	1998-03-12 00:00:00	3	32.0099983	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
10935	WELLI	4	1998-03-09 00:00:00	1998-04-06 00:00:00	1998-03-18 00:00:00	3	47.5900002	Wellington Importadora	Rua do Mercado 12	Resende	SP	08737-363	Brazil
10936	GREAL	3	1998-03-09 00:00:00	1998-04-06 00:00:00	1998-03-18 00:00:00	2	33.6800003	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
10937	CACTU	7	1998-03-10 00:00:00	1998-03-24 00:00:00	1998-03-13 00:00:00	3	31.5100002	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina
10938	QUICK	3	1998-03-10 00:00:00	1998-04-07 00:00:00	1998-03-16 00:00:00	2	31.8899994	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10939	MAGAA	2	1998-03-10 00:00:00	1998-04-07 00:00:00	1998-03-13 00:00:00	2	76.3300018	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10940	BONAP	8	1998-03-11 00:00:00	1998-04-08 00:00:00	1998-03-23 00:00:00	3	19.7700005	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
10941	SAVEA	7	1998-03-11 00:00:00	1998-04-08 00:00:00	1998-03-20 00:00:00	2	400.809998	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10942	REGGC	9	1998-03-11 00:00:00	1998-04-08 00:00:00	1998-03-18 00:00:00	3	17.9500008	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
10943	BSBEV	4	1998-03-11 00:00:00	1998-04-08 00:00:00	1998-03-19 00:00:00	2	2.17000008	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10944	BOTTM	6	1998-03-12 00:00:00	1998-03-26 00:00:00	1998-03-13 00:00:00	3	52.9199982	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10945	MORGK	4	1998-03-12 00:00:00	1998-04-09 00:00:00	1998-03-18 00:00:00	1	10.2200003	Morgenstern Gesundkost	Heerstr. 22	Leipzig	\N	04179	Germany
10946	VAFFE	1	1998-03-12 00:00:00	1998-04-09 00:00:00	1998-03-19 00:00:00	2	27.2000008	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10947	BSBEV	3	1998-03-13 00:00:00	1998-04-10 00:00:00	1998-03-16 00:00:00	2	3.25999999	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
10948	GODOS	3	1998-03-13 00:00:00	1998-04-10 00:00:00	1998-03-19 00:00:00	3	23.3899994	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
10949	BOTTM	2	1998-03-13 00:00:00	1998-04-10 00:00:00	1998-03-17 00:00:00	3	74.4400024	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10950	MAGAA	1	1998-03-16 00:00:00	1998-04-13 00:00:00	1998-03-23 00:00:00	2	2.5	Magazzini Alimentari Riuniti	Via Ludovico il Moro 22	Bergamo	\N	24100	Italy
10951	RICSU	9	1998-03-16 00:00:00	1998-04-27 00:00:00	1998-04-07 00:00:00	2	30.8500004	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
10952	ALFKI	1	1998-03-16 00:00:00	1998-04-27 00:00:00	1998-03-24 00:00:00	1	40.4199982	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany
10953	AROUT	9	1998-03-16 00:00:00	1998-03-30 00:00:00	1998-03-25 00:00:00	2	23.7199993	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
10954	LINOD	5	1998-03-17 00:00:00	1998-04-28 00:00:00	1998-03-20 00:00:00	1	27.9099998	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
10955	FOLKO	8	1998-03-17 00:00:00	1998-04-14 00:00:00	1998-03-20 00:00:00	2	3.25999999	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10956	BLAUS	6	1998-03-17 00:00:00	1998-04-28 00:00:00	1998-03-20 00:00:00	2	44.6500015	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
10957	HILAA	8	1998-03-18 00:00:00	1998-04-15 00:00:00	1998-03-27 00:00:00	3	105.360001	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10958	OCEAN	7	1998-03-18 00:00:00	1998-04-15 00:00:00	1998-03-27 00:00:00	2	49.5600014	Océano Atlántico Ltda.	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	\N	1010	Argentina
10959	GOURL	6	1998-03-18 00:00:00	1998-04-29 00:00:00	1998-03-23 00:00:00	2	4.98000002	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
10960	HILAA	3	1998-03-19 00:00:00	1998-04-02 00:00:00	1998-04-08 00:00:00	1	2.07999992	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10961	QUEEN	8	1998-03-19 00:00:00	1998-04-16 00:00:00	1998-03-30 00:00:00	1	104.470001	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
10962	QUICK	8	1998-03-19 00:00:00	1998-04-16 00:00:00	1998-03-23 00:00:00	2	275.790009	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10963	FURIB	9	1998-03-19 00:00:00	1998-04-16 00:00:00	1998-03-26 00:00:00	3	2.70000005	Furia Bacalhau e Frutos do Mar	Jardim das rosas n. 32	Lisboa	\N	1675	Portugal
10964	SPECD	3	1998-03-20 00:00:00	1998-04-17 00:00:00	1998-03-24 00:00:00	2	87.3799973	Spécialités du monde	25 rue Lauriston	Paris	\N	75016	France
10965	OLDWO	6	1998-03-20 00:00:00	1998-04-17 00:00:00	1998-03-30 00:00:00	3	144.380005	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
10966	CHOPS	4	1998-03-20 00:00:00	1998-04-17 00:00:00	1998-04-08 00:00:00	1	27.1900005	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
10967	TOMSP	2	1998-03-23 00:00:00	1998-04-20 00:00:00	1998-04-02 00:00:00	2	62.2200012	Toms Spezialitäten	Luisenstr. 48	Münster	\N	44087	Germany
10968	ERNSH	1	1998-03-23 00:00:00	1998-04-20 00:00:00	1998-04-01 00:00:00	3	74.5999985	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10969	COMMI	1	1998-03-23 00:00:00	1998-04-20 00:00:00	1998-03-30 00:00:00	2	0.209999993	Comércio Mineiro	Av. dos Lusíadas 23	Sao Paulo	SP	05432-043	Brazil
10970	BOLID	9	1998-03-24 00:00:00	1998-04-07 00:00:00	1998-04-24 00:00:00	1	16.1599998	Bólido Comidas preparadas	C/ Araquil 67	Madrid	\N	28023	Spain
10971	FRANR	2	1998-03-24 00:00:00	1998-04-21 00:00:00	1998-04-02 00:00:00	2	121.82	France restauration	54 rue Royale	Nantes	\N	44000	France
10972	LACOR	4	1998-03-24 00:00:00	1998-04-21 00:00:00	1998-03-26 00:00:00	2	0.0199999996	La corne d'abondance	67 avenue de l'Europe	Versailles	\N	78000	France
10973	LACOR	6	1998-03-24 00:00:00	1998-04-21 00:00:00	1998-03-27 00:00:00	2	15.1700001	La corne d'abondance	67 avenue de l'Europe	Versailles	\N	78000	France
10974	SPLIR	3	1998-03-25 00:00:00	1998-04-08 00:00:00	1998-04-03 00:00:00	3	12.96	Split Rail Beer & Ale	P.O. Box 555	Lander	WY	82520	USA
10975	BOTTM	1	1998-03-25 00:00:00	1998-04-22 00:00:00	1998-03-27 00:00:00	3	32.2700005	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10976	HILAA	1	1998-03-25 00:00:00	1998-05-06 00:00:00	1998-04-03 00:00:00	1	37.9700012	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
10977	FOLKO	8	1998-03-26 00:00:00	1998-04-23 00:00:00	1998-04-10 00:00:00	3	208.5	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10978	MAISD	9	1998-03-26 00:00:00	1998-04-23 00:00:00	1998-04-23 00:00:00	2	32.8199997	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
10979	ERNSH	8	1998-03-26 00:00:00	1998-04-23 00:00:00	1998-03-31 00:00:00	2	353.070007	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10980	FOLKO	4	1998-03-27 00:00:00	1998-05-08 00:00:00	1998-04-17 00:00:00	1	1.25999999	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10981	HANAR	1	1998-03-27 00:00:00	1998-04-24 00:00:00	1998-04-02 00:00:00	2	193.369995	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
10982	BOTTM	2	1998-03-27 00:00:00	1998-04-24 00:00:00	1998-04-08 00:00:00	1	14.0100002	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
10983	SAVEA	2	1998-03-27 00:00:00	1998-04-24 00:00:00	1998-04-06 00:00:00	2	657.539978	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10984	SAVEA	1	1998-03-30 00:00:00	1998-04-27 00:00:00	1998-04-03 00:00:00	3	211.220001	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
10985	HUNGO	2	1998-03-30 00:00:00	1998-04-27 00:00:00	1998-04-02 00:00:00	1	91.5100021	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
10986	OCEAN	8	1998-03-30 00:00:00	1998-04-27 00:00:00	1998-04-21 00:00:00	2	217.860001	Océano Atlántico Ltda.	Ing. Gustavo Moncada 8585 Piso 20-A	Buenos Aires	\N	1010	Argentina
10987	EASTC	8	1998-03-31 00:00:00	1998-04-28 00:00:00	1998-04-06 00:00:00	1	185.479996	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
10988	RATTC	3	1998-03-31 00:00:00	1998-04-28 00:00:00	1998-04-10 00:00:00	2	61.1399994	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
10989	QUEDE	2	1998-03-31 00:00:00	1998-04-28 00:00:00	1998-04-02 00:00:00	1	34.7599983	Que Delícia	Rua da Panificadora 12	Rio de Janeiro	RJ	02389-673	Brazil
10990	ERNSH	2	1998-04-01 00:00:00	1998-05-13 00:00:00	1998-04-07 00:00:00	3	117.610001	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
10991	QUICK	1	1998-04-01 00:00:00	1998-04-29 00:00:00	1998-04-07 00:00:00	1	38.5099983	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10992	THEBI	1	1998-04-01 00:00:00	1998-04-29 00:00:00	1998-04-03 00:00:00	3	4.26999998	The Big Cheese	89 Jefferson Way Suite 2	Portland	OR	97201	USA
10993	FOLKO	7	1998-04-01 00:00:00	1998-04-29 00:00:00	1998-04-10 00:00:00	3	8.81000042	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
10994	VAFFE	2	1998-04-02 00:00:00	1998-04-16 00:00:00	1998-04-09 00:00:00	3	65.5299988	Vaffeljernet	Smagsloget 45	Århus	\N	8200	Denmark
10995	PERIC	1	1998-04-02 00:00:00	1998-04-30 00:00:00	1998-04-06 00:00:00	3	46	Pericles Comidas clásicas	Calle Dr. Jorge Cash 321	México D.F.	\N	05033	Mexico
10996	QUICK	4	1998-04-02 00:00:00	1998-04-30 00:00:00	1998-04-10 00:00:00	2	1.12	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
10997	LILAS	8	1998-04-03 00:00:00	1998-05-15 00:00:00	1998-04-13 00:00:00	2	73.9100037	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
10998	WOLZA	8	1998-04-03 00:00:00	1998-04-17 00:00:00	1998-04-17 00:00:00	2	20.3099995	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
10999	OTTIK	6	1998-04-03 00:00:00	1998-05-01 00:00:00	1998-04-10 00:00:00	2	96.3499985	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
11000	RATTC	2	1998-04-06 00:00:00	1998-05-04 00:00:00	1998-04-14 00:00:00	3	55.1199989	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
11001	FOLKO	2	1998-04-06 00:00:00	1998-05-04 00:00:00	1998-04-14 00:00:00	2	197.300003	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
11002	SAVEA	4	1998-04-06 00:00:00	1998-05-04 00:00:00	1998-04-16 00:00:00	1	141.160004	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
11003	THECR	3	1998-04-06 00:00:00	1998-05-04 00:00:00	1998-04-08 00:00:00	3	14.9099998	The Cracker Box	55 Grizzly Peak Rd.	Butte	MT	59801	USA
11004	MAISD	3	1998-04-07 00:00:00	1998-05-05 00:00:00	1998-04-20 00:00:00	1	44.8400002	Maison Dewey	Rue Joseph-Bens 532	Bruxelles	\N	B-1180	Belgium
11005	WILMK	2	1998-04-07 00:00:00	1998-05-05 00:00:00	1998-04-10 00:00:00	1	0.75	Wilman Kala	Keskuskatu 45	Helsinki	\N	21240	Finland
11006	GREAL	3	1998-04-07 00:00:00	1998-05-05 00:00:00	1998-04-15 00:00:00	2	25.1900005	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
11007	PRINI	8	1998-04-08 00:00:00	1998-05-06 00:00:00	1998-04-13 00:00:00	2	202.240005	Princesa Isabel Vinhos	Estrada da saúde n. 58	Lisboa	\N	1756	Portugal
11008	ERNSH	7	1998-04-08 00:00:00	1998-05-06 00:00:00	\N	3	79.4599991	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
11009	GODOS	2	1998-04-08 00:00:00	1998-05-06 00:00:00	1998-04-10 00:00:00	1	59.1100006	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
11010	REGGC	2	1998-04-09 00:00:00	1998-05-07 00:00:00	1998-04-21 00:00:00	2	28.7099991	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
11011	ALFKI	3	1998-04-09 00:00:00	1998-05-07 00:00:00	1998-04-13 00:00:00	1	1.21000004	Alfred's Futterkiste	Obere Str. 57	Berlin	\N	12209	Germany
11012	FRANK	1	1998-04-09 00:00:00	1998-04-23 00:00:00	1998-04-17 00:00:00	3	242.949997	Frankenversand	Berliner Platz 43	München	\N	80805	Germany
11013	ROMEY	2	1998-04-09 00:00:00	1998-05-07 00:00:00	1998-04-10 00:00:00	1	32.9900017	Romero y tomillo	Gran Vía 1	Madrid	\N	28001	Spain
11014	LINOD	2	1998-04-10 00:00:00	1998-05-08 00:00:00	1998-04-15 00:00:00	3	23.6000004	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
11015	SANTG	2	1998-04-10 00:00:00	1998-04-24 00:00:00	1998-04-20 00:00:00	2	4.61999989	Santé Gourmet	Erling Skakkes gate 78	Stavern	\N	4110	Norway
11016	AROUT	9	1998-04-10 00:00:00	1998-05-08 00:00:00	1998-04-13 00:00:00	2	33.7999992	Around the Horn	Brook Farm Stratford St. Mary	Colchester	Essex	CO7 6JX	UK
11017	ERNSH	9	1998-04-13 00:00:00	1998-05-11 00:00:00	1998-04-20 00:00:00	2	754.26001	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
11018	LONEP	4	1998-04-13 00:00:00	1998-05-11 00:00:00	1998-04-16 00:00:00	2	11.6499996	Lonesome Pine Restaurant	89 Chiaroscuro Rd.	Portland	OR	97219	USA
11019	RANCH	6	1998-04-13 00:00:00	1998-05-11 00:00:00	\N	3	3.17000008	Rancho grande	Av. del Libertador 900	Buenos Aires	\N	1010	Argentina
11020	OTTIK	2	1998-04-14 00:00:00	1998-05-12 00:00:00	1998-04-16 00:00:00	2	43.2999992	Ottilies Käseladen	Mehrheimerstr. 369	Köln	\N	50739	Germany
11021	QUICK	3	1998-04-14 00:00:00	1998-05-12 00:00:00	1998-04-21 00:00:00	1	297.179993	QUICK-Stop	Taucherstraße 10	Cunewalde	\N	01307	Germany
11022	HANAR	9	1998-04-14 00:00:00	1998-05-12 00:00:00	1998-05-04 00:00:00	2	6.26999998	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
11023	BSBEV	1	1998-04-14 00:00:00	1998-04-28 00:00:00	1998-04-24 00:00:00	2	123.830002	B's Beverages	Fauntleroy Circus	London	\N	EC2 5NT	UK
11024	EASTC	4	1998-04-15 00:00:00	1998-05-13 00:00:00	1998-04-20 00:00:00	1	74.3600006	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
11025	WARTH	6	1998-04-15 00:00:00	1998-05-13 00:00:00	1998-04-24 00:00:00	3	29.1700001	Wartian Herkku	Torikatu 38	Oulu	\N	90110	Finland
11026	FRANS	4	1998-04-15 00:00:00	1998-05-13 00:00:00	1998-04-28 00:00:00	1	47.0900002	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy
11027	BOTTM	1	1998-04-16 00:00:00	1998-05-14 00:00:00	1998-04-20 00:00:00	1	52.5200005	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
11028	KOENE	2	1998-04-16 00:00:00	1998-05-14 00:00:00	1998-04-22 00:00:00	1	29.5900002	Königlich Essen	Maubelstr. 90	Brandenburg	\N	14776	Germany
11029	CHOPS	4	1998-04-16 00:00:00	1998-05-14 00:00:00	1998-04-27 00:00:00	1	47.8400002	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
11030	SAVEA	7	1998-04-17 00:00:00	1998-05-15 00:00:00	1998-04-27 00:00:00	2	830.75	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
11031	SAVEA	6	1998-04-17 00:00:00	1998-05-15 00:00:00	1998-04-24 00:00:00	2	227.220001	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
11032	WHITC	2	1998-04-17 00:00:00	1998-05-15 00:00:00	1998-04-23 00:00:00	3	606.190002	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
11033	RICSU	7	1998-04-17 00:00:00	1998-05-15 00:00:00	1998-04-23 00:00:00	3	84.7399979	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
11034	OLDWO	8	1998-04-20 00:00:00	1998-06-01 00:00:00	1998-04-27 00:00:00	1	40.3199997	Old World Delicatessen	2743 Bering St.	Anchorage	AK	99508	USA
11035	SUPRD	2	1998-04-20 00:00:00	1998-05-18 00:00:00	1998-04-24 00:00:00	2	0.170000002	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
11036	DRACD	8	1998-04-20 00:00:00	1998-05-18 00:00:00	1998-04-22 00:00:00	3	149.470001	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany
11037	GODOS	7	1998-04-21 00:00:00	1998-05-19 00:00:00	1998-04-27 00:00:00	1	3.20000005	Godos Cocina Típica	C/ Romero 33	Sevilla	\N	41101	Spain
11038	SUPRD	1	1998-04-21 00:00:00	1998-05-19 00:00:00	1998-04-30 00:00:00	2	29.5900002	Suprêmes délices	Boulevard Tirou 255	Charleroi	\N	B-6000	Belgium
11039	LINOD	1	1998-04-21 00:00:00	1998-05-19 00:00:00	\N	2	65	LINO-Delicateses	Ave. 5 de Mayo Porlamar	I. de Margarita	Nueva Esparta	4980	Venezuela
11040	GREAL	4	1998-04-22 00:00:00	1998-05-20 00:00:00	\N	3	18.8400002	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
11041	CHOPS	3	1998-04-22 00:00:00	1998-05-20 00:00:00	1998-04-28 00:00:00	2	48.2200012	Chop-suey Chinese	Hauptstr. 31	Bern	\N	3012	Switzerland
11042	COMMI	2	1998-04-22 00:00:00	1998-05-06 00:00:00	1998-05-01 00:00:00	1	29.9899998	Comércio Mineiro	Av. dos Lusíadas 23	Sao Paulo	SP	05432-043	Brazil
11043	SPECD	5	1998-04-22 00:00:00	1998-05-20 00:00:00	1998-04-29 00:00:00	2	8.80000019	Spécialités du monde	25 rue Lauriston	Paris	\N	75016	France
11044	WOLZA	4	1998-04-23 00:00:00	1998-05-21 00:00:00	1998-05-01 00:00:00	1	8.72000027	Wolski Zajazd	ul. Filtrowa 68	Warszawa	\N	01-012	Poland
11045	BOTTM	6	1998-04-23 00:00:00	1998-05-21 00:00:00	\N	2	70.5800018	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
11046	WANDK	8	1998-04-23 00:00:00	1998-05-21 00:00:00	1998-04-24 00:00:00	2	71.6399994	Die Wandernde Kuh	Adenauerallee 900	Stuttgart	\N	70563	Germany
11047	EASTC	7	1998-04-24 00:00:00	1998-05-22 00:00:00	1998-05-01 00:00:00	3	46.6199989	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
11048	BOTTM	7	1998-04-24 00:00:00	1998-05-22 00:00:00	1998-04-30 00:00:00	3	24.1200008	Bottom-Dollar Markets	23 Tsawassen Blvd.	Tsawassen	BC	T2F 8M4	Canada
11049	GOURL	3	1998-04-24 00:00:00	1998-05-22 00:00:00	1998-05-04 00:00:00	1	8.34000015	Gourmet Lanchonetes	Av. Brasil 442	Campinas	SP	04876-786	Brazil
11050	FOLKO	8	1998-04-27 00:00:00	1998-05-25 00:00:00	1998-05-05 00:00:00	2	59.4099998	Folk och fä HB	Åkergatan 24	Bräcke	\N	S-844 67	Sweden
11051	LAMAI	7	1998-04-27 00:00:00	1998-05-25 00:00:00	\N	3	2.78999996	La maison d'Asie	1 rue Alsace-Lorraine	Toulouse	\N	31000	France
11052	HANAR	3	1998-04-27 00:00:00	1998-05-25 00:00:00	1998-05-01 00:00:00	1	67.2600021	Hanari Carnes	Rua do Paço 67	Rio de Janeiro	RJ	05454-876	Brazil
11053	PICCO	2	1998-04-27 00:00:00	1998-05-25 00:00:00	1998-04-29 00:00:00	2	53.0499992	Piccolo und mehr	Geislweg 14	Salzburg	\N	5020	Austria
11054	CACTU	8	1998-04-28 00:00:00	1998-05-26 00:00:00	\N	1	0.330000013	Cactus Comidas para llevar	Cerrito 333	Buenos Aires	\N	1010	Argentina
11055	HILAA	7	1998-04-28 00:00:00	1998-05-26 00:00:00	1998-05-05 00:00:00	2	120.919998	HILARION-Abastos	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	Táchira	5022	Venezuela
11056	EASTC	8	1998-04-28 00:00:00	1998-05-12 00:00:00	1998-05-01 00:00:00	2	278.959991	Eastern Connection	35 King George	London	\N	WX3 6FW	UK
11057	NORTS	3	1998-04-29 00:00:00	1998-05-27 00:00:00	1998-05-01 00:00:00	3	4.13000011	North/South	South House 300 Queensbridge	London	\N	SW7 1RZ	UK
11058	BLAUS	9	1998-04-29 00:00:00	1998-05-27 00:00:00	\N	3	31.1399994	Blauer See Delikatessen	Forsterstr. 57	Mannheim	\N	68306	Germany
11059	RICAR	2	1998-04-29 00:00:00	1998-06-10 00:00:00	\N	2	85.8000031	Ricardo Adocicados	Av. Copacabana 267	Rio de Janeiro	RJ	02389-890	Brazil
11060	FRANS	2	1998-04-30 00:00:00	1998-05-28 00:00:00	1998-05-04 00:00:00	2	10.9799995	Franchi S.p.A.	Via Monte Bianco 34	Torino	\N	10100	Italy
11061	GREAL	4	1998-04-30 00:00:00	1998-06-11 00:00:00	\N	3	14.0100002	Great Lakes Food Market	2732 Baker Blvd.	Eugene	OR	97403	USA
11062	REGGC	4	1998-04-30 00:00:00	1998-05-28 00:00:00	\N	2	29.9300003	Reggiani Caseifici	Strada Provinciale 124	Reggio Emilia	\N	42100	Italy
11063	HUNGO	3	1998-04-30 00:00:00	1998-05-28 00:00:00	1998-05-06 00:00:00	2	81.7300034	Hungry Owl All-Night Grocers	8 Johnstown Road	Cork	Co. Cork	\N	Ireland
11064	SAVEA	1	1998-05-01 00:00:00	1998-05-29 00:00:00	1998-05-04 00:00:00	1	30.0900002	Save-a-lot Markets	187 Suffolk Ln.	Boise	ID	83720	USA
11065	LILAS	8	1998-05-01 00:00:00	1998-05-29 00:00:00	\N	1	12.9099998	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
11066	WHITC	7	1998-05-01 00:00:00	1998-05-29 00:00:00	1998-05-04 00:00:00	2	44.7200012	White Clover Markets	1029 - 12th Ave. S.	Seattle	WA	98124	USA
11067	DRACD	1	1998-05-04 00:00:00	1998-05-18 00:00:00	1998-05-06 00:00:00	2	7.98000002	Drachenblut Delikatessen	Walserweg 21	Aachen	\N	52066	Germany
11068	QUEEN	8	1998-05-04 00:00:00	1998-06-01 00:00:00	\N	2	81.75	Queen Cozinha	Alameda dos Canàrios 891	Sao Paulo	SP	05487-020	Brazil
11069	TORTU	1	1998-05-04 00:00:00	1998-06-01 00:00:00	1998-05-06 00:00:00	2	15.6700001	Tortuga Restaurante	Avda. Azteca 123	México D.F.	\N	05033	Mexico
11070	LEHMS	2	1998-05-05 00:00:00	1998-06-02 00:00:00	\N	1	136	Lehmanns Marktstand	Magazinweg 7	Frankfurt a.M.	\N	60528	Germany
11071	LILAS	1	1998-05-05 00:00:00	1998-06-02 00:00:00	\N	1	0.930000007	LILA-Supermercado	Carrera 52 con Ave. Bolívar #65-98 Llano Largo	Barquisimeto	Lara	3508	Venezuela
11072	ERNSH	4	1998-05-05 00:00:00	1998-06-02 00:00:00	\N	2	258.640015	Ernst Handel	Kirchgasse 6	Graz	\N	8010	Austria
11073	PERIC	2	1998-05-05 00:00:00	1998-06-02 00:00:00	\N	2	24.9500008	Pericles Comidas clásicas	Calle Dr. Jorge Cash 321	México D.F.	\N	05033	Mexico
11074	SIMOB	7	1998-05-06 00:00:00	1998-06-03 00:00:00	\N	2	18.4400005	Simons bistro	Vinbæltet 34	Kobenhavn	\N	1734	Denmark
11075	RICSU	8	1998-05-06 00:00:00	1998-06-03 00:00:00	\N	2	6.19000006	Richter Supermarkt	Starenweg 5	Genève	\N	1204	Switzerland
11076	BONAP	4	1998-05-06 00:00:00	1998-06-03 00:00:00	\N	2	38.2799988	Bon app'	12 rue des Bouchers	Marseille	\N	13008	France
11077	RATTC	1	1998-05-06 00:00:00	1998-06-03 00:00:00	\N	2	8.52999973	Rattlesnake Canyon Grocery	2817 Milton Dr.	Albuquerque	NM	87110	USA
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (productid, productname, supplierid, categoryid, quantityperunit, unitprice, unitsinstock, unitsonorder, reorderlevel, discontinued) FROM stdin;
1	Chai	1	1	10 boxes x 20 bags	18	39	0	10	0
2	Chang	1	1	24 - 12 oz bottles	19	17	40	25	0
3	Aniseed Syrup	1	2	12 - 550 ml bottles	10	13	70	25	0
4	Chef Anton's Cajun Seasoning	2	2	48 - 6 oz jars	22	53	0	0	0
5	Chef Anton's Gumbo Mix	2	2	36 boxes	21.3500004	0	0	0	1
6	Grandma's Boysenberry Spread	3	2	12 - 8 oz jars	25	120	0	25	0
7	Uncle Bob's Organic Dried Pears	3	7	12 - 1 lb pkgs.	30	15	0	10	0
8	Northwoods Cranberry Sauce	3	2	12 - 12 oz jars	40	6	0	0	0
9	Mishi Kobe Niku	4	6	18 - 500 g pkgs.	97	29	0	0	1
10	Ikura	4	8	12 - 200 ml jars	31	31	0	0	0
11	Queso Cabrales	5	4	1 kg pkg.	21	22	30	30	0
12	Queso Manchego La Pastora	5	4	10 - 500 g pkgs.	38	86	0	0	0
13	Konbu	6	8	2 kg box	6	24	0	5	0
14	Tofu	6	7	40 - 100 g pkgs.	23.25	35	0	0	0
15	Genen Shouyu	6	2	24 - 250 ml bottles	15.5	39	0	5	0
16	Pavlova	7	3	32 - 500 g boxes	17.4500008	29	0	10	0
17	Alice Mutton	7	6	20 - 1 kg tins	39	0	0	0	1
18	Carnarvon Tigers	7	8	16 kg pkg.	62.5	42	0	0	0
19	Teatime Chocolate Biscuits	8	3	10 boxes x 12 pieces	9.19999981	25	0	5	0
20	Sir Rodney's Marmalade	8	3	30 gift boxes	81	40	0	0	0
21	Sir Rodney's Scones	8	3	24 pkgs. x 4 pieces	10	3	40	5	0
22	Gustaf's Knäckebröd	9	5	24 - 500 g pkgs.	21	104	0	25	0
23	Tunnbröd	9	5	12 - 250 g pkgs.	9	61	0	25	0
24	Guaraná Fantástica	10	1	12 - 355 ml cans	4.5	20	0	0	1
25	NuNuCa Nuß-Nougat-Creme	11	3	20 - 450 g glasses	14	76	0	30	0
26	Gumbär Gummibärchen	11	3	100 - 250 g bags	31.2299995	15	0	0	0
27	Schoggi Schokolade	11	3	100 - 100 g pieces	43.9000015	49	0	30	0
28	Rössle Sauerkraut	12	7	25 - 825 g cans	45.5999985	26	0	0	1
29	Thüringer Rostbratwurst	12	6	50 bags x 30 sausgs.	123.790001	0	0	0	1
30	Nord-Ost Matjeshering	13	8	10 - 200 g glasses	25.8899994	10	0	15	0
31	Gorgonzola Telino	14	4	12 - 100 g pkgs	12.5	0	70	20	0
32	Mascarpone Fabioli	14	4	24 - 200 g pkgs.	32	9	40	25	0
33	Geitost	15	4	500 g	2.5	112	0	20	0
34	Sasquatch Ale	16	1	24 - 12 oz bottles	14	111	0	15	0
35	Steeleye Stout	16	1	24 - 12 oz bottles	18	20	0	15	0
36	Inlagd Sill	17	8	24 - 250 g  jars	19	112	0	20	0
37	Gravad lax	17	8	12 - 500 g pkgs.	26	11	50	25	0
38	Côte de Blaye	18	1	12 - 75 cl bottles	263.5	17	0	15	0
39	Chartreuse verte	18	1	750 cc per bottle	18	69	0	5	0
40	Boston Crab Meat	19	8	24 - 4 oz tins	18.3999996	123	0	30	0
41	Jack's New England Clam Chowder	19	8	12 - 12 oz cans	9.64999962	85	0	10	0
42	Singaporean Hokkien Fried Mee	20	5	32 - 1 kg pkgs.	14	26	0	0	1
43	Ipoh Coffee	20	1	16 - 500 g tins	46	17	10	25	0
44	Gula Malacca	20	2	20 - 2 kg bags	19.4500008	27	0	15	0
45	Rogede sild	21	8	1k pkg.	9.5	5	70	15	0
46	Spegesild	21	8	4 - 450 g glasses	12	95	0	0	0
47	Zaanse koeken	22	3	10 - 4 oz boxes	9.5	36	0	0	0
48	Chocolade	22	3	10 pkgs.	12.75	15	70	25	0
49	Maxilaku	23	3	24 - 50 g pkgs.	20	10	60	15	0
50	Valkoinen suklaa	23	3	12 - 100 g bars	16.25	65	0	30	0
51	Manjimup Dried Apples	24	7	50 - 300 g pkgs.	53	20	0	10	0
52	Filo Mix	24	5	16 - 2 kg boxes	7	38	0	25	0
53	Perth Pasties	24	6	48 pieces	32.7999992	0	0	0	1
54	Tourtière	25	6	16 pies	7.44999981	21	0	10	0
55	Pâté chinois	25	6	24 boxes x 2 pies	24	115	0	20	0
56	Gnocchi di nonna Alice	26	5	24 - 250 g pkgs.	38	21	10	30	0
57	Ravioli Angelo	26	5	24 - 250 g pkgs.	19.5	36	0	20	0
58	Escargots de Bourgogne	27	8	24 pieces	13.25	62	0	20	0
59	Raclette Courdavault	28	4	5 kg pkg.	55	79	0	0	0
60	Camembert Pierrot	28	4	15 - 300 g rounds	34	19	0	0	0
61	Sirop d'érable	29	2	24 - 500 ml bottles	28.5	113	0	25	0
62	Tarte au sucre	29	3	48 pies	49.2999992	17	0	0	0
63	Vegie-spread	7	2	15 - 625 g jars	43.9000015	24	0	5	0
64	Wimmers gute Semmelknödel	12	5	20 bags x 4 pieces	33.25	22	80	30	0
65	Louisiana Fiery Hot Pepper Sauce	2	2	32 - 8 oz bottles	21.0499992	76	0	0	0
66	Louisiana Hot Spiced Okra	2	2	24 - 8 oz jars	17	4	100	20	0
67	Laughing Lumberjack Lager	16	1	24 - 12 oz bottles	14	52	0	10	0
68	Scottish Longbreads	8	3	10 boxes x 8 pieces	12.5	6	10	15	0
69	Gudbrandsdalsost	15	4	10 kg pkg.	36	26	0	15	0
70	Outback Lager	7	1	24 - 355 ml bottles	15	15	10	30	0
71	Flotemysost	15	4	10 - 500 g pkgs.	21.5	26	0	0	0
72	Mozzarella di Giovanni	14	4	24 - 200 g pkgs.	34.7999992	14	0	0	0
73	Röd Kaviar	17	8	24 - 150 g jars	15	101	0	5	0
74	Longlife Tofu	4	7	5 kg pkg.	10	4	20	5	0
75	Rhönbräu Klosterbier	12	1	24 - 0.5 l bottles	7.75	125	0	25	0
76	Lakkalikööri	23	1	500 ml	18	57	0	20	0
77	Original Frankfurter grüne Soße	12	2	12 boxes	13	32	0	15	0
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (regionid, regiondescription) FROM stdin;
1	Eastern
2	Western
3	Northern
4	Southern
\.


--
-- Data for Name: shippers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shippers (shipperid, companyname, phone) FROM stdin;
1	Speedy Express	(503) 555-9831
2	United Package	(503) 555-3199
3	Federal Shipping	(503) 555-9931
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax, homepage) FROM stdin;
1	Exotic Liquids	Charlotte Cooper	Purchasing Manager	49 Gilbert St.	London	NULL	EC1 4SD	UK	(171) 555-2222	NULL	NULL
2	New Orleans Cajun Delights	Shelley Burke	Order Administrator	P.O. Box 78934	New Orleans	LA	70117	USA	(100) 555-4822	NULL	#CAJUN.HTM#
3	Grandma Kelly's Homestead	Regina Murphy	Sales Representative	707 Oxford Rd.	Ann Arbor	MI	48104	USA	(313) 555-5735	(313) 555-3349	NULL
4	Tokyo Traders	Yoshi Nagase	Marketing Manager	9-8 Sekimai Musashino-shi	Tokyo	NULL	100	Japan	(03) 3555-5011	NULL	NULL
5	Cooperativa de Quesos 'Las Cabras'	Antonio del Valle Saavedra	Export Administrator	Calle del Rosal 4	Oviedo	Asturias	33007	Spain	(98) 598 76 54	NULL	NULL
6	Mayumi's	Mayumi Ohno	Marketing Representative	92 Setsuko Chuo-ku	Osaka	NULL	545	Japan	(06) 431-7877	NULL	Mayumi's (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#
7	Pavlova Ltd.	Ian Devling	Marketing Manager	74 Rose St. Moonie Ponds	Melbourne	Victoria	3058	Australia	(03) 444-2343	(03) 444-6588	NULL
8	Specialty Biscuits Ltd.	Peter Wilson	Sales Representative	29 King's Way	Manchester	NULL	M14 GSD	UK	(161) 555-4448	NULL	NULL
9	PB Knäckebröd AB	Lars Peterson	Sales Agent	Kaloadagatan 13	Göteborg	NULL	S-345 67	Sweden	031-987 65 43	031-987 65 91	NULL
10	Refrescos Americanas LTDA	Carlos Diaz	Marketing Manager	Av. das Americanas 12.890	Sao Paulo	NULL	5442	Brazil	(11) 555 4640	NULL	NULL
11	Heli Süßwaren GmbH & Co. KG	Petra Winkler	Sales Manager	Tiergartenstraße 5	Berlin	NULL	10785	Germany	(010) 9984510	NULL	NULL
12	Plutzer Lebensmittelgroßmärkte AG	Martin Bein	International Marketing Mgr.	Bogenallee 51	Frankfurt	NULL	60439	Germany	(069) 992755	NULL	Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#
13	Nord-Ost-Fisch Handelsgesellschaft mbH	Sven Petersen	Coordinator Foreign Markets	Frahmredder 112a	Cuxhaven	NULL	27478	Germany	(04721) 8713	(04721) 8714	NULL
14	Formaggi Fortini s.r.l.	Elio Rossi	Sales Representative	Viale Dante 75	Ravenna	NULL	48100	Italy	(0544) 60323	(0544) 60603	#FORMAGGI.HTM#
15	Norske Meierier	Beate Vileid	Marketing Manager	Hatlevegen 5	Sandvika	NULL	1320	Norway	(0)2-953010	NULL	NULL
16	Bigfoot Breweries	Cheryl Saylor	Regional Account Rep.	3400 - 8th Avenue Suite 210	Bend	OR	97101	USA	(503) 555-9931	NULL	NULL
17	Svensk Sjöföda AB	Michael Björn	Sales Representative	Brovallavägen 231	Stockholm	NULL	S-123 45	Sweden	08-123 45 67	NULL	NULL
18	Aux joyeux ecclésiastiques	Guylène Nodier	Sales Manager	203 Rue des Francs-Bourgeois	Paris	NULL	75004	France	(1) 03.83.00.68	(1) 03.83.00.62	NULL
19	New England Seafood Cannery	Robb Merchant	Wholesale Account Agent	Order Processing Dept. 2100 Paul Revere Blvd.	Boston	MA	02134	USA	(617) 555-3267	(617) 555-3389	NULL
20	Leka Trading	Chandra Leka	Owner	471 Serangoon Loop Suite #402	Singapore	NULL	0512	Singapore	555-8787	NULL	NULL
21	Lyngbysild	Niels Petersen	Sales Manager	Lyngbysild Fiskebakken 10	Lyngby	NULL	2800	Denmark	43844108	43844115	NULL
22	Zaanse Snoepfabriek	Dirk Luchte	Accounting Manager	Verkoop Rijnweg 22	Zaandam	NULL	9999 ZZ	Netherlands	(12345) 1212	(12345) 1210	NULL
23	Karkki Oy	Anne Heikkonen	Product Manager	Valtakatu 12	Lappeenranta	NULL	53120	Finland	(953) 10956	NULL	NULL
24	G'day Mate	Wendy Mackenzie	Sales Representative	170 Prince Edward Parade Hunter's Hill	Sydney	NSW	2042	Australia	(02) 555-5914	(02) 555-4873	G'day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#
25	Ma Maison	Jean-Guy Lauzon	Marketing Manager	2960 Rue St. Laurent	Montréal	Québec	H1J 1C3	Canada	(514) 555-9022	NULL	NULL
26	Pasta Buttini s.r.l.	Giovanni Giudici	Order Administrator	Via dei Gelsomini 153	Salerno	NULL	84100	Italy	(089) 6547665	(089) 6547667	NULL
27	Escargots Nouveaux	Marie Delamare	Sales Manager	22 rue H. Voiron	Montceau	NULL	71300	France	85.57.00.07	NULL	NULL
28	Gai pâturage	Eliane Noz	Sales Representative	Bat. B 3 rue des Alpes	Annecy	NULL	74000	France	38.76.98.06	38.76.98.58	NULL
29	Forêts d'érables	Chantal Goulet	Accounting Manager	148 rue Chasseur	Ste-Hyacinthe	Québec	J2S 7S8	Canada	(514) 555-2955	(514) 555-2921	NULL
\.


--
-- Data for Name: territories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.territories (territoryid, territorydescription, regionid) FROM stdin;
01581	Westboro	1
01730	Bedford	1
01833	Georgetow	1
02116	Boston	1
02139	Cambridge	1
02184	Braintree	1
02903	Providence	1
03049	Hollis	3
03801	Portsmouth	3
06897	Wilton	1
07960	Morristown	1
08837	Edison	1
10019	NewYork	1
10038	NewYork	1
11747	Mellvile	1
14450	Fairport	1
19428	Philadelphia	3
19713	Neward	1
20852	Rockville	1
27403	Greensboro	1
27511	Cary	1
29202	Columbia	4
30346	Atlanta	4
31406	Savannah	4
32859	Orlando	4
33607	Tampa	4
40222	Louisville	1
44122	Beachwood	3
45839	Findlay	3
48075	Southfield	3
48084	Troy	3
48304	BloomfieldHills	3
53404	Racine	3
55113	Roseville	3
55439	Minneapolis	3
60179	HoffmanEstates	2
60601	Chicago	2
72716	Bentonville	4
75234	Dallas	4
78759	Austin	4
80202	Denver	2
80909	ColoradoSprings	2
85014	Phoenix	2
85251	Scottsdale	2
90405	SantaMonica	2
94025	MenloPark	2
94105	SanFrancisco	2
95008	Campbell	2
95054	SantaClara	2
95060	SantaCruz	2
98004	Bellevue	2
98052	Redmond	2
98104	Seattle	2
\.


--
-- Name: categories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_categoryid_seq', 1, false);


--
-- Name: employees_employeeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employeeid_seq', 1, false);


--
-- Name: order_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_details_id_seq', 2155, true);


--
-- Name: products_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_productid_seq', 1, false);


--
-- Name: regions_regionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regions_regionid_seq', 1, false);


--
-- Name: shippers_shipperid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shippers_shipperid_seq', 1, false);


--
-- Name: suppliers_supplierid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_supplierid_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categoryid);


--
-- Name: customers customers_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_id_key UNIQUE (id);


--
-- Name: employee_territories employee_territories_territoryid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_territories
    ADD CONSTRAINT employee_territories_territoryid_key UNIQUE (territoryid);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employeeid);


--
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (id);


--
-- Name: orders orders_orderid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_orderid_key UNIQUE (orderid);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (regionid);


--
-- Name: shippers shippers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shippers
    ADD CONSTRAINT shippers_pkey PRIMARY KEY (shipperid);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplierid);


--
-- Name: territories territories_territoryid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_territoryid_key UNIQUE (territoryid);


--
-- PostgreSQL database dump complete
--

