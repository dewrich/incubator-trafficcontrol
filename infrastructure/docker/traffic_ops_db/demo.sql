--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.8
-- Dumped by pg_dump version 9.6.4

-- Started on 2018-03-26 10:27:53 MDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12393)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2876 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 633 (class 1247 OID 17509)
-- Name: change_types; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE change_types AS ENUM (
    'create',
    'update',
    'delete'
);


--
-- TOC entry 636 (class 1247 OID 17516)
-- Name: deep_caching_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE deep_caching_type AS ENUM (
    'NEVER',
    'ALWAYS'
);


--
-- TOC entry 639 (class 1247 OID 17521)
-- Name: deliveryservice_signature_type; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN deliveryservice_signature_type AS text
	CONSTRAINT deliveryservice_signature_type_check CHECK ((VALUE = ANY (ARRAY['url_sig'::text, 'uri_signing'::text])));


--
-- TOC entry 641 (class 1247 OID 17524)
-- Name: http_method_t; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE http_method_t AS ENUM (
    'GET',
    'POST',
    'PUT',
    'PATCH',
    'DELETE'
);


--
-- TOC entry 644 (class 1247 OID 17536)
-- Name: profile_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE profile_type AS ENUM (
    'ATS_PROFILE',
    'TR_PROFILE',
    'TM_PROFILE',
    'TS_PROFILE',
    'TP_PROFILE',
    'INFLUXDB_PROFILE',
    'RIAK_PROFILE',
    'SPLUNK_PROFILE',
    'DS_PROFILE',
    'ORG_PROFILE',
    'KAFKA_PROFILE',
    'LOGSTASH_PROFILE',
    'ES_PROFILE',
    'UNK_PROFILE'
);


--
-- TOC entry 647 (class 1247 OID 17566)
-- Name: workflow_states; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE workflow_states AS ENUM (
    'draft',
    'submitted',
    'rejected',
    'pending',
    'complete'
);


--
-- TOC entry 261 (class 1255 OID 17577)
-- Name: on_update_current_timestamp_last_updated(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION on_update_current_timestamp_last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.last_updated = now();
  RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 17578)
