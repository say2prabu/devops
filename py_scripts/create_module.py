# import json
# import sys
# import yaml

# # Variables
# main_file = "main.tf"
# input_file = str(sys.argv[1])

# # Convert yaml to json
# with open(input_file,"r") as yaml_doc:
#     yaml_to_dict=yaml.load(yaml_doc,Loader=yaml.FullLoader)
#     json_file = input_file + ".json"
#     with open(json_file,"w") as json_doc:
#         json.dump(yaml_to_dict,json_doc)

# # Read json file and put it in array
# print (json_file)
# json_input = open(json_file,"r")
# json_converted_input_file = json.load(json_input)

# # Header variable in input yaml file
# header = ["Env", "ApplicationName"]
# try:
#     for module_type in json_converted_input_file:
#         i = 1
#         resource_list = (json_converted_input_file[module_type])
#         if any(x in module_type for x in header):
#             print ("found header information, hence skipped writting to main.tf")
#             continue
#         else:
#             for variables in resource_list:
#                 print (module_type)
#                 with open(main_file, "a") as main:
#                     t1 =  f'module "{module_type}{i}" {{ \n source = "../services/{module_type}"\n'
#                     main.writelines(t1)
#                     main.close
#                 variable_list = json_converted_input_file[module_type][variables]

#                 for keyValue in variable_list:
#                     key = keyValue
#                     value = variable_list[keyValue]

#                     print (key)
#                     if type(value) is dict:
#                         print ('key', value)
#                         with open(main_file, "a") as main:
#                             t2 = f'{key} = {{\n'
#                             main.write(t2)
#                             main.close

#                         for kv in value:
#                             with open(main_file, "a") as main:
#                                 t3 = f'"{kv}" = "{value[kv]}"\n'
#                                 main.write(t3)
#                                 main.close
#                         with open(main_file, "a") as main:
#                             t5 =  '}\n'
#                             main.write(t5)
#                             main.close


#                     else:
#                         with open(main_file, "a") as main:
#                             if isinstance(value, int) or isinstance(value, float):
#                                 t4 = f'{key} = {value}\n'
#                             else:
#                                 t4 =  f'{key} = "{value}"\n'
#                             main.write(t4)
#                             main.close
#                 with open(main_file, "a") as main:
#                         t6 =  '}\n\n'
#                         main.write(t6)
#                         main.close
#                 print ("add output")
#                 with open(main_file, "a") as main:
#                     t9 =  f'output "{module_type}{i}-id" {{ \n value = module.{module_type}{i}.id \n }} \n\n'
#                     main.write(t9)
#                     main.close
#                 x = {2,3,4}
#                 print(isinstance(x , set))
#                 i += 1
# except:
#     with open(main_file, "a") as main:
#         t6 =  ""
#         main.writelines(t6)
#         main.close
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
                    t1 =  f'module "{module_type}{i}" {{ \n\nsource = "../services/{module_type}"\n\n'             
                    main.writelines(t1) 
                    main.close 
                variable_list = json_converted_input_file[module_type][variables]
                
                for keyValue in variable_list: 
                    key = keyValue
                    value = variable_list[keyValue] 
