import csv
import matplotlib.pyplot as plt
import collections

def processFile(file_path):
    # Initialize an empty list to store the data
    data = []
    temp_file = '/tmp/temp.data'
    
    # Open the input file and read its contents
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Filter out the lines starting with '#'
    filtered_lines = [line for line in lines if not line.startswith('#')]

    # Write the filtered lines to the output file
    with open(temp_file, 'w', newline='') as file:
        file.writelines(filtered_lines)
    
    # Open the CSV file and read the contents
    with open(temp_file, 'r') as file:
        csv_reader = csv.DictReader(file, dialect='excel-tab')
        for row in csv_reader:
            # Filter out rows where 'criterion' is not 'total'
            if row['criterion'] == 'total':
                data.append(row)
    
    # Create a dictionary to store the data grouped by benchmark and executor
    benchmarks_dict = {}
    
    for row in data:
        benchmark = row['benchmark']
        executor = row['executor']
        value = float(row['value'])
        
        if benchmark not in benchmarks_dict:
            benchmarks_dict[benchmark] = {}
    
        if executor not in benchmarks_dict[benchmark]:
            benchmarks_dict[benchmark][executor] = []
    
        benchmarks_dict[benchmark][executor].append(value)
    
    # Generate the box plot
    
    for benchmark, groupedData in benchmarks_dict.items():
        gd = dict(sorted(groupedData.items(), key=lambda item: item[0])) 
        fig, ax = plt.subplots(figsize=(12, 6))
        ax.set_title(benchmark)
        ax.set_xlabel('Executor')
        ax.set_ylabel('Value')
        ax.boxplot(list(gd.values()), tick_labels=list(gd.keys()), showfliers=True)
        plt.xticks(rotation=90)
        plt.tight_layout()
        plt.savefig('./plots/' + benchmark + '.png', dpi=300)
        
processFile('./data/pharo.data')
processFile('./data/bloc.data')
processFile('./data/cormas.data')
processFile('./data/microdown.data')
processFile('./data/dataFrame.data')
processFile('./data/honeyGinger.data')