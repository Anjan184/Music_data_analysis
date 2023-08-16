Q.1 Who is the senior most employee based on job title?

->select concat(first_name,last_name) as Name from employee where
  title = "Senior General Manager";

Q.2 Which country have the most Invoices? 

  ->select count(*) as c,billing_country from invoice 
	group by billing_country
	order by c desc;

Q.3 What are top 3 values of total invoices?

  ->select total from invoice
	order by total desc limit 3

Q.4  Which city has the best customers? We would like to throw  promotional Music Festival in the city we made the most money. 
	  Write a query that returns one city that has highest sum of invoices totals.
	  Return both the city name and sum of all invoice totals.

  ->select sum(total) as invoice_totals,billing_city from invoice
	group by billing_city
	order by invoice_totals desc

Q.5 Who is the best customer? The customer who has spent the most money will be declared the best customer. 
	Write a query that returns the person who has spent the most money.
    
  ->select invoice.customer_id,customer.first_name,customer.last_name,sum(invoice.total) as total 
    from customer
    inner join invoice on customer.customer_id=invoice.customer_id
    group by customer.customer_id,customer.first_name,customer.last_name
    order by total desc
    limit 1
    
Q.6 Write a query in return the email,first_name,last_name and genre of all rock music listeners. 
     #Return your list ordered alphabetically by email starting with A.
     
   ->select email,first_name,last_name
     from customer
     join invoice on invoice.customer_id=customer.customer_id
     join invoice_line on invoice.invoice_id=invoice_line.invoice_id
     where track_id in(
			select track_id from track 
			join genre on track.genre_id=genre.genre_id
			where genre.name like 'Rock'
            )
	order by email;
    
Q.7 Lets invite the artists who have written the most rock music in our dataset. 
	Write a query that returns the Artist name and total track count of the top 10 rock bands
     
   ->select artist.artist_id,artist.name, count(artist.artist_id) as number_of_songs
     from artist
     join album on artist.artist_id=album.album_id
     join track on album.album_id=track.album_id
     join genre on track.genre_id=genre.genre_id
     where genre.name like 'Rock'
     group by artist.artist_id,artist.name 
     order by number_of_songs desc
     limit 10;
     
Q.8 Return all the track names that have a song length longer than the average song length. 
	Return the name and milliseconds for each track.
	Order by the song length with longest songs listed first.
    
    -> select name ,milliseconds from track 
       where milliseconds >(select avg(milliseconds) as m from track)
	   order by track.milliseconds  desc;
       
Q.9 Find how much amount spent by each customer on artists? Write a query to return customer name,artist name and total spent
		
	 select artist.artist_id,customer.first_name,customer.last_name,artist.name,sum(invoice_line.unit_price*invoice_line.quantity) as total_sales
     from customer
     join invoice on customer.customer_id=invoice.customer_id
     join invoice_line on invoice.invoice_id=invoice_line.invoice_id
     join track on invoice_line.track_id=track.track_id
     join album on track.album_id=album.album_id
     join artist on album.artist_id=artist.artist_id
     group by  artist.artist_id,customer.first_name,customer.last_name,artist.name
     order by total_sales desc
     