# lines 43-60 are for the tags variables specifically, they are given as a map in main.tf
                    print (key)
                    # if 'tags' in key:
                    #     print ('tags in key', value)
                    #     with open(main_file, "a") as main:
                    #         t2 = f'{key} = {{\n' 
                    #         main.write(t2) 
                    #         main.close 

                    #     for kv in value:
                    #         with open(main_file, "a") as main:
                    #             t3 = f'"{kv}" = "{value[kv]}"\n' 
                    #             main.write(t3) 
                    #             main.close 
                    #     with open(main_file, "a") as main: 
                    #         t5 =  '}\n' 
                    #         main.write(t5) 
                    #         main.close

                    # if 'backend_pool' == key:
                    #     with open(main_file, "a") as main:
                    #         t200 = f'{key} = {{' 
                    #         main.write(t200) 
                    #         main.close 
                    #     # with open(main_file, "a") as main:
                    #     #     t400 = f'{{'
                    #     for kv in value:
                    #         with open(main_file, "a") as main:
                    #             t300 = f'"{kv}" = "{value[kv]}"\n' 
                    #             main.write(t300) 
                    #             main.close 
                    #     with open(main_file, "a") as main: 
                    #         t500 =  '}\n' 
                    #         main.write(t500) 
                    #         main.close
                    if isinstance(value,list)==True:
                        with open(main_file , "a") as main:
                            t12 = f'{key} = [\n'
                            main.write(t12)
                            main.close
                        for listel in value: # kv are the individual list elements. if the individial list elements is a dictionary
                            #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                            if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                with open(main_file,"a") as main:
                                    t1000 = f'   {{  \n'
                                    main.write(t1000)
                                    main.close
                                for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                    #print(kv[kvdict]) 
                                    if isinstance(listel[kvdict], str):
                                        with open(main_file,"a") as main:
                                            t1001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                            main.write(t1001)
                                            main.close
                                    elif isinstance(listel[kvdict], bool):
                                        with open(main_file,"a") as main:
                                            t1002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                            main.write(t1002)
                                            main.close
                                    else: # ie the numbers 
                                        with open(main_file,"a") as main:
                                            t1003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                            main.write(t1003)
                                            main.close
                                with open(main_file,"a") as main:
                                    t1004 = f'   }}, \n'
                                    main.write(t1004)
                                    main.close
                            else: # ie if it is just a normal list
                                with open(main_file,"a") as main:
                                    t1005 = f'"{listel}" , \n'
                                    main.write(t1005)
                                    main.close
                        with open(main_file, "a") as main: 
                            t1006 =  f']\n' 
                            main.write(t1006) 
                            main.close
                    elif isinstance(value, str):  #(basically a string)
                        with open(main_file, "a") as main:
                            t43 =  f'{key} = "{value}"\n'
                            main.write(t43) 
                            main.close
                    #bool is written below        
                    # elif isinstance(value, bool):  #(basically a string)
                    #     with open(main_file, "a") as main:
                    #         t437 =  f'{key} = "{str(value).lower()}"\n'
                    #         main.write(t437) 
                    #         main.close
                    
# lines 61-65 picks whether the key is a dictionary and if so sets the key with an open bracket in the main                            
                    #*********************************
                    #dictionary1
                    #*********************************
                    elif isinstance(value, dict)==True:
                        with open(main_file, "a") as main:
                            t23 = f'{key} = {{\n' 
                            main.write(t23) 
                            main.close 
                        for kv in value:
                            #need to try to have it so the first dictionary can have value[kv] as string bool list etc as well as seperate the 
                            if isinstance(value[kv], (bool,))==True:
                                # if isinstance(value[kv],bool)==True:
                                with open(main_file, "a") as main:
                                    t913 = f'    "{kv}" = "{str(value[kv]).lower()}"\n'
                                    main.write(t913) 
                                    main.close 
                                    #value of the dictionary inside a dictionary is a string
                            elif isinstance(value[kv], (str,))==True:
                                with open(main_file, "a") as main:
                                    t9143 = f'    "{kv}" = "{value[kv]}"\n'
                                    main.write(t9143) 
                                    main.close 
                            #value of the dictionary inside a dictionary is a list
                            elif isinstance(value[kv],list)==True:
                                #print(kv1)
                                with open(main_file , "a") as main:
                                    t1123 = f'   "{kv}" = [\n'
                                    main.write(t1123)
                                    main.close
                                for listel in value[kv]: # kv are the individual list elements. if the individial list elements is a dictionary
                                    #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                                    if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                        with open(main_file,"a") as main:
                                            t2000 = f'   {{  \n'
                                            main.write(t2000)
                                            main.close
                                        for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                            #print(kv[kvdict]) 
                                            if isinstance(listel[kvdict], str):
                                                with open(main_file,"a") as main:
                                                    t2001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                                    main.write(t2001)
                                                    main.close
                                            elif isinstance(listel[kvdict], bool):
                                                with open(main_file,"a") as main:
                                                    t2002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                                    main.write(t2002)
                                                    main.close
                                            else: # ie the numbers 
                                                with open(main_file,"a") as main:
                                                    t2003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                                    main.write(t2003)
                                                    main.close
                                        with open(main_file,"a") as main:
                                            t2004 = f'   }}, \n'
                                            main.write(t2004)
                                            main.close
                                    else: # ie if it is just a normal list
                                        with open(main_file,"a") as main:
                                            t2005 = f'"{listel}" , \n'
                                            main.write(t2005)
                                            main.close
                                with open(main_file, "a") as main: 
                                    t2006 =  f']\n' 
                                    main.write(t2006) 
                                    main.close
                            #**************************************************************
                            # if isinstance(value[kv], dict)==True:
                            #     with open(main_file, "a") as main:
                            #         t23 = f'{key} = {{\n' 
                            #         main.write(t23) 
                            #         main.close 
                            #         break
                            #         #above is setting it to be a double dictionary. 
                            # else:# everything 
                            #     with open(main_file, "a") as main:
                            #         t2345 = f'{key} = [{{\n' 
                            #         main.write(t2345) 
                            #         main.close 
                            #         break # this sets a square bracket for only one dictionary like tags. this is wrong. 
        
