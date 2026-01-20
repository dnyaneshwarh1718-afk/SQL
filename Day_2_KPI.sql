# 17) Total loan amount by status
select Status, sum(amount) As Total_loan_amount
from loan
group by Status;

# 18) Avg loan amount by status
select Status, round(avg(amount),2) As Avg_loan_amount
from loan
group by Status;

# 19) Avg duration by status
select Status,round(avg(duration),2) as Avg_Duration
from loan
group by Status;

# 20) Default rate % overall
select
	round(sum(status in  ('B', 'D')) / count(*) * 100,2) as default_rate_pct
from loan;

# 21) Default rate % by duration bucket (create bucket with CASE)
select
	case 
		when duration <= 12 then '01_<=12'
        when duration <= 24 then '02_13-24'
        when duration <= 12 then '03_25-36'
        when duration <= 12 then '04_37-48'
		else '05_49-60'
	end as duration_bucket,
    count(*) as total_sales,
    sum(status in('B','D')) as default_loan,
    round(sum(status in('B','D')) / count(*) *100,2) as default_rate_pct
from loan
group by duration_bucket;

# 22) Count accounts by status
select status, count(distinct account_id) as account_count
from loan 
group by status;

# 23) Top 10 districts by total loan amount (if district join exists)
select 
	d.A1 as district_id, 
    sum(l.amount) as total_loan_amount
from district d
join account a on a.district_id = d.a1
join loan l on a.account_id = l.account_id
group by d.a1
ORDER BY total_loan_amount DESC
limit 10;

# 24) Create loan amount bands using CASE
select
loan_id,
account_id,
amount,
	case
		when amount < 50000 then '< 50K'
        when amount < 100000 then '50k-99k'
        when amount < 200000 then '100k-199k'
        when amount < 300000 then '200k-299k'
        else '>=300k'
	end as amount_band
from loan;

# 25) Create duration bands using CASE
select 
	loan_id,
    duration,
	case
		when duration < 20 then '<20'
        when duration < 40 then '20-40'
        when duration <= 60 then '40-60'
        else '<60'
	end as duration_band
	from loan;

# 26) Create binary flag: is_default (1 if status in B,D else 0)
select 
	loan_id,
    Status,
	case
		when status in ('B','D') then 1 else 0
	end is_default
from loan;

# 27) Create binary flag: is_paid (1 if status in A,C else 0)
select
	loan_id,
    status,
    case
		when status in ('A','C') then 1 else 0
	end is_paid
from loan;

# 28) Calculate default rate by amount band
select
	case
		when amount < 50000 then '< 50K'
		when amount < 100000 then '50k-99k'
		when amount < 200000 then '100k-199k'
		when amount < 300000 then '200k-299k'
		else '>=300k'
	end as amount_band,
    count(*) as total_loans,
    sum(case when status in('B','D') then 1 else 0 end) as default_loans,
    round(sum(case when status in ('B','D') then 1 else 0 end) / count(*) *100,2) as default_rate_pct
from loan
group by amount_band;

# 29) Calculate default rate by duration band
select 
	case
		when duration < 20 then '<20'
        when duration < 40 then '20-40'
        when duration <= 60 then '40-60'
        else '<60'
	end as duration_band,
    
    COUNT(*) AS total_loans,
    SUM(CASE WHEN status IN ('B','D') THEN 1 ELSE 0 END) AS default_loans,
    
    ROUND(
        (SUM(CASE WHEN status IN ('B','D') THEN 1 ELSE 0 END) / COUNT(*)) * 100
    , 2) AS default_rate_pct

FROM loan
GROUP BY duration_band;
