-- Weekly pings per responder, used in section 6 of one-pager-farlight-kip.md.
-- Run against rook-database. Data covers 29 Jun–6 Sep 2026.
SELECT responder,
       date_trunc('week', sent_at)::date AS week_start,
       COUNT(*) AS pings,
       COUNT(*) FILTER (WHERE outcome = 'missed') AS missed,
       COUNT(*) FILTER (WHERE outcome = 'taken') AS taken
FROM pings
WHERE responder IN ('Farlight', 'Meteor Mite', 'The Gale')
  AND sent_at >= '2026-08-03'
GROUP BY 1, 2
ORDER BY 1, 2;
