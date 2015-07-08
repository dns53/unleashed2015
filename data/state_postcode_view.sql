-- View: public.postcode_and_state

-- DROP VIEW public.postcode_and_state;

CREATE OR REPLACE VIEW public.postcode_and_state AS 
 SELECT x.postcode,
    x.suburb,
    y.state
   FROM suburbs x,
    state_postcode_rules y
  WHERE x.postcode >= y.min AND x.postcode < y.max;

ALTER TABLE public.postcode_and_state
  OWNER TO govhack;
