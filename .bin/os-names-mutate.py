#!/usr/bin/python3

text=open('../Fuzzing/os-names.txt').read().split('\n')
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

open("../Fuzzing/os-names-mutated.txt","w").write('\n'.join(temp))
