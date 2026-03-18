import os

file_path = 'original_clean.js'
search_str = 'Aperitivo'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()
    index = content.find(search_str)
    if index >= 0:
        print(f"Found at {index}")
        print(content[index-200:index+3000])
    else:
        print("Not found")
