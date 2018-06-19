Question 1
SELECT utm_source, utm_campaign, 
COUNT(utm_campaign) AS 'visits attributed' 
FROM page_visits 
GROUP BY utm_campaign;

Question 2
SELECT DISTINCT page_name 
FROM page_visits;

Question 3
WITH first_touch AS (
SELECT user_id,
MIN(timestamp) as first_touch_at
FROM page_visits
GROUP BY user_id)
SELECT pv.utm_source as 'Source',
pv.utm_campaign as 'Campaign',
count(ft.user_id) as 'First Touches'   
FROM first_touch ft
JOIN page_visits pv
ON ft.user_id = pv.user_id
AND ft.first_touch_at = pv.timestamp
group by pv.utm_campaign;

Question 4
WITH last_touch AS (
SELECT user_id,
Max(timestamp) as last_touch_at
FROM page_visits
GROUP BY user_id)
SELECT pv.utm_source as 'Source',
pv.utm_campaign as 'Campaign',
count(lt.user_id) as 'Last Touches'   
FROM last_touch lt
JOIN page_visits pv
ON lt.user_id = pv.user_id
AND lt.last_touch_at = pv.timestamp
group by pv.utm_campaign;

Question 5
SELECT COUNT (DISTINCT (user_id)) AS 'Unique Purchases'
FROM page_visits 
WHERE page_name = '4 - purchase';

Question 6
WITH last_touch AS (
SELECT user_id,
Max(timestamp) as last_touch_at
FROM page_visits
GROUP BY user_id)
SELECT pv.utm_source as 'Source',
pv.utm_campaign as 'Campaign',
count(lt.user_id) as 'Purchases'   
FROM last_touch lt
JOIN page_visits pv
ON lt.user_id = pv.user_id
AND lt.last_touch_at = pv.timestamp
where pv.page_name is '4 - purchase'
group by pv.utm_campaign;