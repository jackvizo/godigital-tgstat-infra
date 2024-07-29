CREATE OR REPLACE FUNCTION public.check_user_access(x_hasura_user_id uuid, tg_channel_ids bigint[])
  RETURNS void
  LANGUAGE plpgsql
  AS $function$
DECLARE
  count_channels int;
BEGIN
  -- Проверяем количество каналов, доступных пользователю
  SELECT
    COUNT(*) INTO count_channels
  FROM
    user_tg_channel utgc
  WHERE
    utgc.user_id = x_hasura_user_id
    AND utgc.tg_channel_id = ANY (tg_channel_ids);
  -- Если количество найденных каналов не соответствует количеству переданных ID, выбрасываем исключение
  IF count_channels <> array_length(tg_channel_ids, 1) THEN
    RAISE EXCEPTION 'User % does not have access to all provided tg_channel_ids', x_hasura_user_id;
  END IF;
END;
$function$;

CREATE TABLE IF NOT EXISTS fn_users_by_period(
  time_bucket timestamp,
  count bigint
);

CREATE OR REPLACE FUNCTION public.user_signups_by_period(hasura_session json, start_date timestamp without time zone, end_date timestamp without time zone, tg_channel_ids bigint[], time_period text, tg_invite_links text[] DEFAULT NULL)
  RETURNS SETOF fn_users_by_period
  LANGUAGE plpgsql
  STABLE
  AS $function$
DECLARE
  x_hasura_user_id uuid;
BEGIN
  x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
  PERFORM
    public.check_user_access(x_hasura_user_id, tg_channel_ids);
  RETURN QUERY
  SELECT
    DATE_TRUNC(
      CASE WHEN time_period = 'hour' THEN
        'hour'
      WHEN time_period = 'day' THEN
        'day'
      WHEN time_period = 'month' THEN
        'month'
      ELSE
        'hour' -- default to 'hour' if an invalid value is provided
      END, joined_at)::timestamp(6) WITHOUT time zone AS time_bucket,
    COUNT(*) AS signup_count
  FROM
    stat_user
  WHERE
    tg_channel_id = ANY (tg_channel_ids)
    AND joined_at IS NOT NULL
    AND joined_at BETWEEN start_date AND end_date
    AND (tg_invite_links IS NULL
      OR invite_link = ANY (tg_invite_links))
  GROUP BY
    time_bucket
  ORDER BY
    time_bucket;
END;
$function$;

CREATE OR REPLACE FUNCTION public.user_unsubscribes_by_period(hasura_session json, start_date timestamp without time zone, end_date timestamp without time zone, tg_channel_ids bigint[], time_period text, tg_invite_links text[] DEFAULT NULL)
  RETURNS SETOF fn_users_by_period
  LANGUAGE plpgsql
  STABLE
  AS $function$
DECLARE
  x_hasura_user_id uuid;
BEGIN
  x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
  PERFORM
    public.check_user_access(x_hasura_user_id, tg_channel_ids);
  RETURN QUERY
  SELECT
    DATE_TRUNC(
      CASE WHEN time_period = 'hour' THEN
        'hour'
      WHEN time_period = 'day' THEN
        'day'
      WHEN time_period = 'month' THEN
        'month'
      ELSE
        'hour' -- default to 'hour' if an invalid value is provided
      END, left_at)::timestamp(6) WITHOUT time zone AS time_bucket,
    COUNT(*) AS count
  FROM
    stat_user
  WHERE
    tg_channel_id = ANY (tg_channel_ids)
    AND left_at IS NOT NULL
    AND left_at BETWEEN start_date AND end_date
    AND (tg_invite_links IS NULL
      OR invite_link = ANY (tg_invite_links))
  GROUP BY
    time_bucket
  ORDER BY
    time_bucket;
END;
$function$;

CREATE TABLE IF NOT EXISTS "public"."fn_unsubscribes_by_links"(
  "invite_link" text,
  "joined_count" int8,
  "left_count" int8
);

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

CREATE TABLE IF NOT EXISTS public.fn_unsubscribes_by_periods(
  interval_label text,
  count int,
  percentage float
);

CREATE OR REPLACE FUNCTION public.unsubscribes_by_periods(hasura_session json, start_date timestamp without time zone, end_date timestamp without time zone, tg_channel_ids bigint[])
  RETURNS SETOF fn_unsubscribes_by_periods
  LANGUAGE plpgsql
  STABLE
  AS $function$
DECLARE
  x_hasura_user_id uuid;
BEGIN
  x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
  PERFORM
    public.check_user_access(x_hasura_user_id, tg_channel_ids);
  RETURN QUERY WITH intervals AS (
    SELECT
      '0_TO_1_MIN' AS interval_label,
      0 AS interval_start,
      60 AS interval_end
    UNION ALL
    SELECT
      '1_MIN_TO_1_HOUR',
      60,
      3600
    UNION ALL
    SELECT
      '1_HOUR_TO_1_DAY',
      3600,
      86400
    UNION ALL
    SELECT
      '1_DAY_TO_3_DAYS',
      86400,
      259200
    UNION ALL
    SELECT
      '3_DAYS_TO_7_DAYS',
      259200,
      604800
    UNION ALL
    SELECT
      '1_WEEK_TO_2_WEEKS',
      604800,
      1209600
    UNION ALL
    SELECT
      '2_WEEKS_TO_1_MONTH',
      1209600,
      2592000
    UNION ALL
    SELECT
      '1_MONTH_TO_2_MONTHS',
      2592000,
      5184000
)
  SELECT
    i.interval_label,
    COUNT(su.tg_user_id)::integer AS count,
    ROUND((COUNT(su.tg_user_id) * 100.0 / NULLIF(SUM(COUNT(su.tg_user_id)) OVER (), 0)), 2)::double precision AS percentage
  FROM
    intervals i
  LEFT JOIN stat_user su ON EXTRACT(EPOCH FROM (su.left_at - su.joined_at)) BETWEEN i.interval_start AND i.interval_end
    AND su.tg_channel_id = ANY (tg_channel_ids)
    AND su.left_at >= start_date
    AND su.left_at <= end_date
