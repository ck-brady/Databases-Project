
SELECT p.Account_ID, p.First_Name, p.Last_Name, h.Property_Type, a.Payment_Amount, 
       a.Payment_Type, a.Payment_Status, r.Signing_Date, b.Branch_Name
FROM Person p, Property h, Payment a, Rental_Agreement r, Branch b, Listing l, Guest g
WHERE p.Account_ID = g.Account_ID AND g.Guest_ID = r.Guest_ID AND 
      r.Listing_ID = l.Listing_ID AND l.Property_ID = h.Property_ID AND 
	  h.Branch_Name = b.Branch_Name AND r.RA_ID = a.RA_ID 
ORDER BY a.Payment_Type ASC, r.Signing_Date DESC



CREATE VIEW GuestListView AS
SELECT Account_ID, First_Name, Middle_Name, Last_Name, addr, Email_Address, Phone_Number
FROM Person 
WHERE EXISTS (SELECT    1
              FROM      Guest
              WHERE     Guest.Account_ID = Person.Account_ID)
ORDER BY Account_ID ASC;






SELECT p.Rental_Rate, h.* 
FROM Pricing p, Property h, Listing l, Rental_Agreement r
WHERE p.Property_ID = h.Property_ID AND h.Property_ID = l.Property_ID AND l.Listing_ID = r.Listing_ID 
ORDER BY p.Rental_Rate ASC
LIMIT 1






SELECT a.Listing_ID, b.Overall_Score
FROM Rental_Agreement a JOIN Reviews b ON a.RA_ID = b.RA_ID
ORDER BY Overall_Score ASC;






SELECT p.Property_ID
FROM Property p LEFT JOIN Listing l ON p.Property_ID = l.Property_ID
WHERE NOT EXIST (
	SELECT * 
	FROM Rental_Agreement r
	WHERE r.Listing_ID = l.Listing_ID
	)





SELECT * 
FROM Listing
WHERE EXISTS (SELECT 1
              FROM Rental_Agreement
              WHERE Rental_Agreement.RA_ID = Listing.RA_ID AND Rental_Agreement.Signing_Date = 10)





 

SELECT p.Account_ID, p.First_Name, p.Last_Name, 
      (SELECT m.Branch_Name FROM Manager m WHERE p.Account_ID = m.Manager_ID OR
	   (e.Manager = m.Manager_ID AND e.Account_ID = p.Account_ID)) AS ‘branch name’, 
	   e.Salary, m.Salary
FROM Manger m, Employee e, Person p, Branch b 
WHERE (m.Account_ID = p.Account_ID AND m.Salary > 15000) OR 
      (e.Account_ID = p.Account_ID AND e.Salary > 15000)
SORT BY m.Manager_ID






SELECT * 
FROM Pricing
WHERE EXISTS (SELECT 1
              FROM Property
              WHERE Property.Property_ID = Pricing.Property_ID
              and EXISTS (
                    SELECT 1
                    FROM Listing
                    WHERE Listing.Property_ID = Property.Property_ID
                    AND EXISTS (
                        SELECT 1
                        FROM Rental_Agreement
                        WHERE Listing.RA_ID = Rental_RA.Property_ID 
                        and EXISTS(
                            SELECT 1
                            FROM Rental_Agreement
                            WHERE Listing.Guest_ID = guest_name 
                        )
                    )
              )
              )




UPDATE (Person NATURAL JOIN Guest ON Account_ID)
SET Phone_Number = ‘555-555-5555’
WHERE Account_ID = ‘_____’






SELECT  
    FirstName, 
    MiddleName, 
    LastName,
    CONCAT(FirstName,' ',MiddleName,' ',LastName) as full_name
FROM Person
