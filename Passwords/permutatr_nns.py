# Ask the user to enter a list of names separated by a space
names = input("Enter a list of names separated by a space: ").split(" ")

# Using the symbols of the keyboard
symbols = ['!', '"', '#', '$', '%', '&', "'", '(', ')', '*', '+', ',', '-', '.', '/', '<', '=', '>', '?', '@', ':', '£', ';', '_', '#']

# For each name of the list...
for name in names:
  # ...add a 4 digit numerical sequence from 0000 to 9999
  for i in range(10000):
    # Format the number as a 4 digit string with starting 0000
    number = "{:04d}".format(i)

    # For each ASCII symbol...
    for symbol in symbols:
      # ...combine name, number and symbol without spaces and print the result
      result = name + number + symbol
      print(result)
