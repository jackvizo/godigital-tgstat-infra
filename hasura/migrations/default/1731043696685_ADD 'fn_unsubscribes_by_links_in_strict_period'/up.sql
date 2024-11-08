/*
CREATE TABLE IF NOT EXISTS public.fn_unsubscribes_by_links_in_strict_period (
    invite_link text NULL,
    joined_count int8 NULL,
    left_count int8 NULL
);
*/

CREATE OR REPLACE FUNCTION public.unsubscribes_by_links_in_strict_period(hasura_session json, start_date timestamp without time zone, end_date timestamp without time zone, tg_channel_ids bigint[], link_array text[])
 RETURNS SETOF fn_unsubscribes_by_links
 LANGUAGE plpgsql
 STABLE
 AS $function$
DECLARE
 x_hasura_user_id uuid;
BEGIN
 x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
 PERFORM
   public.check_user_access(x_hasura_user_id, tg_channel_ids);
 RETURN QUERY WITH link_prefixes AS (
   SELECT
   LEFT (unnest(link_array),
     22) AS link_prefix
),
filtered_users AS (
 SELECT
   tg_channel_id,
   invite_link,
   COUNT(
     CASE WHEN joined_at BETWEEN start_date AND end_date THEN
       1
     END) AS joined_count,
   COUNT(
     -- Доработка ниже
     CASE WHEN left_at BETWEEN start_date AND end_date AND joined_at BETWEEN start_date AND end_date THEN
       1
     END) AS left_count
 FROM
   stat_user,
   link_prefixes
 WHERE
   tg_channel_id = ANY (tg_channel_ids)
   AND
   LEFT (invite_link,
     22) = link_prefixes.link_prefix
 GROUP BY
   tg_channel_id,
   invite_link
)
SELECT
 f.invite_link,
 COALESCE(f.joined_count, 0) AS joined_count,
 COALESCE(f.left_count, 0) AS left_count
FROM
 filtered_users f
GROUP BY
 f.invite_link,
 f.joined_count,
 f.left_count;
END;
$function$