#lines 68-73 checks if we have a lsit of maps and if so sets the begining list with an open bracket
# lines 74-88 sets the list of maps in main.tf and also checks for intiger and float values (line 75)       
                        #for kv in value:
                            #*****************************
                            #dictionary inside a dictionary (2)
                            #*****************************
                            elif isinstance(value[kv], dict)==True:
                                with open(main_file, "a") as main:
                                    t93 = f'    {kv} = {{\n'
                                    main.write(t93) 
                                    main.close
                                for kv1 in value[kv]:
                                    #value of the dictionary inside a dictionary is a bool
                                    if isinstance(value[kv][kv1], (bool,))==True:
                                        # if isinstance(value[kv][kv1],bool)==True:
                                        with open(main_file, "a") as main:
                                            t91 = f'        "{kv1}" = "{str(value[kv][kv1]).lower()}"\n'
                                            main.write(t91) 
                                            main.close 
                                    #value of the dictionary inside a dictionary is a string
                                    elif isinstance(value[kv][kv1], (str,))==True:
                                        with open(main_file, "a") as main:
                                            t914 = f'        "{kv1}" = "{value[kv][kv1]}"\n'
                                            main.write(t914) 
                                            main.close 
                                    #value of the dictionary inside a dictionary is a list
                                    elif isinstance(value[kv][kv1],list)==True:
                                        #print(kv1)
                                        with open(main_file , "a") as main:
                                            t112 = f'        "{kv1}" = [\n'
                                            main.write(t112)
                                            main.close
                                        for listel in value[kv][kv1]: # kv are the individual list elements. if the individial list elements is a dictionary
                                            #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                                            if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                                with open(main_file,"a") as main:
                                                    t3000 = f'   {{  \n'
                                                    main.write(t3000)
                                                    main.close
                                                for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                                    #print(kv[kvdict]) 
                                                    if isinstance(listel[kvdict], str):
                                                        with open(main_file,"a") as main:
                                                            t3001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                                            main.write(t3001)
                                                            main.close
                                                    elif isinstance(listel[kvdict], bool):
                                                        with open(main_file,"a") as main:
                                                            t3002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                                            main.write(t3002)
                                                            main.close
                                                    else: # ie the numbers 
                                                        with open(main_file,"a") as main:
                                                            t3003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                                            main.write(t3003)
                                                            main.close
                                                with open(main_file,"a") as main:
                                                    t3004 = f'   }}, \n'
                                                    main.write(t3004)
                                                    main.close
                                            else: # ie if it is just a normal list
                                                with open(main_file,"a") as main:
                                                    t3005 = f'"{listel}" , \n'
                                                    main.write(t3005)
                                                    main.close
                                        with open(main_file, "a") as main: 
                                            t3006 =  f']\n' 
                                            main.write(t3006) 
                                            main.close
                                    #value of dictionary inside a dictionary is a dictionary
                                    #**************************************************
                                    #dictionary inside a dictionary isnide a dictionary (3)
                                    #*************************************************
                                    elif isinstance(value[kv][kv1],dict)==True:
                                        with open(main_file , "a") as main: # this is the beginning of the dictionary
                                            t1112 = f'        {kv1} = {{\n'
                                            main.write(t1112)
                                            main.close
                                        for kv2 in value[kv][kv1]:
                                            if isinstance(value[kv][kv1][kv2],str)==True:
                                                with open(main_file,"a") as main:
                                                    t1113 = f'           "{kv2}" = "{value[kv][kv1][kv2]}", \n'
                                                    main.write(t1113)
                                                    main.close
                                            elif isinstance(value[kv][kv1][kv2], bool)==True:
                                                with open(main_file,"a") as main:
                                                    t1114 = f'           "{kv2}" = "{str(value[kv][kv1][kv2]).lower()}", \n'
                                                    main.write(t1114)
                                                    main.close
                                            elif isinstance(value[kv][kv1][kv2], list)==True:
                                                with open(main_file , "a") as main:
                                                    t1116 = f'           "{kv2}" = [\n'
                                                    main.write(t1116)
                                                    main.close
                                                for listel in value[kv][kv1][kv2]: # kv are the individual list elements. if the individial list elements is a dictionary
                                                    #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                                                    if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                                        with open(main_file,"a") as main:
                                                            t4000 = f'   {{  \n'
                                                            main.write(t4000)
                                                            main.close
                                                        for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                                            #print(kv[kvdict]) 
                                                            if isinstance(listel[kvdict], str):
                                                                with open(main_file,"a") as main:
                                                                    t4001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                                                    main.write(t4001)
                                                                    main.close
                                                            elif isinstance(listel[kvdict], bool):
                                                                with open(main_file,"a") as main:
                                                                    t4002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                                                    main.write(t4002)
                                                                    main.close
                                                            else: # ie the numbers 
                                                                with open(main_file,"a") as main:
                                                                    t4003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                                                    main.write(t4003)
                                                                    main.close
                                                        with open(main_file,"a") as main:
                                                            t4004 = f'   }}, \n'
                                                            main.write(t4004)
                                                            main.close
                                                    else: # ie if it is just a normal list
                                                        with open(main_file,"a") as main:
                                                            t4005 = f'"{listel}" , \n'
                                                            main.write(t4005)
                                                            main.close
                                                with open(main_file, "a") as main: 
                                                    t4006 =  f']\n' 
                                                    main.write(t4006) 
                                                    main.close
                                            #**************************************************
                                            #dictionary inside a dictionary isnide a dictionary isnde a dictionary (4)
                                            #*************************************************
                                            elif isinstance(value[kv][kv1][kv2],dict)==True:
                                                with open(main_file , "a") as main: # this is the beginning of the dictionary
                                                    t11114 = f'            {kv2} = {{\n'
                                                    main.write(t11114)
                                                    main.close
                                                for kv3 in value[kv][kv1][kv2]:
                                                    if isinstance(value[kv][kv1][kv2][kv3],str)==True:
                                                        with open(main_file,"a") as main:
                                                            t11113 = f'                "{kv3}" = "{value[kv][kv1][kv2][kv3]}" \n'
                                                            main.write(t11113)
                                                            main.close
                                                    elif isinstance(value[kv][kv1][kv2][kv3], bool)==True:
                                                        with open(main_file,"a") as main:
                                                            t11115 = f'                "{kv3}" = "{str(value[kv][kv1][kv2][kv3]).lower()}", \n'
                                                            main.write(t11115)
                                                            main.close
                                                    elif isinstance(value[kv][kv1][kv2][kv3], list)==True:
                                                        with open(main_file , "a") as main:
                                                            t11116 = f'                "{kv3}" = [\n'
                                                            main.write(t11116)
                                                            main.close
                                                        for listel in value[kv][kv1][kv2][kv3]: # kv are the individual list elements. if the individial list elements is a dictionary
                                                            #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                                                            if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                                                with open(main_file,"a") as main:
                                                                    t5000 = f'   {{  \n'
                                                                    main.write(t5000)
                                                                    main.close
                                                                for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                                                    #print(kv[kvdict]) 
                                                                    if isinstance(listel[kvdict], str):
                                                                        with open(main_file,"a") as main:
                                                                            t5001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                                                            main.write(t5001)
                                                                            main.close
                                                                    elif isinstance(listel[kvdict], bool):
                                                                        with open(main_file,"a") as main:
                                                                            t5002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                                                            main.write(t5002)
                                                                            main.close
                                                                    else: # ie the numbers 
                                                                        with open(main_file,"a") as main:
                                                                            t5003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                                                            main.write(t5003)
                                                                            main.close
                                                                with open(main_file,"a") as main:
                                                                    t5004 = f'   }}, \n'
                                                                    main.write(t5004)
                                                                    main.close
                                                            else: # ie if it is just a normal list
                                                                with open(main_file,"a") as main:
                                                                    t5005 = f'                  "{listel}" , \n'
                                                                    main.write(t5005)
                                                                    main.close
                                                        with open(main_file, "a") as main: 
                                                            t5006 =  f'                 ]\n' 
                                                            main.write(t5006) 
                                                            main.close
                                                    #**************************************************
                                                    # dictionary inside a dictionary isnide a dictionary isnde a dictionary inside a dictionary(5)
                                                    # *************************************************        
                                                    elif isinstance(value[kv][kv1][kv2][kv3], dict)==True:
                                                        with open(main_file , "a") as main: # this is the beginning of the dictionary
                                                            t111112 = f'                {kv3} = {{\n'
                                                            main.write(t111112)
                                                            main.close
                                                        for kv4 in value[kv][kv1][kv2][kv3]:
                                                            if isinstance(value[kv][kv1][kv2][kv3][kv4],str)==True:
                                                                with open(main_file,"a") as main:
                                                                    t111113 = f'                    "{kv4}" = "{value[kv][kv1][kv2][kv3][kv4]}" \n'
                                                                    main.write(t111113)
                                                                    main.close
                                                            elif isinstance(value[kv][kv1][kv2][kv3][kv4], bool)==True:
                                                                with open(main_file,"a") as main:
                                                                    t111115 = f'                    "{kv4}" = "{str(value[kv][kv1][kv2][kv3][kv4]).lower()}", \n'
                                                                    main.write(t111115)
                                                                    main.close
                                                            elif isinstance(value[kv][kv1][kv2][kv3][kv4], list)==True:
                                                                with open(main_file , "a") as main:
                                                                    t111116 = f'                   "{kv4}" = [\n'
                                                                    main.write(t111116)
                                                                    main.close
                                                                for listel in value[kv][kv1][kv2][kv3][kv4]: # kv are the individual list elements. if the individial list elements is a dictionary
                                                                    #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                                                                    if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                                                        with open(main_file,"a") as main:
                                                                            t6000 = f'   {{  \n'
                                                                            main.write(t6000)
                                                                            main.close
                                                                        for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                                                            #print(kv[kvdict]) 
                                                                            if isinstance(listel[kvdict], str):
                                                                                with open(main_file,"a") as main:
                                                                                    t6001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                                                                    main.write(t6001)
                                                                                    main.close
                                                                            elif isinstance(listel[kvdict], bool):
                                                                                with open(main_file,"a") as main:
                                                                                    t6002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                                                                    main.write(t6002)
                                                                                    main.close
                                                                            else: # ie the numbers 
                                                                                with open(main_file,"a") as main:
                                                                                    t6003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                                                                    main.write(t6003)
                                                                                    main.close
                                                                        with open(main_file,"a") as main:
                                                                            t6004 = f'   }}, \n'
                                                                            main.write(t6004)
                                                                            main.close
                                                                    else: # ie if it is just a normal list
                                                                        with open(main_file,"a") as main:
                                                                            t6005 = f'                  "{listel}" , \n'
                                                                            main.write(t6005)
                                                                            main.close
                                                                with open(main_file, "a") as main: 
                                                                    t6006 =  f'                 ]\n' 
                                                                    main.write(t6006) 
                                                                    main.close
                                                            #****************************************************
                                                            #dictionary 6
                                                            #**************************************************        
                                                            elif isinstance(value[kv][kv1][kv2][kv3][kv4], dict)==True:
                                                                with open(main_file , "a") as main: # this is the beginning of the dictionary
                                                                    t1111121 = f'                   {kv4} = {{\n'
                                                                    main.write(t1111121)
                                                                    main.close
                                                                for kv5 in value[kv][kv1][kv2][kv3][kv4]:
                                                                    if isinstance(value[kv][kv1][kv2][kv3][kv4][kv5],str)==True:
                                                                        with open(main_file,"a") as main:
                                                                            t111113 = f'                        "{kv5}" = "{value[kv][kv1][kv2][kv3][kv4][kv5]}" \n'
                                                                            main.write(t111113)
                                                                            main.close
                                                                    elif isinstance(value[kv][kv1][kv2][kv3][kv4][kv5], bool)==True:
                                                                        with open(main_file,"a") as main:
                                                                            t111115 = f'                        "{kv5}" = "{str(value[kv][kv1][kv2][kv3][kv4][kv5]).lower()}", \n'
                                                                            main.write(t111115)
                                                                            main.close
                                                                    elif isinstance(value[kv][kv1][kv2][kv3][kv4][kv5], list)==True:
                                                                        with open(main_file , "a") as main:
                                                                            t111116 = f'                        "{kv5}" = [\n'
                                                                            main.write(t111116)
                                                                            main.close
                                                                        for listel in value[kv][kv1][kv2][kv3][kv4][kv5]: # kv are the individual list elements. if the individial list elements is a dictionary
                                                                            #listel is the whole object which is a dictionary. listel is { ...=... , ...=...}
                                                                            if isinstance(listel, dict): #(listel is the whole key value for the dictionary) if the individial list elements is a dictionary
                                                                                with open(main_file,"a") as main:
                                                                                    t7000 = f'   {{  \n'
                                                                                    main.write(t7000)
                                                                                    main.close
                                                                                for kvdict in listel: # kvdict is the key in the dictionary and listel[kvdict] is the value
                                                                                    #print(kv[kvdict]) 
                                                                                    if isinstance(listel[kvdict], str):
                                                                                        with open(main_file,"a") as main:
                                                                                            t7001 = f'  "{kvdict}" = "{listel[kvdict]}" \n'
                                                                                            main.write(t7001)
                                                                                            main.close
                                                                                    elif isinstance(listel[kvdict], bool):
                                                                                        with open(main_file,"a") as main:
                                                                                            t7002 = f'   "{kvdict}" = "{str(listel[kvdict]).lower()}" \n'
                                                                                            main.write(t7002)
                                                                                            main.close
                                                                                    else: # ie the numbers 
                                                                                        with open(main_file,"a") as main:
                                                                                            t7003 = f'   "{kvdict}" = {listel[kvdict]}, \n'
                                                                                            main.write(t7003)
                                                                                            main.close
                                                                                with open(main_file,"a") as main:
                                                                                    t7004 = f'   }}, \n'
                                                                                    main.write(t7004)
                                                                                    main.close
                                                                            else: # ie if it is just a normal list
                                                                                with open(main_file,"a") as main:
                                                                                    t7005 = f'                  "{listel}" , \n'
                                                                                    main.write(t7005)
                                                                                    main.close
                                                                        with open(main_file, "a") as main: 
                                                                            t7006 =  f'                 ]\n' 
                                                                            main.write(t7006) 
                                                                            main.close
                                                                    else:
                                                                        with open(main_file,"a") as main:
                                                                            t111118 = f'                         "{kv5}" = {value[kv][kv1][kv2][kv3][kv4][kv5]} \n' #everything else in dictionary 6
                                                                            main.write(t111118)
                                                                            main.close
                                                                with open(main_file,"a") as main:
                                                                    t1111119 = f'                    }},\n' #close dictionary 6
                                                                    main.write(t1111119)
                                                                    main.close          
                                                            else:
                                                                with open(main_file,"a") as main:
                                                                    t11118 = f'                    "{kv4}" = {value[kv][kv1][kv2][kv3][kv4]} \n' #everything else in dictionary 5
                                                                    main.write(t11118)
                                                                    main.close  
                                                        with open(main_file,"a") as main:
                                                            t111119 = f'                }},\n' #close dictionary 5
                                                            main.write(t111119)
                                                            main.close              
                                                    else:
                                                        with open(main_file,"a") as main:
                                                            t11118 = f'                "{kv3}" = {value[kv][kv1][kv2][kv3]} \n' #everything else in dictionary 4
                                                            main.write(t11118)
                                                            main.close
                                                with open(main_file,"a") as main:
                                                    t11119 = f'            }},\n' #close dictionary 4
                                                    main.write(t11119)
                                                    main.close
                                            else:
                                                with open(main_file,"a") as main:
                                                    t1118 = f'           "{kv2}" = {value[kv][kv1][kv2]}, \n' # everything else in dictionary 3
                                                    main.write(t1118)
                                                    main.close
                                        with open(main_file,"a") as main: 
                                            t1119 = f'        }},\n' #close dictionary 3
                                            main.write(t1119)
                                            main.close
                                    #value of the dictionary inside a dictionary is not a dictionary,list,bool,or string (numbers)       
                                    else:
                                        with open(main_file, "a") as main:
                                            t99 = f'        "{kv1}" = {value[kv][kv1]}\n' #everything else in dictionary 2
                                            main.write(t99) 
                                            main.close 
                                with open(main_file, "a") as main: 
                                    t92 =  f'    }},\n' # close dictionary 2 
                                    main.write(t92) 
                                    main.close
                            else:
                                with open(main_file, "a") as main:
                                    t99432 = f'    "{kv}" = {value[kv]}\n' #everything else in dicitonary 1
                                    main.write(t99432) 
                                    main.close 
                        with open(main_file, "a") as main: 
                            t9232 =  f'}}\n' # close dictionary1  
                            main.write(t9232) 
                            main.close
