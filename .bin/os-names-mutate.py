#!/usr/bin/python3

with open('../Fuzzing/os-names.txt') as source_file:
 text=source_file.read().split('\n')
new_temp=[]
for i in text:
 if " " in i:
  new_temp.append(i.replace(" ", "-"))
  new_temp.append(i.replace(" ", "_"))
 else:
  new_temp.append(i)
temp=[]
for i in new_temp:
 if i.lower() != i:
  temp.append(i)
  temp.append(i.lower())
 else:
  temp.append(i)

with open("../Fuzzing/os-names-mutated.txt","w") as output_file:
 output_file.write('\n'.join(temp))