-- Name: api_capability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_capability (
    id bigint NOT NULL,
    http_method http_method_t NOT NULL,
    route text NOT NULL,
    capability text NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 186 (class 1259 OID 17585)
-- Name: api_capability_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_capability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2877 (class 0 OID 0)
-- Dependencies: 186
-- Name: api_capability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_capability_id_seq OWNED BY api_capability.id;


--
-- TOC entry 187 (class 1259 OID 17587)
-- Name: asn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE asn (
    id bigint NOT NULL,
    asn bigint NOT NULL,
    cachegroup bigint DEFAULT '0'::bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 188 (class 1259 OID 17592)
-- Name: asn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE asn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 188
-- Name: asn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE asn_id_seq OWNED BY asn.id;


--
-- TOC entry 189 (class 1259 OID 17594)
-- Name: cachegroup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cachegroup (
    id bigint NOT NULL,
    name text NOT NULL,
    short_name text NOT NULL,
    latitude numeric,
    longitude numeric,
    parent_cachegroup_id bigint,
    secondary_parent_cachegroup_id bigint,
    type bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 190 (class 1259 OID 17601)
-- Name: cachegroup_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cachegroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2879 (class 0 OID 0)
-- Dependencies: 190
-- Name: cachegroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cachegroup_id_seq OWNED BY cachegroup.id;


--
-- TOC entry 191 (class 1259 OID 17603)
-- Name: cachegroup_parameter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cachegroup_parameter (
    cachegroup bigint DEFAULT '0'::bigint NOT NULL,
    parameter bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 192 (class 1259 OID 17608)
-- Name: capability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE capability (
    name text NOT NULL,
    description text,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 193 (class 1259 OID 17615)
-- Name: cdn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cdn (
    id bigint NOT NULL,
    name text NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL,
    dnssec_enabled boolean DEFAULT false NOT NULL,
    domain_name text NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 17623)
-- Name: cdn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cdn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 194
-- Name: cdn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cdn_id_seq OWNED BY cdn.id;


--
-- TOC entry 195 (class 1259 OID 17625)
-- Name: deliveryservice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveryservice (
    id bigint NOT NULL,
    xml_id text NOT NULL,
    active boolean DEFAULT false NOT NULL,
    dscp bigint NOT NULL,
    signing_algorithm deliveryservice_signature_type,
    qstring_ignore smallint,
    geo_limit smallint DEFAULT '0'::smallint,
    http_bypass_fqdn text,
    dns_bypass_ip text,
    dns_bypass_ip6 text,
    dns_bypass_ttl bigint,
    org_server_fqdn text,
    type bigint NOT NULL,
    profile bigint,
    cdn_id bigint NOT NULL,
    ccr_dns_ttl bigint,
    global_max_mbps bigint,
    global_max_tps bigint,
    long_desc text,
    long_desc_1 text,
    long_desc_2 text,
    max_dns_answers bigint DEFAULT '5'::bigint,
    info_url text,
    miss_lat numeric,
    miss_long numeric,
    check_path text,
    last_updated timestamp with time zone DEFAULT now(),
    protocol smallint DEFAULT '0'::smallint,
    ssl_key_version bigint DEFAULT '0'::bigint,
    ipv6_routing_enabled boolean DEFAULT false,
    range_request_handling smallint DEFAULT '0'::smallint,
    edge_header_rewrite text,
    origin_shield text,
    mid_header_rewrite text,
    regex_remap text,
    cacheurl text,
    remap_text text,
    multi_site_origin boolean DEFAULT false,
    display_name text NOT NULL,
    tr_response_headers text,
    initial_dispersion bigint DEFAULT '1'::bigint,
    dns_bypass_cname text,
    tr_request_headers text,
    regional_geo_blocking boolean DEFAULT false NOT NULL,
    geo_provider smallint DEFAULT '0'::smallint,
    geo_limit_countries text,
    logs_enabled boolean DEFAULT false,
    multi_site_origin_algorithm smallint,
    geolimit_redirect_url text,
    tenant_id bigint,
    routing_name text,
    deep_caching_type deep_caching_type DEFAULT 'NEVER'::deep_caching_type,
    fq_pacing_rate bigint DEFAULT 0
);


--
-- TOC entry 196 (class 1259 OID 17646)
-- Name: deliveryservice_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveryservice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2881 (class 0 OID 0)
-- Dependencies: 196
-- Name: deliveryservice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveryservice_id_seq OWNED BY deliveryservice.id;


--
-- TOC entry 197 (class 1259 OID 17648)
-- Name: deliveryservice_regex; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveryservice_regex (
    deliveryservice bigint NOT NULL,
    regex bigint NOT NULL,
    set_number bigint DEFAULT '0'::bigint
);


--
-- TOC entry 198 (class 1259 OID 17652)
-- Name: deliveryservice_request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveryservice_request (
    assignee_id bigint,
    author_id bigint NOT NULL,
    change_type change_types NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id bigint NOT NULL,
    last_edited_by_id bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL,
    deliveryservice jsonb NOT NULL,
    status workflow_states NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 17660)
-- Name: deliveryservice_request_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveryservice_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 199
-- Name: deliveryservice_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveryservice_request_id_seq OWNED BY deliveryservice_request.id;


--
-- TOC entry 200 (class 1259 OID 17662)
-- Name: deliveryservice_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveryservice_server (
    deliveryservice bigint NOT NULL,
    server bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 201 (class 1259 OID 17666)
-- Name: deliveryservice_tmuser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveryservice_tmuser (
    deliveryservice bigint NOT NULL,
    tm_user_id bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 202 (class 1259 OID 17670)
-- Name: division; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE division (
    id bigint NOT NULL,
    name text NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 203 (class 1259 OID 17677)
-- Name: division_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE division_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 203
-- Name: division_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE division_id_seq OWNED BY division.id;


--
-- TOC entry 204 (class 1259 OID 17679)
-- Name: federation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federation (
    id bigint NOT NULL,
    cname text NOT NULL,
    description text,
    ttl integer NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 205 (class 1259 OID 17686)
-- Name: federation_deliveryservice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federation_deliveryservice (
    federation bigint NOT NULL,
    deliveryservice bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 206 (class 1259 OID 17690)
-- Name: federation_federation_resolver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federation_federation_resolver (
    federation bigint NOT NULL,
    federation_resolver bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 207 (class 1259 OID 17694)
-- Name: federation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE federation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 207
-- Name: federation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE federation_id_seq OWNED BY federation.id;


--
-- TOC entry 208 (class 1259 OID 17696)
-- Name: federation_resolver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federation_resolver (
    id bigint NOT NULL,
    ip_address text NOT NULL,
    type bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 209 (class 1259 OID 17703)
-- Name: federation_resolver_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE federation_resolver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 209
-- Name: federation_resolver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE federation_resolver_id_seq OWNED BY federation_resolver.id;


--
-- TOC entry 210 (class 1259 OID 17705)
-- Name: federation_tmuser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federation_tmuser (
    federation bigint NOT NULL,
    tm_user bigint NOT NULL,
    role bigint,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 211 (class 1259 OID 17709)
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


--
-- TOC entry 212 (class 1259 OID 17713)
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goose_db_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2886 (class 0 OID 0)
-- Dependencies: 212
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goose_db_version_id_seq OWNED BY goose_db_version.id;


--
-- TOC entry 213 (class 1259 OID 17715)
-- Name: hwinfo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hwinfo (
    id bigint NOT NULL,
    serverid bigint NOT NULL,
    description text NOT NULL,
    val text NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 214 (class 1259 OID 17722)
-- Name: hwinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hwinfo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2887 (class 0 OID 0)
-- Dependencies: 214
-- Name: hwinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hwinfo_id_seq OWNED BY hwinfo.id;


--
-- TOC entry 215 (class 1259 OID 17724)
-- Name: job; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job (
    id bigint NOT NULL,
    agent bigint,
    object_type text,
    object_name text,
    keyword text NOT NULL,
    parameters text,
    asset_url text NOT NULL,
    asset_type text NOT NULL,
    status bigint NOT NULL,
    start_time timestamp with time zone NOT NULL,
    entered_time timestamp with time zone NOT NULL,
    job_user bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now(),
    job_deliveryservice bigint
);


--
-- TOC entry 216 (class 1259 OID 17731)
-- Name: job_agent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job_agent (
    id bigint NOT NULL,
    name text,
    description text,
    active integer DEFAULT 0 NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 217 (class 1259 OID 17739)
-- Name: job_agent_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 217
-- Name: job_agent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_agent_id_seq OWNED BY job_agent.id;


--
-- TOC entry 218 (class 1259 OID 17741)
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 218
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_id_seq OWNED BY job.id;


--
-- TOC entry 219 (class 1259 OID 17743)
-- Name: job_result; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job_result (
    id bigint NOT NULL,
    job bigint NOT NULL,
    agent bigint NOT NULL,
    result text NOT NULL,
    description text,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 220 (class 1259 OID 17750)
-- Name: job_result_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 220
-- Name: job_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_result_id_seq OWNED BY job_result.id;


--
-- TOC entry 221 (class 1259 OID 17752)
-- Name: job_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE job_status (
    id bigint NOT NULL,
    name text,
    description text,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 222 (class 1259 OID 17759)
-- Name: job_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 222
-- Name: job_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_status_id_seq OWNED BY job_status.id;


--
-- TOC entry 223 (class 1259 OID 17761)
-- Name: log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE log (
    id bigint NOT NULL,
    level text,
    message text NOT NULL,
    tm_user bigint NOT NULL,
    ticketnum text,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 224 (class 1259 OID 17768)
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE log_id_seq OWNED BY log.id;


--
-- TOC entry 225 (class 1259 OID 17770)
-- Name: parameter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE parameter (
    id bigint NOT NULL,
    name text NOT NULL,
    config_file text,
    value text NOT NULL,
    last_updated timestamp with time zone DEFAULT now(),
    secure boolean DEFAULT false NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 17778)
-- Name: parameter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 226
-- Name: parameter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parameter_id_seq OWNED BY parameter.id;


--
-- TOC entry 227 (class 1259 OID 17780)
-- Name: phys_location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE phys_location (
    id bigint NOT NULL,
    name text NOT NULL,
    short_name text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    zip text NOT NULL,
    poc text,
    phone text,
    email text,
    comments text,
    region bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 228 (class 1259 OID 17787)
-- Name: phys_location_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phys_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 228
-- Name: phys_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phys_location_id_seq OWNED BY phys_location.id;


--
-- TOC entry 229 (class 1259 OID 17789)
-- Name: profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE profile (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    last_updated timestamp with time zone DEFAULT now(),
    type profile_type NOT NULL,
    cdn bigint,
    routing_disabled boolean DEFAULT false NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 17797)
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 230
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profile_id_seq OWNED BY profile.id;


--
-- TOC entry 231 (class 1259 OID 17799)
-- Name: profile_parameter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE profile_parameter (
    profile bigint NOT NULL,
    parameter bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 232 (class 1259 OID 17803)
-- Name: profile_type_values; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW profile_type_values AS
 SELECT unnest(enum_range(NULL::profile_type)) AS value
  ORDER BY (unnest(enum_range(NULL::profile_type)));


--
-- TOC entry 233 (class 1259 OID 17807)
-- Name: regex; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE regex (
    id bigint NOT NULL,
    pattern text DEFAULT ''::text NOT NULL,
    type bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 234 (class 1259 OID 17815)
-- Name: regex_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 234
-- Name: regex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regex_id_seq OWNED BY regex.id;


--
-- TOC entry 235 (class 1259 OID 17817)
-- Name: region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE region (
    id bigint NOT NULL,
    name text NOT NULL,
    division bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 236 (class 1259 OID 17824)
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2897 (class 0 OID 0)
-- Dependencies: 236
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE region_id_seq OWNED BY region.id;


--
-- TOC entry 237 (class 1259 OID 17826)
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE role (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    priv_level bigint NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 17832)
-- Name: role_capability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE role_capability (
    role_id bigint NOT NULL,
    cap_name text NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 239 (class 1259 OID 17839)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2898 (class 0 OID 0)
-- Dependencies: 239
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- TOC entry 240 (class 1259 OID 17841)
-- Name: server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE server (
    id bigint NOT NULL,
    host_name text NOT NULL,
    domain_name text NOT NULL,
    tcp_port bigint,
    xmpp_id text,
    xmpp_passwd text,
    interface_name text NOT NULL,
    ip_address text NOT NULL,
    ip_netmask text NOT NULL,
    ip_gateway text NOT NULL,
    ip6_address text,
    ip6_gateway text,
    interface_mtu bigint DEFAULT '9000'::bigint NOT NULL,
    phys_location bigint NOT NULL,
    rack text,
    cachegroup bigint DEFAULT '0'::bigint NOT NULL,
    type bigint NOT NULL,
    status bigint NOT NULL,
    offline_reason text,
    upd_pending boolean DEFAULT false NOT NULL,
    profile bigint NOT NULL,
    cdn_id bigint NOT NULL,
    mgmt_ip_address text,
    mgmt_ip_netmask text,
    mgmt_ip_gateway text,
    ilo_ip_address text,
    ilo_ip_netmask text,
    ilo_ip_gateway text,
    ilo_username text,
    ilo_password text,
    router_host_name text,
    router_port_name text,
    guid text,
    last_updated timestamp with time zone DEFAULT now(),
    https_port bigint,
    reval_pending boolean DEFAULT false NOT NULL
);


--
-- TOC entry 241 (class 1259 OID 17852)
-- Name: server_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE server_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2899 (class 0 OID 0)
-- Dependencies: 241
-- Name: server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE server_id_seq OWNED BY server.id;


--
-- TOC entry 242 (class 1259 OID 17854)
-- Name: servercheck; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE servercheck (
    id bigint NOT NULL,
    server bigint NOT NULL,
    aa bigint,
    ab bigint,
    ac bigint,
    ad bigint,
    ae bigint,
    af bigint,
    ag bigint,
    ah bigint,
    ai bigint,
    aj bigint,
    ak bigint,
    al bigint,
    am bigint,
    an bigint,
    ao bigint,
    ap bigint,
    aq bigint,
    ar bigint,
    bf bigint,
    at bigint,
    au bigint,
    av bigint,
    aw bigint,
    ax bigint,
    ay bigint,
    az bigint,
    ba bigint,
    bb bigint,
    bc bigint,
    bd bigint,
    be bigint,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 243 (class 1259 OID 17858)
-- Name: servercheck_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE servercheck_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2900 (class 0 OID 0)
-- Dependencies: 243
-- Name: servercheck_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE servercheck_id_seq OWNED BY servercheck.id;


--
-- TOC entry 244 (class 1259 OID 17860)
-- Name: snapshot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE snapshot (
    cdn text NOT NULL,
    content json NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 245 (class 1259 OID 17867)
-- Name: staticdnsentry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE staticdnsentry (
    id bigint NOT NULL,
    host text NOT NULL,
    address text NOT NULL,
    type bigint NOT NULL,
    ttl bigint DEFAULT '3600'::bigint NOT NULL,
    deliveryservice bigint NOT NULL,
    cachegroup bigint,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 246 (class 1259 OID 17875)
-- Name: staticdnsentry_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE staticdnsentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2901 (class 0 OID 0)
-- Dependencies: 246
-- Name: staticdnsentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE staticdnsentry_id_seq OWNED BY staticdnsentry.id;


--
-- TOC entry 247 (class 1259 OID 17877)
-- Name: stats_summary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stats_summary (
    id bigint NOT NULL,
    cdn_name text DEFAULT 'all'::text NOT NULL,
    deliveryservice_name text NOT NULL,
    stat_name text NOT NULL,
    stat_value double precision NOT NULL,
    summary_time timestamp with time zone DEFAULT now() NOT NULL,
    stat_date date
);


--
-- TOC entry 248 (class 1259 OID 17885)
-- Name: stats_summary_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stats_summary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2902 (class 0 OID 0)
-- Dependencies: 248
-- Name: stats_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stats_summary_id_seq OWNED BY stats_summary.id;


--
-- TOC entry 249 (class 1259 OID 17887)
-- Name: status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE status (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 250 (class 1259 OID 17894)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2903 (class 0 OID 0)
-- Dependencies: 250
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- TOC entry 251 (class 1259 OID 17896)
-- Name: steering_target; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE steering_target (
    deliveryservice bigint NOT NULL,
    target bigint NOT NULL,
    value bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now(),
    type bigint
);


--
-- TOC entry 252 (class 1259 OID 17900)
-- Name: tenant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tenant (
    id bigint NOT NULL,
    name text NOT NULL,
    active boolean DEFAULT false NOT NULL,
    parent_id bigint DEFAULT 1,
    last_updated timestamp with time zone DEFAULT now(),
    CONSTRAINT tenant_check CHECK ((id <> parent_id))
);


--
-- TOC entry 253 (class 1259 OID 17910)
-- Name: tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tenant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2904 (class 0 OID 0)
-- Dependencies: 253
-- Name: tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tenant_id_seq OWNED BY tenant.id;


--
-- TOC entry 254 (class 1259 OID 17912)
-- Name: tm_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tm_user (
    id bigint NOT NULL,
    username text,
    public_ssh_key text,
    role bigint,
    uid bigint,
    gid bigint,
    local_passwd text,
    confirm_local_passwd text,
    last_updated timestamp with time zone DEFAULT now(),
    company text,
    email text,
    full_name text,
    new_user boolean DEFAULT false NOT NULL,
    address_line1 text,
    address_line2 text,
    city text,
    state_or_province text,
    phone_number text,
    postal_code text,
    country text,
    token text,
    registration_sent timestamp with time zone,
    tenant_id bigint
);


--
-- TOC entry 255 (class 1259 OID 17920)
-- Name: tm_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tm_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2905 (class 0 OID 0)
-- Dependencies: 255
-- Name: tm_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tm_user_id_seq OWNED BY tm_user.id;


--
-- TOC entry 256 (class 1259 OID 17922)
-- Name: to_extension; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE to_extension (
    id bigint NOT NULL,
    name text NOT NULL,
    version text NOT NULL,
    info_url text NOT NULL,
    script_file text NOT NULL,
    isactive boolean DEFAULT false NOT NULL,
    additional_config_json text,
    description text,
    servercheck_short_name text,
    servercheck_column_name text,
    type bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 17930)
-- Name: to_extension_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE to_extension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2906 (class 0 OID 0)
-- Dependencies: 257
-- Name: to_extension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE to_extension_id_seq OWNED BY to_extension.id;


--
-- TOC entry 258 (class 1259 OID 17932)
-- Name: type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE type (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    use_in_table text,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 259 (class 1259 OID 17939)
-- Name: type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2907 (class 0 OID 0)
-- Dependencies: 259
-- Name: type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE type_id_seq OWNED BY type.id;


--
-- TOC entry 260 (class 1259 OID 17941)
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    last_updated timestamp with time zone DEFAULT now()
);


--
-- TOC entry 2291 (class 2604 OID 17945)
-- Name: api_capability id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_capability ALTER COLUMN id SET DEFAULT nextval('api_capability_id_seq'::regclass);


--
-- TOC entry 2294 (class 2604 OID 17946)
-- Name: asn id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY asn ALTER COLUMN id SET DEFAULT nextval('asn_id_seq'::regclass);


--
-- TOC entry 2296 (class 2604 OID 17947)
-- Name: cachegroup id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup ALTER COLUMN id SET DEFAULT nextval('cachegroup_id_seq'::regclass);


--
-- TOC entry 2302 (class 2604 OID 17948)
-- Name: cdn id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cdn ALTER COLUMN id SET DEFAULT nextval('cdn_id_seq'::regclass);


--
-- TOC entry 2318 (class 2604 OID 17949)
-- Name: deliveryservice id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice ALTER COLUMN id SET DEFAULT nextval('deliveryservice_id_seq'::regclass);


--
-- TOC entry 2322 (class 2604 OID 17950)
-- Name: deliveryservice_request id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_request ALTER COLUMN id SET DEFAULT nextval('deliveryservice_request_id_seq'::regclass);


--
-- TOC entry 2326 (class 2604 OID 17951)
-- Name: division id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY division ALTER COLUMN id SET DEFAULT nextval('division_id_seq'::regclass);


--
-- TOC entry 2328 (class 2604 OID 17952)
-- Name: federation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation ALTER COLUMN id SET DEFAULT nextval('federation_id_seq'::regclass);


--
-- TOC entry 2332 (class 2604 OID 17953)
-- Name: federation_resolver id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_resolver ALTER COLUMN id SET DEFAULT nextval('federation_resolver_id_seq'::regclass);


--
-- TOC entry 2335 (class 2604 OID 17954)
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goose_db_version ALTER COLUMN id SET DEFAULT nextval('goose_db_version_id_seq'::regclass);


--
-- TOC entry 2337 (class 2604 OID 17955)
-- Name: hwinfo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hwinfo ALTER COLUMN id SET DEFAULT nextval('hwinfo_id_seq'::regclass);


--
-- TOC entry 2339 (class 2604 OID 17956)
-- Name: job id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job ALTER COLUMN id SET DEFAULT nextval('job_id_seq'::regclass);


--
-- TOC entry 2342 (class 2604 OID 17957)
-- Name: job_agent id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_agent ALTER COLUMN id SET DEFAULT nextval('job_agent_id_seq'::regclass);


--
-- TOC entry 2344 (class 2604 OID 17958)
-- Name: job_result id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_result ALTER COLUMN id SET DEFAULT nextval('job_result_id_seq'::regclass);


--
-- TOC entry 2346 (class 2604 OID 17959)
-- Name: job_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_status ALTER COLUMN id SET DEFAULT nextval('job_status_id_seq'::regclass);


--
-- TOC entry 2348 (class 2604 OID 17960)
-- Name: log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY log ALTER COLUMN id SET DEFAULT nextval('log_id_seq'::regclass);


--
-- TOC entry 2351 (class 2604 OID 17961)
-- Name: parameter id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY parameter ALTER COLUMN id SET DEFAULT nextval('parameter_id_seq'::regclass);


--
-- TOC entry 2353 (class 2604 OID 17962)
-- Name: phys_location id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phys_location ALTER COLUMN id SET DEFAULT nextval('phys_location_id_seq'::regclass);


--
-- TOC entry 2356 (class 2604 OID 17963)
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile ALTER COLUMN id SET DEFAULT nextval('profile_id_seq'::regclass);


--
-- TOC entry 2360 (class 2604 OID 17964)
-- Name: regex id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regex ALTER COLUMN id SET DEFAULT nextval('regex_id_seq'::regclass);


--
-- TOC entry 2362 (class 2604 OID 17965)
-- Name: region id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY region ALTER COLUMN id SET DEFAULT nextval('region_id_seq'::regclass);


--
-- TOC entry 2363 (class 2604 OID 17966)
-- Name: role id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- TOC entry 2370 (class 2604 OID 17967)
-- Name: server id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY server ALTER COLUMN id SET DEFAULT nextval('server_id_seq'::regclass);


--
-- TOC entry 2372 (class 2604 OID 17968)
-- Name: servercheck id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY servercheck ALTER COLUMN id SET DEFAULT nextval('servercheck_id_seq'::regclass);


--
-- TOC entry 2376 (class 2604 OID 17969)
-- Name: staticdnsentry id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY staticdnsentry ALTER COLUMN id SET DEFAULT nextval('staticdnsentry_id_seq'::regclass);


--
-- TOC entry 2379 (class 2604 OID 17970)
-- Name: stats_summary id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stats_summary ALTER COLUMN id SET DEFAULT nextval('stats_summary_id_seq'::regclass);


--
-- TOC entry 2381 (class 2604 OID 17971)
-- Name: status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- TOC entry 2386 (class 2604 OID 17972)
-- Name: tenant id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tenant ALTER COLUMN id SET DEFAULT nextval('tenant_id_seq'::regclass);


--
-- TOC entry 2390 (class 2604 OID 17973)
-- Name: tm_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tm_user ALTER COLUMN id SET DEFAULT nextval('tm_user_id_seq'::regclass);


--
-- TOC entry 2393 (class 2604 OID 17974)
-- Name: to_extension id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY to_extension ALTER COLUMN id SET DEFAULT nextval('to_extension_id_seq'::regclass);


--
-- TOC entry 2395 (class 2604 OID 17975)
-- Name: type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY type ALTER COLUMN id SET DEFAULT nextval('type_id_seq'::regclass);


--
-- TOC entry 2795 (class 0 OID 17578)
-- Dependencies: 185
-- Data for Name: api_capability; Type: TABLE DATA; Schema: public; Owner: -
--

COPY api_capability (id, http_method, route, capability, last_updated) FROM stdin;
\.


--
-- TOC entry 2908 (class 0 OID 0)
-- Dependencies: 186
-- Name: api_capability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('api_capability_id_seq', 1, false);


--
-- TOC entry 2797 (class 0 OID 17587)
-- Dependencies: 187
-- Data for Name: asn; Type: TABLE DATA; Schema: public; Owner: -
--

COPY asn (id, asn, cachegroup, last_updated) FROM stdin;
\.


--
-- TOC entry 2909 (class 0 OID 0)
-- Dependencies: 188
-- Name: asn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('asn_id_seq', 1, false);


--
-- TOC entry 2799 (class 0 OID 17594)
-- Dependencies: 189
-- Data for Name: cachegroup; Type: TABLE DATA; Schema: public; Owner: -
--

COPY cachegroup (id, name, short_name, latitude, longitude, parent_cachegroup_id, secondary_parent_cachegroup_id, type, last_updated) FROM stdin;
\.


--
-- TOC entry 2910 (class 0 OID 0)
-- Dependencies: 190
-- Name: cachegroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cachegroup_id_seq', 1, false);


--
-- TOC entry 2801 (class 0 OID 17603)
-- Dependencies: 191
-- Data for Name: cachegroup_parameter; Type: TABLE DATA; Schema: public; Owner: -
--

COPY cachegroup_parameter (cachegroup, parameter, last_updated) FROM stdin;
\.


--
-- TOC entry 2802 (class 0 OID 17608)
-- Dependencies: 192
-- Data for Name: capability; Type: TABLE DATA; Schema: public; Owner: -
--

COPY capability (name, description, last_updated) FROM stdin;
\.


--
-- TOC entry 2803 (class 0 OID 17615)
-- Dependencies: 193
-- Data for Name: cdn; Type: TABLE DATA; Schema: public; Owner: -
--

COPY cdn (id, name, last_updated, dnssec_enabled, domain_name) FROM stdin;
1	cdn1	2018-03-26 16:19:07.582844+00	t	test.cdn1.net
2	cdn2	2018-03-26 16:19:07.590313+00	f	test.cdn2.net
3	cdn3	2018-03-26 16:19:07.595554+00	t	test.cdn3.net
\.


--
-- TOC entry 2911 (class 0 OID 0)
-- Dependencies: 194
-- Name: cdn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cdn_id_seq', 3, true);


--
-- TOC entry 2805 (class 0 OID 17625)
-- Dependencies: 195
-- Data for Name: deliveryservice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY deliveryservice (id, xml_id, active, dscp, signing_algorithm, qstring_ignore, geo_limit, http_bypass_fqdn, dns_bypass_ip, dns_bypass_ip6, dns_bypass_ttl, org_server_fqdn, type, profile, cdn_id, ccr_dns_ttl, global_max_mbps, global_max_tps, long_desc, long_desc_1, long_desc_2, max_dns_answers, info_url, miss_lat, miss_long, check_path, last_updated, protocol, ssl_key_version, ipv6_routing_enabled, range_request_handling, edge_header_rewrite, origin_shield, mid_header_rewrite, regex_remap, cacheurl, remap_text, multi_site_origin, display_name, tr_response_headers, initial_dispersion, dns_bypass_cname, tr_request_headers, regional_geo_blocking, geo_provider, geo_limit_countries, logs_enabled, multi_site_origin_algorithm, geolimit_redirect_url, tenant_id, routing_name, deep_caching_type, fq_pacing_rate) FROM stdin;
\.


--
-- TOC entry 2912 (class 0 OID 0)
-- Dependencies: 196
-- Name: deliveryservice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('deliveryservice_id_seq', 1, false);


--
-- TOC entry 2807 (class 0 OID 17648)
-- Dependencies: 197
-- Data for Name: deliveryservice_regex; Type: TABLE DATA; Schema: public; Owner: -
--

COPY deliveryservice_regex (deliveryservice, regex, set_number) FROM stdin;
\.


--
-- TOC entry 2808 (class 0 OID 17652)
-- Dependencies: 198
-- Data for Name: deliveryservice_request; Type: TABLE DATA; Schema: public; Owner: -
--

COPY deliveryservice_request (assignee_id, author_id, change_type, created_at, id, last_edited_by_id, last_updated, deliveryservice, status) FROM stdin;
\N	10	create	2018-03-26 16:19:07.614076+00	1	10	2018-03-26 16:19:07.614076+00	{"id": 0, "dscp": 1, "cdnId": 1, "xmlId": "test-ds1", "active": true, "typeId": 70, "cdnName": "", "infoUrl": "", "missLat": 0, "cacheurl": "", "geoLimit": 1, "longDesc": "long desc", "missLong": 0, "protocol": 0, "tenantId": 2, "typeName": null, "ccrDnsTtl": 30, "checkPath": "", "longDesc1": "", "longDesc2": "", "matchList": null, "profileId": null, "remapText": "", "regexRemap": "", "displayName": "Good Kabletown CDN", "dnsBypassIp": "", "geoProvider": 1, "lastUpdated": null, "logsEnabled": true, "profileName": "", "routingName": "goodroute", "dnsBypassIp6": "", "dnsBypassTtl": 0, "globalMaxTps": 0, "originShield": null, "globalMaxMbps": 0, "maxDnsAnswers": 0, "orgServerFqdn": "", "qstringIgnore": 0, "sslKeyVersion": null, "dnsBypassCname": "", "httpBypassFqdn": "", "deepCachingType": "NEVER", "multiSiteOrigin": false, "midHeaderRewrite": "", "signingAlgorithm": "", "trRequestHeaders": null, "edgeHeaderRewrite": "", "geoLimitCountries": null, "initialDispersion": 1, "trResponseHeaders": "", "ipv6RoutingEnabled": false, "profileDescription": "", "geoLimitRedirectURL": null, "regionalGeoBlocking": true, "rangeRequestHandling": 0, "multiSiteOriginAlgorithm": null}	draft
\N	10	update	2018-03-26 16:19:08.282701+00	2	10	2018-03-26 16:19:08.298682+00	{"id": 0, "dscp": 3, "cdnId": 1, "xmlId": "test-transitions", "active": false, "typeId": 70, "cdnName": "", "infoUrl": "", "missLat": 0, "cacheurl": "", "geoLimit": 1, "longDesc": "long desc", "missLong": 0, "protocol": 0, "tenantId": 2, "typeName": null, "ccrDnsTtl": 30, "checkPath": "", "longDesc1": "", "longDesc2": "", "matchList": null, "profileId": null, "remapText": "", "regexRemap": "", "displayName": "Testing transitions", "dnsBypassIp": "", "geoProvider": 1, "lastUpdated": null, "logsEnabled": true, "profileName": "", "routingName": "goodroute", "dnsBypassIp6": "", "dnsBypassTtl": 0, "globalMaxTps": 0, "originShield": null, "globalMaxMbps": 0, "maxDnsAnswers": 0, "orgServerFqdn": "", "qstringIgnore": 0, "sslKeyVersion": null, "dnsBypassCname": "", "httpBypassFqdn": "", "deepCachingType": "ALWAYS", "multiSiteOrigin": false, "midHeaderRewrite": "", "signingAlgorithm": "", "trRequestHeaders": null, "edgeHeaderRewrite": "", "geoLimitCountries": null, "initialDispersion": 1, "trResponseHeaders": "", "ipv6RoutingEnabled": false, "profileDescription": "", "geoLimitRedirectURL": null, "regionalGeoBlocking": true, "rangeRequestHandling": 0, "multiSiteOriginAlgorithm": null}	submitted
\.


--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 199
-- Name: deliveryservice_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('deliveryservice_request_id_seq', 2, true);


--
-- TOC entry 2810 (class 0 OID 17662)
-- Dependencies: 200
-- Data for Name: deliveryservice_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY deliveryservice_server (deliveryservice, server, last_updated) FROM stdin;
\.


--
-- TOC entry 2811 (class 0 OID 17666)
-- Dependencies: 201
-- Data for Name: deliveryservice_tmuser; Type: TABLE DATA; Schema: public; Owner: -
--

COPY deliveryservice_tmuser (deliveryservice, tm_user_id, last_updated) FROM stdin;
\.


--
-- TOC entry 2812 (class 0 OID 17670)
-- Dependencies: 202
-- Data for Name: division; Type: TABLE DATA; Schema: public; Owner: -
--

COPY division (id, name, last_updated) FROM stdin;
100	mountain	2018-01-19 19:01:21.851102+00
1	division1	2018-03-26 16:19:08.309001+00
2	division2	2018-03-26 16:19:08.313714+00
\.


--
-- TOC entry 2914 (class 0 OID 0)
-- Dependencies: 203
-- Name: division_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('division_id_seq', 2, true);


--
-- TOC entry 2814 (class 0 OID 17679)
-- Dependencies: 204
-- Data for Name: federation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federation (id, cname, description, ttl, last_updated) FROM stdin;
\.


--
-- TOC entry 2815 (class 0 OID 17686)
-- Dependencies: 205
-- Data for Name: federation_deliveryservice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federation_deliveryservice (federation, deliveryservice, last_updated) FROM stdin;
\.


--
-- TOC entry 2816 (class 0 OID 17690)
-- Dependencies: 206
-- Data for Name: federation_federation_resolver; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federation_federation_resolver (federation, federation_resolver, last_updated) FROM stdin;
\.


--
-- TOC entry 2915 (class 0 OID 0)
-- Dependencies: 207
-- Name: federation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('federation_id_seq', 1, false);


--
-- TOC entry 2818 (class 0 OID 17696)
-- Dependencies: 208
-- Data for Name: federation_resolver; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federation_resolver (id, ip_address, type, last_updated) FROM stdin;
\.


--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 209
-- Name: federation_resolver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('federation_resolver_id_seq', 1, false);


--
-- TOC entry 2820 (class 0 OID 17705)
-- Dependencies: 210
-- Data for Name: federation_tmuser; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federation_tmuser (federation, tm_user, role, last_updated) FROM stdin;
\.


--
-- TOC entry 2821 (class 0 OID 17709)
-- Dependencies: 211
-- Data for Name: goose_db_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY goose_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	0	t	2018-03-26 16:07:57.446563
2	20161208000000	t	2018-03-26 16:07:57.453996
3	20161208000001	t	2018-03-26 16:07:57.456863
4	20170205101432	t	2018-03-26 16:08:27.773088
5	20170315000000	t	2018-03-26 16:08:27.811935
6	20170328190847	t	2018-03-26 16:08:27.825095
7	20170401000000	t	2018-03-26 16:08:27.848982
8	20170404000000	t	2018-03-26 16:08:27.854765
9	20170404000001	t	2018-03-26 16:08:27.859035
10	20170404000002	t	2018-03-26 16:08:27.863599
11	20170404000003	t	2018-03-26 16:08:27.86769
12	20170404000004	t	2018-03-26 16:08:27.871958
13	20170404000005	t	2018-03-26 16:08:27.876067
14	20170406000001	t	2018-03-26 16:08:27.880492
15	20170601183753	t	2018-03-26 16:08:27.902979
16	20170623144818	t	2018-03-26 16:08:27.908891
17	20170628000000	t	2018-03-26 16:08:27.946386
18	20170711160724	t	2018-03-26 16:08:27.952582
19	20170816000000	t	2018-03-26 16:08:27.956661
20	20170816000001	t	2018-03-26 16:08:27.960888
21	20170822000000	t	2018-03-26 16:08:27.964242
22	20170825124926	t	2018-03-26 16:08:27.966923
23	20171013000000	t	2018-03-26 16:08:27.97815
24	20171023000000	t	2018-03-26 16:08:27.99651
25	20171027000000	t	2018-03-26 16:08:28.000353
26	20171204000000	t	2018-03-26 16:08:28.003159
27	20171220000000	t	2018-03-26 16:08:28.005956
28	20180110000000	t	2018-03-26 16:08:28.01099
29	20180131000000	t	2018-03-26 16:08:28.028848
30	20180201000000	t	2018-03-26 16:08:28.031228
31	20180202000000	t	2018-03-26 16:08:28.035186
32	20180314000000	t	2018-03-26 16:08:28.046868
\.


--
-- TOC entry 2917 (class 0 OID 0)
-- Dependencies: 212
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('goose_db_version_id_seq', 32, true);


--
-- TOC entry 2823 (class 0 OID 17715)
-- Dependencies: 213
-- Data for Name: hwinfo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY hwinfo (id, serverid, description, val, last_updated) FROM stdin;
\.


--
-- TOC entry 2918 (class 0 OID 0)
-- Dependencies: 214
-- Name: hwinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('hwinfo_id_seq', 1, false);


--
-- TOC entry 2825 (class 0 OID 17724)
-- Dependencies: 215
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: -
--

COPY job (id, agent, object_type, object_name, keyword, parameters, asset_url, asset_type, status, start_time, entered_time, job_user, last_updated, job_deliveryservice) FROM stdin;
\.


--
-- TOC entry 2826 (class 0 OID 17731)
-- Dependencies: 216
-- Data for Name: job_agent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY job_agent (id, name, description, active, last_updated) FROM stdin;
\.


--
-- TOC entry 2919 (class 0 OID 0)
-- Dependencies: 217
-- Name: job_agent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('job_agent_id_seq', 1, false);


--
-- TOC entry 2920 (class 0 OID 0)
-- Dependencies: 218
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('job_id_seq', 1, false);


--
-- TOC entry 2829 (class 0 OID 17743)
-- Dependencies: 219
-- Data for Name: job_result; Type: TABLE DATA; Schema: public; Owner: -
--

COPY job_result (id, job, agent, result, description, last_updated) FROM stdin;
\.


--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 220
-- Name: job_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('job_result_id_seq', 1, false);


--
-- TOC entry 2831 (class 0 OID 17752)
-- Dependencies: 221
-- Data for Name: job_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY job_status (id, name, description, last_updated) FROM stdin;
\.


--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 222
-- Name: job_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('job_status_id_seq', 1, false);


--
-- TOC entry 2833 (class 0 OID 17761)
-- Dependencies: 223
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY log (id, level, message, tm_user, ticketnum, last_updated) FROM stdin;
1	APICHANGE	Created cdn: cdn1 id: 1	10	\N	2018-03-26 16:19:07.586976+00
2	APICHANGE	Created cdn: cdn2 id: 2	10	\N	2018-03-26 16:19:07.592543+00
3	APICHANGE	Created cdn: cdn3 id: 3	10	\N	2018-03-26 16:19:07.598107+00
4	APICHANGE	Created deliveryservice_request of type 'create' for deliveryservice 'test-ds1'	10	\N	2018-03-26 16:19:07.617612+00
5	APICHANGE	Created parameter: health.threshold.loadavg id: 4	10	\N	2018-03-26 16:19:07.639742+00
6	APICHANGE	Created parameter: health.threshold.availableBandwidthInKbps id: 5	10	\N	2018-03-26 16:19:07.646394+00
7	APICHANGE	Created parameter: history.count id: 6	10	\N	2018-03-26 16:19:07.652208+00
8	APICHANGE	Created parameter: key0 id: 7	10	\N	2018-03-26 16:19:07.657232+00
9	APICHANGE	Created parameter: key1 id: 8	10	\N	2018-03-26 16:19:07.662094+00
10	APICHANGE	Created parameter: key2 id: 9	10	\N	2018-03-26 16:19:07.667674+00
11	APICHANGE	Created parameter: key3 id: 10	10	\N	2018-03-26 16:19:07.672425+00
12	APICHANGE	Created parameter: key4 id: 11	10	\N	2018-03-26 16:19:07.677151+00
13	APICHANGE	Created parameter: key5 id: 12	10	\N	2018-03-26 16:19:07.683187+00
14	APICHANGE	Created parameter: key6 id: 13	10	\N	2018-03-26 16:19:07.687513+00
15	APICHANGE	Created parameter: key7 id: 14	10	\N	2018-03-26 16:19:07.691528+00
16	APICHANGE	Created parameter: key8 id: 15	10	\N	2018-03-26 16:19:07.69719+00
17	APICHANGE	Created parameter: key9 id: 16	10	\N	2018-03-26 16:19:07.702797+00
18	APICHANGE	Created parameter: key10 id: 17	10	\N	2018-03-26 16:19:07.707236+00
19	APICHANGE	Created parameter: key11 id: 18	10	\N	2018-03-26 16:19:07.711217+00
20	APICHANGE	Created parameter: key12 id: 19	10	\N	2018-03-26 16:19:07.715409+00
21	APICHANGE	Created parameter: key13 id: 20	10	\N	2018-03-26 16:19:07.71949+00
22	APICHANGE	Created parameter: key14 id: 21	10	\N	2018-03-26 16:19:07.724153+00
23	APICHANGE	Created parameter: key15 id: 22	10	\N	2018-03-26 16:19:07.729309+00
24	APICHANGE	Created parameter: error_url id: 23	10	\N	2018-03-26 16:19:07.734876+00
25	APICHANGE	Created parameter: CONFIG proxy.config.allocator.debug_filter id: 24	10	\N	2018-03-26 16:19:07.739798+00
26	APICHANGE	Created parameter: CONFIG proxy.config.allocator.enable_reclaim id: 25	10	\N	2018-03-26 16:19:07.743887+00
27	APICHANGE	Created parameter: CONFIG proxy.config.allocator.max_overage id: 26	10	\N	2018-03-26 16:19:07.74862+00
28	APICHANGE	Created parameter: CONFIG proxy.config.diags.show_location id: 27	10	\N	2018-03-26 16:19:07.754432+00
29	APICHANGE	Created parameter: CONFIG proxy.config.http.cache.allow_empty_doc id: 28	10	\N	2018-03-26 16:19:07.759539+00
30	APICHANGE	Created parameter: LOCAL proxy.config.cache.interim.storage id: 29	10	\N	2018-03-26 16:19:07.763732+00
31	APICHANGE	Created parameter: CONFIG proxy.config.http.parent_proxy.file id: 30	10	\N	2018-03-26 16:19:07.768127+00
32	APICHANGE	Created parameter: astats_over_http.so id: 31	10	\N	2018-03-26 16:19:07.772555+00
33	APICHANGE	Created parameter: LogFormat.Name id: 32	10	\N	2018-03-26 16:19:07.777098+00
34	APICHANGE	Created parameter: LogObject.Format id: 33	10	\N	2018-03-26 16:19:07.781345+00
35	APICHANGE	Created parameter: LogObject.Filename id: 34	10	\N	2018-03-26 16:19:07.78528+00
36	APICHANGE	Created parameter: CONFIG proxy.config.cache.control.filename id: 35	10	\N	2018-03-26 16:19:07.789342+00
37	APICHANGE	Created parameter: regex_revalidate.so id: 36	10	\N	2018-03-26 16:19:07.793633+00
38	APICHANGE	Created parameter: allow_ip6 id: 37	10	\N	2018-03-26 16:19:07.798869+00
39	APICHANGE	Created parameter: record_types id: 38	10	\N	2018-03-26 16:19:07.80353+00
40	APICHANGE	Created parameter: path id: 39	10	\N	2018-03-26 16:19:07.807376+00
41	APICHANGE	Created parameter: location id: 40	10	\N	2018-03-26 16:19:07.811518+00
42	APICHANGE	Created parameter: Drive_Prefix id: 41	10	\N	2018-03-26 16:19:07.817485+00
43	APICHANGE	Created parameter: Drive_Letters id: 42	10	\N	2018-03-26 16:19:07.82281+00
44	APICHANGE	Created parameter: Disk_Volume id: 43	10	\N	2018-03-26 16:19:07.828794+00
45	APICHANGE	Created parameter: CONFIG proxy.config.hostdb.storage_size id: 44	10	\N	2018-03-26 16:19:07.834684+00
46	APICHANGE	Created parameter: maxRevalDurationDays id: 45	10	\N	2018-03-26 16:19:07.839863+00
47	APICHANGE	Created parameter: unassigned_parameter_1 id: 46	10	\N	2018-03-26 16:19:07.844873+00
48	APICHANGE	Created parameter: trafficserver id: 47	10	\N	2018-03-26 16:19:07.849711+00
49	APICHANGE	Created parameter: use_tenancy id: 48	10	\N	2018-03-26 16:19:07.854396+00
50	APICHANGE	Deleted parameter: 4 id: 4	10	\N	2018-03-26 16:19:07.868321+00
51	APICHANGE	Deleted parameter: 5 id: 5	10	\N	2018-03-26 16:19:07.880507+00
52	APICHANGE	Deleted parameter: 6 id: 6	10	\N	2018-03-26 16:19:07.893943+00
53	APICHANGE	Deleted parameter: 7 id: 7	10	\N	2018-03-26 16:19:07.905325+00
54	APICHANGE	Deleted parameter: 8 id: 8	10	\N	2018-03-26 16:19:07.915294+00
55	APICHANGE	Deleted parameter: 9 id: 9	10	\N	2018-03-26 16:19:07.924665+00
56	APICHANGE	Deleted parameter: 10 id: 10	10	\N	2018-03-26 16:19:07.933651+00
57	APICHANGE	Deleted parameter: 11 id: 11	10	\N	2018-03-26 16:19:07.942041+00
58	APICHANGE	Deleted parameter: 12 id: 12	10	\N	2018-03-26 16:19:07.950276+00
59	APICHANGE	Deleted parameter: 13 id: 13	10	\N	2018-03-26 16:19:07.958026+00
60	APICHANGE	Deleted parameter: 14 id: 14	10	\N	2018-03-26 16:19:07.966795+00
61	APICHANGE	Deleted parameter: 15 id: 15	10	\N	2018-03-26 16:19:07.974677+00
62	APICHANGE	Deleted parameter: 16 id: 16	10	\N	2018-03-26 16:19:07.983958+00
63	APICHANGE	Deleted parameter: 17 id: 17	10	\N	2018-03-26 16:19:07.99248+00
64	APICHANGE	Deleted parameter: 18 id: 18	10	\N	2018-03-26 16:19:08.003067+00
65	APICHANGE	Deleted parameter: 19 id: 19	10	\N	2018-03-26 16:19:08.010963+00
66	APICHANGE	Deleted parameter: 20 id: 20	10	\N	2018-03-26 16:19:08.019427+00
67	APICHANGE	Deleted parameter: 21 id: 21	10	\N	2018-03-26 16:19:08.028105+00
68	APICHANGE	Deleted parameter: 22 id: 22	10	\N	2018-03-26 16:19:08.036276+00
69	APICHANGE	Deleted parameter: 23 id: 23	10	\N	2018-03-26 16:19:08.044249+00
70	APICHANGE	Deleted parameter: 24 id: 24	10	\N	2018-03-26 16:19:08.05334+00
71	APICHANGE	Deleted parameter: 25 id: 25	10	\N	2018-03-26 16:19:08.061447+00
72	APICHANGE	Deleted parameter: 26 id: 26	10	\N	2018-03-26 16:19:08.071902+00
73	APICHANGE	Deleted parameter: 27 id: 27	10	\N	2018-03-26 16:19:08.081017+00
74	APICHANGE	Deleted parameter: 28 id: 28	10	\N	2018-03-26 16:19:08.088406+00
75	APICHANGE	Deleted parameter: 29 id: 29	10	\N	2018-03-26 16:19:08.097819+00
76	APICHANGE	Deleted parameter: 30 id: 30	10	\N	2018-03-26 16:19:08.105717+00
77	APICHANGE	Deleted parameter: 31 id: 31	10	\N	2018-03-26 16:19:08.114005+00
78	APICHANGE	Deleted parameter: 32 id: 32	10	\N	2018-03-26 16:19:08.122461+00
79	APICHANGE	Deleted parameter: 33 id: 33	10	\N	2018-03-26 16:19:08.131914+00
80	APICHANGE	Deleted parameter: 34 id: 34	10	\N	2018-03-26 16:19:08.139873+00
82	APICHANGE	Deleted parameter: 36 id: 36	10	\N	2018-03-26 16:19:08.157187+00
84	APICHANGE	Deleted parameter: 38 id: 38	10	\N	2018-03-26 16:19:08.178474+00
86	APICHANGE	Deleted parameter: 40 id: 40	10	\N	2018-03-26 16:19:08.198822+00
88	APICHANGE	Deleted parameter: 42 id: 42	10	\N	2018-03-26 16:19:08.216293+00
90	APICHANGE	Deleted parameter: 44 id: 44	10	\N	2018-03-26 16:19:08.2354+00
92	APICHANGE	Deleted parameter: 46 id: 46	10	\N	2018-03-26 16:19:08.252505+00
94	APICHANGE	Deleted parameter: 48 id: 48	10	\N	2018-03-26 16:19:08.271232+00
95	APICHANGE	Created deliveryservice_request of type 'update' for deliveryservice 'test-transitions'	10	\N	2018-03-26 16:19:08.28557+00
97	APICHANGE	Created division: division1 id: 1	10	\N	2018-03-26 16:19:08.311551+00
99	APICHANGE	Created parameter: health.threshold.loadavg id: 49	10	\N	2018-03-26 16:19:08.326629+00
101	APICHANGE	Created parameter: history.count id: 51	10	\N	2018-03-26 16:19:08.337083+00
103	APICHANGE	Created parameter: key1 id: 53	10	\N	2018-03-26 16:19:08.345196+00
105	APICHANGE	Created parameter: key3 id: 55	10	\N	2018-03-26 16:19:08.354887+00
107	APICHANGE	Created parameter: key5 id: 57	10	\N	2018-03-26 16:19:08.363619+00
109	APICHANGE	Created parameter: key7 id: 59	10	\N	2018-03-26 16:19:08.372697+00
111	APICHANGE	Created parameter: key9 id: 61	10	\N	2018-03-26 16:19:08.38216+00
113	APICHANGE	Created parameter: key11 id: 63	10	\N	2018-03-26 16:19:08.389718+00
115	APICHANGE	Created parameter: key13 id: 65	10	\N	2018-03-26 16:19:08.399652+00
117	APICHANGE	Created parameter: key15 id: 67	10	\N	2018-03-26 16:19:08.408364+00
119	APICHANGE	Created parameter: CONFIG proxy.config.allocator.debug_filter id: 69	10	\N	2018-03-26 16:19:08.417074+00
121	APICHANGE	Created parameter: CONFIG proxy.config.allocator.max_overage id: 71	10	\N	2018-03-26 16:19:08.42735+00
123	APICHANGE	Created parameter: CONFIG proxy.config.http.cache.allow_empty_doc id: 73	10	\N	2018-03-26 16:19:08.438587+00
125	APICHANGE	Created parameter: CONFIG proxy.config.http.parent_proxy.file id: 75	10	\N	2018-03-26 16:19:08.448208+00
127	APICHANGE	Created parameter: LogFormat.Name id: 77	10	\N	2018-03-26 16:19:08.456574+00
129	APICHANGE	Created parameter: LogObject.Filename id: 79	10	\N	2018-03-26 16:19:08.466187+00
131	APICHANGE	Created parameter: regex_revalidate.so id: 81	10	\N	2018-03-26 16:19:08.477913+00
133	APICHANGE	Created parameter: record_types id: 83	10	\N	2018-03-26 16:19:08.488584+00
135	APICHANGE	Created parameter: location id: 85	10	\N	2018-03-26 16:19:08.501012+00
137	APICHANGE	Created parameter: Drive_Letters id: 87	10	\N	2018-03-26 16:19:08.51085+00
139	APICHANGE	Created parameter: CONFIG proxy.config.hostdb.storage_size id: 89	10	\N	2018-03-26 16:19:08.519156+00
141	APICHANGE	Created parameter: unassigned_parameter_1 id: 91	10	\N	2018-03-26 16:19:08.528129+00
143	APICHANGE	Created parameter: use_tenancy id: 93	10	\N	2018-03-26 16:19:08.536858+00
144	APICHANGE	Created profile: EDGE1 id: 1	10	\N	2018-03-26 16:19:08.645986+00
146	APICHANGE	Created profile: CCR1 id: 3	10	\N	2018-03-26 16:19:08.661173+00
148	APICHANGE	Created profile: RASCAL1 id: 5	10	\N	2018-03-26 16:19:08.67597+00
150	APICHANGE	Created region: region1 id: 1	10	\N	2018-03-26 16:19:08.706537+00
152	APICHANGE	Created type: HOST_REGEXP id: 1	10	\N	2018-03-26 16:19:08.721263+00
154	APICHANGE	Created type: OTHER_CDN id: 3	10	\N	2018-03-26 16:19:08.729302+00
156	APICHANGE	Created type: INFLUXDB id: 5	10	\N	2018-03-26 16:19:08.738037+00
158	APICHANGE	Created type: ORG id: 7	10	\N	2018-03-26 16:19:08.746281+00
160	APICHANGE	Created type: ACTIVE_DIRECTORY id: 9	10	\N	2018-03-26 16:19:08.754621+00
162	APICHANGE	Created type: A_RECORD id: 11	10	\N	2018-03-26 16:19:08.762003+00
164	APICHANGE	Created type: STEERING_WEIGHT id: 13	10	\N	2018-03-26 16:19:08.770935+00
166	APICHANGE	Created type: TOOLS_SERVER id: 15	10	\N	2018-03-26 16:19:08.779362+00
168	APICHANGE	Created type: CNAME_RECORD id: 17	10	\N	2018-03-26 16:19:08.787256+00
170	APICHANGE	Created type: MID_LOC id: 19	10	\N	2018-03-26 16:19:08.796743+00
172	APICHANGE	Created type: STEERING_ORDER id: 21	10	\N	2018-03-26 16:19:08.807774+00
174	APICHANGE	Created type: RESOLVE6 id: 23	10	\N	2018-03-26 16:19:08.816739+00
176	APICHANGE	Created type: HTTP_NO_CACHE id: 25	10	\N	2018-03-26 16:19:08.824141+00
178	APICHANGE	Created type: STEERING id: 27	10	\N	2018-03-26 16:19:08.83259+00
180	APICHANGE	Created type: HTTP id: 29	10	\N	2018-03-26 16:19:08.840171+00
182	APICHANGE	Updated type: testType1 id: 1	10	\N	2018-03-26 16:19:08.851423+00
81	APICHANGE	Deleted parameter: 35 id: 35	10	\N	2018-03-26 16:19:08.149075+00
83	APICHANGE	Deleted parameter: 37 id: 37	10	\N	2018-03-26 16:19:08.167818+00
85	APICHANGE	Deleted parameter: 39 id: 39	10	\N	2018-03-26 16:19:08.189132+00
87	APICHANGE	Deleted parameter: 41 id: 41	10	\N	2018-03-26 16:19:08.207671+00
89	APICHANGE	Deleted parameter: 43 id: 43	10	\N	2018-03-26 16:19:08.225338+00
91	APICHANGE	Deleted parameter: 45 id: 45	10	\N	2018-03-26 16:19:08.244095+00
93	APICHANGE	Deleted parameter: 47 id: 47	10	\N	2018-03-26 16:19:08.260383+00
96	APICHANGE	Updated deliveryservice_request of type 'update' for deliveryservice 'test-transitions'	10	\N	2018-03-26 16:19:08.303003+00
98	APICHANGE	Created division: division2 id: 2	10	\N	2018-03-26 16:19:08.316649+00
100	APICHANGE	Created parameter: health.threshold.availableBandwidthInKbps id: 50	10	\N	2018-03-26 16:19:08.332118+00
102	APICHANGE	Created parameter: key0 id: 52	10	\N	2018-03-26 16:19:08.341126+00
104	APICHANGE	Created parameter: key2 id: 54	10	\N	2018-03-26 16:19:08.349912+00
106	APICHANGE	Created parameter: key4 id: 56	10	\N	2018-03-26 16:19:08.359466+00
108	APICHANGE	Created parameter: key6 id: 58	10	\N	2018-03-26 16:19:08.368611+00
110	APICHANGE	Created parameter: key8 id: 60	10	\N	2018-03-26 16:19:08.377438+00
112	APICHANGE	Created parameter: key10 id: 62	10	\N	2018-03-26 16:19:08.386+00
114	APICHANGE	Created parameter: key12 id: 64	10	\N	2018-03-26 16:19:08.39404+00
116	APICHANGE	Created parameter: key14 id: 66	10	\N	2018-03-26 16:19:08.404532+00
118	APICHANGE	Created parameter: error_url id: 68	10	\N	2018-03-26 16:19:08.412241+00
120	APICHANGE	Created parameter: CONFIG proxy.config.allocator.enable_reclaim id: 70	10	\N	2018-03-26 16:19:08.422336+00
122	APICHANGE	Created parameter: CONFIG proxy.config.diags.show_location id: 72	10	\N	2018-03-26 16:19:08.433118+00
124	APICHANGE	Created parameter: LOCAL proxy.config.cache.interim.storage id: 74	10	\N	2018-03-26 16:19:08.443242+00
126	APICHANGE	Created parameter: astats_over_http.so id: 76	10	\N	2018-03-26 16:19:08.45255+00
128	APICHANGE	Created parameter: LogObject.Format id: 78	10	\N	2018-03-26 16:19:08.460703+00
130	APICHANGE	Created parameter: CONFIG proxy.config.cache.control.filename id: 80	10	\N	2018-03-26 16:19:08.472936+00
132	APICHANGE	Created parameter: allow_ip6 id: 82	10	\N	2018-03-26 16:19:08.482512+00
134	APICHANGE	Created parameter: path id: 84	10	\N	2018-03-26 16:19:08.494473+00
136	APICHANGE	Created parameter: Drive_Prefix id: 86	10	\N	2018-03-26 16:19:08.506634+00
138	APICHANGE	Created parameter: Disk_Volume id: 88	10	\N	2018-03-26 16:19:08.515195+00
140	APICHANGE	Created parameter: maxRevalDurationDays id: 90	10	\N	2018-03-26 16:19:08.523091+00
142	APICHANGE	Created parameter: trafficserver id: 92	10	\N	2018-03-26 16:19:08.532606+00
145	APICHANGE	Created profile: MID1 id: 2	10	\N	2018-03-26 16:19:08.65215+00
147	APICHANGE	Created profile: CCR2 id: 4	10	\N	2018-03-26 16:19:08.670108+00
149	APICHANGE	Created profile: EDGE2 id: 6	10	\N	2018-03-26 16:19:08.683107+00
151	APICHANGE	Created region: region2 id: 2	10	\N	2018-03-26 16:19:08.710822+00
153	APICHANGE	Created type: DNS_LIVE_NATNL id: 2	10	\N	2018-03-26 16:19:08.725333+00
155	APICHANGE	Created type: CLIENT_STEERING id: 4	10	\N	2018-03-26 16:19:08.733658+00
157	APICHANGE	Created type: RIAK id: 6	10	\N	2018-03-26 16:19:08.741914+00
159	APICHANGE	Created type: HTTP_LIVE id: 8	10	\N	2018-03-26 16:19:08.750904+00
161	APICHANGE	Created type: RESOLVE4 id: 10	10	\N	2018-03-26 16:19:08.758379+00
163	APICHANGE	Created type: LOCAL id: 12	10	\N	2018-03-26 16:19:08.766293+00
165	APICHANGE	Created type: HTTP_LIVE_NATNL id: 14	10	\N	2018-03-26 16:19:08.775312+00
167	APICHANGE	Created type: PATH_REGEXP id: 16	10	\N	2018-03-26 16:19:08.783527+00
169	APICHANGE	Created type: CCR id: 18	10	\N	2018-03-26 16:19:08.792382+00
171	APICHANGE	Created type: EDGE id: 20	10	\N	2018-03-26 16:19:08.802102+00
173	APICHANGE	Created type: DNS id: 22	10	\N	2018-03-26 16:19:08.812333+00
175	APICHANGE	Created type: AAAA_RECORD id: 24	10	\N	2018-03-26 16:19:08.820595+00
177	APICHANGE	Created type: ANY_MAP id: 26	10	\N	2018-03-26 16:19:08.828125+00
179	APICHANGE	Created type: EDGE_LOC id: 28	10	\N	2018-03-26 16:19:08.836357+00
181	APICHANGE	Created type: MID id: 30	10	\N	2018-03-26 16:19:08.844119+00
\.


--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('log_id_seq', 182, true);


--
-- TOC entry 2835 (class 0 OID 17770)
-- Dependencies: 225
-- Data for Name: parameter; Type: TABLE DATA; Schema: public; Owner: -
--

COPY parameter (id, name, config_file, value, last_updated, secure) FROM stdin;
49	health.threshold.loadavg	rascal.properties	25.0	2018-03-26 16:19:08.323985+00	f
50	health.threshold.availableBandwidthInKbps	rascal.properties	>1750000	2018-03-26 16:19:08.329038+00	f
51	history.count	rascal.properties	30	2018-03-26 16:19:08.334226+00	f
52	key0	url_sig.config	HOOJ3Ghq1x4gChp3iQkqVTcPlOj8UCi3	2018-03-26 16:19:08.339133+00	t
53	key1	url_sig.config	_9LZYkRnfCS0rCBF7fTQzM9Scwlp2FhO	2018-03-26 16:19:08.343079+00	t
54	key2	url_sig.config	AFpkxfc4oTiyFSqtY6_ohjt3V80aAIxS	2018-03-26 16:19:08.347383+00	t
55	key3	url_sig.config	AL9kzs_SXaRZjPWH8G5e2m4ByTTzkzlc	2018-03-26 16:19:08.352217+00	t
56	key4	url_sig.config	poP3n3szbD1U4vx1xQXV65BvkVgWzfN8	2018-03-26 16:19:08.356995+00	t
57	key5	url_sig.config	1ir32ng4C4w137p5oq72kd2wqmIZUrya	2018-03-26 16:19:08.361335+00	t
58	key6	url_sig.config	B1qLptn2T1b_iXeTCWDcVuYvANtH139f	2018-03-26 16:19:08.366272+00	t
59	key7	url_sig.config	PiCV_5OODMzBbsNFMWsBxcQ8v1sK0TYE	2018-03-26 16:19:08.37053+00	t
60	key8	url_sig.config	Ggpv6DqXDvt2s1CETPBpNKwaLk4fTM9l	2018-03-26 16:19:08.375028+00	t
61	key9	url_sig.config	qPlVT_s6kL37aqb6hipDm4Bt55S72mI7	2018-03-26 16:19:08.379723+00	t
62	key10	url_sig.config	BsI5A9EmWrobIS1FeuOs1z9fm2t2WSBe	2018-03-26 16:19:08.383921+00	t
63	key11	url_sig.config	A54y66NCIj897GjS4yA9RrsSPtCUnQXP	2018-03-26 16:19:08.387699+00	t
64	key12	url_sig.config	2jZH0NDPSJttIr4c2KP510f47EKqTQAu	2018-03-26 16:19:08.39171+00	t
65	key13	url_sig.config	XduT2FBjBmmVID5JRB5LEf9oR5QDtBgC	2018-03-26 16:19:08.396619+00	t
66	key14	url_sig.config	D9nH0SvK_0kP5w8QNd1UFJ28ulFkFKPn	2018-03-26 16:19:08.402287+00	t
67	key15	url_sig.config	udKXWYNwbXXweaaLzaKDGl57OixnIIcm	2018-03-26 16:19:08.406382+00	t
68	error_url	url_sig.config	403	2018-03-26 16:19:08.410148+00	t
69	CONFIG proxy.config.allocator.debug_filter	records.config	INT 0	2018-03-26 16:19:08.41417+00	f
70	CONFIG proxy.config.allocator.enable_reclaim	records.config	INT 0	2018-03-26 16:19:08.419791+00	f
71	CONFIG proxy.config.allocator.max_overage	records.config	INT 3	2018-03-26 16:19:08.42443+00	f
72	CONFIG proxy.config.diags.show_location	records.config	INT 0	2018-03-26 16:19:08.430112+00	f
73	CONFIG proxy.config.http.cache.allow_empty_doc	records.config	INT 0	2018-03-26 16:19:08.435425+00	f
74	LOCAL proxy.config.cache.interim.storage	records.config	STRING NULL	2018-03-26 16:19:08.440816+00	f
75	CONFIG proxy.config.http.parent_proxy.file	records.config	STRING parent.config	2018-03-26 16:19:08.445411+00	f
77	LogFormat.Name	logs_xml.config	custom_ats_2	2018-03-26 16:19:08.454457+00	f
79	LogObject.Filename	logs_xml.config	custom_ats_2	2018-03-26 16:19:08.463222+00	f
81	regex_revalidate.so	plugin.config	--config regex_revalidate.config	2018-03-26 16:19:08.475316+00	f
83	record_types	astats.config	144	2018-03-26 16:19:08.485095+00	f
85	location	storage.config	/opt/trafficserver/etc/trafficserver/	2018-03-26 16:19:08.497851+00	f
87	Drive_Letters	storage.config	b,c,d,e,f,g,h,i,j,k,l,m,n,o	2018-03-26 16:19:08.508783+00	f
89	CONFIG proxy.config.hostdb.storage_size	records.config	INT 33554432	2018-03-26 16:19:08.517006+00	f
91	unassigned_parameter_1	whaterver.config	852	2018-03-26 16:19:08.525644+00	f
93	use_tenancy	global	1	2018-03-26 16:19:08.534623+00	f
76	astats_over_http.so	plugin.config	_astats 33.101.99.100,172.39.19.39,172.39.19.49,172.39.19.49,172.39.29.49	2018-03-26 16:19:08.450223+00	f
78	LogObject.Format	logs_xml.config	custom_ats_2	2018-03-26 16:19:08.458421+00	f
80	CONFIG proxy.config.cache.control.filename	records.config	STRING cache.config	2018-03-26 16:19:08.469209+00	f
82	allow_ip6	astats.config	::1,2033:D011:3300::336/64,2033:D011:3300::335/64,2033:D021:3300::333/64,2033:D021:3300::334/64	2018-03-26 16:19:08.480074+00	f
84	path	astats.config	_astats	2018-03-26 16:19:08.491351+00	f
86	Drive_Prefix	storage.config	/dev/sd	2018-03-26 16:19:08.504138+00	f
88	Disk_Volume	storage.config	1	2018-03-26 16:19:08.512755+00	f
90	maxRevalDurationDays	regex_revalidate.config	90	2018-03-26 16:19:08.520987+00	f
92	trafficserver	package	5.3.2-765.f4354b9.el7.centos.x86_64	2018-03-26 16:19:08.530265+00	f
\.


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 226
-- Name: parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('parameter_id_seq', 93, true);


--
-- TOC entry 2837 (class 0 OID 17780)
-- Dependencies: 227
-- Data for Name: phys_location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY phys_location (id, name, short_name, address, city, state, zip, poc, phone, email, comments, region, last_updated) FROM stdin;
\.


--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 228
-- Name: phys_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('phys_location_id_seq', 1, false);


--
-- TOC entry 2839 (class 0 OID 17789)
-- Dependencies: 229
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY profile (id, name, description, last_updated, type, cdn, routing_disabled) FROM stdin;
1	EDGE1	edge description	2018-03-26 16:19:08.643626+00	ATS_PROFILE	1	f
2	MID1	mid description	2018-03-26 16:19:08.6497+00	ATS_PROFILE	1	f
3	CCR1	cdn1 description	2018-03-26 16:19:08.657625+00	TR_PROFILE	1	f
4	CCR2	cdn2 description	2018-03-26 16:19:08.666374+00	TR_PROFILE	2	f
5	RASCAL1	rascal description	2018-03-26 16:19:08.673729+00	TM_PROFILE	1	f
6	EDGE2	edge2 description	2018-03-26 16:19:08.680279+00	ATS_PROFILE	2	f
\.


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 230
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('profile_id_seq', 6, true);


--
-- TOC entry 2841 (class 0 OID 17799)
-- Dependencies: 231
-- Data for Name: profile_parameter; Type: TABLE DATA; Schema: public; Owner: -
--

COPY profile_parameter (profile, parameter, last_updated) FROM stdin;
\.


--
-- TOC entry 2842 (class 0 OID 17807)
-- Dependencies: 233
-- Data for Name: regex; Type: TABLE DATA; Schema: public; Owner: -
--

COPY regex (id, pattern, type, last_updated) FROM stdin;
\.


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 234
-- Name: regex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('regex_id_seq', 1, false);


--
-- TOC entry 2844 (class 0 OID 17817)
-- Dependencies: 235
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: -
--

COPY region (id, name, division, last_updated) FROM stdin;
100	Denver Region	100	2018-01-19 19:01:21.85943+00
200	Boulder Region	100	2018-01-19 19:01:21.854509+00
1	region1	1	2018-03-26 16:19:08.704091+00
2	region2	1	2018-03-26 16:19:08.708325+00
\.


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 236
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('region_id_seq', 2, true);


--
-- TOC entry 2846 (class 0 OID 17826)
-- Dependencies: 237
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY role (id, name, description, priv_level) FROM stdin;
1	disallowed	Block all access	0
2	read-only user	Block all access	10
3	operations	Block all access	20
4	admin	super-user	30
5	portal	Portal User	2
7	federation	Role for Secondary CZF	15
\.


--
-- TOC entry 2847 (class 0 OID 17832)
-- Dependencies: 238
-- Data for Name: role_capability; Type: TABLE DATA; Schema: public; Owner: -
--

COPY role_capability (role_id, cap_name, last_updated) FROM stdin;
\.


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 239
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_id_seq', 1, false);


--
-- TOC entry 2849 (class 0 OID 17841)
-- Dependencies: 240
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY server (id, host_name, domain_name, tcp_port, xmpp_id, xmpp_passwd, interface_name, ip_address, ip_netmask, ip_gateway, ip6_address, ip6_gateway, interface_mtu, phys_location, rack, cachegroup, type, status, offline_reason, upd_pending, profile, cdn_id, mgmt_ip_address, mgmt_ip_netmask, mgmt_ip_gateway, ilo_ip_address, ilo_ip_netmask, ilo_ip_gateway, ilo_username, ilo_password, router_host_name, router_port_name, guid, last_updated, https_port, reval_pending) FROM stdin;
\.


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 241
-- Name: server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('server_id_seq', 1, false);


--
-- TOC entry 2851 (class 0 OID 17854)
-- Dependencies: 242
-- Data for Name: servercheck; Type: TABLE DATA; Schema: public; Owner: -
--

COPY servercheck (id, server, aa, ab, ac, ad, ae, af, ag, ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, bf, at, au, av, aw, ax, ay, az, ba, bb, bc, bd, be, last_updated) FROM stdin;
\.


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 243
-- Name: servercheck_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('servercheck_id_seq', 1, false);


--
-- TOC entry 2853 (class 0 OID 17860)
-- Dependencies: 244
-- Data for Name: snapshot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY snapshot (cdn, content, last_updated) FROM stdin;
\.


--
-- TOC entry 2854 (class 0 OID 17867)
-- Dependencies: 245
-- Data for Name: staticdnsentry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY staticdnsentry (id, host, address, type, ttl, deliveryservice, cachegroup, last_updated) FROM stdin;
\.


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 246
-- Name: staticdnsentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('staticdnsentry_id_seq', 1, false);


--
-- TOC entry 2856 (class 0 OID 17877)
-- Dependencies: 247
-- Data for Name: stats_summary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY stats_summary (id, cdn_name, deliveryservice_name, stat_name, stat_value, summary_time, stat_date) FROM stdin;
\.


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 248
-- Name: stats_summary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stats_summary_id_seq', 1, false);


--
-- TOC entry 2858 (class 0 OID 17887)
-- Dependencies: 249
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY status (id, name, description, last_updated) FROM stdin;
1	OFFLINE	Edge: Puts server in CCR config file in this state, but CCR will never route traffic to it. Mid: Server will not be included in parent.config files for its edge caches	2018-01-19 19:01:21.388399+00
2	ONLINE	Edge: Puts server in CCR config file in this state, and CCR will always route traffic to it. Mid: Server will be included in parent.config files for its edges	2018-01-19 19:01:21.384459+00
3	REPORTED	Edge: Puts server in CCR config file in this state, and CCR will adhere to the health protocol. Mid: N/A for now	2018-01-19 19:01:21.379811+00
4	ADMIN_DOWN	Temporary down. Edge: XMPP client will send status OFFLINE to CCR, otherwise similar to REPORTED. Mid: Server will not be included in parent.config files for its edge caches	2018-01-19 19:01:21.385798+00
5	CCR_IGNORE	Edge: 12M will not include caches in this state in CCR config files. Mid: N/A for now	2018-01-19 19:01:21.383085+00
6	PRE_PROD	Pre Production. Not active in any configuration.	2018-01-19 19:01:21.387146+00
\.


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 250
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('status_id_seq', 1, false);


--
-- TOC entry 2860 (class 0 OID 17896)
-- Dependencies: 251
-- Data for Name: steering_target; Type: TABLE DATA; Schema: public; Owner: -
--

COPY steering_target (deliveryservice, target, value, last_updated, type) FROM stdin;
\.


--
-- TOC entry 2861 (class 0 OID 17900)
-- Dependencies: 252
-- Data for Name: tenant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tenant (id, name, active, parent_id, last_updated) FROM stdin;
1	root	t	\N	2018-01-19 19:01:21.327262+00
2	grandparent tenant	t	1	2018-01-19 19:01:21.327262+00
3	parent tenant	t	2	2018-01-19 19:01:21.327262+00
4	child tenant	t	3	2018-01-19 19:01:21.327262+00
\.


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 253
-- Name: tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tenant_id_seq', 1, false);


--
-- TOC entry 2863 (class 0 OID 17912)
-- Dependencies: 254
-- Data for Name: tm_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tm_user (id, username, public_ssh_key, role, uid, gid, local_passwd, confirm_local_passwd, last_updated, company, email, full_name, new_user, address_line1, address_line2, city, state_or_province, phone_number, postal_code, country, token, registration_sent, tenant_id) FROM stdin;
7	disallowed	\N	1	\N	\N	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	2018-03-26 16:19:07.218772+00	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	3
8	readOnly	\N	2	\N	\N	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	2018-03-26 16:19:07.218772+00	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	3
9	operations	\N	3	\N	\N	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	2018-03-26 16:19:07.218772+00	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	3
10	admin	\N	4	\N	\N	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	2018-03-26 16:19:07.218772+00	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	2
11	portal	\N	5	\N	\N	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	2018-03-26 16:19:07.218772+00	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	3
12	federation	\N	7	\N	\N	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	SCRYPT:16384:8:1:puoj4ClDQhbBgHJ9C3ak0efxFIYnNGir3g37po6jKoK+1zKCwjSj+qBq6uQafq67LvwxwEGJP/YvbVMTV/Kw6A==:CDNgdc4rHezcPB4od8UscmLeqbRy3rLCWBJi7/oPty6Dbpw6PwUK9GqOrrqA3SK2CM8l919JYNbLyuzvpLkhmA==	2018-03-26 16:19:07.218772+00	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	3
\.


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 255
-- Name: tm_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tm_user_id_seq', 12, true);


--
-- TOC entry 2865 (class 0 OID 17922)
-- Dependencies: 256
-- Data for Name: to_extension; Type: TABLE DATA; Schema: public; Owner: -
--

COPY to_extension (id, name, version, info_url, script_file, isactive, additional_config_json, description, servercheck_short_name, servercheck_column_name, type, last_updated) FROM stdin;
\.


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 257
-- Name: to_extension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('to_extension_id_seq', 1, false);


--
-- TOC entry 2867 (class 0 OID 17932)
-- Dependencies: 258
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY type (id, name, description, use_in_table, last_updated) FROM stdin;
2	DNS_LIVE_NATNL	DNS Content routing, RAM cache, National	deliveryservice	2018-03-26 16:19:08.723073+00
3	OTHER_CDN	Other CDN (CDS-IS, Akamai, etc)	server	2018-03-26 16:19:08.727005+00
4	CLIENT_STEERING	Client-Controlled Steering Delivery Service	deliveryservice	2018-03-26 16:19:08.731329+00
5	INFLUXDB	influxdb type	server	2018-03-26 16:19:08.735547+00
6	RIAK	riak type	server	2018-03-26 16:19:08.739812+00
7	ORG	Origin	server	2018-03-26 16:19:08.744093+00
8	HTTP_LIVE	HTTP Content routing cache in RAM 	deliveryservice	2018-03-26 16:19:08.74862+00
9	ACTIVE_DIRECTORY	Active Directory User	tm_user	2018-03-26 16:19:08.752678+00
10	RESOLVE4	federation type resolve4	federation	2018-03-26 16:19:08.756375+00
11	A_RECORD	Static DNS A entry	staticdnsentry	2018-03-26 16:19:08.760079+00
12	LOCAL	Local User	tm_user	2018-03-26 16:19:08.763963+00
13	STEERING_WEIGHT	Weighted steering target	steering_target	2018-03-26 16:19:08.768422+00
14	HTTP_LIVE_NATNL	HTTP Content routing, RAM cache, National	deliveryservice	2018-03-26 16:19:08.773102+00
15	TOOLS_SERVER	Ops hosts for management	server	2018-03-26 16:19:08.777031+00
16	PATH_REGEXP	Path regular expression	regex	2018-03-26 16:19:08.78131+00
17	CNAME_RECORD	Static DNS CNAME entry	staticdnsentry	2018-03-26 16:19:08.785181+00
18	CCR	Kabletown Content Router	server	2018-03-26 16:19:08.789509+00
19	MID_LOC	Mid Cachegroup	cachegroup	2018-03-26 16:19:08.794512+00
20	EDGE	Edge Cache	server	2018-03-26 16:19:08.799399+00
21	STEERING_ORDER	Ordered steering target	steering_target	2018-03-26 16:19:08.805094+00
22	DNS	DNS Content Routing	deliveryservice	2018-03-26 16:19:08.809846+00
23	RESOLVE6	federation type resolve6	federation	2018-03-26 16:19:08.814205+00
24	AAAA_RECORD	Static DNS AAAA entry	staticdnsentry	2018-03-26 16:19:08.818551+00
25	HTTP_NO_CACHE	HTTP Content Routing, no caching	deliveryservice	2018-03-26 16:19:08.822264+00
26	ANY_MAP	any_map type	deliveryservice	2018-03-26 16:19:08.826022+00
27	STEERING	Steering Delivery Service	deliveryservice	2018-03-26 16:19:08.830376+00
28	EDGE_LOC	Edge Cachegroup	cachegroup	2018-03-26 16:19:08.834317+00
29	HTTP	HTTP Content routing cache 	deliveryservice	2018-03-26 16:19:08.83815+00
30	MID	Mid Tier Cache	server	2018-03-26 16:19:08.84207+00
1	testType1	Host header regular expression	regex	2018-03-26 16:19:08.848239+00
\.


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 259
-- Name: type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('type_id_seq', 30, true);


--
-- TOC entry 2869 (class 0 OID 17941)
-- Dependencies: 260
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_role (user_id, role_id, last_updated) FROM stdin;
\.


--
-- TOC entry 2398 (class 2606 OID 17977)
-- Name: api_capability api_capability_http_method_route_capability_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_capability
    ADD CONSTRAINT api_capability_http_method_route_capability_key UNIQUE (http_method, route, capability);


--
-- TOC entry 2400 (class 2606 OID 17979)
-- Name: api_capability api_capability_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_capability
    ADD CONSTRAINT api_capability_pkey PRIMARY KEY (id);


--
-- TOC entry 2417 (class 2606 OID 17981)
-- Name: capability capability_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY capability
    ADD CONSTRAINT capability_pkey PRIMARY KEY (name);


--
-- TOC entry 2419 (class 2606 OID 17983)
-- Name: cdn cdn_domain_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cdn
    ADD CONSTRAINT cdn_domain_name_unique UNIQUE (domain_name);


--
-- TOC entry 2435 (class 2606 OID 17985)
-- Name: deliveryservice_request deliveryservice_request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_request
    ADD CONSTRAINT deliveryservice_request_pkey PRIMARY KEY (id);


--
-- TOC entry 2464 (class 2606 OID 17987)
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- TOC entry 2404 (class 2606 OID 17989)
-- Name: asn idx_89468_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY asn
    ADD CONSTRAINT idx_89468_primary PRIMARY KEY (id, cachegroup);


--
-- TOC entry 2412 (class 2606 OID 17991)
-- Name: cachegroup idx_89476_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup
    ADD CONSTRAINT idx_89476_primary PRIMARY KEY (id, type);


--
-- TOC entry 2415 (class 2606 OID 17993)
-- Name: cachegroup_parameter idx_89484_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup_parameter
    ADD CONSTRAINT idx_89484_primary PRIMARY KEY (cachegroup, parameter);


--
-- TOC entry 2422 (class 2606 OID 17995)
-- Name: cdn idx_89491_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cdn
    ADD CONSTRAINT idx_89491_primary PRIMARY KEY (id);


--
-- TOC entry 2429 (class 2606 OID 17997)
-- Name: deliveryservice idx_89502_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice
    ADD CONSTRAINT idx_89502_primary PRIMARY KEY (id, type);


--
-- TOC entry 2433 (class 2606 OID 17999)
-- Name: deliveryservice_regex idx_89517_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_regex
    ADD CONSTRAINT idx_89517_primary PRIMARY KEY (deliveryservice, regex);


--
-- TOC entry 2438 (class 2606 OID 18001)
-- Name: deliveryservice_server idx_89521_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_server
    ADD CONSTRAINT idx_89521_primary PRIMARY KEY (deliveryservice, server);


--
-- TOC entry 2441 (class 2606 OID 18003)
-- Name: deliveryservice_tmuser idx_89525_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_tmuser
    ADD CONSTRAINT idx_89525_primary PRIMARY KEY (deliveryservice, tm_user_id);


--
-- TOC entry 2444 (class 2606 OID 18005)
-- Name: division idx_89531_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY division
    ADD CONSTRAINT idx_89531_primary PRIMARY KEY (id);


--
-- TOC entry 2446 (class 2606 OID 18007)
-- Name: federation idx_89541_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation
    ADD CONSTRAINT idx_89541_primary PRIMARY KEY (id);


--
-- TOC entry 2449 (class 2606 OID 18009)
-- Name: federation_deliveryservice idx_89549_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_deliveryservice
    ADD CONSTRAINT idx_89549_primary PRIMARY KEY (federation, deliveryservice);


--
-- TOC entry 2453 (class 2606 OID 18011)
-- Name: federation_federation_resolver idx_89553_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_federation_resolver
    ADD CONSTRAINT idx_89553_primary PRIMARY KEY (federation, federation_resolver);


--
-- TOC entry 2457 (class 2606 OID 18013)
-- Name: federation_resolver idx_89559_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_resolver
    ADD CONSTRAINT idx_89559_primary PRIMARY KEY (id);


--
-- TOC entry 2462 (class 2606 OID 18015)
-- Name: federation_tmuser idx_89567_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_tmuser
    ADD CONSTRAINT idx_89567_primary PRIMARY KEY (federation, tm_user);


--
-- TOC entry 2467 (class 2606 OID 18017)
-- Name: hwinfo idx_89583_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hwinfo
    ADD CONSTRAINT idx_89583_primary PRIMARY KEY (id);


--
-- TOC entry 2474 (class 2606 OID 18019)
-- Name: job idx_89593_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job
    ADD CONSTRAINT idx_89593_primary PRIMARY KEY (id);


--
-- TOC entry 2476 (class 2606 OID 18021)
-- Name: job_agent idx_89603_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_agent
    ADD CONSTRAINT idx_89603_primary PRIMARY KEY (id);


--
-- TOC entry 2482 (class 2606 OID 18023)
-- Name: job_result idx_89614_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_result
    ADD CONSTRAINT idx_89614_primary PRIMARY KEY (id);


--
-- TOC entry 2484 (class 2606 OID 18025)
-- Name: job_status idx_89624_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_status
    ADD CONSTRAINT idx_89624_primary PRIMARY KEY (id);


--
-- TOC entry 2490 (class 2606 OID 18027)
-- Name: log idx_89634_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY log
    ADD CONSTRAINT idx_89634_primary PRIMARY KEY (id, tm_user);


--
-- TOC entry 2493 (class 2606 OID 18029)
-- Name: parameter idx_89644_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT idx_89644_primary PRIMARY KEY (id);


--
-- TOC entry 2499 (class 2606 OID 18031)
-- Name: phys_location idx_89655_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY phys_location
    ADD CONSTRAINT idx_89655_primary PRIMARY KEY (id);


--
-- TOC entry 2504 (class 2606 OID 18033)
-- Name: profile idx_89665_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT idx_89665_primary PRIMARY KEY (id);


--
-- TOC entry 2508 (class 2606 OID 18035)
-- Name: profile_parameter idx_89673_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile_parameter
    ADD CONSTRAINT idx_89673_primary PRIMARY KEY (profile, parameter);


--
-- TOC entry 2511 (class 2606 OID 18037)
-- Name: regex idx_89679_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regex
    ADD CONSTRAINT idx_89679_primary PRIMARY KEY (id, type);


--
-- TOC entry 2516 (class 2606 OID 18039)
-- Name: region idx_89690_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY region
    ADD CONSTRAINT idx_89690_primary PRIMARY KEY (id);


--
-- TOC entry 2518 (class 2606 OID 18041)
-- Name: role idx_89700_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role
    ADD CONSTRAINT idx_89700_primary PRIMARY KEY (id);


--
-- TOC entry 2532 (class 2606 OID 18043)
-- Name: server idx_89709_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT idx_89709_primary PRIMARY KEY (id, cachegroup, type, status, profile);


--
-- TOC entry 2536 (class 2606 OID 18045)
-- Name: servercheck idx_89722_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY servercheck
    ADD CONSTRAINT idx_89722_primary PRIMARY KEY (id, server);


--
-- TOC entry 2546 (class 2606 OID 18047)
-- Name: staticdnsentry idx_89729_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staticdnsentry
    ADD CONSTRAINT idx_89729_primary PRIMARY KEY (id);


--
-- TOC entry 2548 (class 2606 OID 18049)
-- Name: stats_summary idx_89740_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stats_summary
    ADD CONSTRAINT idx_89740_primary PRIMARY KEY (id);


--
-- TOC entry 2550 (class 2606 OID 18051)
-- Name: status idx_89751_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY status
    ADD CONSTRAINT idx_89751_primary PRIMARY KEY (id);


--
-- TOC entry 2554 (class 2606 OID 18053)
-- Name: steering_target idx_89759_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY steering_target
    ADD CONSTRAINT idx_89759_primary PRIMARY KEY (deliveryservice, target);


--
-- TOC entry 2562 (class 2606 OID 18055)
-- Name: tm_user idx_89765_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tm_user
    ADD CONSTRAINT idx_89765_primary PRIMARY KEY (id);


--
-- TOC entry 2569 (class 2606 OID 18057)
-- Name: to_extension idx_89776_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY to_extension
    ADD CONSTRAINT idx_89776_primary PRIMARY KEY (id);


--
-- TOC entry 2571 (class 2606 OID 18059)
-- Name: type idx_89786_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY type
    ADD CONSTRAINT idx_89786_primary PRIMARY KEY (id);


--
-- TOC entry 2478 (class 2606 OID 18061)
-- Name: job_agent job_agent_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_agent
    ADD CONSTRAINT job_agent_name_unique UNIQUE (name);


--
-- TOC entry 2486 (class 2606 OID 18063)
-- Name: job_status job_status_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_status
    ADD CONSTRAINT job_status_name_unique UNIQUE (name);


--
-- TOC entry 2522 (class 2606 OID 18065)
-- Name: role_capability role_capability_role_id_cap_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_capability
    ADD CONSTRAINT role_capability_role_id_cap_name_key UNIQUE (role_id, cap_name);


--
-- TOC entry 2520 (class 2606 OID 18067)
-- Name: role role_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_unique UNIQUE (name);


--
-- TOC entry 2540 (class 2606 OID 18069)
-- Name: snapshot snapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshot
    ADD CONSTRAINT snapshot_pkey PRIMARY KEY (cdn);


--
-- TOC entry 2552 (class 2606 OID 18071)
-- Name: status status_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_name_unique UNIQUE (name);


--
-- TOC entry 2557 (class 2606 OID 18073)
-- Name: tenant tenant_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tenant
    ADD CONSTRAINT tenant_name_key UNIQUE (name);


--
-- TOC entry 2559 (class 2606 OID 18075)
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- TOC entry 2573 (class 2606 OID 18077)
-- Name: type type_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY type
    ADD CONSTRAINT type_name_unique UNIQUE (name);


--
-- TOC entry 2495 (class 2606 OID 18079)
-- Name: parameter unique_param; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT unique_param UNIQUE (name, config_file, value);


--
-- TOC entry 2501 (class 1259 OID 18080)
-- Name: idx_181818_fk_cdn1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_181818_fk_cdn1 ON public.profile USING btree (cdn);


--
-- TOC entry 2401 (class 1259 OID 18081)
-- Name: idx_89468_cr_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89468_cr_id_unique ON public.asn USING btree (id);


--
-- TOC entry 2402 (class 1259 OID 18082)
-- Name: idx_89468_fk_cran_cachegroup1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89468_fk_cran_cachegroup1 ON public.asn USING btree (cachegroup);


--
-- TOC entry 2405 (class 1259 OID 18083)
-- Name: idx_89476_cg_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89476_cg_name_unique ON public.cachegroup USING btree (name);


--
-- TOC entry 2406 (class 1259 OID 18084)
-- Name: idx_89476_cg_short_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89476_cg_short_unique ON public.cachegroup USING btree (short_name);


--
-- TOC entry 2407 (class 1259 OID 18085)
-- Name: idx_89476_fk_cg_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89476_fk_cg_1 ON public.cachegroup USING btree (parent_cachegroup_id);


--
-- TOC entry 2408 (class 1259 OID 18086)
-- Name: idx_89476_fk_cg_secondary; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89476_fk_cg_secondary ON public.cachegroup USING btree (secondary_parent_cachegroup_id);


--
-- TOC entry 2409 (class 1259 OID 18087)
-- Name: idx_89476_fk_cg_type1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89476_fk_cg_type1 ON public.cachegroup USING btree (type);


--
-- TOC entry 2410 (class 1259 OID 18088)
-- Name: idx_89476_lo_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89476_lo_id_unique ON public.cachegroup USING btree (id);


--
-- TOC entry 2413 (class 1259 OID 18089)
-- Name: idx_89484_fk_parameter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89484_fk_parameter ON public.cachegroup_parameter USING btree (parameter);


--
-- TOC entry 2420 (class 1259 OID 18090)
-- Name: idx_89491_cdn_cdn_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89491_cdn_cdn_unique ON public.cdn USING btree (name);


--
-- TOC entry 2423 (class 1259 OID 18091)
-- Name: idx_89502_ds_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89502_ds_id_unique ON public.deliveryservice USING btree (id);


--
-- TOC entry 2424 (class 1259 OID 18092)
-- Name: idx_89502_ds_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89502_ds_name_unique ON public.deliveryservice USING btree (xml_id);


--
-- TOC entry 2425 (class 1259 OID 18093)
-- Name: idx_89502_fk_cdn1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89502_fk_cdn1 ON public.deliveryservice USING btree (cdn_id);


--
-- TOC entry 2426 (class 1259 OID 18094)
-- Name: idx_89502_fk_deliveryservice_profile1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89502_fk_deliveryservice_profile1 ON public.deliveryservice USING btree (profile);


--
-- TOC entry 2427 (class 1259 OID 18095)
-- Name: idx_89502_fk_deliveryservice_type1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89502_fk_deliveryservice_type1 ON public.deliveryservice USING btree (type);


--
-- TOC entry 2431 (class 1259 OID 18096)
-- Name: idx_89517_fk_ds_to_regex_regex1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89517_fk_ds_to_regex_regex1 ON public.deliveryservice_regex USING btree (regex);


--
-- TOC entry 2436 (class 1259 OID 18097)
-- Name: idx_89521_fk_ds_to_cs_contentserver1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89521_fk_ds_to_cs_contentserver1 ON public.deliveryservice_server USING btree (server);


--
-- TOC entry 2439 (class 1259 OID 18098)
-- Name: idx_89525_fk_tm_userid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89525_fk_tm_userid ON public.deliveryservice_tmuser USING btree (tm_user_id);


--
-- TOC entry 2442 (class 1259 OID 18099)
-- Name: idx_89531_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89531_name_unique ON public.division USING btree (name);


--
-- TOC entry 2447 (class 1259 OID 18100)
-- Name: idx_89549_fk_fed_to_ds1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89549_fk_fed_to_ds1 ON public.federation_deliveryservice USING btree (deliveryservice);


--
-- TOC entry 2450 (class 1259 OID 18101)
-- Name: idx_89553_fk_federation_federation_resolver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89553_fk_federation_federation_resolver ON public.federation_federation_resolver USING btree (federation);


--
-- TOC entry 2451 (class 1259 OID 18102)
-- Name: idx_89553_fk_federation_resolver_to_fed1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89553_fk_federation_resolver_to_fed1 ON public.federation_federation_resolver USING btree (federation_resolver);


--
-- TOC entry 2454 (class 1259 OID 18103)
-- Name: idx_89559_federation_resolver_ip_address; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89559_federation_resolver_ip_address ON public.federation_resolver USING btree (ip_address);


--
-- TOC entry 2455 (class 1259 OID 18104)
-- Name: idx_89559_fk_federation_mapping_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89559_fk_federation_mapping_type ON public.federation_resolver USING btree (type);


--
-- TOC entry 2458 (class 1259 OID 18105)
-- Name: idx_89567_fk_federation_federation_resolver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89567_fk_federation_federation_resolver ON public.federation_tmuser USING btree (federation);


--
-- TOC entry 2459 (class 1259 OID 18106)
-- Name: idx_89567_fk_federation_tmuser_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89567_fk_federation_tmuser_role ON public.federation_tmuser USING btree (role);


--
-- TOC entry 2460 (class 1259 OID 18107)
-- Name: idx_89567_fk_federation_tmuser_tmuser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89567_fk_federation_tmuser_tmuser ON public.federation_tmuser USING btree (tm_user);


--
-- TOC entry 2465 (class 1259 OID 18108)
-- Name: idx_89583_fk_hwinfo1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89583_fk_hwinfo1 ON public.hwinfo USING btree (serverid);


--
-- TOC entry 2468 (class 1259 OID 18109)
-- Name: idx_89583_serverid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89583_serverid ON public.hwinfo USING btree (serverid, description);


--
-- TOC entry 2469 (class 1259 OID 18110)
-- Name: idx_89593_fk_job_agent_id1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89593_fk_job_agent_id1 ON public.job USING btree (agent);


--
-- TOC entry 2470 (class 1259 OID 18111)
-- Name: idx_89593_fk_job_deliveryservice1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89593_fk_job_deliveryservice1 ON public.job USING btree (job_deliveryservice);


--
-- TOC entry 2471 (class 1259 OID 18112)
-- Name: idx_89593_fk_job_status_id1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89593_fk_job_status_id1 ON public.job USING btree (status);


--
-- TOC entry 2472 (class 1259 OID 18113)
-- Name: idx_89593_fk_job_user_id1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89593_fk_job_user_id1 ON public.job USING btree (job_user);


--
-- TOC entry 2479 (class 1259 OID 18114)
-- Name: idx_89614_fk_agent_id1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89614_fk_agent_id1 ON public.job_result USING btree (agent);


--
-- TOC entry 2480 (class 1259 OID 18115)
-- Name: idx_89614_fk_job_id1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89614_fk_job_id1 ON public.job_result USING btree (job);


--
-- TOC entry 2487 (class 1259 OID 18116)
-- Name: idx_89634_fk_log_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89634_fk_log_1 ON public.log USING btree (tm_user);


--
-- TOC entry 2488 (class 1259 OID 18117)
-- Name: idx_89634_idx_last_updated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89634_idx_last_updated ON public.log USING btree (last_updated);


--
-- TOC entry 2491 (class 1259 OID 18118)
-- Name: idx_89644_parameter_name_value_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89644_parameter_name_value_idx ON public.parameter USING btree (name, value);


--
-- TOC entry 2496 (class 1259 OID 18119)
-- Name: idx_89655_fk_phys_location_region_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89655_fk_phys_location_region_idx ON public.phys_location USING btree (region);


--
-- TOC entry 2497 (class 1259 OID 18120)
-- Name: idx_89655_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89655_name_unique ON public.phys_location USING btree (name);


--
-- TOC entry 2500 (class 1259 OID 18121)
-- Name: idx_89655_short_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89655_short_name_unique ON public.phys_location USING btree (short_name);


--
-- TOC entry 2502 (class 1259 OID 18122)
-- Name: idx_89665_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89665_name_unique ON public.profile USING btree (name);


--
-- TOC entry 2505 (class 1259 OID 18123)
-- Name: idx_89673_fk_atsprofile_atsparameters_atsparameters1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89673_fk_atsprofile_atsparameters_atsparameters1 ON public.profile_parameter USING btree (parameter);


--
-- TOC entry 2506 (class 1259 OID 18124)
-- Name: idx_89673_fk_atsprofile_atsparameters_atsprofile1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89673_fk_atsprofile_atsparameters_atsprofile1 ON public.profile_parameter USING btree (profile);


--
-- TOC entry 2509 (class 1259 OID 18125)
-- Name: idx_89679_fk_regex_type1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89679_fk_regex_type1 ON public.regex USING btree (type);


--
-- TOC entry 2512 (class 1259 OID 18126)
-- Name: idx_89679_re_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89679_re_id_unique ON public.regex USING btree (id);


--
-- TOC entry 2513 (class 1259 OID 18127)
-- Name: idx_89690_fk_region_division1_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89690_fk_region_division1_idx ON public.region USING btree (division);


--
-- TOC entry 2514 (class 1259 OID 18128)
-- Name: idx_89690_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89690_name_unique ON public.region USING btree (name);


--
-- TOC entry 2523 (class 1259 OID 18129)
-- Name: idx_89709_fk_cdn2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89709_fk_cdn2 ON public.server USING btree (cdn_id);


--
-- TOC entry 2524 (class 1259 OID 18130)
-- Name: idx_89709_fk_contentserver_atsprofile1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89709_fk_contentserver_atsprofile1 ON public.server USING btree (profile);


--
-- TOC entry 2525 (class 1259 OID 18131)
-- Name: idx_89709_fk_contentserver_contentserverstatus1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89709_fk_contentserver_contentserverstatus1 ON public.server USING btree (status);


--
-- TOC entry 2526 (class 1259 OID 18132)
-- Name: idx_89709_fk_contentserver_contentservertype1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89709_fk_contentserver_contentservertype1 ON public.server USING btree (type);


--
-- TOC entry 2527 (class 1259 OID 18133)
-- Name: idx_89709_fk_contentserver_phys_location1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89709_fk_contentserver_phys_location1 ON public.server USING btree (phys_location);


--
-- TOC entry 2528 (class 1259 OID 18134)
-- Name: idx_89709_fk_server_cachegroup1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89709_fk_server_cachegroup1 ON public.server USING btree (cachegroup);


--
-- TOC entry 2529 (class 1259 OID 18135)
-- Name: idx_89709_ip6_profile; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89709_ip6_profile ON public.server USING btree (ip6_address, profile);


--
-- TOC entry 2530 (class 1259 OID 18136)
-- Name: idx_89709_ip_profile; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89709_ip_profile ON public.server USING btree (ip_address, profile);


--
-- TOC entry 2533 (class 1259 OID 18137)
-- Name: idx_89709_se_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89709_se_id_unique ON public.server USING btree (id);


--
-- TOC entry 2534 (class 1259 OID 18138)
-- Name: idx_89722_fk_serverstatus_server1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89722_fk_serverstatus_server1 ON public.servercheck USING btree (server);


--
-- TOC entry 2537 (class 1259 OID 18139)
-- Name: idx_89722_server; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89722_server ON public.servercheck USING btree (server);


--
-- TOC entry 2538 (class 1259 OID 18140)
-- Name: idx_89722_ses_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89722_ses_id_unique ON public.servercheck USING btree (id);


--
-- TOC entry 2541 (class 1259 OID 18141)
-- Name: idx_89729_combi_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89729_combi_unique ON public.staticdnsentry USING btree (host, address, deliveryservice, cachegroup);


--
-- TOC entry 2542 (class 1259 OID 18142)
-- Name: idx_89729_fk_staticdnsentry_cachegroup1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89729_fk_staticdnsentry_cachegroup1 ON public.staticdnsentry USING btree (cachegroup);


--
-- TOC entry 2543 (class 1259 OID 18143)
-- Name: idx_89729_fk_staticdnsentry_ds; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89729_fk_staticdnsentry_ds ON public.staticdnsentry USING btree (deliveryservice);


--
-- TOC entry 2544 (class 1259 OID 18144)
-- Name: idx_89729_fk_staticdnsentry_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89729_fk_staticdnsentry_type ON public.staticdnsentry USING btree (type);


--
-- TOC entry 2560 (class 1259 OID 18145)
-- Name: idx_89765_fk_user_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89765_fk_user_1 ON public.tm_user USING btree (role);


--
-- TOC entry 2563 (class 1259 OID 18146)
-- Name: idx_89765_tmuser_email_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89765_tmuser_email_unique ON public.tm_user USING btree (email);


--
-- TOC entry 2564 (class 1259 OID 18147)
-- Name: idx_89765_username_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89765_username_unique ON public.tm_user USING btree (username);


--
-- TOC entry 2566 (class 1259 OID 18148)
-- Name: idx_89776_fk_ext_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_89776_fk_ext_type_idx ON public.to_extension USING btree (type);


--
-- TOC entry 2567 (class 1259 OID 18149)
-- Name: idx_89776_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_89776_id_unique ON public.to_extension USING btree (id);


--
-- TOC entry 2430 (class 1259 OID 18150)
-- Name: idx_k_deliveryservice_tenant_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_k_deliveryservice_tenant_idx ON public.deliveryservice USING btree (tenant_id);


--
-- TOC entry 2555 (class 1259 OID 18151)
-- Name: idx_k_tenant_parent_tenant_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_k_tenant_parent_tenant_idx ON public.tenant USING btree (parent_id);


--
-- TOC entry 2565 (class 1259 OID 18152)
-- Name: idx_k_tm_user_tenant_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_k_tm_user_tenant_idx ON public.tm_user USING btree (tenant_id);


--
-- TOC entry 2669 (class 2620 OID 18153)
-- Name: snapshot on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.snapshot FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2673 (class 2620 OID 18154)
-- Name: tenant on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.tenant FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2642 (class 2620 OID 18155)
-- Name: capability on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.capability FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2638 (class 2620 OID 18156)
-- Name: api_capability on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.api_capability FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2666 (class 2620 OID 18157)
-- Name: role_capability on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.role_capability FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2676 (class 2620 OID 18158)
-- Name: user_role on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.user_role FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2639 (class 2620 OID 18159)
-- Name: asn on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.asn FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2640 (class 2620 OID 18160)
-- Name: cachegroup on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.cachegroup FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2641 (class 2620 OID 18161)
-- Name: cachegroup_parameter on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.cachegroup_parameter FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2643 (class 2620 OID 18162)
-- Name: cdn on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.cdn FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2644 (class 2620 OID 18163)
-- Name: deliveryservice on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.deliveryservice FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2646 (class 2620 OID 18164)
-- Name: deliveryservice_server on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.deliveryservice_server FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2647 (class 2620 OID 18165)
-- Name: deliveryservice_tmuser on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.deliveryservice_tmuser FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2648 (class 2620 OID 18166)
-- Name: division on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.division FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2649 (class 2620 OID 18167)
-- Name: federation on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.federation FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2650 (class 2620 OID 18168)
-- Name: federation_deliveryservice on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.federation_deliveryservice FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2651 (class 2620 OID 18169)
-- Name: federation_federation_resolver on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.federation_federation_resolver FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2652 (class 2620 OID 18170)
-- Name: federation_resolver on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.federation_resolver FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2653 (class 2620 OID 18171)
-- Name: federation_tmuser on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.federation_tmuser FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2654 (class 2620 OID 18172)
-- Name: hwinfo on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.hwinfo FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2655 (class 2620 OID 18173)
-- Name: job on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.job FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2656 (class 2620 OID 18174)
-- Name: job_agent on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.job_agent FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2657 (class 2620 OID 18175)
-- Name: job_result on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.job_result FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2658 (class 2620 OID 18176)
-- Name: job_status on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.job_status FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2659 (class 2620 OID 18177)
-- Name: log on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.log FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2660 (class 2620 OID 18178)
-- Name: parameter on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.parameter FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2661 (class 2620 OID 18179)
-- Name: phys_location on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.phys_location FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2662 (class 2620 OID 18180)
-- Name: profile on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.profile FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2663 (class 2620 OID 18181)
-- Name: profile_parameter on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.profile_parameter FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2664 (class 2620 OID 18182)
-- Name: regex on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.regex FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2665 (class 2620 OID 18183)
-- Name: region on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.region FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2667 (class 2620 OID 18184)
-- Name: server on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.server FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2668 (class 2620 OID 18185)
-- Name: servercheck on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.servercheck FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2670 (class 2620 OID 18186)
-- Name: staticdnsentry on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.staticdnsentry FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2671 (class 2620 OID 18187)
-- Name: status on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.status FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2672 (class 2620 OID 18188)
-- Name: steering_target on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.steering_target FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2674 (class 2620 OID 18189)
-- Name: tm_user on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.tm_user FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2675 (class 2620 OID 18190)
-- Name: type on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.type FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2645 (class 2620 OID 18191)
-- Name: deliveryservice_request on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.deliveryservice_request FOR EACH ROW EXECUTE PROCEDURE on_update_current_timestamp_last_updated();


--
-- TOC entry 2607 (class 2606 OID 18192)
-- Name: job_result fk_agent_id1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_result
    ADD CONSTRAINT fk_agent_id1 FOREIGN KEY (agent) REFERENCES job_agent(id) ON DELETE CASCADE;


--
-- TOC entry 2587 (class 2606 OID 18197)
-- Name: deliveryservice_request fk_assignee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_request
    ADD CONSTRAINT fk_assignee FOREIGN KEY (assignee_id) REFERENCES tm_user(id) ON DELETE SET NULL;


--
-- TOC entry 2612 (class 2606 OID 18202)
-- Name: profile_parameter fk_atsprofile_atsparameters_atsparameters1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile_parameter
    ADD CONSTRAINT fk_atsprofile_atsparameters_atsparameters1 FOREIGN KEY (parameter) REFERENCES parameter(id) ON DELETE CASCADE;


--
-- TOC entry 2613 (class 2606 OID 18207)
-- Name: profile_parameter fk_atsprofile_atsparameters_atsprofile1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile_parameter
    ADD CONSTRAINT fk_atsprofile_atsparameters_atsprofile1 FOREIGN KEY (profile) REFERENCES profile(id) ON DELETE CASCADE;


--
-- TOC entry 2588 (class 2606 OID 18212)
-- Name: deliveryservice_request fk_author; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_request
    ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES tm_user(id) ON DELETE CASCADE;


--
-- TOC entry 2616 (class 2606 OID 18217)
-- Name: role_capability fk_cap_name; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_capability
    ADD CONSTRAINT fk_cap_name FOREIGN KEY (cap_name) REFERENCES capability(name) ON DELETE RESTRICT;


--
-- TOC entry 2574 (class 2606 OID 18222)
-- Name: api_capability fk_capability; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_capability
    ADD CONSTRAINT fk_capability FOREIGN KEY (capability) REFERENCES capability(name) ON DELETE RESTRICT;


--
-- TOC entry 2581 (class 2606 OID 18227)
-- Name: deliveryservice fk_cdn1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice
    ADD CONSTRAINT fk_cdn1 FOREIGN KEY (cdn_id) REFERENCES cdn(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2611 (class 2606 OID 18232)
-- Name: profile fk_cdn1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT fk_cdn1 FOREIGN KEY (cdn) REFERENCES cdn(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2618 (class 2606 OID 18237)
-- Name: server fk_cdn2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT fk_cdn2 FOREIGN KEY (cdn_id) REFERENCES cdn(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2576 (class 2606 OID 18242)
-- Name: cachegroup fk_cg_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup
    ADD CONSTRAINT fk_cg_1 FOREIGN KEY (parent_cachegroup_id) REFERENCES cachegroup(id);


--
-- TOC entry 2579 (class 2606 OID 18247)
-- Name: cachegroup_parameter fk_cg_param_cachegroup1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup_parameter
    ADD CONSTRAINT fk_cg_param_cachegroup1 FOREIGN KEY (cachegroup) REFERENCES cachegroup(id) ON DELETE CASCADE;


--
-- TOC entry 2577 (class 2606 OID 18252)
-- Name: cachegroup fk_cg_secondary; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup
    ADD CONSTRAINT fk_cg_secondary FOREIGN KEY (secondary_parent_cachegroup_id) REFERENCES cachegroup(id);


--
-- TOC entry 2578 (class 2606 OID 18257)
-- Name: cachegroup fk_cg_type1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup
    ADD CONSTRAINT fk_cg_type1 FOREIGN KEY (type) REFERENCES type(id);


--
-- TOC entry 2619 (class 2606 OID 18262)
-- Name: server fk_contentserver_atsprofile1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT fk_contentserver_atsprofile1 FOREIGN KEY (profile) REFERENCES profile(id);


--
-- TOC entry 2620 (class 2606 OID 18267)
-- Name: server fk_contentserver_contentserverstatus1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT fk_contentserver_contentserverstatus1 FOREIGN KEY (status) REFERENCES status(id);


--
-- TOC entry 2621 (class 2606 OID 18272)
-- Name: server fk_contentserver_contentservertype1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT fk_contentserver_contentservertype1 FOREIGN KEY (type) REFERENCES type(id);


--
-- TOC entry 2622 (class 2606 OID 18277)
-- Name: server fk_contentserver_phys_location1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT fk_contentserver_phys_location1 FOREIGN KEY (phys_location) REFERENCES phys_location(id);


--
-- TOC entry 2575 (class 2606 OID 18282)
-- Name: asn fk_cran_cachegroup1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY asn
    ADD CONSTRAINT fk_cran_cachegroup1 FOREIGN KEY (cachegroup) REFERENCES cachegroup(id);


--
-- TOC entry 2582 (class 2606 OID 18287)
-- Name: deliveryservice fk_deliveryservice_profile1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice
    ADD CONSTRAINT fk_deliveryservice_profile1 FOREIGN KEY (profile) REFERENCES profile(id);


--
-- TOC entry 2583 (class 2606 OID 18292)
-- Name: deliveryservice fk_deliveryservice_type1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice
    ADD CONSTRAINT fk_deliveryservice_type1 FOREIGN KEY (type) REFERENCES type(id);


--
-- TOC entry 2590 (class 2606 OID 18297)
-- Name: deliveryservice_server fk_ds_to_cs_contentserver1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_server
    ADD CONSTRAINT fk_ds_to_cs_contentserver1 FOREIGN KEY (server) REFERENCES server(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2591 (class 2606 OID 18302)
-- Name: deliveryservice_server fk_ds_to_cs_deliveryservice1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_server
    ADD CONSTRAINT fk_ds_to_cs_deliveryservice1 FOREIGN KEY (deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2585 (class 2606 OID 18307)
-- Name: deliveryservice_regex fk_ds_to_regex_deliveryservice1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_regex
    ADD CONSTRAINT fk_ds_to_regex_deliveryservice1 FOREIGN KEY (deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2586 (class 2606 OID 18312)
-- Name: deliveryservice_regex fk_ds_to_regex_regex1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_regex
    ADD CONSTRAINT fk_ds_to_regex_regex1 FOREIGN KEY (regex) REFERENCES regex(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2635 (class 2606 OID 18317)
-- Name: to_extension fk_ext_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY to_extension
    ADD CONSTRAINT fk_ext_type FOREIGN KEY (type) REFERENCES type(id);


--
-- TOC entry 2596 (class 2606 OID 18322)
-- Name: federation_federation_resolver fk_federation_federation_resolver1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_federation_resolver
    ADD CONSTRAINT fk_federation_federation_resolver1 FOREIGN KEY (federation) REFERENCES federation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2598 (class 2606 OID 18327)
-- Name: federation_resolver fk_federation_mapping_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_resolver
    ADD CONSTRAINT fk_federation_mapping_type FOREIGN KEY (type) REFERENCES type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2597 (class 2606 OID 18332)
-- Name: federation_federation_resolver fk_federation_resolver_to_fed1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_federation_resolver
    ADD CONSTRAINT fk_federation_resolver_to_fed1 FOREIGN KEY (federation_resolver) REFERENCES federation_resolver(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2599 (class 2606 OID 18337)
-- Name: federation_tmuser fk_federation_tmuser_federation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_tmuser
    ADD CONSTRAINT fk_federation_tmuser_federation FOREIGN KEY (federation) REFERENCES federation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2600 (class 2606 OID 18342)
-- Name: federation_tmuser fk_federation_tmuser_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_tmuser
    ADD CONSTRAINT fk_federation_tmuser_role FOREIGN KEY (role) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2601 (class 2606 OID 18347)
-- Name: federation_tmuser fk_federation_tmuser_tmuser; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_tmuser
    ADD CONSTRAINT fk_federation_tmuser_tmuser FOREIGN KEY (tm_user) REFERENCES tm_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2594 (class 2606 OID 18352)
-- Name: federation_deliveryservice fk_federation_to_ds1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_deliveryservice
    ADD CONSTRAINT fk_federation_to_ds1 FOREIGN KEY (deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2595 (class 2606 OID 18357)
-- Name: federation_deliveryservice fk_federation_to_fed1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federation_deliveryservice
    ADD CONSTRAINT fk_federation_to_fed1 FOREIGN KEY (federation) REFERENCES federation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2602 (class 2606 OID 18362)
-- Name: hwinfo fk_hwinfo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hwinfo
    ADD CONSTRAINT fk_hwinfo1 FOREIGN KEY (serverid) REFERENCES server(id) ON DELETE CASCADE;


--
-- TOC entry 2603 (class 2606 OID 18367)
-- Name: job fk_job_agent_id1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job
    ADD CONSTRAINT fk_job_agent_id1 FOREIGN KEY (agent) REFERENCES job_agent(id) ON DELETE CASCADE;


--
-- TOC entry 2604 (class 2606 OID 18372)
-- Name: job fk_job_deliveryservice1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job
    ADD CONSTRAINT fk_job_deliveryservice1 FOREIGN KEY (job_deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2608 (class 2606 OID 18377)
-- Name: job_result fk_job_id1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_result
    ADD CONSTRAINT fk_job_id1 FOREIGN KEY (job) REFERENCES job(id) ON DELETE CASCADE;


--
-- TOC entry 2605 (class 2606 OID 18382)
-- Name: job fk_job_status_id1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job
    ADD CONSTRAINT fk_job_status_id1 FOREIGN KEY (status) REFERENCES job_status(id);


--
-- TOC entry 2606 (class 2606 OID 18387)
-- Name: job fk_job_user_id1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY job
    ADD CONSTRAINT fk_job_user_id1 FOREIGN KEY (job_user) REFERENCES tm_user(id);


--
-- TOC entry 2589 (class 2606 OID 18392)
-- Name: deliveryservice_request fk_last_edited_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_request
    ADD CONSTRAINT fk_last_edited_by FOREIGN KEY (last_edited_by_id) REFERENCES tm_user(id) ON DELETE CASCADE;


--
-- TOC entry 2609 (class 2606 OID 18397)
-- Name: log fk_log_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY log
    ADD CONSTRAINT fk_log_1 FOREIGN KEY (tm_user) REFERENCES tm_user(id);


--
-- TOC entry 2580 (class 2606 OID 18402)
-- Name: cachegroup_parameter fk_parameter; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cachegroup_parameter
    ADD CONSTRAINT fk_parameter FOREIGN KEY (parameter) REFERENCES parameter(id) ON DELETE CASCADE;


--
-- TOC entry 2632 (class 2606 OID 18407)
-- Name: tenant fk_parentid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tenant
    ADD CONSTRAINT fk_parentid FOREIGN KEY (parent_id) REFERENCES tenant(id);


--
-- TOC entry 2610 (class 2606 OID 18412)
-- Name: phys_location fk_phys_location_region; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY phys_location
    ADD CONSTRAINT fk_phys_location_region FOREIGN KEY (region) REFERENCES region(id);


--
-- TOC entry 2614 (class 2606 OID 18417)
-- Name: regex fk_regex_type1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regex
    ADD CONSTRAINT fk_regex_type1 FOREIGN KEY (type) REFERENCES type(id);


--
-- TOC entry 2615 (class 2606 OID 18422)
-- Name: region fk_region_division1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY region
    ADD CONSTRAINT fk_region_division1 FOREIGN KEY (division) REFERENCES division(id);


--
-- TOC entry 2617 (class 2606 OID 18427)
-- Name: role_capability fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_capability
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE;


--
-- TOC entry 2636 (class 2606 OID 18432)
-- Name: user_role fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE RESTRICT;


--
-- TOC entry 2623 (class 2606 OID 18437)
-- Name: server fk_server_cachegroup1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY server
    ADD CONSTRAINT fk_server_cachegroup1 FOREIGN KEY (cachegroup) REFERENCES cachegroup(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2624 (class 2606 OID 18442)
-- Name: servercheck fk_serverstatus_server1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY servercheck
    ADD CONSTRAINT fk_serverstatus_server1 FOREIGN KEY (server) REFERENCES server(id) ON DELETE CASCADE;


--
-- TOC entry 2626 (class 2606 OID 18447)
-- Name: staticdnsentry fk_staticdnsentry_cachegroup1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staticdnsentry
    ADD CONSTRAINT fk_staticdnsentry_cachegroup1 FOREIGN KEY (cachegroup) REFERENCES cachegroup(id);


--
-- TOC entry 2627 (class 2606 OID 18452)
-- Name: staticdnsentry fk_staticdnsentry_ds; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staticdnsentry
    ADD CONSTRAINT fk_staticdnsentry_ds FOREIGN KEY (deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2628 (class 2606 OID 18457)
-- Name: staticdnsentry fk_staticdnsentry_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY staticdnsentry
    ADD CONSTRAINT fk_staticdnsentry_type FOREIGN KEY (type) REFERENCES type(id);


--
-- TOC entry 2629 (class 2606 OID 18462)
-- Name: steering_target fk_steering_target_delivery_service; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY steering_target
    ADD CONSTRAINT fk_steering_target_delivery_service FOREIGN KEY (deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2630 (class 2606 OID 18467)
-- Name: steering_target fk_steering_target_target; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY steering_target
    ADD CONSTRAINT fk_steering_target_target FOREIGN KEY (target) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2633 (class 2606 OID 18472)
-- Name: tm_user fk_tenantid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tm_user
    ADD CONSTRAINT fk_tenantid FOREIGN KEY (tenant_id) REFERENCES tenant(id) MATCH FULL;


--
-- TOC entry 2584 (class 2606 OID 18477)
-- Name: deliveryservice fk_tenantid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice
    ADD CONSTRAINT fk_tenantid FOREIGN KEY (tenant_id) REFERENCES tenant(id) MATCH FULL;


--
-- TOC entry 2592 (class 2606 OID 18482)
-- Name: deliveryservice_tmuser fk_tm_user_ds; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_tmuser
    ADD CONSTRAINT fk_tm_user_ds FOREIGN KEY (deliveryservice) REFERENCES deliveryservice(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2593 (class 2606 OID 18487)
-- Name: deliveryservice_tmuser fk_tm_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveryservice_tmuser
    ADD CONSTRAINT fk_tm_user_id FOREIGN KEY (tm_user_id) REFERENCES tm_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2634 (class 2606 OID 18492)
-- Name: tm_user fk_user_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tm_user
    ADD CONSTRAINT fk_user_1 FOREIGN KEY (role) REFERENCES role(id) ON DELETE SET NULL;


--
-- TOC entry 2637 (class 2606 OID 18497)
-- Name: user_role fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES tm_user(id) ON DELETE CASCADE;


--
-- TOC entry 2625 (class 2606 OID 18502)
-- Name: snapshot snapshot_cdn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshot
    ADD CONSTRAINT snapshot_cdn_fkey FOREIGN KEY (cdn) REFERENCES cdn(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2631 (class 2606 OID 18507)
-- Name: steering_target steering_target_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY steering_target
    ADD CONSTRAINT steering_target_type_fkey FOREIGN KEY (type) REFERENCES type(id);


-- Completed on 2018-03-26 10:27:53 MDT

--
-- PostgreSQL database dump complete
--

