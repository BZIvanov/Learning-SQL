From the following 3 tables:

**reviewers**

| id  | first_name | last_name |
| --- | ---------- | --------- |
| 1   | Thomas     | Stoneman  |
| 2   | Wyatt      | Skaggs    |
| 3   | Kimbra     | Masters   |
| 4   | Domingo    | Cortes    |
| 5   | Colt       | Steele    |
| 6   | Pinkie     | Petit     |
| 7   | Marlon     | Crafford  |

**series**

| id  | title                 | released_year | genre     |
| --- | --------------------- | ------------- | --------- |
| 1   | Archer                | 2009          | Animation |
| 2   | Arrested Development  | 2003          | Comedy    |
| 3   | Bob's Burgers         | 2011          | Animation |
| 4   | Bojack Horseman       | 2014          | Animation |
| 5   | Breaking Bad          | 2008          | Drama     |
| 6   | Curb Your Enthusiasm  | 2000          | Comedy    |
| 7   | Fargo                 | 2014          | Drama     |
| 8   | Freaks and Geeks      | 1999          | Comedy    |
| 9   | General Hospital      | 1963          | Drama     |
| 10  | Halt and Catch Fire   | 2014          | Drama     |
| 11  | Malcolm In The Middle | 2000          | Comedy    |
| 12  | Pushing Daisies       | 2007          | Comedy    |
| 13  | Seinfeld              | 1989          | Comedy    |
| 14  | Stranger Things       | 2016          | Drama     |

**reviews**

| id  | rating | series_id | reviewer_id |
| --- | ------ | --------- | ----------- |
| 1   | 8.0    | 1         | 1           |
| 2   | 7.5    | 1         | 2           |
| 3   | 8.5    | 1         | 3           |
| 4   | 7.7    | 1         | 4           |
| 5   | 8.9    | 1         | 5           |
| 6   | 8.1    | 2         | 1           |
| 7   | 6.0    | 2         | 4           |
| 8   | 8.0    | 2         | 3           |
| 9   | 8.4    | 2         | 6           |
| 10  | 9.9    | 2         | 5           |
| 11  | 7.0    | 3         | 1           |
| 12  | 7.5    | 3         | 6           |
| 13  | 8.0    | 3         | 4           |
| 14  | 7.1    | 3         | 3           |
| 15  | 8.0    | 3         | 5           |
| 16  | 7.5    | 4         | 1           |
| 17  | 7.8    | 4         | 3           |
| 18  | 8.3    | 4         | 4           |
| 19  | 7.6    | 4         | 2           |
| 20  | 8.5    | 4         | 5           |
| 21  | 9.5    | 5         | 1           |
| 22  | 9.0    | 5         | 3           |
| 23  | 9.1    | 5         | 4           |
| 24  | 9.3    | 5         | 2           |
| 25  | 9.9    | 5         | 5           |
| 26  | 6.5    | 6         | 2           |
| 27  | 7.8    | 6         | 3           |
| 28  | 8.8    | 6         | 4           |
| 29  | 8.4    | 6         | 2           |
| 30  | 9.1    | 6         | 5           |
| 31  | 9.1    | 7         | 2           |
| 32  | 9.7    | 7         | 5           |
| 33  | 8.5    | 8         | 4           |
| 34  | 7.8    | 8         | 2           |
| 35  | 8.8    | 8         | 6           |
| 36  | 9.3    | 8         | 5           |
| 37  | 5.5    | 9         | 2           |
| 38  | 6.8    | 9         | 3           |
| 39  | 5.8    | 9         | 4           |
| 40  | 4.3    | 9         | 6           |
| 41  | 4.5    | 9         | 5           |
| 42  | 9.9    | 10        | 5           |
| 43  | 8.0    | 13        | 3           |
| 44  | 7.2    | 13        | 4           |
| 45  | 8.5    | 14        | 2           |
| 46  | 8.9    | 14        | 3           |
| 47  | 8.9    | 14        | 4           |

_Use the setup.sql file to create the tables._

complete the following tasks:

1. Ratings for each serie.

_Only first 10 results are shown_

| title                | rating |
| -------------------- | ------ |
| Archer               | 8.0    |
| Archer               | 7.5    |
| Archer               | 8.5    |
| Archer               | 7.7    |
| Archer               | 8.9    |
| Arrested Development | 8.1    |
| Arrested Development | 6.0    |
| Arrested Development | 8.0    |
| Arrested Development | 8.4    |
| Arrested Development | 9.9    |

2. Average rating for each serie.

| title                | avg_rating |
| -------------------- | ---------- |
| General Hospital     | 5.38       |
| Bob's Burgers        | 7.52       |
| Seinfeld             | 7.60       |
| Bojack Horseman      | 7.94       |
| Arrested Development | 8.08       |
| Archer               | 8.12       |
| Curb Your Enthusiasm | 8.12       |
| Freaks and Geeks     | 8.60       |
| Stranger Things      | 8.77       |
| Breaking Bad         | 9.36       |
| Fargo                | 9.40       |
| Halt and Catch Fire  | 9.90       |

3. Unrated series.

| unreviewed_series     |
| --------------------- |
| Malcolm In The Middle |
| Pushing Daisies       |

4. Statistics

| first_name | last_name | count | min | max | avg_rating | status   |
| ---------- | --------- | ----- | --- | --- | ---------- | -------- |
| Thomas     | Stoneman  | 5     | 7.0 | 9.5 | 8.02       | ACTIVE   |
| Wyatt      | Skaggs    | 9     | 5.5 | 9.3 | 7.80       | ACTIVE   |
| Kimbra     | Masters   | 9     | 6.8 | 9.0 | 7.99       | ACTIVE   |
| Domingo    | Cortes    | 10    | 5.8 | 9.1 | 7.83       | ACTIVE   |
| Colt       | Steele    | 10    | 4.5 | 9.9 | 8.77       | ACTIVE   |
| Pinkie     | Petit     | 4     | 4.3 | 8.8 | 7.25       | ACTIVE   |
| Marlon     | Crafford  | 0     | 0.0 | 0.0 | 0.00       | INACTIVE |

5. Title for each reviewer with rating.

_Only first 10 results are shown_

| title                | rating | reviewer        |
| -------------------- | ------ | --------------- |
| Archer               | 8.0    | Thomas Stoneman |
| Archer               | 7.5    | Wyatt Skaggs    |
| Archer               | 8.5    | Kimbra Masters  |
| Archer               | 7.7    | Domingo Cortes  |
| Archer               | 8.9    | Colt Steele     |
| Arrested Development | 8.1    | Thomas Stoneman |
| Arrested Development | 6.0    | Domingo Cortes  |
| Arrested Development | 8.0    | Kimbra Masters  |
| Arrested Development | 8.4    | Pinkie Petit    |
| Arrested Development | 9.9    | Colt Steele     |
