import pandas as pd
from faker import Faker
import random

fake = Faker("en_IN")  # Use Indian locale for names and data
# Generate customers.csv
# num_customers = 60
# customers = []
# for i in range(1, num_customers + 1):
#     name = fake.name()
#     reg_date = fake.date_between(start_date="-2y", end_date="today")
#     customers.append([i, name, reg_date])
# customers_df = pd.DataFrame(
#     customers, columns=["customer_id", "customer_name", "reg_date"]
# )
# customers_df.to_csv("data/customers.csv", index=False)

# # Generate restaurants.csv
# restaurants = [
#     [1, "L7 Club & Lounge", "Koregaon Park", "11:00-23:30"],
#     [2, "The Game Palacio", "Dhole Patil Road", "11:00-22:00"],
#     [3, "FC Road Social", "Shivaji Nagar", "10:00-23:00"],
#     [4, "Plink", "Yerawada", "12:00-23:59"],
#     [5, "2BHK Diner & Key Club", "Bund Garden Road", "18:00-02:00"],
#     [6, "The Camden Lane", "Koregaon Park", "08:30-00:00"],
#     [7, "Foo KOPA", "Mundhwa", "11:30-22:30"],
#     [8, "OleOle - The Luxurious Club", "Baner", "12:30-03:00"],
#     [9, "Feast - Sheraton Grand", "Bund Garden Road", "06:30-10:00"],
#     [10, "Malaka Spice", "Koregaon Park", "11:00-23:00"],
# ]
# restaurants_df = pd.DataFrame(
#     restaurants, columns=["restaurant_id", "restaurant_name", "loc", "opening_hours"]
# )
# restaurants_df.to_csv("data/restaurants.csv", index=False)


# RESTAURANTS (90 entries)
# -----------------------------
# pune_localities = [
#     "Koregaon Park",
#     "Baner",
#     "Viman Nagar",
#     "Kothrud",
#     "Hinjewadi",
#     "Shivaji Nagar",
#     "Wakad",
#     "Hadapsar",
#     "Magarpatta",
#     "FC Road",
#     "Camp",
#     "Bavdhan",
#     "Mundhwa",
#     "Pashan",
#     "Yerawada",
#     "Nigdi",
#     "Dhanori",
#     "Pimpri",
#     "Sadashiv Peth",
#     "Bibwewadi",
#     "Kalyani Nagar"
# ]
# restaurant_names = [
#     "L7 Club & Lounge",
#     "The Game Palacio",
#     "FC Road Social",
#     "Plink",
#     "Aasmana",
#     "Baan Tao",
#     "Marz-O-Rin",
#     "Kayani Bakery",
#     "Blue Nile Restaurant",
#     "Cafe Goodluck",
#     "Wah! Marathi",
#     "Le Plaisir",
#     "Cobbler & Crew",
#     "The Sassy Spoon",
#     "SP's Biryani House Since 1994",
#     "Durvankur Dining Hall",
#     "Shizusan Viman Nagar",
#     "Elephant and Co.",
#     "George Restaurant",
#     "2BHK Diner & Key Club",
#     "The Camden Lane",
#     "Foo KOPA",
#     "OleOle - The Luxurious Club",
#     "Nawab Asia",
#     "Soy Como Soy",
#     "Juju - Mexican Tapas Bar",
#     "Wadeshwar",
#     "Ukiyo",
#     "Coriander Kitchen",
#     "The Great Punjab Koregaon Park",
#     "Feast - Sheraton Grand",
#     "Malaka Spice",
# ]
# # Add 80 more generated names
# for _ in range(80):
#     restaurant_names.append(fake.company() + " Restaurant")

# restaurants = []
# for i in range(1, 91):
#     name = restaurant_names[i - 1]
#     loc = random.choice(pune_localities)
#     opening_hours = f"{random.randint(7,12)}:00-{random.randint(20,23)}:{random.choice(['00','30'])}"
#     restaurants.append([i, name, loc, opening_hours])
# restaurants_df = pd.DataFrame(
#     restaurants, columns=["restaurant_id", "restaurant_name", "loc", "opening_hours"]
# )
# restaurants_df.to_csv("data/restaurants.csv", index=False)

# Generate riders.csv
# num_riders = 20
# riders = []
# for i in range(1, num_riders + 1):
#     name = fake.name()
#     # Generate a realistic mobile number starting with 7-9
#     first_digit = str(fake.random_element(elements=("9", "8", "7")))
#     mob = first_digit + "".join(str(fake.random_digit()) for _ in range(9))
#     sign_up = fake.date_between(start_date="-2y", end_date="today")
#     riders.append([i, name, mob, sign_up])
# riders_df = pd.DataFrame(
#     riders, columns=["rider_id", "rider_name", "mob_No", "sign_up"]
# )
# riders_df.to_csv("data/riders.csv", index=False)
# ---------------------------
# RIDERS (50 entries)
# -----------------------------
# num_riders = 50
# riders = []
# for i in range(1, num_riders+1):
#     name = fake.name()
#     mob = str(random.choice(['9','8','7'])) + ''.join([str(random.randint(0,9)) for _ in range(9)])
#     sign_up = fake.date_between(start_date='-2y', end_date='today')
#     riders.append([i, name, mob, sign_up])
# riders_df = pd.DataFrame(riders, columns=['rider_id','rider_name','mob_No','sign_up'])
# riders_df.to_csv("data/riders.csv", index=False)


