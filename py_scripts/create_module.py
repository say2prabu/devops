import json 
import sys
import yaml

# Variables
main_file = "main.tf" 
input_file = str(sys.argv[1])

# Convert yaml to json
with open(input_file,"r") as yaml_doc:
    yaml_to_dict=yaml.load(yaml_doc,Loader=yaml.FullLoader)
    json_file = input_file + ".json"
    with open(json_file,"w") as json_doc:
        json.dump(yaml_to_dict,json_doc)

# Read json file and put it in array
print (json_file)
json_input = open(json_file,"r")
json_converted_input_file = json.load(json_input)

# Header variable in input yaml file
header = ["Env", "ApplicationName"]
try:
    for module_type in json_converted_input_file:
        i = 1
        resource_list = (json_converted_input_file[module_type])
        if any(x in module_type for x in header):
            print ("found header information, hence skipped writting to main.tf")
            continue
        else:
            for variables in resource_list: 
                print (module_type)
                with open(main_file, "a") as main:
                    t1 =  f'module "{module_type}{i}" {{ \n source = "../services/{module_type}"\n'             
                    main.writelines(t1) 
                    main.close 
                variable_list = json_converted_input_file[module_type][variables]
                
                for keyValue in variable_list: 
                    key = keyValue
                    value = variable_list[keyValue] 

                    print (key)
                    if 'tags' in key:
                        print ('tags in key', value)
                        with open(main_file, "a") as main:
                            t2 = f'{key} = {{\n' 
                            main.write(t2) 
                            main.close 

                        for kv in value:
                            with open(main_file, "a") as main:
                                t3 = f'"{kv}" = "{value[kv]}"\n' 
                                main.write(t3) 
                                main.close 
                        with open(main_file, "a") as main: 
                            t5 =  '}\n' 
                            main.write(t5) 
                            main.close


                    else:                        
                        with open(main_file, "a") as main: 
                            if isinstance(value, int) or isinstance(value, float):
                                t4 = f'{key} = {value}\n'                   
                            else:
                                t4 =  f'{key} = "{value}"\n'       
                            main.write(t4) 
                            main.close 
                with open(main_file, "a") as main: 
                        t6 =  '}\n\n' 
                        main.write(t6) 
                        main.close
                print ("add output")
                with open(main_file, "a") as main: 
                    t9 =  f'output "{module_type}{i}-id" {{ \n value = module.{module_type}{i}.id \n }} \n\n'
                    main.write(t9) 
                    main.close
                i += 1
except:
    with open(main_file, "a") as main:
        t6 =  ""             
        main.writelines(t6) 
        main.close 
