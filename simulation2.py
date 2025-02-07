import numpy as np
from scipy.stats import norm
import matplotlib
matplotlib.use("TkAgg")  # Switch to a GUI backend


def grant_simulation(num_proposals=200, num_simulations=1000, top_percentile=0.90):
    # Threshold for the top 10% of total scores
    threshold = norm.ppf(top_percentile, loc=0, scale=np.sqrt(2))  # Total score follows N(0, sqrt(2))

    # Arrays to store correlations
    correlations_all = []
    correlations_funded = []

    # Simulation loop
    for _ in range(num_simulations):
        # Generate independent rigor and impact scores
        rigor = np.random.normal(0, 1, num_proposals)
        impact = np.random.normal(0, 1, num_proposals)

        # Calculate total score
        total_score = rigor + impact

        # Select proposals that are in the top 10% by total score
        funded_indices = total_score >= threshold
        funded_rigor = rigor[funded_indices]
        funded_impact = impact[funded_indices]

        # Calculate correlations
        correlations_all.append(np.corrcoef(rigor, impact)[0, 1])  # General population
        correlations_funded.append(np.corrcoef(funded_rigor, funded_impact)[0, 1])  # Funded proposals

    return correlations_all, correlations_funded

