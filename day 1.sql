-- A) Basic Checks --
# 1) Show first 20 rows of loan table
select * from loan
limit 20;

# 2) Count total loans
select count(*)as Total_Loans
from loan;

# 3) Count distinct accounts in loan table
select count(Distinct account_id) as Distinct_Account_ID
from loan;

# 4) Check min / max loan amount
select 
	min(amount) as Min_Amount,
	max(amount) as MAx_Amount
from loan;	

# 5) Check min / max duration
select 
	min(duration) as Min_Duration,
    max(duration) as Max_Duration
from loan;

# 6) Count loans by status
select 
	status, count(*) as Loan_Count
from loan
group by Status;

# 7) Find NULL count for each column (basic method)
select 
	sum(loan_id is null) as null_loan_id,
    sum(account_id is null) as null_account_id,
    sum(date is null) as null_date,
    sum(amount is null) as null_amount,
    sum(duration is null) as null_duration,
    sum(payments is null) as null_payments,
    sum(status is null) as null_status
from loan;

# 8) Check distinct status values
select distinct status 
from loan;

# 9) Count loans per account (top 10 accounts)
select account_id, count(*) as loan_counts
from loan
group by account_id
order by account_id
limit 10;

-- B) Filtering + Business Conditions --
# 9) Filter loans where amount > 100000
select * from loan
where amount > 100000;

# 10) Filter duration between 12 and 60
select * from loan
where duration between 12 and 60;

# 11) Filter status IN (‘A’, ‘B’, ‘C’, ‘D’)
select * from loan 
where status in ('A', 'B', 'C', 'D');

# 12) Count loans per status where duration > 36
select 
	Status, 
    count(*) as loan_count 
from loan
where duration > 36
group by status
order by loan_count;

# 13) Find default-rate-like count: status IN (‘B’,’D’)
-- count --
select 
	Status, 
    count(*) as loan_count 
from loan
where status in ('B', 'D')
group by status;

-- default rate --
select
	round(sum(status in  ('B', 'D')) / count(*) * 100,2) as default_rate_pct
from loan;
# 14) Identify accounts with more than 1 loan
select 
	account_id, 
    count(*) as total_loans
from loan 
group by account_id
having count(*) > 1;

# 15) Find loans after a specific date
select * from loan
where date >  930705;