CREATE OR REPLACE FUNCTION public.unsubscribes_by_links(hasura_session json, start_date timestamp without time zone, end_date timestamp without time zone, tg_channel_ids bigint[], link_array text[])
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
  RETURN QUERY WITH filtered_users AS (
    SELECT
      tg_channel_id,
      invite_link,
      COUNT(
        CASE WHEN joined_at BETWEEN start_date AND end_date THEN
          1
        END) AS joined_count,
      COUNT(
        CASE WHEN left_at BETWEEN start_date AND end_date THEN
          1
        END) AS left_count
    FROM
      stat_user
    WHERE
      invite_link = ANY (link_array)
      AND tg_channel_id = ANY (tg_channel_ids)
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
  WHERE
    tg_channel_id = ANY (tg_channel_ids)
    AND f.invite_link = ANY (link_array)
  GROUP BY
    f.invite_link,
    f.joined_count,
    f.left_count;
END;
$function$;