# lines 90-105 sets a map in the main.tf file. line 92 checks and sets strings with "". 
                        # for kv in value:
                        #     if isinstance(value[kv], dict)==False: # ie if there is not a double dictionary and only one then.
                        #         if isinstance(value[kv], (str,bool))==True:
                        #             if isinstance(value[kv], bool)==True:
                        #                 with open(main_file, "a") as main:
                        #                     t35 = f'    "{kv}" = "{str(value[kv]).lower()}"\n' 
                        #                     main.write(t35) 
                        #                     main.close
                        #             else:
                        #                 with open(main_file, "a") as main:
                        #                     t3545 = f'    "{kv}" = "{value[kv]}"\n' 
                        #                     main.write(t3545) 
                        #                     main.close
                        #         else:
                        #             with open(main_file, "a") as main:
                        #                 t355 = f'    "{kv}" = {value[kv]}\n' 
                        #                 main.write(t355) 
                        #                 main.close 
                        #                 #dont have options of list here
                        # for kv in value:
                        #     if isinstance(value[kv], dict)==True:
                        #         with open(main_file, "a") as main:
                        #             t23331 = f'}}\n' 
                        #             main.write(t23331) 
                        #             main.close 
                        #             break
                        #     else:
                        #         with open(main_file, "a") as main:
                        #             t2345331 = f'}},\n' 
                        #             main.write(t2345331) 
                        #             main.close 
                        #             break
                        # for kv in value:
                        #     if isinstance(value[kv], dict)==True:
                        #         with open(main_file, "a") as main:
                        #             t2333 = f'' 
                        #             main.write(t2333) 
                        #             main.close 
                        #             break
                        #     else:
                        #         with open(main_file, "a") as main:
                        #             t234533 = f']\n' 
                        #             main.write(t234533) 
                        #             main.close 
                        #             break
