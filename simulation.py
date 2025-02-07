
import numpy as np
import matplotlib
matplotlib.use("TkAgg") 

def mosquito_simulation(beer_bites, water_bites, num_simulations=50000):
    # Observed difference
    observed_difference = np.mean(beer_bites) - np.mean(water_bites)

    # Combine data
    all_bites = np.concatenate([beer_bites, water_bites])

    # Perform simulations
    simulated_differences = []
    for _ in range(num_simulations):
        np.random.shuffle(all_bites)
        beer_sim = all_bites[:len(beer_bites)]
        water_sim = all_bites[len(beer_bites):]
        simulated_differences.append(np.mean(beer_sim) - np.mean(water_sim))

    # Calculate p-value
    p_value = np.mean(np.abs(simulated_differences) >= np.abs(observed_difference))
    
    return observed_difference, p_value, simulated_differences
    
