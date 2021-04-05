/************************
 * 
 * Assignment 4
 * Meag Tessmann
 * u1120583
 * IS 6420 Database Design and Theory
 * Submitted march 21, 2021
 *
 *************************/


-- 1: Create a query that uses a CASE statement and gets the following columns: order_id, num_items   (number of items in the order), num_desks   (number of desks in the order)

SELECT ol.order_id, sum(ol.quantity) num_items, sum(
	CASE 
		WHEN ol.product_id = 104 THEN ol.quantity
		ELSE 0
		end 
		) num_desks
FROM order_line ol
group by ol.order_id
order by num_desks desc 
;


-- 2: Create a query that uses a Common Table Expression (CTE) and a Window Function to get the following columns: state_province, last_customer_name    (name of customer that placed an order most recently)


/*
 WITH 
latest_customer_cte as (
	select distinct state_province, order_date, max(order_date) over() last_order_date, customer_name
	from order_header oh 
	inner join customer c2 
	using (customer_id)
	where order_date is not null
	order by order_date desc
	)
select state_province, customer_name 
from latest_customer_cte
where order_date = last_order_date
;
*/
	
------ NOTE ------
-- choose to go with abbreviations since there were more of them. 


WITH 
state_customers_cte as (
	select distinct state_province, order_date, max(order_date) over(partition by state_province) last_order_date, customer_name
	from order_header oh 
	inner join customer c2 
	using (customer_id)
	where order_date is not null
	order by state_province desc
	)
select state_province, customer_name as last_customer_name
from state_customers_cte
where order_date = last_order_date
and length(state_province) <3
order by state_province 
;



/* public State GetStateByName(string name)
        {
            switch (name.ToUpper())
            {
                case "ALABAMA":
                    return State.AL;

                case "ALASKA":
                    return State.AK;

                case "AMERICAN SAMOA":
                    return State.AS;

                case "ARIZONA":
                    return State.AZ;

                case "ARKANSAS":
                    return State.AR;

                case "CALIFORNIA":
                    return State.CA;

                case "COLORADO":
                    return State.CO;

                case "CONNECTICUT":
                    return State.CT;

                case "DELAWARE":
                    return State.DE;

                case "DISTRICT OF COLUMBIA":
                    return State.DC;

                case "FEDERATED STATES OF MICRONESIA":
                    return State.FM;

                case "FLORIDA":
                    return State.FL;

                case "GEORGIA":
                    return State.GA;

                case "GUAM":
                    return State.GU;

                case "HAWAII":
                    return State.HI;

                case "IDAHO":
                    return State.ID;

                case "ILLINOIS":
                    return State.IL;

                case "INDIANA":
                    return State.IN;

                case "IOWA":
                    return State.IA;

                case "KANSAS":
                    return State.KS;

                case "KENTUCKY":
                    return State.KY;

                case "LOUISIANA":
                    return State.LA;

                case "MAINE":
                    return State.ME;

                case "MARSHALL ISLANDS":
                    return State.MH;

                case "MARYLAND":
                    return State.MD;

                case "MASSACHUSETTS":
                    return State.MA;

                case "MICHIGAN":
                    return State.MI;

                case "MINNESOTA":
                    return State.MN;

                case "MISSISSIPPI":
                    return State.MS;

                case "MISSOURI":
                    return State.MO;

                case "MONTANA":
                    return State.MT;

                case "NEBRASKA":
                    return State.NE;

                case "NEVADA":
                    return State.NV;

                case "NEW HAMPSHIRE":
                    return State.NH;

                case "NEW JERSEY":
                    return State.NJ;

                case "NEW MEXICO":
                    return State.NM;

                case "NEW YORK":
                    return State.NY;

                case "NORTH CAROLINA":
                    return State.NC;

                case "NORTH DAKOTA":
                    return State.ND;

                case "NORTHERN MARIANA ISLANDS":
                    return State.MP;

                case "OHIO":
                    return State.OH;

                case "OKLAHOMA":
                    return State.OK;

                case "OREGON":
                    return State.OR;

                case "PALAU":
                    return State.PW;

                case "PENNSYLVANIA":
                    return State.PA;

                case "PUERTO RICO":
                    return State.PR;

                case "RHODE ISLAND":
                    return State.RI;

                case "SOUTH CAROLINA":
                    return State.SC;

                case "SOUTH DAKOTA":
                    return State.SD;

                case "TENNESSEE":
                    return State.TN;

                case "TEXAS":
                    return State.TX;

                case "UTAH":
                    return State.UT;

                case "VERMONT":
                    return State.VT;

                case "VIRGIN ISLANDS":
                    return State.VI;

                case "VIRGINIA":
                    return State.VA;

                case "WASHINGTON":
                    return State.WA;

                case "WEST VIRGINIA":
                    return State.WV;

                case "WISCONSIN":
                    return State.WI;

                case "WYOMING":
                    return State.WY;
            }

            throw new Exception("Not Available");
        }
        
 */





-- 3: Create the query from question #2 using a Temporary Table instead of a CTE.  Please include a DROP IF EXISTS statement prior to your statement that creates the Temporary Table.

DROP TABLE IF EXISTS latest_customer_temp;

CREATE TEMP TABLE latest_customer_temp AS
	select distinct state_province, order_date, max(order_date) over(partition by state_province) last_order_date, customer_name
	from order_header oh 
	inner join customer c2 
	using (customer_id)
	where order_date is not null
	order by state_province desc
;

select state_province, customer_name as last_customer_name
from latest_customer_temp
where order_date = last_order_date
and length(state_province) <3
order by state_province 
;

-- 4: Create the query from question #2 using a View instead of a CTE.   Please include a DROP IF EXISTS statement prior to your statement that creates the View.


drop view if exists latest_customer_cte_view;

CREATE VIEW latest_customer_cte_view AS
	select distinct state_province, order_date, max(order_date) over(partition by state_province) last_order_date, customer_name
	from order_header oh 
	inner join customer c2 
	using (customer_id)
	where order_date is not null
	order by state_province desc
;

select state_province, customer_name as last_customer_name
from latest_customer_cte_view
where order_date = last_order_date
and length(state_province) <3
order by state_province 
;


-- 5: Create a role named “product_administrator” with permissions to SELECT and INSERT records into the product table.   Create a user named “bob finance” who is a member of that role.  


drop role if exists product_administrator;
create role product_administrator;


create role bob_finance 
login 
password 'Abcd1234';


grant product_administrator to bob_finance;

grant select, insert on product to product_administrator;

-- revoke select on product from product_administrator;


























		