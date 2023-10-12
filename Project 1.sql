-- PROJECT 1 --
-- Question 1 --
CREATE SCHEMA ecommerce;

-- Question 2 --
-- users_data.csv file has been succesfully in ecommerce schema

-- Question 3 --
USE ecommerce;
DESC users_data;

-- Question 4 --
SELECT * FROM users_data LIMIT 100;

-- Question 5 --
SELECT COUNT(DISTINCT country) No_of_country,
COUNT(DISTINCT language) No_of_language FROM users_data;

-- Question 6 --
SELECT gender, SUM(socialNbFollowers) Sum_of_followers
FROM users_data GROUP BY gender;

-- Question 7 --
SELECT COUNT(hasProfilePicture) Users_with_profilePicture FROM users_data
WHERE hasProfilePicture = 'TRUE';
SELECT COUNT(hasAnyApp) Users_with_Application FROM users_data WHERE hasAnyApp = 'TRUE' ;
SELECT COUNT(hasAndroidApp) Users_with_Android FROM users_data WHERE hasAndroidApp = 'TRUE' ;
SELECT COUNT(hasIosApp) Users_with_Ios FROM users_data WHERE hasIosApp = 'TRUE' ;

-- Question 8 --
SELECT DISTINCT(country),COUNT(productsBought) total_buyers FROM users_data 
WHERE productsBought != 0 GROUP BY country ORDER BY COUNT(productsBought) DESC;

-- Question 9 --
SELECT DISTINCT(country),COUNT(productsSold) total_sellers FROM users_data 
WHERE productsSold != 0 GROUP BY country ORDER BY COUNT(productsSold) ASC;

-- Question 10 -- 
SELECT DISTINCT country,MAX(productsPassRate) Max_productsPassRate FROM users_data 
GROUP BY country ORDER BY MAX(productsPassRate) DESC LIMIT 10;

-- Question 11 -- 
SELECT language, COUNT(language) no_of_users FROM users_data GROUP BY language;

-- Question 12 -- 

SELECT COUNT(productsWished) Choices FROM users_data WHERE gender = 'F' AND productsWished > 0 UNION
SELECT COUNT(socialProductsLiked) Choices FROM users_data WHERE gender = 'F' AND socialProductsLiked > 0;

-- Question 13 --
SELECT COUNT(productsBought) Choices FROM users_data WHERE gender = 'M' AND productsBought > 0 UNION 
SELECT COUNT(productsSold) Choices FROM users_data WHERE gender = 'M' AND productsSold > 0 ;

-- Question 14 --
SELECT country ,COUNT(productsBought) Max_no_of_buyers FROM users_data 
GROUP BY country ORDER BY COUNT(productsBought) DESC LIMIT 1;

-- Question 15 --
SELECT country FROM users_data WHERE productsSold = 0 
GROUP BY country  LIMIT 10; 

-- Question 16 --
SELECT * FROM users_data ORDER BY daysSinceLastLogin LIMIT 110;

-- Question 17 --
SELECT COUNT(gender) Female_user FROM users_Data WHERE daysSinceLastLogin > 100 AND gender = 'F';

-- Question 18 --
SELECT country,COUNT(gender) Female_user FROM users_data 
WHERE gender = 'F' AND hasAnyApp = 'TRUE' GROUP BY country;

-- Question 19 --
SELECT country,COUNT(gender) Male_user FROM users_data 
WHERE gender = 'M' AND hasAnyApp = 'TRUE' GROUP BY country;

-- Question 20 --
SELECT country,AVG(productsSold) Average_sold ,AVG(productsBought) Average_bought 
FROM users_data WHERE gender = 'M'GROUP BY country;