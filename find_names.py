import os

file_path = 'original_clean.js'
search_strs = ['Sam', 'Sof', 'Rahul', 'Dhanya']

with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()
    for s in search_strs:
        index = content.find(s)
        if index >= 0:
            print(f"'{s}' found at {index}")
            print(f"Context: {content[max(0, index-100):min(len(content), index+100)]}")
        else:
            print(f"'{s}' not found")
