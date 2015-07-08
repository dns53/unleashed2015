-- View: public.council_contact_addresses

-- DROP VIEW public.council_contact_addresses;

CREATE OR REPLACE VIEW public.council_contact_addresses AS 
 SELECT x.council,
    concat(x.street, ' ', x.suburb_state) AS concat,
    x.postcode AS office_postcode,
    x.phone,
    x.website,
    x.email
   FROM council_contacts x,
    lga y
  WHERE btrim(lower(x.council)) = btrim(lower(y.lga::text));

ALTER TABLE public.council_contact_addresses
  OWNER TO govhack;