GROUP BY
  i.interval_label,
  i.interval_start
ORDER BY
  count DESC;
END;
$function$;

CREATE TABLE IF NOT EXISTS "public"."fn_cohort_analysis"(
  "join_date" date,
  "left_date" date,
  "joined_count" int8,
  "left_count" int8
);

CREATE OR REPLACE FUNCTION public.cohort_analysis(hasura_session json, start_date date, end_date date, tg_channel_ids bigint[], time_bucket text)
  RETURNS SETOF fn_cohort_analysis
  LANGUAGE plpgsql
  STABLE
  AS $function$
DECLARE
  x_hasura_user_id uuid;
BEGIN
  x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
  PERFORM
    public.check_user_access(x_hasura_user_id, tg_channel_ids);
  RETURN QUERY WITH joined_users AS (
    SELECT
      CASE WHEN time_bucket = 'month' THEN
        date_trunc('month', joined_at)::date
      ELSE
        date_trunc('day', joined_at)::date
      END AS join_date,
      COUNT(DISTINCT tg_user_id)::bigint AS joined_count
    FROM
      stat_user
    WHERE
      joined_at IS NOT NULL
      AND stat_user.tg_channel_id = ANY (tg_channel_ids)
      AND joined_at BETWEEN start_date AND end_date
    GROUP BY
      CASE WHEN time_bucket = 'month' THEN
        date_trunc('month', joined_at)::date
      ELSE
        date_trunc('day', joined_at)::date
      END
),
left_users AS (
  SELECT
    CASE WHEN time_bucket = 'month' THEN
      date_trunc('month', left_at)::date
    ELSE
      date_trunc('day', left_at)::date
    END AS left_date,
    CASE WHEN time_bucket = 'month' THEN
      date_trunc('month', joined_at)::date
    ELSE
      date_trunc('day', joined_at)::date
    END AS join_date,
    COUNT(DISTINCT tg_user_id)::bigint AS left_count
  FROM
    stat_user
  WHERE
    left_at IS NOT NULL
    AND joined_at IS NOT NULL
    AND stat_user.tg_channel_id = ANY (tg_channel_ids)
    AND joined_at BETWEEN start_date AND end_date
    AND left_at BETWEEN start_date AND end_date
  GROUP BY
    CASE WHEN time_bucket = 'month' THEN
      date_trunc('month', left_at)::date
    ELSE
      date_trunc('day', left_at)::date
    END,
    CASE WHEN time_bucket = 'month' THEN
      date_trunc('month', joined_at)::date
    ELSE
      date_trunc('day', joined_at)::date
    END
),
all_dates AS (
  SELECT
    CASE WHEN time_bucket = 'month' THEN
      date_trunc('month', gs)::date
    ELSE
      gs::date
    END AS date
  FROM
    generate_series(start_date::timestamp, end_date::timestamp, '1 day'::interval) AS gs
  GROUP BY
    CASE WHEN time_bucket = 'month' THEN
      date_trunc('month', gs)::date
    ELSE
      gs::date
    END
),
cohort_analysis AS (
  SELECT
    j.join_date,
    d.date AS left_date,
    j.joined_count,
    COALESCE(l.left_count, 0) AS left_count
  FROM
    joined_users j
    CROSS JOIN all_dates d
    LEFT JOIN left_users l ON j.join_date = l.join_date
      AND d.date = l.left_date
  WHERE
    d.date >= j.join_date
  ORDER BY
    j.join_date,
    d.date
)
SELECT
  join_date::date,
  left_date::date,
  joined_count,
  left_count
FROM
  cohort_analysis
ORDER BY
  join_date,
  left_date;
END;
$function$;

CREATE TABLE IF NOT EXISTS fn_get_avg_user_lifecycle(
  avg_lifecycle_days double precision
);

CREATE OR REPLACE FUNCTION public.get_avg_user_lifecycle(hasura_session json, tg_channel_ids bigint[])
  RETURNS SETOF fn_get_avg_user_lifecycle
  LANGUAGE plpgsql
  STABLE
  AS $function$
DECLARE
  x_hasura_user_id uuid;
BEGIN
  x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
  PERFORM
    public.check_user_access(x_hasura_user_id, tg_channel_ids);
  x_hasura_user_id := hasura_session ->> 'x-hasura-user-id';
  RETURN QUERY
  SELECT
    CAST(AVG(EXTRACT(EPOCH FROM (left_at - joined_at))) / 86400 AS DOUBLE PRECISION) AS avg_lifecycle_days
  FROM
    stat_user
  WHERE
    tg_channel_id = ANY (tg_channel_ids)
    AND left_at IS NOT NULL;
END;
$function$;