#lines108-115 sets non-dictionary items in main.tf
# lines 120-124 asks for an output in particular the module type id.          
                    # elif isinstance(value,list)==True:
                    #         with open(main_file , "a") as main:
                    #             t12 = f'{key} = [\n'
                    #             main.write(t12)
                    #             main.close
                    #         for kv in value:
                    #             #for kv1 in value:
                    #             with open(main_file,"a") as main:
                    #                 t13 = f'"{kv}" , \n'
                    #                 main.write(t13)
                    #                 main.close
                    #         with open(main_file, "a") as main: 
                    #             t14 =  f']\n' 
                    #             main.write(t14) 
                    #             main.close
                    # elif isinstance(value, str):  #(basically a string)
                    #     with open(main_file, "a") as main:
                    #         t43 =  f'{key} = "{value}"\n'
                    #         main.write(t43) 
                    #         main.close
                    else:                        
                        with open(main_file, "a") as main:    
                            if isinstance(value,bool):
                                t4 = f'{key} = "{str(value[kv]).lower()}"\n'                     
                            else: #basically the ints floats and sets of the initial value
                                t4 = f'{key} = {value}\n'
                            main.write(t4) 
                            main.close
                with open(main_file, "a") as main: 
                        t6 =  '}\n\n' 
                        main.write(t6) 
                        main.close
                print ("add output")
                with open(main_file, "a") as main: 
                    t9 =  f'output "{module_type}{i}-id" {{ \n   value = module.{module_type}{i}.id \n   }} \n\n'
                    main.write(t9) 
                    main.close
                x = {2,3,4}
                print(isinstance(x , set))
                i += 1
except:
    with open(main_file, "a") as main:
        t6 =  ""             
        main.writelines(t6) 
        main.close