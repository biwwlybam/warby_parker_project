SELECT
   question,
   COUNT(user_id) AS ‘completed’,
   100.0 * COUNT(user_id) / LAG(COUNT(user_id, 1, 500) OVER () AS ‘% completed’
FROM
   survey
GROUP BY
   question;

--

WITH funnels AS (SELECT
  DISTINCT q.user_id,
  hto.user_id IS NOT NULL AS 'is_home_try_on',
  hto.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'
FROM
  quiz AS 'q'
LEFT JOIN
  home_try_on AS 'hto'
ON q.user_id = hto.user_id
LEFT JOIN
  purchase AS 'p'
ON p.user_id = q.user_id)

SELECT
  COUNT(number_of_pairs),
  SUM(is_purchase)
FROM funnels
WHERE number_of_pairs = '3 pairs';
