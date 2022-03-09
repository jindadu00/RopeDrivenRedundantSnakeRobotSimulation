with open('output.txt', 'r') as f:
    txt = f.read()

# txt = txt.replace('\n', ';\n')

# for i in range(1, 25):
#     print(i)
#     txt = txt.replace('theta' + str(i) + ';', 'theta(' + str(i) + ');')
# for i in range(1, 25):
#     print(i)
#     txt = txt.replace('theta(' + str(i) + ');','theta' + str(i) + ';')
for i in range(1, 25):
    print(i)
    txt = txt.replace('(theta' + str(i) + ')', '(theta(' + str(i) + '))')
# for i in range(1, 25):
#     print(i)
#     txt = txt.replace('(theta(' + str(i) + '))', '(theta' + str(i) + ')')

with open('output.txt', 'w') as f:
    f.write(txt)
print(i)