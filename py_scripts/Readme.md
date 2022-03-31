This Python program is written to create main.tf structure using sample.yaml file.

Once a user add any information to the yaml file a CICD pipeline will get trigger and python script will create Module.tf using the YAML file. Python file is performing below actions

1) Reading YAML file and Storing information to temparaory json file, format of json file is exactly same at yaml file however .json is getting added, e.g "sample.yaml" file will be stores at "sample.yaml.json" file

2) Run through the temporary created json file and create specific module mentioned in the input file