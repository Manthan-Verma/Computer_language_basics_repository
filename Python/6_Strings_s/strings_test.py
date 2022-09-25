name = 'Manthan'
father_name = "Parmod kumar"
mother_name = '''Madhu bala'''                            # All types of quotes are allowed

print(len(father_name))                                     # PRINTS THE LEN OF STRING

print(father_name[7],father_name[-8])                   # Both positive and negative indexing works --> positive forward , Negative backward

nn = father_name + mother_name                         # String concatenation
print(nn)                              

# father_name[4] = 't'         -->   This type of indivisual assigment is not allowed

m = 'hi'
print(m*3)                     # prints --> hihihi

print(mother_name[0:9:2])              # Slicing of the Srrings  Var_name[Start:End:increment]
check = name[0:5:1]                     # assigning to other var using slicing

print('h' in 'hello')                   # Prints true if h is found in corrospnding string

total = father_name.count('a')          # Counts total no of 'a' in String Father-name
print(total)

print(father_name.find('d ku'))            # PRINTS THE INDEX OF STRING FOUND 

print(father_name.capitalize())             # Capitalize the 1st letter and then other all small

print(father_name.title())                      # Makes the 1st letter of every word capital

# upper lowr isupper islower all rest functions works normally

print(mother_name.replace('Madhu','madhu'))         # Replaces the String entered with the 2nd entered string 

