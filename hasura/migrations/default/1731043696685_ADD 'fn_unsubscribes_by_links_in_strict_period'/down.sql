-- DROP TABLE IF EXISTS public.fn_unsubscribes_by_links_in_strict_period CASCADE;
-- DROP TABLE IF EXISTS public.fn_unsubscribes_by_links CASCADE;

DROP FUNCTION IF EXISTS public.unsubscribes_by_links_in_strict_period(json, timestamp, timestamp, _int8, _text);