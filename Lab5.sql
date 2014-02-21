--Name: Prudhvi Krishna Narra
--CWID:200 54 101
--Date:2/20/2014



--1. Get the cities of agents booking an order for customer “Basics”. This time use joins; no subqueries.

select a.city from agents a
join orders o
on o.aid=a.aid
join customers c
on c.cid=o.cid
where c.name='Basics'

--2. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use joins this time; no subqueries.

select distinct o1.pid from orders o
left join customers c
on o.cid=c.cid
join orders o1
on o.aid=o1.aid
where c.city='Kyoto' order by pid asc

--3. Get the names of customers who have never placed an order. Use a subquery.

select distinct name from Customers
where not cid in (
      select cid from Orders
      )

--4. Get the names of customers who have never placed an order. Use an outer join.

select name from customers c
left outer join orders o
           on o.cid=c.cid
           where o.cid is null

--5. Get the names of customers who placed at least one order through an agent in their city, along with those agent(s’) names.

select distinct c.name as cname, a.name as aname
from Customers c, Agents a, Orders o
where c.city = a.city 
and o.aid = a.aid
and o.cid = c.cid

--6. Get the names of customers and agents in the same city, along with the name of the city, regardless
--of whether or not the customer has ever placed an order with that agent.

select c.name as cname,a.name as aname
from customers c,agents a
where c.city=a.city

--7. Get the name and city of customers who live in the city where the least number of products are made.

select distinct c.name, c.city 
from customers c
where c.city in ( select city 
                  from products
		  group by city
		  order by count(quantity)
		  limit 1 ) ;