# Possible order items and statuses
# items = [
#     "Margherita Pizza",
#     "Paneer Butter Masala",
#     "Chicken Biryani",
#     "Veg Burger",
#     "Masala Dosa",
#     "Spaghetti Pasta",
#     "Caesar Salad",
#     "Chicken Tikka",
#     "Sushi Roll",
#     "Chocolate Cake",
#     "Coffee",
#     "Mutton Curry",
#     "Noodles",
#     "Ice Cream Sundae",
#     "Quattro Formaggi Pizza",
#     "Malai Kofta",
#     "Chicken Pulao",
#     "Paneer Tikka Sandwich",
#     "Onion Uttapam",
#     "Penne in Arrabbiata Sauce",
#     "Greek Salad",
#     "Mutton Seekh Kebab",
#     "Shrimp Tempura",
#     "Red Velvet Cake",
#     "Masala Chai",
#     "Rogan Josh",
#     "Schezwan Fried Rice",
#     "Sizzling Brownie with Ice Cream"
# ]
# statuses = ["Delivered", "Cancelled", "In Transit", "Preparing"]

# # Load or define restaurants before generating orders
# import os

# restaurants = []
# restaurants_csv_path = "data/restaurants.csv"
# if os.path.exists(restaurants_csv_path):
#     restaurants_df = pd.read_csv(restaurants_csv_path)
#     restaurants = restaurants_df.values.tolist()
# else:
#     # Fallback: create dummy restaurants if CSV doesn't exist
#     for i in range(1, 11):
#         restaurants.append([i, f"Restaurant {i}", "Unknown", "10:00-22:00"])

# # Define the number of customers (should match your customers.csv if generated)
# num_customers = 60

# orders = []
# order_id = 1
# for _ in range(150):
#     cust_id = random.randint(1, num_customers)
#     rest_id = random.randint(1, len(restaurants))
#     item = random.choice(items)
#     order_dt = fake.date_time_between(start_date="-1y", end_date="now")
#     status = random.choices(statuses, weights=[0.7, 0.1, 0.1, 0.1])[0]
#     amount = round(random.uniform(50, 2000), 2)  # rupees
#     orders.append([order_id, cust_id, rest_id, item, order_dt, status, amount])
#     order_id += 1

# orders_df = pd.DataFrame(
#     orders,
#     columns=[
#         "order_id",
#         "customer_id",
#         "restaurant_id",
#         "order_item",
#         "order_date",
#         "order_status",
#         "total_amount"
#     ]
# )
# orders_df.to_csv("data/orders.csv", index=False)


# Set num_riders to match the number of riders in your riders.csv (e.g., 20 or 50)
# num_riders = 20

# delivery_ids = list(range(1, 101))
# delivered_orders = random.sample(range(1, 151), 100)  # pick 100 distinct orders
# delivery_statuses = []
# delivery_times = []
# rider_ids = []
# for oid in delivered_orders:
#     # Randomly assign a status; mostly delivered
#     status = random.choices(["Delivered", "Failed"], weights=[0.9, 0.1])[0]
#     if status == "Delivered":
#         time_taken = random.randint(20, 60)  # minutes
#     else:
#         time_taken = None
#     rider = random.randint(1, num_riders)
#     delivery_statuses.append(status)
#     delivery_times.append(time_taken)
#     rider_ids.append(rider)

# deliveries = []
# for i, oid in enumerate(delivered_orders, start=1):
#     deliveries.append(
#         [i, oid, delivery_statuses[i - 1], delivery_times[i - 1], rider_ids[i - 1]]
#     )
# deliveries_df = pd.DataFrame(
#     deliveries,
#     columns=["delivery_id", "order_id", "delivery_status", "delivery_time", "rider_id"],
# )
# deliveries_df.to_csv("data/deliveries.csv", index=False)

# -----------------------------
# DELIVERIES (200 entries)
# -----------------------------
num_orders = 150  # Set this to match the number of orders generated earlier
num_deliveries = 400
num_riders = 20  # Set this to match the number of riders in your riders.csv (e.g., 20 or 50)
delivery_records = []
for did in range(1, num_deliveries + 1):
    oid = random.randint(1, num_orders)  # with replacement
    status = random.choices(["Delivered", "Failed"], weights=[0.9, 0.1])[0]
    time_taken = random.randint(20, 60) if status == "Delivered" else None
    rider_id = random.randint(1, num_riders)  # matches riders.csv
    delivery_records.append([did, oid, status, time_taken, rider_id])

deliveries_df = pd.DataFrame(
    delivery_records,
    columns=["delivery_id", "order_id", "delivery_status", "delivery_time", "rider_id"],
)
deliveries_df.to_csv("data\deliveries.csv", index=False)
print("Data generation complete. Files saved in ../data/")
