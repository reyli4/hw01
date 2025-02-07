ENV["PYTHON"] = "C:\\Users\\LJL\\anaconda3\\python.exe" #Chatgpt generated coding. Before using this I have a hard time letting julia implement python
import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using Random # random number generation and seed-setting
using DataFrames # tabular data structure
using CSVFiles # reads/writes .csv files
using Distributions # interface to work with probability distributions
using Plots # plotting library
using StatsBase # statistical quantities like mean, median, etc
using StatsPlots # some additional statistical plotting tools
using PyCall # I googled the method of calling python in julia
using Conda # I googled the method of calling python in julia
using PyPlot #Chatgpt generated coding. I tried every methods I knew in python to plot the histogram, but julia kept telling me the plot is not interactive, so I use the pyplot from python to plot the graph.
data = DataFrame(load("C:\\Users\\LJL\\Downloads\\hw01/data/bites.csv")) # load data into DataFrame
# print data variable (semi-colon suppresses echoed output in Julia, which in this case would duplicate the output)
@show data;
# split data into vectors of bites for each group
beer = data[data.group .== "beer", :bites]
water = data[data.group .== "water", :bites]

observed_difference = mean(beer) - mean(water)
@show observed_difference;

#Chatgpt generated coding. Before using this I have a hard time letting julia implement python
py"""
import sys
sys.path.append(r"C:\\Users\\LJL\\Downloads\\hw01")  
"""
simulation = pyimport("simulation")


# Convert Julia vectors to Python arrays
beer_py = PyObject(collect(beer))
water_py = PyObject(collect(water))

# Call the Python function
observed_difference_py, p_value, simulated_differences_py = simulation.mosquito_simulation(beer_py, water_py)

# Print the results
println("Observed Difference: $observed_difference_py")
println("P-value : $p_value")

simulated_differences = collect(simulated_differences_py)

# Plot the histogram
fig, ax = plt.subplots(figsize=(10, 6))
ax.hist(simulated_differences, bins=30, alpha=0.7, color="blue", edgecolor="black", label="Simulated Differences")
ax.axvline(observed_difference_py, color="red", linestyle="dashed", linewidth=2, label="Observed Difference")

ax.set_xlabel("Difference in Means")
ax.set_ylabel("Frequency")
ax.set_title("Permutation Test: Distribution of Simulated Differences")
ax.legend()
ax.grid(true)

plt.show()  

