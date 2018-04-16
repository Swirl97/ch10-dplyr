# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
library("dplyr")
library("nycflights13")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)
dim(flights)
colnames(flights)
??flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- flights %>% 
  mutate(time_gained = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- flights %>% 
  arrange(time_gained)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights<- mutate(flights, time_gained = arr_delay - dep_delay) %>% 
  arrange(time_gained)

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$time_gained)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$time_gained, na.rm = TRUE)
summarize(flights, mean = mean(time_gained, na.rm = TRUE))

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
to_sea <- flights %>% 
  filter(dest == "SEA") %>% 
  select(origin, dest, time_gained)

# On average, did flights to SeaTac gain or loose time?
summarize(to_sea, mean())

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk_sea <- flights %>% 
  filter(origin == "JFK", dest == "SEA") %>% 
  select(origin, dest, time_gained)

summary <- flights %>% 
  filter(origin == "JFK", dest == "SEA") %>% 
  summarise(
    #na.rm removing data that is not availiable
    avg_time = mean(time_gained, na.rm = T),
    min_time = min(time_gained, na.rm = T),
    max_time = max(time_gained, na.rm = T)
  )

flights %>% 
  group_by(origin) %>% 
  summarize(avg_delay = mean(dep_delay, na.rm = T))

flights %>% 
  group_by(dest) %>% 
  summarize(avg_arr_delay = mean(arr_delay, na.rm = T)) %>% 
  arrange(-avg_arr_delay)