import os
import yaml
import json
import pandas as pd
with open('./dev.yaml') as r:
    with open('output.json', 'w') as j:
        yaml_data=yaml.safe_load(r.read())
        json_data=json.dumps(yaml_data)
        j.write(json_data)
df = pd.read_json('output.json')
resources=print(len(df.index))
os.remove('output.json')